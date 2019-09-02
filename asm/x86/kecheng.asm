

显示器 为 80 * 25
 共 25 行 每行 显示 80 个字符


除法指令：
div 指令
	如果除数为8位，被除数则为16位，默认存放在AX中
	如果除数为16位，被除数则为32位，DX存放高16位，AX存放低16位

结果： 如果除数8 位，则AL 存储除法操作得商，AH存储除法操作得余数
	如果除数是16位，则AX 存储除法得商，DX 存储除法操作得余数

乘法指令
mul 指令
	两个相乘数，要么都是8位，要么都是16位
	如果是8位 一个数字默认存放在al 中另外一个数字存放在其他8位寄存器 或者 字节型内存单元中
	al	*(mul) 	8位寄存器		= ax
	al	*(mul)	byte ptr ds:[0]		= ax
	mul 8位寄存器
	mul byte ptr ds:[0]

	如果两个相乘数为16位，一个数字默认存放在ax 中 另外一个数字存放在其他16位寄存器 或者 字型内存单元中
	ax *(mul)	16位寄存器	=	dx, ax
	ax *(mul)	word ptr ds:[0]	=	dx, ax
	mul 16位寄存器
	mul word ptr ds:[0]



dup 伪指令
	db	100 dup (0)



根据位移来修改IP寄存器  进行转移 指令的优势

	jmp 标号
	jmp short 标号  （短转移）
	jmp near 标号  （长转移）
	jcxz 标号
	loop 标号

	位移 = 标号处的偏移地址 - 转移指令后第一个字节的地址
	转移指令后的第一个字节的地址 + 转移指令的机器码 = 转移地址


CALL 和 RET 指令
	ret ： 相当于pop ip
	retf ： 相当于pop ip ，pop cs
	call ： push ip ，jmp near ptr 标号
	call  far ptr 标号 ： push cs， push ip，jmp far ptr 标号


转移地址在寄存器中的call 指令
格式 ： 
	call 16位寄存器 ： push ip，jmp 16位寄存器 ip = 16位寄存器中的字型数据

转移地址在内存中的call 指令
	格式：
	call word ptr 内存单元地址 ： push ip ，jmp word ptr 内存单元地址
	call dword ptr 内存单元地址 ： push cs，push ip ，jmp dword ptr 内存单元地址


call 指令的应用 : 重新组织了代码，对逻辑进行了切割
	组织数据得目的 是 为了 更好的 组织代码




标志位寄存器

15	14	13	12	11	10	9	8	7	6	5	4	3	2	1	0
				OF	DF	IF	TF	SF	ZF		AF		PF		CF

CF (Carry Flag) ：运算结果是否进位

ZF (Zero Flag): 运算结果是否与0相关 

PF (Parity Flag) :  运算结果奇偶性

SF (Sign Flag) : 运算结果正负 

OF (Overflow Flag) : 运算结果是否溢出 

DF () : 


标志		值为1		值为0
OF		OV		NV	OV = 溢出		NV = 没溢出

SF		NG		PL	NG (Negative) = 负数	PL(Positive) = 正数 

ZF		ZR		NZ	ZR = Zero 		NZ = Not Zero

PF		PE		PO	PE = EVEN (偶数)	O = ODD (奇数)

CF		CY		NC	CY = Carry Yes  	NC = Not Carry  Carry(进位)

DF		DN		UP	DN (Down) = 向下			UP = 向上




汇编指令

adc	add carry
add	ax,bx		ax = ax + bx
adc	ax,bx 		ax = ax + bx + carry

sbb	sub carry
sub 	ax,bx		ax = ax - bx
sbb	ax,bx		ax = ax - bx - carry

cmp
cmp	ax,bx		修改标志位,无符号比较

je	标号	jmp equal		a=b
jne	标号	jmp not equal		a!=b
jb	标号	jmp below		a<b 
jb	标号	jmp not below		a>=b
ja	标号	jmp above		a>b
jna	标号	jmp not above		a<=b

cld	设置DF 段 为 UP

;串传送指令
rep	movsb				;rep 重复 	movsb 复制字节   inc si		inc di
rep	movsw				;rep 重复	movsw 复制双字节

pushf	flag	作用：将标志位寄存器放入栈中
popf	flag	作用：将标志位寄存器从栈中取出	PSW：标志位寄存器


12章 内中断

中断：发生了需要CPU 立刻去处理的信息
中断信息：
1.除法错误，divide overflow 除法溢出
2.单步执行
3.执行into指令
4.执行int 指令

中断后需要一个程序去处理，改变执行位置 需要修改CS、IP ====》 需要处理的程序入口 段地址：偏移地址

中断向量表						中断类型码
0 号处理中断信息的程序地址	cs:ip					除法溢出 调用 int 0	
1 号处理中断信息的程序地址	cs:ip
2 号处理中断信息的程序地址	cs:ip

CPU 通过中断类型码 找到 中断向量表中程序地址的位置

中断向量表：
0000:0000 - 0000:03FFH
CS:IP 存储方式 ： CS = 中断码*4+2   IP = 中断码*4

0:200 - 0:3FFH 为安全区域（中断向量表）

