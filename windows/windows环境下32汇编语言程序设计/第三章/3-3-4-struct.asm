                .386
                .model      flat,stdcall
                option      casemap:none

;-----------------------------------------------------------
;   定义自己的数据结构
;-----------------------------------------------------------
MY_STRUCT       struct

id              DWORD       ?
node            WORD        ?
index           BYTE        ?
;-----------------------------------------------------------
;   结构的嵌套
;-----------------------------------------------------------
NEW_STRUCT      struct
mystruct        MY_STRUCT   <>
id              dword       ?
;-----------------------------------------------------------
;   数据段中给出数据结构
;-----------------------------------------------------------
                .data
my_struct1      MY_STRUCT       <>
my_struct2      MY_STRUCT       <1,2,0001B>         ;初始化结构内的变量
my_struct3      NEW_STRUCT      <my_struct1,3>
;-----------------------------------------------------------
;   代码段中数据结构的引用
;-----------------------------------------------------------
                .code
start:
;               第一种直接取定义在.data中的结构体
                mov         eax,my_struct1.id
                mov         ax,my_struct1.node
                mov         al,my_struct1.index

;               第二种，利用esi取
                mov         esi,offset my_struct2
                mov         eax,[esi + MY_STRUCT.id]
                mov         ax,[esi + MY_STRUCT.node]
                mov         al,[esi + MY_STRUCT.index]

;               第三种用 assume 伪指令把寄存器预先定义为结构指针
                mov         esi,offset my_struct3
                assume      esi:ptr NEW_STRUCT
                mov         eax,[esi].id
                mov         ebx,[esi].mystruct

                assume      esi:nothing


end             start
