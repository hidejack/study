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
include         Hookdll.inc
includelib      Hookdll.lib
;--------------------------------------------------------------------------------------
;Equ 等值定义
;--------------------------------------------------------------------------------------
ICO_MAIN        Equ         1000
DLG_MAIN        Equ         1000
IDC_TEXT        Equ         1001
WM_HOOK         Equ         WM_USER + 100h      ;自定义消息，WM_USER 后面的值，用户可以随便使用
;--------------------------------------------------------------------------------------
;code
;--------------------------------------------------------------------------------------
                .code
;--------------------------------------------------------------------------------------
_ProcDlgMain    proc        uses ebx edi esi hWnd,wMsg,wParam,lParam
                local       @dwTemp

                mov         eax,wMsg

                .if         eax == WM_CLOSE
                            invoke      UnInstallHook
                            invoke      EndDialog,hWnd,NULL
                .elseif     eax == WM_INITDIALOG
                            invoke      InstallHook,hWnd,WM_HOOK
                            .if         ! eax
                                        invoke      EndDialog,hWnd,NULL
                            .endif
                .elseif     eax == WM_HOOK
                            mov         eax,wParam
                            .if         al == 0dh
                                        mov         eax,0a0dh
                            .endif
                            mov         @dwTemp,eax
                            invoke      SendDlgItemMessage,hWnd,IDC_TEXT,EM_REPLACESEL,\
                                        0,addr @dwTemp
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
                invoke      DialogBoxParam,eax,DLG_MAIN,NULL,offset _ProcDlgMain,NULL
                invoke      ExitProcess,NULL

                end         start