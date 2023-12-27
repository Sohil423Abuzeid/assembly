.model small
.data
    welcome db "Welcome to the Test", 0dh, 0ah, "$"

    Q1 db "What is the capital of India?", 0dh, 0ah, "$"
    Q1_A db "A. Delhi", 0dh, 0ah, "$"
    Q1_B db "B. Mumbai", 0dh, 0ah, "$"
    Q1_C db "C. Chennai", 0dh, 0ah, "$"
    Q1_D db "D. Kolkata", 0dh, 0ah, "$"

    Q2 db "What is the capital of Australia?", 0dh, 0ah, "$"
    Q2_A db "A. Sydney", 0dh, 0ah, "$"
    Q2_B db "B. Melbourne", 0dh, 0ah, "$"
    Q2_C db "C. Canberra", 0dh, 0ah, "$"
    Q2_D db "D. Perth", 0dh, 0ah, "$"

    Q3 db "What is the capital of Japan?", 0dh, 0ah, "$"
    Q3_A db "A. Tokyo", 0dh, 0ah, "$"
    Q3_B db "B. Kyoto", 0dh, 0ah, "$"
    Q3_C db "C. Osaka", 0dh, 0ah, "$"
    Q3_D db "D. Hiroshima", 0dh, 0ah, "$"

    Q4 db "What is the capital of China?", 0dh, 0ah, "$"
    Q4_A db "A. Beijing", 0dh, 0ah, "$"
    Q4_B db "B. Shanghai", 0dh, 0ah, "$"
    Q4_C db "C. Hong Kong", 0dh, 0ah, "$"
    Q4_D db "D. Macau", 0dh, 0ah, "$"

    correct_msg db 0dh, 0ah,"Correct Answer", 0dh, 0ah, "$"
    incorrect_msg db 0dh, 0ah, "Incorrect Answer", 0dh, 0ah, "$"
    score_msg db 0dh, 0ah, "Your score is: ", "$"

.code
MAIN PROC FAR 
    .startup
    mov cx, 0
    MOV DX, OFFSET welcome
    MOV AH, 09H
    INT 21H
    ; Question 1
    CALL quetion_1
    CALL check_q1

    ; Question 2
    CALL question_2
    CALL check_q2

    ; Question 3
    CALL question_3
    CALL check_q3

    ; Question 4
    CALL question_4
    CALL check_q4

    ; Display score
    MOV AH, 09H
    MOV DX, OFFSET score_msg
    INT 21H
    MOV AH, 02H
    MOV DL, CL
    add dl, 30h
    INT 21H
    .exit
MAIN ENDP

quetion_1 Proc NEAR 
    mov ah, 09h

    mov dx, offset Q1
    int 21h
    mov dx, offset Q1_A
    int 21h
    mov dx, offset Q1_B
    int 21h
    mov dx, offset Q1_C
    int 21h
    mov dx, offset Q1_D
    int 21h
    ret
quetion_1 ENDP

question_2 Proc NEAR
    mov ah, 09h

    mov dx, offset Q2
    int 21h
    mov dx, offset Q2_A
    int 21h
    mov dx, offset Q2_B
    int 21h
    mov dx, offset Q2_C
    int 21h
    mov dx, offset Q2_D
    int 21h
    ret
question_2 ENDP

question_3 Proc NEAR
    mov ah, 09h

    mov dx, offset Q3
    int 21h
    mov dx, offset Q3_A
    int 21h
    mov dx, offset Q3_B
    int 21h
    mov dx, offset Q3_C
    int 21h
    mov dx, offset Q3_D
    int 21h
    ret
question_3 ENDP

question_4 Proc NEAR
    mov ah, 09h

    mov dx, offset Q4
    int 21h
    mov dx, offset Q4_A
    int 21h
    mov dx, offset Q4_B
    int 21h
    mov dx, offset Q4_C
    int 21h
    mov dx, offset Q4_D
    int 21h
    ret
question_4 ENDP

check_q1 Proc NEAR
    mov ah, 01h
    int 21h
    cmp al, 'A'
    je correct_q1
    cmp al, 'a'
    je correct_q1
    jmp incorrect_q1
    correct_q1:
        mov ah, 09h
        mov dx, offset correct_msg
        int 21h
        inc cx ; increment the correct answer count
        ret
    incorrect_q1:
        mov ah, 09h
        mov dx, offset incorrect_msg
        int 21h
        ret
check_q1 ENDP

check_q2 Proc NEAR
    mov ah, 01h
    int 21h
    cmp al, 'C'
    je correct_q2
    cmp al, 'c'
    je correct_q2
    jmp incorrect_q2
    correct_q2:
        mov ah, 09h
        mov dx, offset correct_msg
        int 21h
        inc cx ; increment the correct answer count
        ret
    incorrect_q2:
        mov ah, 09h
        mov dx, offset incorrect_msg
        int 21h
        ret
check_q2 ENDP

check_q3 Proc NEAR
    mov ah, 01h
    int 21h
    cmp al, 'A'
    je correct_q3
    cmp al, 'a'
    je correct_q3
    jmp incorrect_q3
    correct_q3:
        mov ah, 09h
        mov dx, offset correct_msg
        int 21h
        inc cx ; increment the correct answer count
        ret
    incorrect_q3:
        mov ah, 09h
        mov dx, offset incorrect_msg
        int 21h
        ret
check_q3 ENDP

check_q4 Proc NEAR
    mov ah, 01h
    int 21h
    cmp al, 'A'
    je correct_q4
    cmp al, 'a'
    je correct_q4
    jmp incorrect_q4
    correct_q4:
        mov ah, 09h
        mov dx, offset correct_msg
        int 21h
        inc cx ; increment the correct answer count
        ret
    incorrect_q4:
        mov ah, 09h
        mov dx, offset incorrect_msg
        int 21h
        ret
check_q4 ENDP

END MAIN