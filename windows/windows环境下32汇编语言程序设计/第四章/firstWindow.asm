                .386
                .model  flat,stdcall
                option  casemap:none

;--------------------------------------------------------------------------------------
;include
;--------------------------------------------------------------------------------------
include         windows.inc
include         gdi32.inc
includelib      gdi32.lib
include         user32.inc
includelib      user32.lib
include         kernel32.inc
includelib      kernel32.lib
;--------------------------------------------------------------------------------------
;data sengment
;--------------------------------------------------------------------------------------
                .data?
hInstance       dd              ?                   ;程序的句柄实例
hWinMain        dd              ?

                .const
szClassName     db              'MyClass',0
szCaptionMain   db              'My first Window !',0
szText          db              'Win32 Assembly,Simple and powerful !',0
;--------------------------------------------------------------------------------------
;code segment
;--------------------------------------------------------------------------------------
                .code
;--------------------------------------------------------------------------------------
;Window Process
;--------------------------------------------------------------------------------------
_ProcWinMain    proc            uses ebx edi esi,hWnd,uMsg,wParam,lParam
                local           @stPs:PAINTSTRUCT
                local           @stRect:RECT    ;客户区的大小
                local           @hDc        ;设备环境句柄

                mov             eax,uMsg
;*********************************************************************************************
                .if             eax ==      WM_PAINT

                                invoke      BeginPaint,hWnd,addr @stPs
                                mov         @hDc,eax

                                invoke      GetClientRect,hWnd,addr @stRect
                                invoke      DrawText,@hDc,addr szText,-1, \
                                            addr @stRect,\
                                            DT_SINGLELINE or DT_CENTER or DT_VCENTER

                                invoke      EndPaint,hWnd,addr @stPs
;*********************************************************************************************
                .elseif         eax ==      WM_CLOSE

                                invoke      DestroyWindow,hWinMain
                                invoke      PostQuitMessage,NULL
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

                invoke          GetModuleHandle,NULL            ;这里获取模块句柄！
                mov             hInstance,eax
                invoke          RtlZeroMemory,addr @stWndClass,sizeof @stWndClass           ;这个函数将WNDCLASSEX结构体的内存空间全部设置为0
;*********************************************************************************************
;regist Window Class
;*********************************************************************************************
                invoke          LoadCursor,0,IDC_ARROW
                mov             @stWndClass.hCursor,eax
                push            hInstance
                pop             @stWndClass.hInstance
                mov             @stWndClass.cbSize,sizeof WNDCLASSEX
                mov				@stWndClass.style,CS_HREDRAW or CS_VREDRAW
                mov				@stWndClass.lpfnWndProc,offset _ProcWinMain
                mov				@stWndClass.hbrBackground,COLOR_WINDOW + 1
                mov				@stWndClass.lpszClassName,offset szClassName
                invoke          RegisterClassEx,addr @stWndClass
;*********************************************************************************************
;build and show a Window
;*********************************************************************************************
                invoke          CreateWindowEx,WS_EX_CLIENTEDGE,\
                                offset szClassName,offset szCaptionMain,\
                                WS_OVERLAPPEDWINDOW,\
                                100,100,600,400,\
                                NULL,NULL,hInstance,NULL
                mov             hWinMain,eax
                invoke          ShowWindow,hWinMain,SW_SHOWNORMAL
                invoke          UpdateWindow,hWinMain
;*********************************************************************************************
;Message Loop
;*********************************************************************************************
                .while          TRUE
                                invoke      GetMessage,addr @stMsg,NULL,0,0
                                .break      .if     eax == 0                    ;满足条件跳出循环
                                invoke      TranslateMessage,addr @stMsg
                                invoke      DispatchMessage,addr @stMsg

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
;程序分析
;代码中一共定义了两个子程序：_WinMain,_ProcWinMain
;主程序一共调用了两个程序：_WinMain,ExitProcess
;_WinMain中共顺序调用了7个系统API:
;GetModuleHandle--->RtlZeroMemory--->LoadCursor--->RegisterClassEx--->CreateWindowsEx--->ShowWindow--->updateWindow
;接下来是3个API组成的循环：GetMessage--->TranslateMessage--->DispatchMessage
;运行流程：
;1.得到应用程序的句柄（GetModuleHandle）
;2.注册窗口类（RegisterClassEx）,需填写RegisterClassEx的参数WNDCLASSEX结构
;3.建立窗口（CreateWindowEx）
;4.显示窗口（ShowWindow）
;5.刷新窗口客户区（UpdateWindow）
;6。进入无限的消息获取和处理的循环。首先GetMessage获取消息。有消息则处理（TranslateMessage），最后DispatchMessage在自己内部回来调用窗口过程

;_ProcWinMain:用来处理消息的回调函数，也叫窗口过程。有消息响应则回调此函数。
;函数内部对消息类型进行了分类处理

;程序一共3个部分
;第一个部分注册窗口实例，建立窗口，显示刷新窗口
;第二个部分负责轮循 Windows 提供的消息队列，取到消息处理转发
;第三个部分，响应消息事件，处理消息