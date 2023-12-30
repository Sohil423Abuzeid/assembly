.model small
.STACK 300h
.data
    start db "================================",0Ah,0Dh,"Assembly Language Program to convert binary number to decimal, octal and hexadecimal",0Ah,0Dh,0Ah,0Dh,"Developed By:",0Ah,0Dh, "1- Saad Al-Tohamy",0Ah,0Dh,"2- Sohil Mohammed",0Ah,0Dh,"================================",0Ah,0Dh,"$"
    end_msg db 0Ah,0Dh,"================================",0Ah,0Dh,"Thank you for using our program",0Ah,0Dh,"================================",0Ah,0Dh,"$"
    welcome DB 'Welcome, please enter binary number (MAX = 16 digits)',0Ah,0Dh,'Press ENTER to end',0Ah,0Dh,'$'
    error DB ' Not an option, sorry. Enter again: ',0Ah,0Dh,'$'
    obtions DB 0Ah,0Dh,0Ah,0Dh,'Convert it to ',0Ah,0Dh,'1- Decimal',0Ah,0Dh,'2- Octal',0Ah,0Dh,'3- Hexadecimal',0Ah,0Dh, '9-End',0Ah,0Dh,'$'
    deci_msg DB 0Ah,0Dh,0Ah,0Dh,'Decimal is: ','$'
    oct_msg DB 0Ah,0Dh,0Ah,0Dh,'Octal is: ','$'
    hex_msg DB 0Ah,0Dh,0Ah,0Dh,'Hexadecimal is: ','$'
    bnum DB 11 DUP(?)       ; buffer to store the binary number
    rbnum DB 11 DUP(?)      ; buffer to store the reversed binary number
    lenght_bnum db 0        ; lenght of the binary number
.code
MAIN PROC FAR
    .startup
    ; print start
    MOV ah ,09h
    LEA dx , start
    int 21h

    ; print welcome
    MOV ah ,09h
    LEA dx , welcome
    int 21h
    xor ax, ax          ; clear ax register

    
    ; Read string
    LEA SI, bnum
    MOV CX, 16
    mov bx, 0           ; counter for the lenght of the binary number
READ:
    MOV AH, 01h 
    INT 21H             ; read a character
    MOV [SI], AL        ; store the character in the buffer
    CMP AL, 0Dh         ; if equal to carriage return "Enter", jump string_end
    JE string_end       ; if equal, jump string_end
    INC SI              ; increment the pointer
    XOR AX, AX
    inc bx 
    LOOP READ           ; repeat until CX = 0
string_end:
    MOV BYTE PTR [SI], '$' ; add the string terminator

;--------------------------------------------------------------
; reverse bnum 
; take two strings and store the reversed into second string 
; by usring two pointers
;--------------------------------------------------------------
    dec si
    LEA di, rbnum       ; load the address of the buffer into SI
    MOV CX, bx          ; set the counter to 10
reverse:
    mov al ,[si] 
    mov [di] ,al
    inc di
    dec si
    loop reverse
    
    ; add the string terminator
    inc di
    MOV BYTE PTR [SI], '$' ;
    
    xor si, si

mov lenght_bnum, bl     ; store the lenght of the binary number in lenght_bnum



    ; print obtions
obtion:
    mov ah, 09h
    LEA dx, obtions
    int 21h

    ; read obtion and store it in al
    mov ah, 01h ; 
    int 21h ; 
    
    
    ;switch
    cmp al,'1' ; decimal obtion
    je decimal
    
    cmp al,'2' ; octal obtion
    je octal
    
    cmp al,'3' ; hex obtion
    je hex

    cmp al,'9' ; end obtion
    je endd
    
    ; print error if not 1 or 2 or 3 or 9, and jump to obtion
    mov ah ,09h 
    LEA dx , error
    int 21h
    jmp obtion 

decimal:
    call convert
    call print_dec
    jmp endd

octal:
    call convert
    call print_oct
    jmp endd

hex: 
    call convert
    call print_hex
    jmp endd

endd:
    ; print end_msg
    MOV ah ,09h
    LEA dx , end_msg
    int 21h
    .EXIT 
MAIN ENDP

