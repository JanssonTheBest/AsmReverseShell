.386
.model flat, stdcall
option casemap:none
.stack 4096

includelib kernel32.lib
includelib user32.lib
includelib Ws2_32.lib



EXTERN AllocConsole@0:PROC
EXTERN ExitProcess@4:PROC
EXTERN GetStdHandle@4:PROC
EXTERN WriteConsoleA@20:PROC
EXTERN CreateThread@24:PROC
EXTERN WSAStartup@8:PROC
EXTERN WSAGetLastError@0:PROC
EXTERN socket@12:PROC
EXTERN bind@12:PROC
EXTERN CreateFileA@28:PROC
EXTERN ReadFile@20:PROC
EXTERN GetLastError@0:PROC

.DATA


.CODE

Main PROC
    call AllocConsole@0

    sub esp, 32                    
    mov edi, esp                

    mov byte ptr [edi], 87  
    mov byte ptr [edi+1], 97    
    mov byte ptr [edi+2], 105   
    mov byte ptr [edi+3], 116   
    mov byte ptr [edi+4], 105   
    mov byte ptr [edi+5], 110   
    mov byte ptr [edi+6], 103   
    mov byte ptr [edi+7], 32    
    mov byte ptr [edi+8], 102   
    mov byte ptr [edi+9], 111   
    mov byte ptr [edi+10], 114  
    mov byte ptr [edi+11], 32   
    mov byte ptr [edi+12], 99   
    mov byte ptr [edi+13], 111  
    mov byte ptr [edi+14], 110  
    mov byte ptr [edi+15], 110  
    mov byte ptr [edi+16], 101  
    mov byte ptr [edi+17], 99   
    mov byte ptr [edi+18], 116  
    mov byte ptr [edi+19], 105  
    mov byte ptr [edi+20], 111  
    mov byte ptr [edi+21], 110  
    mov byte ptr [edi+22], 46   
    mov byte ptr [edi+23], 46   
    mov byte ptr [edi+24], 46   
    mov byte ptr [edi+25], 13   
    mov byte ptr [edi+26], 10   
    mov byte ptr [edi+27], 0    

    push 27                         
    push edi  
    call WriteToConsole@8
    add esp, 32   


    call ReadConfig@0
    ;call CreateTcpSocket@8
    
    DoNotExit:
    jmp DoNotExit
    push 0                          
    call ExitProcess@4

Main ENDP

WriteToConsole@8 PROC
    push ebp
    mov ebp, esp

    mov ecx, [ebp+12]              
    mov edx, [ebp+8]               

    push -11                       
    call GetStdHandle@4             

    sub esp,4
    mov edi,esp

    push 0                          
    push edi                          
    push ecx                        
    push edx                        
    push eax                        
    call WriteConsoleA@20           
    mov eax,[edi]
    mov esp, ebp
    pop ebp
    ret 8                           

WriteToConsole@8 ENDP

RunOnThread@4 PROC
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8] 

    push 0
    push 0
    push 0
    push ebx
    push 0
    push 0
    call CreateThread@24

    mov esp,ebp
    pop ebp
    ret 4
RunOnThread@4 ENDP

CreateTcpSocket@8 PROC

    push ebp
    mov ebp,esp

    sub esp,400
    mov eax,esp

    sub esp, 4
    mov edi,esp
    mov byte ptr [edi], 2
    mov byte ptr [edi+1], 2
    mov byte ptr [edi+2], 0 ;dword 32 bit not word thus 0 padding
    mov byte ptr [edi+3], 0 ;dword 32 bit not word thus 0 padding

    push eax
    push dword ptr [edi] ;32 bit not word
    call WSAStartup@8

    push 6
    push 1
    push 2
    call socket@12


    call bind@12

    mov esp,ebp
    pop ebp

    ret 8

CreateTcpSocket@8 ENDP


ReadConfig@0 PROC
    push ebp
    mov ebp,esp

    sub esp, 16
    mov edi, esp

    mov byte ptr [edi], 115
    mov byte ptr [edi+1], 101
    mov byte ptr [edi+2], 116
    mov byte ptr [edi+3], 116
    mov byte ptr [esp+4], 105
    mov byte ptr [esp+5], 110
    mov byte ptr [esp+6], 103
    mov byte ptr [esp+7], 115
    mov byte ptr [esp+8], 46
    mov byte ptr [esp+9], 116
    mov byte ptr [esp+10], 170
    mov byte ptr [esp+11], 116
    mov byte ptr [esp+12], 0


    push 0
    push 128
    push 3
    push 0
    push 0
    push 80000000h
    push edi
    call CreateFileA@28 ;relies on 0 terminated string no kength required

    call GetLastError@0

    mov esp,ebp
    sub esp, 132
    mov edi,esp

    

    push 0
    push [edi + 4]
    push 128
    push edi
    push eax
    call ReadFile@20

    mov esp,ebp
    pop ebp

ReadConfig@0 ENDP



END Main
