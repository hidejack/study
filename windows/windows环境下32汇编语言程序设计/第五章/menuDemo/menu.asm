                .386
                .model  flat,stdcall
                option  casemap:none

;--------------------------------------------------------------------------------------
;include define file
;--------------------------------------------------------------------------------------
include         windows.inc
include         user32.inc
includelib      user32.lib
include         kernel32.inc
includelib      kernel32.lib
;--------------------------------------------------------------------------------------
;Equ 等值定义
;--------------------------------------------------------------------------------------
ICO_MAIN        equ             1000H       ;图标
IDM_MAIN        equ             2000H       ;菜单
IDA_MAIN        equ             2000H       ;加速键
IDM_OPEN        equ             4101H
IDM_OPTION      equ             4102H
IDM_EXIT        equ             4103H

IDM_SETFONT     equ             4201H
IDM_SETCOLOR    equ             4202H
IDM_INACT       equ             4203H
IDM_GRAY        equ             4204H
IDM_BIG         equ             4205H
IDM_SMALL       equ             4206H
IDM_LIST        equ             4207H
IDM_DETAIL      equ             4208H
IDM_TOOLBAR     equ             4209H
IDM_TOOLBARTEXT equ             4210H
IDM_INPUTBAR    equ             4211H
IDM_STATUSBAR   equ             4212H
IDM_HELP        equ             4301H
IDM_ABOUT       equ             4302H
;--------------------------------------------------------------------------------------
;data sengment
;--------------------------------------------------------------------------------------
                .data?
hInstance       dd              ?                   ;程序的句柄实例
hWinMain        dd              ?
hMenu           dd              ?
hSubMenu        dd              ?
                .const
szClassName     db              'Menu Example',0
szCaptionMain   db              'Menu',0
szMenuHelp      db              'help theme(&H)',0
szMenuAbout     db              'about me(&A)...',0
szCaption       db              'select menu',0
szFormat        db              'you choose menu ID : %08x',0
;--------------------------------------------------------------------------------------
;code segment
;--------------------------------------------------------------------------------------
                .code
;--------------------------------------------------------------------------------------
_DisplayMenuItem    proc        _dwCommandID
                    local       @szBuffer[256]:byte

                pushad
                invoke          wsprintf,addr @szBuffer,addr szFormat,_dwCommandID
                invoke          MessageBox,hWinMain,addr @szBuffer,offset szCaption,MB_OK
                popad
                ret

_DisplayMenuItem    endp
;--------------------------------------------------------------------------------------
_Quit            proc

                invoke          DestroyWindow,hWinMain
                invoke          PostQuitMessage,NULL
                ret

_Quit           endp
;--------------------------------------------------------------------------------------
;Window Process
;--------------------------------------------------------------------------------------
_ProcWinMain    proc            uses ebx edi esi,hWnd,uMsg,wParam,lParam
                local           @stPos:POINT
                local           @hSysMenu

                mov             eax,uMsg
;*********************************************************************************************
                .if             eax ==      WM_CREATE

                                invoke      GetSubMenu,hMenu,1
                                mov         hSubMenu,eax
;*********************************************************************************************
;在系统菜单中添加菜单项
;*********************************************************************************************
                                invoke      GetSystemMenu,hWnd,FALSE
                                mov         @hSysMenu,eax
                                invoke      AppendMenu,@hSysMenu,MF_SEPARATOR,0,NULL
                                invoke      AppendMenu,@hSysMenu,0,IDM_HELP,\
                                            offset szMenuHelp
                                invoke      AppendMenu,@hSysMenu,0,IDM_ABOUT,\
                                            offset szMenuAbout
;*********************************************************************************************
;处理菜单及加速键消息
;*********************************************************************************************
                .elseif         eax ==      WM_COMMAND
                                invoke      _DisplayMenuItem,wParam
                                mov         eax,wParam
                                movzx       eax,ax              ;将eax的高16位填0，低16位为ax
                                .if         eax ==      IDM_EXIT
                                            call        _Quit
                                .elseif     eax >= IDM_TOOLBAR && eax <= IDM_STATUSBAR
                                            mov         ebx,eax
                                            invoke      GetMenuState,hMenu,ebx,MF_BYCOMMAND
                                            .if         eax ==      MF_CHECKED
                                                        mov         eax,MF_UNCHECKED
                                            .else
                                                        mov         eax,MF_CHECKED
                                            .endif
                                            invoke      CheckMenuItem,hMenu,ebx,eax
                                .elseif     eax >= IDM_BIG && eax <= IDM_DETAIL
                                            invoke      CheckMenuRadioItem,hMenu,IDM_BIG,\
                                            IDM_DETAIL,eax,MF_BYCOMMAND
                                .endif
