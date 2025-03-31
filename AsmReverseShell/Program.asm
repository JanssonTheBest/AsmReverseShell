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
    

    ReadOption:
    sub esp, 1024
    mov edi,esp
    
    push edi
    push 1024
    call ReadFromConsole@8
    
    mov edi,esp
    sub esp, 4
    lea ebx,[esp]
    mov byte ptr [ebx],114
    mov byte ptr [ebx+1],110
    push edi
    push ebx
    push 1
    call CompareString@12
    mov edi,esp
    add esp,4
    cmp eax,-1
    je StartListening

    mov edi,esp
    sub esp, 4
    lea ebx,[esp]
    mov byte ptr [ebx],98
    mov byte ptr [ebx+1],100
    push edi
    push ebx
    push 1
    call CompareString@12
    add esp,4
    mov edi,esp
    cmp eax,-1
    je Build

    sub esp, 32
    lea edi,[esp]
    mov byte ptr [edi],67    
    mov byte ptr [edi+1],111 
    mov byte ptr [edi+2],109 
    mov byte ptr [edi+3],109 
    mov byte ptr [edi+4],97  
    mov byte ptr [edi+5],110 
    mov byte ptr [edi+6],100 
    mov byte ptr [edi+7],32  
    mov byte ptr [edi+8],105 
    mov byte ptr [edi+9],115 
    mov byte ptr [edi+10],32 
    mov byte ptr [edi+11],110
    mov byte ptr [edi+12],111
    mov byte ptr [edi+13],116
    mov byte ptr [edi+14],32 
    mov byte ptr [edi+15],114
    mov byte ptr [edi+16],101
    mov byte ptr [edi+17],99 
    mov byte ptr [edi+18],111
    mov byte ptr [edi+19],103
    mov byte ptr [edi+20],110
    mov byte ptr [edi+21],105
    mov byte ptr [edi+22],122
    mov byte ptr [edi+23],101
    mov byte ptr [edi+24],100
    mov byte ptr [edi+25],13  
    mov byte ptr [edi+26],10  
    mov byte ptr [edi+27],0

    push 27
    push edi
    call WriteToConsole@8
    add esp,32

    add esp, 1024 ;Reset buffer
    jmp ReadOption

    Build:
    ;Todo create builder
    
    StartListening:
    lea edi,[esp]
    push 58
    push edi
    call FirstIndexOf@8

    lea edi,[esp];command offset
    
    lea ecx,[edi+3]
    push ecx ;ip offset
    lea ecx, [edi+eax+1]
    push ecx ; port offset
    mov ecx, eax
    sub ecx,3
    push ecx

    lea ebx, [edi+eax] 

    push 13
    push ebx ;port offset again but lea?? create copy because of stdcall convention
    call FirstIndexOf@8 ; considder the stack and the parameters to be cleared after thiss call because of stdcall thus the next procedure call will see the parameters before this because we only cleared 8, next will get the parameters before here and some more after this
    sub eax,1 
    push eax ;length of port in this case 4 because 2332
    call CreateTcpSocket@16

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

;-----------------------------------------------------------------
; WriteToConsole@8
;-----------------------------------------------------------------
WriteToConsole@8 PROC
    push    ebp
    mov     ebp, esp
    push    ebx          ; Preserve EBX
    push    edi          ; Preserve EDI

    mov     ecx, [ebp+12]
    mov     edx, [ebp+8]

    push    -11
    call    GetStdHandle@4
    mov     ebx, eax

    sub     esp, 4
    mov     edi, esp

    push    0
    push    edi
    push    ecx
    push    edx
    push    eax
    call    WriteConsoleA@20

    mov     eax, [edi]
    pop     edi          ; Restore EDI
    pop     ebx          ; Restore EBX
    mov     esp, ebp
    pop     ebp
    ret     8
WriteToConsole@8 ENDP

