.model small
.data
    welcome DB 'Welcome, please enter binary number max(10 digits)',0Ah,0Dh,'Press e to end',0Ah,0Dh,'$'
    msg1 DB 0Ah,0Dh,'You entered: ',0Ah,0Dh,'$'
    error DB ' Not an option, sorry. Enter again: ',0Ah,0Dh,'$'
    obtions DB 0Ah,0Dh,'convert it to ',0Ah,0Dh,'1-decimal',0Ah,0Dh,'2-octal',0Ah,0Dh,'3-hexa',0Ah,0Dh, '9-End',0Ah,0Dh,'$'
    bnum DB 11 DUP(?) ; buffer to store the binary number
    endl DB 0Ah,0Dh
    
    dec_result db 6 dup (?) ; decimal result will be stored here 
    oct_result db 5 dup (?) ; octal result will be stored here 
    dec_result_len dw 0
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
READ:
    MOV AH, 01h ; set the function to read a character from the keyboard
    INT 21H ; call the interrupt
    MOV [SI], AL ; store the character in the buffer
    CMP AL, 65H ; compare the character to 'e'
    JE string_end ; if equal, jump string_end
    INC SI ; increment the pointer
    XOR AX, AX
    LOOP READ ; repeat until CX = 0
string_end:
    MOV BYTE PTR [SI], '$' ; add the string terminator
    LEA DX, msg1 ; load the address of the message into DX
    MOV AH, 09h ; set the function to print a string
    INT 21h ; call the interrupt
    LEA DX, bnum ; load the address of the buffer into DX
    MOV AH, 09h ; set the function to print a string
    INT 21h ; call the interrupt

    
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

    jmp endd
    
octal:

    jmp endd



hexadecimal:
    ; code for converting binary to hexadecimal goes here
    
    jmp endd
      
endd:
    .EXIT 
MAIN ENDP
END MAIN