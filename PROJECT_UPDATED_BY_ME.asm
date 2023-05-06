 ORG 100H      
 .DATA 

A DB 032h, 088h, 031h, 0e0h
  DB 043h ,05ah, 031h ,037h
  DB 0f6h, 030h, 098h ,007h 
  DB 0a8h ,08dh, 0a2h, 034h 
  
KEY DB  02bh, 028h ,0abh, 009h 
    DB  07eh, 0aeh ,0f7h ,0cfh
    DB  015h ,0d2h ,015h, 04fh
    DB  016h ,0a6h ,088h, 03ch
     
    
M DB 002h, 003h ,001h, 001h
       DB 001h, 002h ,003h, 001h 
       DB 001h, 001h, 002h, 003h
       DB 003h, 001h, 001h, 002h 
C DB 0,0,0,0
  DB 0,0,0,0
  DB 0,0,0,0 
  db 0,0,0,0 
   
INPUT DB 0,0,0,0
      DB 0,0,0,0
      DB 0,0,0,0
      DB 0,0,0,0       
       
sbox DB 063h,07ch,077h,07bh,0f2h,06bh,06fh,0c5h,030h,001h,067h,02bh,0feh,0d7h,0abh,076h,
         DB 0cah,082h,0c9h,07dh,0fah,059h,047h,0f0h,0adh,0d4h,0a2h,0afh,09ch,0a4h,072h,0c0h,
         DB 0b7h,0fdh,093h,026h,036h,03fh,0f7h,0cch,034h,0a5h,0e5h,0f1h,071h,0d8h,031h,015h,
         DB 004h,0c7h,023h,0c3h,018h,096h,005h,09ah,007h,012h,080h,0e2h,0ebh,027h,0b2h,075h,
         DB 009h,083h,02ch,01ah,01bh,06eh,05ah,0a0h,052h,03bh,0d6h,0b3h,029h,0e3h,02fh,084h,
         DB 053h,0d1h,000h,0edh,020h,0fch,0b1h,05bh,06ah,0cbh,0beh,039h,04ah,04ch,058h,0cfh,
         DB 0d0h,0efh,0aah,0fbh,043h,04dh,033h,085h,045h,0f9h,002h,07fh,050h,03ch,09fh,0a8h,
         DB 051h,0a3h,040h,08fh,092h,09dh,038h,0f5h,0bch,0b6h,0dah,021h,010h,0ffh,0f3h,0d2h,
         DB 0cdh,00ch,013h,0ech,05fh,097h,044h,017h,0c4h,0a7h,07eh,03dh,064h,05dh,019h,073h,
         DB 060h,081h,04fh,0dch,022h,02ah,090h,088h,046h,0eeh,0b8h,014h,0deh,05eh,00bh,0dbh,
         DB 0e0h,032h,03ah,00ah,049h,006h,024h,05ch,0c2h,0d3h,0ach,062h,091h,095h,0e4h,079h,
         DB 0e7h,0c8h,037h,06dh,08dh,0d5h,04eh,0a9h,06ch,056h,0f4h,0eah,065h,07ah,0aeh,008h,
         DB 0bah,078h,025h,02eh,01ch,0a6h,0b4h,0c6h,0e8h,0ddh,074h,01fh,04bh,0bdh,08bh,08ah,
         DB 070h,03eh,0b5h,066h,048h,003h,0f6h,00eh,061h,035h,057h,0b9h,086h,0c1h,01dh,09eh,
         DB 0e1h,0f8h,098h,011h,069h,0d9h,08eh,094h,09bh,01eh,087h,0e9h,0ceh,055h,028h,0dfh,
         DB 08ch,0a1h,089h,00dh,0bfh,0e6h,042h,068h,041h,099h,02dh,00fh,0b0h,054h,0bbh,016h

RCON  db 01h,02h,04h,08h,10h,20h,40h,80h,01Bh,36h
      db 00,00,00,00,00,00,00,00,00,00
      db 00,00,00,00,00,00,00,00,00,00
      db 00,00,00,00,00,00,00,00,00,00    
      
COLUMN DB 0,0,0,0      
 
 
SUBBYTESKEY PROC 
   MOV AH,0
   MOV AL ,COLUMN[0] 
   mov di,ax 
   mov cl,sbox[di]
   mov COLUMN[0] ,cl 
   
   MOV AL ,COLUMN[1] 
   mov di,ax 
   mov cl,sbox[di]
   mov COLUMN[1] ,cl
   
   MOV AL ,COLUMN[2] 
   mov di,ax 
   mov cl,sbox[di]
   mov COLUMN[2] ,cl 
   
   MOV AL ,COLUMN[3] 
   mov di,ax 
   mov cl,sbox[di]
   mov COLUMN[3] ,cl 
   RET
   ENDP
      
