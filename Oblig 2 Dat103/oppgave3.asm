; Konstanter 
cr equ 13 ; Vognretur 
lf equ 10 ; Linjeskift 
  
section .text 

global _start 

_start: 
mov ecx, 12         ;flytter tallet 12 inn i ecx 
mov eax,'1'         ;flytter tallet 1 inn i eax 
  
l1: 
  
mov [num], eax      ;Tallet i eax blir flyttet inn i num 
mov [tall], eax 
  
cmp eax, '9' 
ja skrivtosiffer    ;dersom over 9, kall metoden for 2 siffer 
  
mov eax, 4          ;skrive ut tallet 
mov ebx, 1           
push ecx            ;stabel -> FILO 
  
mov ecx, num        ;Flytter tallet inn i ecx 
mov edx, 1             
int 0x80      
    

sistedel: 
mov eax, [num]      ;flytt nummeret inn i eax 
sub eax,'0'            ;gjøre det om til tall 
inc eax                ;øker tallet til eax 
call nylinje

cmp eax,13 
je slutt 
add eax,'0'            ;gjøre det om til string 
pop ecx                ;tar ut tallet i ecx 
loop l1                ;begynner løkka på nytt 
  
mov edx,nlLen         
mov ecx,nl            ;flytter nl inn i ecx 
mov ebx,1            ;STDOUT 
mov eax,4            ;Skrive ut 
int 0x80            ;interrupt 

slutt: 
mov eax,1            ;avslutte programmet 
int 0x80            ;interrupt 
 

section .bss 
num resb 1 
siffer resb 4 
sifferb resb 4 
tall resb 4 
  

segment .data 
nl dw 0xa,cr,lf 
nlLen equ $ - nl 
crlf db cr,lf 
crlflen equ $ - crlf 

  

;-------------------------------------- 
  

nylinje: 

push eax 
push ebx 
push ecx 
push edx 
mov edx,crlflen 
mov ecx,crlf 
mov ebx,1 
mov eax,4 
int 0x80 
pop edx 
pop ecx 
pop ebx 
pop eax 
ret 

  

;----------------------------------- 

;skriv ut ett-tall først  

skrivtosiffer:  
push ebx                ; bruker push til å ta vare på gamle verdier 
push ecx  
push edx  
push eax  
mov ecx,'1'             ; setter 1 inn i ecx 
mov [sifferb],ecx       ; setter ecx inn i sifferb 
mov ecx,sifferb         ; setter sifferb inn i ecx 
mov edx,1  
mov ebx,1  
mov eax,4                
int 0x80                

mov ecx,[tall]          ; setter tall inn i ecx 
sub ecx, 10             ; nummeret minus 10 
mov [tall], ecx         ; setter ecx inn i num 
mov eax,tall            ; setter tall inn i eax 
call skriv 
int 0x80 
pop edx  
pop ecx  
pop ebx  
pop eax  
ret 
  

  

skriv: 
mov ecx, tall            ;Flytter tallet inn i ecx 
mov edx, 1               ;Lengde på nummeret 
mov eax, 4               ;skrive ut tallet 
mov ebx, 1               ;STDOUT 
int 0x80                 ;Avslutter 
call sistedel 
ret 

 