convert PROC NEAR
;-----------------------------------------------------------------------
; Procedure: convert
; Description: This procedure converts a binary number to a hexadecimal number.
; Input:
;   - rbnum: The reversed-binary number to be converted
; Output:
;   - bx: The hexadecimal representation of the binary number
; Registers modified:
;   - cx: Used as a loop counter
;   - bx: Stores the hexadecimal answer
;   - dx: Used for multiplication by 2
;   - di: Points to the current digit of the binary number
;-----------------------------------------------------------------------
    mov cx ,bx 
    xor bx ,bx ;reset to zero to store answer
    mov dx ,1  ;
    LEA di, rbnum
conv_b_h: ; covert binary to Hex loop
    cmp byte ptr [di], 30h
    je no_value ;if current digit equal 0 skip
    add bx ,dx
no_value:
    inc di
    shl dx, 1 ;multi dx by 2 
    loop conv_b_h
    ret
convert ENDP

print_dec PROC NEAR
;--------------------------------------------------------------
; Procedure: print_dec
; Description: This procedure prints the decimal value stored in the BX register.
; Input: None
; Output: None
; Registers Modified: AX, BX, CX, DX
;--------------------------------------------------------------
    mov ax, bx        ; Move the value in BX to AX
    mov cx, 10        ; Set CX to 10 for division
    mov bx, 0         ; Clear BX to use it as a counter
    mov dx, 0         ; Clear DX to store remainder

    L1:
        div cx        ; Divide AX by CX, quotient in AX, remainder in DX
        push dx       ; Push the remainder onto the stack
        xor dx, dx    ; Clear DX for the next division
        inc bx        ; Increment BX to keep track of the number of digits
        cmp ax, 0     ; Compare AX with 0
        jne L1        ; Jump to L1 if AX is not zero

    lea dx, deci_msg  ; Load the address of the message to DX
    mov ah, 9         ; Set AH to 9 to print a string
    int 21h           ; Call the DOS interrupt to print the message

    L2:
        pop dx         ; Pop the remainder from the stack to DX
        add dl, 30h    ; Convert the remainder to ASCII character
        mov ah, 2      ; Set AH to 2 to print a character
        int 21h        ; Call the DOS interrupt to print the character
        dec bx         ; Decrement BX to iterate through all the digits
        cmp bx, 0      ; Compare BX with 0
        jne L2         ; Jump to L2 if BX is not zero

    ret               ; Return from the procedure
print_dec ENDP

print_oct PROC NEAR
;--------------------------------------------------------------
; Procedure: print_oct
; Description: This procedure prints the octal representation of a number stored in the BX register.
; Input: None
; Output: None
; Registers modified: AX, BX, CX, DX, AH
;--------------------------------------------------------------
    mov ax, bx
    mov cx, 8
    mov bx, 0
    mov dx, 0
    L1_oct:
        div cx
        push dx
        xor dx, dx
        inc bx
        cmp ax, 0
        jne L1_oct

    lea dx, oct_msg
    mov ah, 9
    int 21h 

    L2_oct:
        pop dx
        add dl, 30h
        mov ah, 2
        int 21h
        dec bx
        cmp bx, 0
        jne L2_oct
    ret
print_oct ENDP

print_hex proc near
;--------------------------------------------------------------
; Function: print_hex
; Description: This procedure prints the hexadecimal representation
;              of the value stored in the BX register.
; Input: None
; Output: None
; Registers modified: AX, BX, CX, DX, AH
;--------------------------------------------------------------
    mov ax, bx
    mov cx, 16
    mov bx, 0
    mov dx, 0
    L1_hex:
        div cx
        push dx
        xor dx, dx
        inc bx
        cmp ax, 0
        jne L1_hex
    
    lea dx, hex_msg
    mov ah, 9
    int 21h

    L2_hex:         ; loop for print the hex number if num < 9
        pop dx
        cmp dx, 9   ; if num > 9
        jg L3_hex
        add dl, 30h
        mov ah, 2
        int 21h
        dec bx
        cmp bx, 0
        jne L2_hex
        ret
    L3_hex:         ; loop for print the hex charachter if num > 9
        add dl, 37h
        mov ah, 2
        int 21h
        dec bx
        cmp bx, 0
        jne L2_hex
    ret
print_hex endp

END MAIN


