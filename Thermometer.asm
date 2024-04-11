#start=led_display.exe#     
#make_bin#
#start=thermometer.exe# 
#start1=thermometer.exe#
#make_bin# 

name "thermo"

    mov ax, 100h     ;We take a data segment with aax
    mov ds, ax
    
    mov ah,1         ;We take an input from user for determine fahrenit or celsius
    int 21h
    mov bl,al        
                                             ,
   
    resetsi:         ;The function is for reseting SI
    mov ax, 1000h
    mov si, ax
    
    cmp bl, 31h      
    je Fahreneit     ;If else for user's input 
    
;************************   
                         
    Celcius:          ;Celsius
    start:

    in al, 125        ;Writing values between 0100:1000-0100:1009
    mov ds:[si], al
    cmp si,1009h      ;Comparing for SI is maximum
    je resetsi        ;If SI max then go to reset SI
    inc si            ;Increment SI
    

    cmp al, 60        ;Measure temperature is lower than 60C
    jl  low

    cmp al, 80        ;Measure temperature is higher than 80C
    jle  ok
    jg   high

    low:
    mov al, 1
    out 127, al   ;turn heater "on".
    
;*************************   

x1: 
NOP               ;for delaying
NOP
NOP
  in ax, 125
  out 199, ax
  cmp ax,24
  jg start
  cmp ax,15 
  jle start 
  jmp x1
    jmp ok

    high:
    mov al, 0
    out 127, al   ; turn heater "off". 
x2: 
NOP
NOP
NOP
  in ax, 125
  out 199, ax
  cmp ax,24 
  jg start
  jle low
  
jmp x2
    ok:
    x3:
NOP
NOP
NOP
  in ax, 125
  out 199, ax
  cmp ax,24 
  jg start
  cmp ax,15
  jle start
jmp x3
    jmp start
    
;************************      
      
          
    Fahreneit:
    start1:
    mov ax, 0h
    in al, 125        
    mov bl, 9
    mul bl
    mov bl, 5
    div bl
    add al, 32
    
    mov ds:[si], al
    cmp si,1009h
    je resetsi
    inc si
    

    cmp al, 60
    jl  low

    cmp al, 80
    jle  ok1
    jg   high1

    low1:
    mov al, 1
    out 127, al   ; turn heater "on".
    jmp ok

    high1:
    mov al, 0
    out 127, al   ; turn heater "off". 

    ok1:
    jmp start1
       
    exit:
    mov ah,4ch
    int 21h
