.model small
.STACK 300h
.data
    welcome DB 'Welcome, please enter binary number max(10 digits)',0Ah,0Dh,'Press e to end',0Ah,0Dh,'$'
    msg1 DB 0Ah,0Dh,'You entered: ',0Ah,0Dh,'$'
    error DB ' Not an option, sorry. Enter again: ',0Ah,0Dh,'$'
    obtions DB 0Ah,0Dh,0Ah,0Dh,'convert it to ',0Ah,0Dh,'1-decimal',0Ah,0Dh,'2-octal',0Ah,0Dh,'3-hexa',0Ah,0Dh, '9-End',0Ah,0Dh,'$'
    bnum DB 11 DUP(?) ; buffer to store the binary number
    rbnum DB 11 DUP(?) ; buffer to store the reversed binary number
    fdnum DB 11 DUP(?) ; buffer to store the final decimal answer number
    length_msg db 0Ah,0Dh,'Length is: ','$'
    lenght_bnum db 0 ; lenght of the binary number
    fans db 0 ; final answer
    hex_num db 5 DUP ('$') ; buffer to store the hexadecimal number
    endl DB 0Ah,0Dh
    
    dec_result db 6 dup (?) ; decimal result will be stored here 
    oct_result db 5 dup (?) ; octal result will be stored here 
    dec_result_len db 0
.code
MAIN PROC  
    .startup

    ; print welcome
    MOV ah ,09h
    LEA dx , welcome
    int 21h
    xor ax, ax ; clear ax register

    
    ; Read string
    LEA SI, bnum ; load the address of the buffer into SI
    MOV CX, 10 ; set the counter to 10
    mov bx, 0 ; counter for the lenght of the binary number
READ:
    MOV AH, 01h 
    INT 21H ; read a character
    MOV [SI], AL ; store the character in the buffer
    CMP AL, 0Dh ; if equal to carriage return "Enter", jump string_end
    JE string_end ; if equal, jump string_end
    INC SI ; increment the pointer
    XOR AX, AX
    inc bx 
    LOOP READ ; repeat until CX = 0
string_end:
    MOV BYTE PTR [SI], '$' ; add the string terminator
    ;;;reverse bnum
    dec si
    LEA di, rbnum ; load the address of the buffer into SI
    MOV CX, bx ; set the counter to 10
reverse:
    mov al ,[si] 
    mov [di] ,al
    inc di
    dec si
    loop reverse
    
    ; add the string terminator
    inc di
    MOV BYTE PTR [SI], '$' ;
    ;;;
    LEA DX, msg1 
    MOV AH, 09h 
    INT 21h ; print msg1 "You entered:"

    LEA DX, bnum 
    MOV AH, 09h 
    INT 21h ; print the binary number

    xor si, si
    lea dx, length_msg
    mov ah, 09h
    int 21h ; print "Length is:"

    mov lenght_bnum, bl ; store the lenght of the binary number in lenght_bnum
    mov dl, lenght_bnum
    add dl, 30h
    MOV AH, 02h
    INT 21h ; print the lenght of the binary number


    ; print obtions
obtion:
    mov ah, 09h
    LEA dx, obtions
    int 21h

    ; read obtion and store it in al
    mov ah, 01h ; 
    int 21h ; 
    
    
    ;switch
    cmp al,'1'
    je decimal
    cmp al,'2'
    je octal
    cmp al,'3'
    je hexadecimal
    cmp al,'9'
    je endd
    
    ; print error if not 1 or 2 or 3 or 9, and jump to obtion
    mov ah ,09h 
    LEA dx , error
    int 21h
    jmp obtion
    
decimal:
    mov cx ,bx 
    xor bx ,bx ;reset to zero to store answer
    mov dx ,1  ;
    LEA di, rbnum
cbd: ; covert binary to decimal loop
    cmp [di],'0'
    je novalue ;if current digit equal 0 skip
    add bx ,dx
novalue:
    inc di
    shl dx, 1 ;multi dx by 2 
    loop cbd
    
    ;;;;;;;;;;;;;;;;strore decimal in string 
    LEA di, fdnum 
    mov cx,0ah
    xor ax,ax 
    mov ax,bx 
    ST : ; bx still bigger than 0  
    xor dx,dx 
    div cx
    mov bx ,ax
    add dl ,30h
    mov [di],dl
    inc di
    mov ax,bx 
    
    test ax, ax    ; Check if quotient is zero
    jnz ST ; If not, continue the loop
     dec di
     ;;;;;;;;;;;;;;;;;;;;
         mov ah ,02h
         LEA si, fdnum
 printt :
     mov ah ,02h
     mov dl , [di]
     int 21h
     dec di
     cmp di,si
     jne printt
     mov dl , [di]
     int 21
    jmp endd
    
   
    
octal:
    jmp endd

hexadecimal:

    jmp endd
    
endd:
    .EXIT 
MAIN ENDP
END MAIN