中断过程：
1.取得中断类型码 N
2.保存标志位寄存器 =》 栈 pushf
3.将标志位寄存器的第8 TF 和第9位 IF 设置为0
4.push cs
5.push ip
6. cs = N*4+2  ip = N*4

iret ： pop ip ,pop cs,popf

十三、int 指令
中断过程：
1.取得中断类型码 N
2.保存标志位寄存器 =》 栈 pushf
3.将标志位寄存器的第8 TF 和第9位 IF 设置为0
4.push cs
5.push ip
6. cs = N*4+2  ip = N*4


BIOS
1.硬件系统的检测和初始化程序
2.将外部中断和内部中断程序登记在 中断向量表中
3.用于对 硬件设备进行I/O操作的中断程序 放到中断向量表中
4.其他相关于硬件系统的中断程序

电脑开机
CS = FFFF  IP = 0   指向BIOS
1.硬件初始化
2.将中断程序的cs 和ip 直接登记在中断向量表中
3.调用 int19H 进行操作系统的引导，将计算机交给操作系统控制 DOS
4.DOS 烯烃将响应的中断程序入口地址 存放到中断向量表中  包括程序 

端口

端口是有地址的
in 和 out 指令 只能使用 ax 或 al 来读取

in al,20H		;20H端口读取一个字节
out 20H,al		;往20H端口 写入一个字节

CMOS RAM 芯片
包含时钟，128个存储单元的RAM存储器，电池
0~DH 内存地址保存的是时间信息，其余大部分是保存系统信息，BIOS 	FFFF:0

2个端口  70H 地址端口 	71H数据端口		8位端口

比如读取 CNOS RAM 的2 号单元
1.将2 送入端口70H
2.从端口71H读取2号单元的内容

mov al,2
out 70H,al
in al,71H

CMOS RAM 的2号单元写入0
mov al,2
out 70H,al
mov al,0
out  71H,al

CMOS 时间信息

单位：	秒	分	小时	日	月	年
地址：	0	2	4	7	8	9
 
指令
shl  shr  逻辑移动指令

mov al,0000 0001
shl al,2	;往左移2位 al = 0000 0100
shr al,1	;往右移1位 al = 0000 0010

1.将一个寄存器或者内存单元中的数据向左移动 bit 位
2.将移出的这一位放入到CF中
3.最低位用0补充


第15章 外中断

中断程序	=》	中断向量表

外设 ： 键盘，鼠标，麦克风，摄像头 （输入）

所有中断分为两种：可屏蔽中断、不可屏蔽中断

不可屏蔽中断：外中断 	中断类型码2
pushf	IF = 0 TF = 0
push cs
push ip
IP = 2*4 CS = 2*4+2

可屏蔽中断			IF = 1		IF = 0
1.取得中断类型码
2.pushf
3.IF = 0 TF = 0
push cs
push ip
ip = n*4 cs = n*4+2

cli	IF = 0
sti	IF = 1

PC 机器键盘的处理过程

扫描码
按下时：通码
断码 = 通码 + 80H

in al,60H

BIOS 提供键盘中断处理程序
键盘的输入到达 60H端口
相关芯片	向CPU 发出中断类型码位 9 的屏蔽中断信息		9*4	9*4+2

如果IF = 1 那么就去执行 int 9 中断
1.读出60H端口的扫描码
2.如果时字符键的扫描码，将这个扫描码和对应的ASCII 码 放到BIOS 中的键盘缓冲区 (15个字型数据，15个4字节  高位字节存放扫描码，低位放ASCII码)
如果是控制键 ctrl shift 则将其转变为状态字节，记录到一个存储状态的字节单元 （0040:0017）

3.对键盘系统的相关控制，比如说，向相关芯片发出应答事情


直接定址表


BIOS 中断
int 16H 		读取键盘缓冲区
mov ah,0		传送功能号
ah = 扫描码	al = ASCII 码

读取
mov ah,0
int 16H

mov ah,0
int 16H


int 16H
1.检测键盘缓冲区是否有数据
2.没有的话继续检测
3.读取缓冲区第一个字型数据的键盘输入
4. ah = 高位 al = 低位
5.删掉读取的字型数据



int 13H 对磁盘进行读写

软盘 C盘 0面0道1扇

上下两面
0 1 面

面 = 80 磁道
道 = 18扇区
扇区 = 512


面号 从 0 开始
磁道 从 0 开始
扇区 从 1 开始


;读取
mov ax,0
mov es,ax
mov bx,200H

mov al,1	;读取的扇区数
mov ch,0	;读取的磁道号
mov cl,1	;扇区号
mov dl,0	;驱动器号	软驱A 0 	软驱B 1
mov dh,0	;面号（磁头）
;读取
mov ah,2
int 13H

;写入
mov ax,0
mov es,ax
mov bx,200H

mov al,1	;扇区数
mov ch,0	;磁道号
mov cl,1	;扇区号
mov dl,0	;驱动器号	软驱A 0 	软驱B 1
mov dh,0	;面号（磁头）
;写入
mov ah,3
int 13H


pusha  =		push ax,cx,dx,bx,sp,bp,si,di

pushad =		push eax,ecx,edx,ebx,esp,ebp,esi,edi

popa   =		pop di,si,bp,sp,bx,dx,cx,ax

popad  =		pop edi,esi,ebp,esp,ebx,edx,ecx,eax


