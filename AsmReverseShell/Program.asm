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
EXTERN GetCurrentDirectoryA@8:PROC
EXTERN CloseHandle@4:PROC

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



    sub esp, 132
    mov edi,esp
    push edi
    call ReadConfig@4

    ;Push ip and port
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

    mov ebx,eax

    sub esp,4
    mov edi,esp

    push 0                          
    push edi                          
    push ecx                        
    push edx                        
    push eax                        
    call WriteConsoleA@20
    
    push ebx
    call CloseHandle@4

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

    ;use the pushed ip and port
    call bind@12

    mov esp,ebp
    pop ebp

    ret 8

CreateTcpSocket@8 ENDP


ReadConfig@4 PROC
    push ebp
    mov ebp,esp

    mov edi,[ebp+4]


    sub esp, 256
    mov edi, esp

    push edi
    push 256
    call GetCurrentDirectoryA@8
    
    
    mov byte ptr [edi+eax],   92
    mov byte ptr [edi+eax+1], 115
    mov byte ptr [edi+eax+2], 101
    mov byte ptr [edi+eax+3], 116
    mov byte ptr [edi+eax+4], 116
    mov byte ptr [edi+eax+5], 105
    mov byte ptr [edi+eax+6], 110
    mov byte ptr [edi+eax+7], 103
    mov byte ptr [edi+eax+8], 115
    mov byte ptr [edi+eax+9], 46
    mov byte ptr [edi+eax+10], 116
    mov byte ptr [edi+eax+11], 120
    mov byte ptr [edi+eax+12], 116
    mov byte ptr [edi+eax+13], 0

    push 0
    push 128
    push 3
    push 0
    push 0
    push 80000000h
    push edi
    call CreateFileA@28 ;relies on 0 terminated string no kength required

    mov esp,ebp
  
    lea ebx, [edi + 128]
    
    push 0
    push ebx
    push 128
    push edi
    push eax
    call ReadFile@20
    call GetLastError@0
    mov esp,ebp
    pop ebp
    ret 4

ReadConfig@4 ENDP




END Main
