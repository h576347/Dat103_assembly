cr equ 13 ; Vognretur
lf equ 10 ; Linjeskift
SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1
STDERR equ 2

section .bss
a resb 1

section .data
nl dw 0xa
nlLen equ $ - nl
crlf db cr,lf
crlflen equ $ - crlf

section .text
global _start

_start:
mov [a], byte 0
mov ecx, 0

start_for:
cmp ecx, 20
jl start_if
je _slutt
_hopp:
inc ecx
jmp start_for

start_if:
cmp ecx, 10
jge else_if
inc byte [a]
jmp _hopp

else_if:
dec byte [a]
jmp _hopp

_slutt:
add byte [a], '0'
mov eax, 4	;sys_write
mov ebx, 1	;Std_out
mov ecx, a	;flytt a til ecx
mov edx, 1	;lengden på utskriften
int 0x80
call nylinje

mov eax, 1	;sys_exit
mov ebx, 0	;korrekt avsluttet
int 80h

nylinje:
push eax
push ebx
push ecx
push edx
mov edx,crlflen
mov ecx,crlf
mov ebx,STDOUT
mov eax,SYS_WRITE
int 80h
pop edx
pop ecx
pop ebx
pop eax
ret 

