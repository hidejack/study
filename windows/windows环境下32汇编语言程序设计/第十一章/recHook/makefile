NAME = RecHook
OBJS = $(NAME).obj
RES = $(NAME).res
ASM = $(NAME).asm
RC = $(NAME).rc

LINK_FLAG = /subsystem:windows
ML_FLAG = /c /coff

$(NAME).exe:$(OBJS) $(RES)
		Link $(LINK_FLAG) $(OBJS) $(RES)
.asm.obj:
		ml $(ML_FLAG) $<
.rc.res:
		rc $<
clean:
		del *.obj
		del *.res