;-----------------------------------------------------------------
; ReadFromConsole@8
;-----------------------------------------------------------------
ReadFromConsole@8 PROC
    push    ebp
    mov     ebp, esp
    push    ebx          ; Preserve EBX
    push    edi          ; Preserve EDI

    mov     ebx, [ebp+8]
    mov     ecx, [ebp+12]

    push    -10
    call    GetStdHandle@4

    lea     edi, [ecx]

    sub     esp, 4
    mov     edx, esp

    push    0
    push    edx
    push    ebx
    push    edi
    push    eax
    call    ReadConsoleA@20
    mov     eax, [edx+4]  ; Spooky action at a distance +4 works
    add     esp, 4
    pop     edi          ; Restore EDI
    pop     ebx          ; Restore EBX
    mov     esp, ebp
    pop     ebp
    ret     8
ReadFromConsole@8 ENDP

;-----------------------------------------------------------------
; RunOnThread@4
;-----------------------------------------------------------------
RunOnThread@4 PROC
    push    ebp
    mov     ebp, esp
    push    ebx          ; Preserve EBX

    mov     ebx, [ebp+8]

    push    0
    push    0
    push    0
    push    ebx
    push    0
    push    0
    call    CreateThread@24

    pop     ebx          ; Restore EBX
    mov     esp, ebp
    pop     ebp
    ret     4
RunOnThread@4 ENDP

;-----------------------------------------------------------------
; CreateTcpSocket@16
;-----------------------------------------------------------------
CreateTcpSocket@16 PROC
    push    ebp
    mov     ebp, esp
    push    ebx          ; Preserve EBX
    push    ecx          ; Preserve ECX
    push    esi          ; Preserve ESI
    push    edi          ; Preserve EDI

    mov     ebx, [ebp+8]  ;port length
    mov     esi, [ebp+12] ;ip length
    mov     ecx, [ebp+16] ;port offset
    mov     edx, [ebp+20] ;ip offset

    sub     esp, 400
    mov     eax, esp

    sub     esp, 4
    mov     edi, esp
    mov     byte ptr [edi],   2
    mov     byte ptr [edi+1], 2
    mov     byte ptr [edi+2], 0  ; 32-bit padding
    mov     byte ptr [edi+3], 0

    push    eax
    push    dword ptr [edi]
    call    WSAStartup@8

    push    6
    push    1
    push    2
    call    socket@12

    ; use the pushed IP and port, this will be hard you will need to push a struct with structs innit in correct order with value to push the socketaddrin
   
    call    bind@12

    pop     edi          ; Restore EDI
    pop     esi          ; Restore ESI
    pop     ecx          ; Restore ECX
    pop     ebx          ; Restore EBX
    mov     esp, ebp
    pop     ebp
    ret     16
CreateTcpSocket@16 ENDP

;-----------------------------------------------------------------
; FirstIndexOf@8
;-----------------------------------------------------------------
FirstIndexOf@8 PROC
    push    ebp
    mov     ebp, esp
    push    ebx          ; Preserve EBX

    mov     eax, [ebp+8]
    mov     dl, byte ptr [ebp+12]

    sub     eax, 1
    mov     ebx, 0
Iterate:
    add     ebx, 1
    mov     cl, byte ptr [eax+ebx]
    cmp     dl, cl
    jne     Iterate
    cmp     cl, 0
    je      NoIndexFound

    jmp     Success

NoIndexFound:
    mov     eax, -1
    jmp     FirstIndexOfEndilog

Success:
    mov     eax, ebx
    sub eax,1 ;0 based index
FirstIndexOfEndilog:
    pop     ebx          ; Restore EBX
    mov     esp, ebp
    pop     ebp
    ret     8
FirstIndexOf@8 ENDP

;-----------------------------------------------------------------
; CompareString@12
;-----------------------------------------------------------------
CompareString@12 PROC
    push    ebp
    mov     ebp, esp
    push    ebx          ; Preserve EBX
    push    edi          ; Preserve EDI

    mov     ebx, [ebp+8]
    mov     ecx, [ebp+12]
    mov     edi, [ebp+16]
    mov     eax, -1

Iterate:
    inc     eax
    mov     dl, byte ptr [ecx+eax]
    mov     dh, byte ptr [edi+eax]
    cmp     dl, dh
    jne     Epilog
    cmp     eax, ebx
    je      Success
    jmp     Iterate

Success:
    mov     eax, -1

Epilog:
    pop     edi          ; Restore EDI
    pop     ebx          ; Restore EBX
    mov     esp, ebp
    pop     ebp
    ret     12
CompareString@12 ENDP




END Main
