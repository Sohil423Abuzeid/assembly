.model small
.data
    fline DB 'welcome please enter binary numer max(10 digits)',0Ah,0Dh,'$'
    error DB 'mot option sorry',0Ah,0Dh,'$'
    sline DB 'convert it to ',0Ah,0Dh,'1-decimal',0Ah,0Dh,'2-octal',0Ah,0Dh,'3-hexa',0Ah,0Dh,'$'
    bnum DB 11
    endl Db 0Ah,0Dh
    
    dec_result db 10    
    dec_result_len dw 0
.code
MAIN PROC  
    mov ax ,@data
    mov ds, ax
    
    
    mov ah ,09h
    mov dx , offset fline
    int 21h
    
    
     mov ah, 0Ah ; 
     mov dx, offset bnum ;
    ; int 21h ;
   
    
    
    mov ah ,09h
    mov dx , offset sline
    int 21h
    mov ah, 01h ; 
    int 21h ; 
    
    
    ;switch
    cmp al,'1'
    je decimal
    cmp al,'2'
    je octal
    cmp al,'3'
    je hexadecimal
    
    mov ah ,09h   ;error 
    mov dx , offset error
    int 21h
    jmp endd
    
    
    
decimal:
    
jmp endd 
octal:
    
    
    
jmp endd
hexadecimal:
    
    
    
      
endd:
.EXIT 
MAIN ENDP
END MAIN