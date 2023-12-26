.model small
.data
    welcome DB 'Welcome, please enter binary number max(10 digits)',0Ah,0Dh,'$'
    error DB ' Not an obtion, sorry. Enter again: ',0Ah,0Dh,'$'
    obtions DB 'convert it to ',0Ah,0Dh,'1-decimal',0Ah,0Dh,'2-octal',0Ah,0Dh,'3-hexa',0Ah,0Dh, '9-End',0Ah,0Dh,'$'
    bnum DB 11 DUP('$')
    endl Db 0Ah,0Dh
    
    dec_result db 10    
    dec_result_len dw 0
.code
MAIN PROC  
    .startup

    ; print welcome
    MOV ah ,09h
    LEA dx , welcome
    int 21h
    
    ; read string
    MOV ah, 0Ah
    LEA dx, bnum
    INT 21h

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
    
    ; print error if not 1 or 2 or 3, and jump to obtion
    mov ah ,09h 
    LEA dx , error
    int 21h
    jmp obtion
    
    
    
decimal:
    
jmp endd 
octal:
    
    
    
jmp endd
hexadecimal:
    
    
    
      
endd:
    .EXIT 
MAIN ENDP
END MAIN