
#makefile 的例子

EXE = t.exe							#指定输出文件
OBJS = t.obj

LINK_FLAG = /subsystem:windows		#链接选项
ML_FLAG = /coff					#编译选项

#定义依赖关系和执行命令
$(EXE):$(OBJS)
	link $(LINK_FLAG) /out:$(EXE) $(OBJS)
$(OBJS):Common.inc
t.obj:t.inc

#定义汇编编译和资源编译的默认规则
.asm.obj:
	ml $(ML_FLAG) $<

#清楚临时文件
clean:
	del *.obj