;*********************************************************************************************
;处理系统菜单消息
;*********************************************************************************************
                .elseif         eax ==      WM_SYSCOMMAND
                                mov         eax,wParam
                                movzx       eax,ax
                                .if         eax == IDM_HELP || eax == IDM_ABOUT
                                            invoke      _DisplayMenuItem,wParam
                                .else
                                            invoke      DefWindowProc,hWnd,uMsg,wParam,lParam
                                            ret
                                .endif
;*********************************************************************************************
;鼠标右键时弹出一个POPUP菜单
;*********************************************************************************************
                .elseif         eax ==      WM_RBUTTONDOWN
                                invoke      GetCursorPos,addr @stPos
                                invoke      TrackPopupMenu,hSubMenu,TPM_LEFTALIGN,\
                                            @stPos.x,@stPos.y,NULL,hWnd,NULL
;*********************************************************************************************
                .elseif         eax ==      WM_CLOSE
                                call        _Quit
;*********************************************************************************************
                .else
                                invoke      DefWindowProc,hWnd,uMsg,wParam,lParam
                                ret
                .endif
;*********************************************************************************************
                xor             eax,eax
                ret

_ProcWinMain    endp
;*********************************************************************************************
;--------------------------------------------------------------------------------------

;--------------------------------------------------------------------------------------
_WinMain        proc
                local           @stWndClass:WNDCLASSEX
                local           @stMsg:MSG
                local           @hAccelerator

                invoke          GetModuleHandle,NULL            ;这里获取模块句柄！
                mov             hInstance,eax
                invoke          LoadMenu,hInstance,IDM_MAIN
                mov             hMenu,eax
                invoke          LoadAccelerators,hInstance,IDA_MAIN         ;载入加速键
                mov             @hAccelerator,eax
;*********************************************************************************************
;regist Window Class 注册窗口类
;*********************************************************************************************
                invoke          RtlZeroMemory,addr @stWndClass,sizeof @stWndClass           ;这个函数将WNDCLASSEX结构体的内存空间全部设置为0
                invoke          LoadIcon,hInstance,ICO_MAIN
                mov             @stWndClass.hIcon,eax
                mov             @stWndClass.hIconSm,eax
                push            hInstance
                pop             @stWndClass.hInstance
                mov             @stWndClass.cbSize,sizeof WNDCLASSEX
                mov				@stWndClass.style,CS_HREDRAW or CS_VREDRAW
                mov				@stWndClass.lpfnWndProc,offset _ProcWinMain
                mov				@stWndClass.hbrBackground,COLOR_WINDOW + 1
                mov				@stWndClass.lpszClassName,offset szClassName

                invoke          RegisterClassEx,addr @stWndClass
;*********************************************************************************************
;build and show a Window 建立并显示窗口类
;*********************************************************************************************
                invoke          CreateWindowEx,WS_EX_CLIENTEDGE,\
                                offset szClassName,offset szCaptionMain,\
                                WS_OVERLAPPEDWINDOW,\
                                100,100,400,300,\
                                NULL,hMenu,hInstance,NULL
                mov             hWinMain,eax
                invoke          ShowWindow,hWinMain,SW_SHOWNORMAL
                invoke          UpdateWindow,hWinMain
;*********************************************************************************************
;Message Loop
;*********************************************************************************************
                .while          TRUE
                                invoke      GetMessage,addr @stMsg,NULL,0,0
                                .break      .if     eax == 0                    ;满足条件跳出循环
                                invoke      TranslateAccelerator,hWinMain,@hAccelerator,\           ;  实现加速键功能的核心
                                            addr @stMsg
                                .if         eax ==      0
                                            invoke      TranslateMessage,addr @stMsg
                                            invoke      DispatchMessage,addr @stMsg
                                .endif
                .endw
                                ret
_WinMain        endp
;*********************************************************************************************
;--------------------------------------------------------------------------------------
start:
                call            _WinMain
                invoke          ExitProcess,NULL        ;退出程序

end             start
;-------------------------------------------------------------------------------------


