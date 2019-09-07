; 定义宏 ： 
reverseArgs         macro       arglist:VARARG
                    local       txt,count

                    txt         TEXTEQU <>                          ;定义宏 <>表示字符串
                    count       = 0
                    for         i, < arglist >

                                count   = count + 1
                                txt     TEXTEQU  @CatStr(i,<!,>,<%txt>)     ;CatStr 链接文本 tx += i,
                    endm
                    if          count GT 0
                                txt     SUBSTR  txt,1,@SizeStr(%txt)-1
                    endif
                    exitm       txt
endm
;-----------------------------------------------------------------------------------
_invoke             macro       _Proc,args:VARARG
                    local       count

                    count       = 0
                    for         i,  <reverseArgs(args)>
                                %echo i
                                count   = count + 1
                                ;push    i
                                %echo count
                    endm
                    call        dword ptr _Proc

endm