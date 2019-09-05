                .386
                .model  flat,stdcall
                option  casemap:none
;--------------------------------------------------------------------------------------
;include
;--------------------------------------------------------------------------------------
include         windows.inc
include         user32.inc
includelib      user32.lib
include         kernel32.inc
includelib      kernel32.lib
;--------------------------------------------------------------------------------------
;Equ 等值定义
;--------------------------------------------------------------------------------------
ICO_MAIN        Equ         1000
DLG_MAIN        Equ         1000
IDC_TEXT        Equ         1001
;--------------------------------------------------------------------------------------
;data sengment
;--------------------------------------------------------------------------------------
                .data?
hInstance       dd          ?
hWinMain        dd          ?
hHook           dd          ?               ;钩子句柄
szAscii         db          4 dup (?)
;--------------------------------------------------------------------------------------
                .code
;--------------------------------------------------------------------------------------
HookProc        proc        _dwCode,_wParam,_lParam
                local       @szKeyState[256]:byte

;               将消息传递给下一个钩子，钩子链
                invoke      CallNextHookEx,hHook,_dwCode,_wParam,_lParam
                pushad
                .if         _dwCode == HC_ACTION
                            mov         ebx,_lParam
                            assume      ebx:ptr EVENTMSG
                            .if         [ebx].message == WM_KEYDOWN
                                        invoke      GetKeyBoardState,addr @szKeyState
                                        invoke      GetKeyState,VK_SHIFT
                                        mov         @szKeyState + VK_SHIFT,al
                                        mov         ecx,[ebx].paramH
                                        shr         ecx,16
                                        invoke      ToAscii,[ebx].paramL,ecx,addr @szKeyState,addr szAscii,0
                                        mov         byte ptr szAscii [eax],0
                                        .if         szAscii == 0dh
                                                    mov         word ptr szAscii+1,0ah
                                        .endif
                                        invoke      SendDlgItemMessage,hWinMain,IDC_TEXT,EM_REPLACESEL,\
                                                    0,addr szAscii
                            .endif
                            assume      ebx:noting
                .endif

                popad

                ret

HookProc        endp
;--------------------------------------------------------------------------------------
_ProcDlgMain    proc        uses ebx edi esi hWnd,wMsg,wParam,lParam
                local       @dwTemp

                mov         eax,wMsg

                .if         eax == WM_CLOSE
                            invoke      UnhookWindowsHookEx,hHook
                            invoke      EndDialog,hWnd,NULL
                .elseif     eax == WM_INITDIALOG
                            push        hWnd
                            pop         hWinMain
                            invoke      SetWindowsHookEx,WH_JOURNALRECORD,\
                                        addr HookProc,hInstance,NULL
                            .if         eax
                                        mov         hHook,eax
                            .else
                                        invoke      EndDialog,hWnd,NULL
                            .endif
                .else
                            mov         eax,FALSE
                            ret
                .endif

                mov eax,TRUE
                ret

_ProcDlgMain    endp
;--------------------------------------------------------------------------------------
start:
                invoke      GetModuleHandle,NULL
                mov         hInstance,eax
                invoke      DialogBoxParam,eax,DLG_MAIN,NULL,offset _ProcDlgMain,NULL
                invoke      ExitProcess,NULL

                end         start