KEYSCHEDULE PROC  
    MOV SI,0 
    MOV AH, KEY[3]
    MOV AL, KEY[7]
    MOV BH, KEY[11]
    MOV BL, KEY[15] 
    MOV  COLUMN[0],AL
    MOV  COLUMN[1],BH
    MOV  COLUMN[2],BL 
    MOV  COLUMN[3],AH 
    
    CALL SUBBYTESKEY 
    
    MOV AH, KEY[0]
    MOV AL, KEY[4]
    MOV BH, KEY[8]
    MOV BL, KEY[12] 
    XOR COLUMN[0],AH
    XOR COLUMN[1],AL
    XOR COLUMN[2],BH
    XOR COLUMN[3],BL 
    
    MOV AH, RCON[BP]
    XOR COLUMN[0],AH
    
    MOV AH,COLUMN[0] 
    MOV KEY[SI],AH
    MOV AH,COLUMN[1]
    MOV KEY[SI+4],AH
    MOV AH,COLUMN[2]
    MOV KEY[SI+8],AH
    MOV AH,COLUMN[3]
    MOV KEY[SI+12],AH 
    
    
 FF:   INC SI 
    MOV AH,KEY[SI-1]
    XOR KEY[SI],AH 
    MOV AH,KEY[SI+3]
    XOR KEY[SI+4],AH
    MOV AH,KEY[SI+7]
    XOR KEY[SI+8],AH
    MOV AH,KEY[SI+11]
    XOR KEY[SI+12],AH 
    CMP SI,3
    JNZ FF
  INC BP  
    
    
    
     RET
     ENDP      
     
SUBBYTES PROC 
    MOV SI ,0
   L1: mov ah,0
    MOV AL ,a[Si] 
   mov di,ax 
   mov cl,sbox[di]
   mov a[si] ,cl   
    INC SI 
    CMP SI,16
    JNZ L1   
  RET 
ENDP
RESETC PROC
    MOV AH,0
    MOV SI,0
    KAR:MOV C[SI],AH
    INC SI
    CMP SI,16
    JNZ KAR
    RET 
    ENDP   
 
SHIFTROWS2 PROC 
    MOV DX,1   
  J:MOV CX,DX 
    MOV AL,DL  
    MOV BL,4
    MUL BL
    MOV SI,AX 
    L:MOV AH,A[SI] 
       MOV AL,A[SI+1]
       MOV A[SI],AL
       MOV AL,A[SI+2]
       MOV A[SI+1],AL
       MOV AL,A[SI+3]
       MOV A[SI+2],AL
       MOV A[SI+3],AH
       LOOP L 
   INC DX
   CMP DX,4
   JNZ J
   RET
ENDP 


ADDROUNDKEY PROC  
    MOV CX,16
    MOV SI,0
    L2:MOV AH,KEY[SI] 
       XOR A[SI],AH
       INC SI 
       LOOP L2 
         
    RET   
ENDP 

;    --------------------------------------------------  
;         ----------------------------------------- 
;               --------------------------



MULT1 MACRO VALUE_STATE ,INDEX_C  
    MOV AH,VALUE_STATE
    MOV DI,INDEX_C 
    XOR C[DI],AH
ENDM

MULT20 MACRO VALUE_STATE ,INDEX_C  
      MOV AH, VALUE_STATE
      MOV DI, INDEX_C
      XOR C[DI],AH
ENDM
MULT21 MACRO VALUE_STATE,INDEX_C      
      MOV AH, VALUE_STATE
      XOR AH, 1Bh            
      MOV DI, INDEX_C
      XOR C[DI],AH
ENDM   
MULT31 MACRO  VALUE_STATE ,INDEX_C
      MOV AH,   VALUE_STATE
      MOV DI, INDEX_C 
      MOV AL,AH 
      RCR AL,1
      XOR AH ,1BH
      XOR AH,AL
      XOR C[DI],AH
      



ENDM
MULT30 MACRO  VALUE_STATE ,INDEX_C
      MOV AH,   VALUE_STATE
      MOV DI, INDEX_C
      MOV AL,AH 
      RCR AL,1
      XOR AH,AL 
      XOR C[DI],AH
      


ENDM 
     
