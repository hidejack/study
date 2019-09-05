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
;data sengmen
;--------------------------------------------------------------------------------------
                .data
hInstance       dd          ?               ;dll模块句柄

                .data?
hWnd            dd          ?               ;窗口句柄
hHook           dd          ?               ;钩子句柄
dwMessage       dd          ?               ;窗口消息
szAscii         db          4 dup (?)
;--------------------------------------------------------------------------------------
                .code
;--------------------------------------------------------------------------------------
DllEntry        proc        _hInstance,_dwReason,_dwReserved

                push        _hInstance
                pop         hInstance
                mov         eax,TRUE
                ret

DllEntry        endp
;--------------------------------------------------------------------------------------
;钩子回调函数
;--------------------------------------------------------------------------------------
;dwCode : 键盘消息的处理方式，HC_ACTION 收到正常的击键消息。HC_NOREMOVE 表示对应消息并没有从消息队列中移除（某个进程用指定PM_NOREMOVE 标志的PeekMessage 函数获取消息时就是如此）
;wParam 按键的虚拟码（Windows.inc 中定义的 VK_xxx 值）
;lParam 按键的重复次数，扫描码和标志等数据。不同数据位的定义如下：
;0-15 按键的重复次数
;16-23 按键的扫描码
;24 按键是否是扩展键（F1，Fx和小键盘数字键等。）为1则是扩展键
;25-28 :未定义
;29 :alt 键按下此键为1
;30 按键的原先状态，消息发送前按键原来是按下的，此位是1
;31 按键的当前动作，如果是按键按下，此位设置0，释放为1
;每个击键动作，钩子回调函数会在按下和释放时被调用两次。
HookProc        proc        _dwCode,_wParam,_lParam
                local       @szKeyState[256]:byte

;               将消息传递给下一个钩子，钩子链
                invoke      CallNextHookEx,hHook,_dwCode,_wParam,_lParam
                invoke      GetKeyBoardState,addr @szKeyState
                invoke      GetKeyState,VK_SHIFT
                mov         @szKeyState + VK_SHIFT,al
                mov         ecx,_lParam
                shr         ecx,16
                invoke      ToAscii,_wParam,ecx,addr @szKeyState,addr szAscii,0
                mov         byte ptr szAscii [eax],0
;               如果不是键盘钩子这里需要用PostMessage
                invoke      SendMessage,hWnd,dwMessage,dword ptr szAscii,NULL
                xor         eax,eax
                ret

HookProc        endp
;--------------------------------------------------------------------------------------
;安装钩子
;--------------------------------------------------------------------------------------
InstallHook     proc        _hWnd,_dwMessage

                push        _hWnd
                pop         hWnd
                push        _dwMessage
                pop         dwMessage
                ;这里最后一个参数为dwThreadID 是安装钩子后想监控的线程的ID号。全局钩子为null，局部钩子可以指定某个线程的ID号
                invoke      SetWindowsHookEx,WH_KEYBOARD,addr HookProc,hInstance,NULL
                ;钩子安装完成返回钩子句柄，失败返回null
                mov         hHook,eax
                ret

InstallHook     endp
;--------------------------------------------------------------------------------------
;卸载钩子
;--------------------------------------------------------------------------------------
UnInstallHook   proc

                invoke      UnhookWindowsHookEx,hHook
                ret

UnInstallHook   endp
;--------------------------------------------------------------------------------------
                end         DllEntry



