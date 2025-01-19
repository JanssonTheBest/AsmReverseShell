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
EXTERN ReadConsoleA@20:PROC

.DATA


.CODE

Main PROC
    call AllocConsole@0


    sub esp, 32                    
    lea edi, [esp]                

    mov byte ptr [edi],     87  
    mov byte ptr [edi+1],   101 
    mov byte ptr [edi+2],   108 
    mov byte ptr [edi+3],   99  
    mov byte ptr [edi+4],   111 
    mov byte ptr [edi+5],   109 
    mov byte ptr [edi+6],   101 
    mov byte ptr [edi+7],   32  
    mov byte ptr [edi+8],   116 
    mov byte ptr [edi+9],   111 
    mov byte ptr [edi+10],  32  
    mov byte ptr [edi+11],  77  
    mov byte ptr [edi+12],  97  
    mov byte ptr [edi+13],  115 
    mov byte ptr [edi+14],  109 
    mov byte ptr [edi+15],  82  
    mov byte ptr [edi+16],  101 
    mov byte ptr [edi+17],  118 
    mov byte ptr [edi+18],  101 
    mov byte ptr [edi+19],  114 
    mov byte ptr [edi+20],  115 
    mov byte ptr [edi+21],  101 
    mov byte ptr [edi+22],  83  
    mov byte ptr [edi+23],  104 
    mov byte ptr [edi+24],  101 
    mov byte ptr [edi+25],  108 
    mov byte ptr [edi+26],  108 
    mov byte ptr [edi+27],  33  
    mov byte ptr [edi+28],  13  
    mov byte ptr [edi+29],  10  
    mov byte ptr [edi+30],  0   
    
    push 30                       
    push edi  
    call WriteToConsole@8
    add esp, 32
    
    sub esp, 1024
    mov edi,esp
    
    push edi
    push 1024
    call ReadFromConsole@8
    
    cmp byte ptr [esp],99
    jne ListenForConnections
    cmp byte ptr [esp+1],102
    jne ListenForConnections
    cmp byte ptr [esp+2],103
    jne ListenForConnections
    
    mov edi,esp

    push 58
    push edi
    call FirstIndexOf@8
    mov eax, eax

    ListenForConnections:
    add esp,1024

    sub esp, 32                    
    lea edi, [esp]                
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
    
    mov eax,[edi]
    mov esp, ebp
    pop ebp
    ret 8                           

WriteToConsole@8 ENDP

ReadFromConsole@8 PROC
    push ebp
    mov ebp,esp
    mov ebx, [ebp+8]
    mov ecx, [ebp+12]

    push -10                       
    call GetStdHandle@4  

    lea edi,[ecx]
    
    sub esp,4
    mov edx, esp

    push 0
    push edx
    push ebx
    push edi
    push eax
    call ReadConsoleA@20
    mov eax, [edx+4] ;Spooky action at a distance +4 works
    add esp, 4
    mov esp,ebp
    pop ebp
    ret 8

ReadFromConsole@8 ENDP

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

;todo fix loop bug it has something with the 16 bit registers overlapping 32 bit viseversa
FirstIndexOf@8 PROC
    push ebp
    mov ebp,esp

    mov eax, [ebp+8]
    mov dl, byte ptr [ebp+12]

    sub eax, 1
    mov ebx,0
    Iterate:
    add ebx,1
    add eax, ebx
    mov cl,byte ptr [eax]
    cmp dl, cl
    jne Iterate
    cmp cl, 0
    je NoIndexFound

    jmp FirstIndexOfEndilog

    NoIndexFound:
    mov eax, -1

    FirstIndexOfEndilog:
    mov eax,ebx
    mov esp,ebp
    pop ebp
    ret 4
FirstIndexOf@8 ENDP





END Main