MIXCOLUMNS PROC
    MOV CX,0   ;CX INDEX OF C
    MOV SI,0   ;SI INDEX THAT WILL LOOP ON COLUMNS OF A    
  LO0:MOV BH,A[SI]
       clc
       SHL BH,1
       JC Y
       JNC Z
    Y: MULT21 BH,CX     ;     R0,COL0  -->C[CX=0]
    JMP X
    Z: MULT20 BH,CX
         
    X: MOV BH,A[SI+4]       ;     R0,COL1 -->C[CX=1]
      SHL BH,1
      JC Y0
      JNC Z0
      Y0:MULT31 BH,CX
      JMP X1
      Z0:MULT30 BH,CX 
       
      X1:MULT1 A[SI+8],CX    ;     R0,COL2 -->C[CX=2]
         MULT1 A[SI+12],CX   ;     R0,COL3 -->C[CX=3]
     INC SI
     INC CX  
     CMP SI,4 
     JNZ LO0   
    
   
   
       mov si,0 
       clc
   LO1:MULT1 A[SI],CX
   
      
     MOV BH,A[SI+4]
       clc
       SHL BH,1
       JC Y2
       JNC Z2
    Y2: MULT21 BH,CX     ;     R0,COL0  -->C[CX=0]
    JMP X2
    Z2: MULT20 BH,CX
    
      
     X2: MOV BH,A[SI+8]       ;     R0,COL1 -->C[CX=1]
      clc
      SHL BH,1
      JC Y3
      JNC Z3
      Y3:MULT31 BH,CX
      JMP X3
      Z3:MULT30 BH,CX
       
      
      X3: MULT1 A[SI+12],CX
     INC SI 
    INC CX
     CMP SI,4
     JNZ LO1
   
  
  
  
  
  
  mov si,0
  LO2:
   MULT1 A[SI],CX
   MULT1 A[SI+4],CX 
   mov bh,A[si+8]
   shl bh,1
   jc ad1
   jnc ad2
   ad1:MULT21 BH,CX
   jmp hm
   ad2:MULT20 BH,CX  
   hm:
   mov bh,A[si+12]
   clc
   shl bh,1
   jc Y4
   jnc Z4 
   Y4:MULT31 BH,CX
   jmp x4
   Z4:MULT30 BH,CX 
   x4:INC SI 
    INC CX
     CMP SI,4
     JNZ LO2
   
 
 MOV SI,0
L03: MOV BH, A[SI]
 CLC
 SHL BH,1
 JC YY
 JNC ZZ
 YY:MULT31 BH,CX
 JMP XX
 ZZ: MULT30 BH,CX
 XX:MOV BH, A[SI+4]
 MULT1 BH,CX
 MOV BH,A[SI+8]
 MULT1 BH,CX
 MOV BH, A[SI+12]
 CLC
 SHL BH,1
 JC RR
 JNC LL
 RR:MULT21 BH,CX
 JMP AA
 LL:MULT20 BH,CX
 AA: INC SI
 INC CX
 CMP SI,4
 JNZ L03         
     MOV SI,0 
     LOOOP:   MOV AH,C[SI]
          MOV A[SI],AH
          INC SI
          CMP SI,16
          JNZ LOOOP
    CALL RESETC              
    RET 
    ENDP 

    
;-------------------------------------------------
WRITE PROC 
      MOV SI,0
      MOV AH ,1 
     YAS: INT 21H;INPUT FROM THE USER--->AL
       CMP AL,40H
       JS NUMBERS
       JNS LETTERS
       NUMBERS: SUB AL,30H
       JMP NEXT
       LETTERS:SUB AL,57H
     NEXT: mov cl,10h
      mul cl
      mov cl,al 
      MOV AH ,1
      INT 21H;INPUT FROM THE USER--->AL
       CMP AL,40H
       JS NUMBERS1 
       JNS LETTERS1
       NUMBERS1: SUB AL,30H
       JMP NORMAL
       LETTERS1:SUB AL,57H 
       NORMAL:add cl,al
       mov A[SI],cl
        
      INC SI
      CMP SI ,16
      JNZ YAS
    RET
ENDP
 
READ PROC 
    MOV SI,0
    MOV AH,2 
    MOV DL,' '
     INT 21H
     
  RAN:MOV AH,0  
  MOV AL,A[SI]
    MOV CL,10H
    DIV CL;Q AL R AH
    MOV DL,AL
    MOV DH,AH
     MOV AH,2
     CMP DL,10
     JS NUMBERS2
     JNS LETTERS2
     NUMBERS2: ADD DL,30H
     JMP NORMAL2
     LETTERS2:ADD DL,57H
     NORMAL2:INT 21H;MOV DL,A[SI] 
     MOV DL,DH
     CMP DL,10
     JS NUMBERS3
     JNS LETTERS3
     NUMBERS3: ADD DL,30H
     JMP NORMAL3
     LETTERS3:ADD DL,57H
     NORMAL3:INT 21H
            
     MOV DL,' '
     INT 21H
     INC SI
     CMP SI ,16
     JNZ RAN
   
    RET 
ENDP  
;................................................. 

.CODE

BISMALLAH :
MOV BP,0
CALL WRITE
    ;INTIALROUND
   CALL ADDROUNDKEY
   CALL KEYSCHEDULE
   MOV Dx,0 
   STAGE:push dx
   CALL SUBBYTES
   CALL SHIFTROWS2  
   CALL MIXCOLUMNS
   CALL ADDROUNDKEY 
   CALL KEYSCHEDULE
   pop dx
   INC Dx
   CMP Dx,9
   JNZ STAGE
   ;FINAL ROUND 
   CALL SUBBYTES
   CALL SHIFTROWS2
   CALL ADDROUNDKEY   
   CALL READ
     
    RET
    

