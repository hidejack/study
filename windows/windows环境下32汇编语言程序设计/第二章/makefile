
#makefile 的例子

EXE = t.exe							#指定输出文件
OBJS = x.obj \
		y.obj						#需要的目标文件
RES = x.res 						#需要的资源文件

LINK_FLAG = /subsystem:windows		#链接选项
ML_FLAG = /c /coff					#编译选项

#定义依赖关系和执行命令
$(EXE) : $(OBJS) $(RES
	Link $(LINK_FLAG) /out:$(EXE) $(OBJS) $(RES)
$(OBJS) : Common.inc
y.obj : y.inc

#定义汇编编译和资源编译的默认规则
.asm.obj:
	ml $(ML_FLAG) $<
.rc.res:
	rc $<

#清楚临时文件
clean:
	del *.obj
	del *.res
