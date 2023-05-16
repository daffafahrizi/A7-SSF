#define __SFR_OFFSET 0x00
#include "avr/io.h"
;------------------------
.global main
.equ  SCK, 5
.equ  MOSI, 3
.equ  SS, 2
main:
  SBI DDRB, 1     ;pin PB1 as o/p (Trigger)
  CBI DDRB, 0     ;pin PB0 as i/p (Echo)
  SBI DDRD, 4     ;pin PD4 as o/p (LED)
loop:
  ;proses mendapatkan input dari sensor jarak
  SBI   PORTB, 1
  RCALL delay_timer0
  CBI   PORTB, 1        ;send 10us high pulse to sensor
  RCALL echo_PW         ;compute Echo pulse width count
  RCALL dsp
  RJMP  loop
;===============================================================

echo_PW:
;-------
    LDI   R20, 0b00000000
    STS   TCCR1A, R20     ;Timer 1 normal mode
    LDI   R20, 0b11000101 ;set for rising edge detection &
    STS   TCCR1B, R20     ;prescaler=1024, noise cancellation ON
    ;-----------------------------------------------------------
l1: 
    IN    R21, TIFR1
    SBRS  R21, ICF1
    RJMP  l1              ;loop until rising edge is detected
    ;-----------------------------------------------------------
    LDS   R16, ICR1L      ;store count value at rising edge
    ;-----------------------------------------------------------
    OUT   TIFR1, R21      ;clear flag for falling edge detection
    LDI   R20, 0b10000101
    STS   TCCR1B, R20     ;set for falling edge detection
    ;-----------------------------------------------------------
l2: 
    IN    R21, TIFR1
    SBRS  R21, ICF1
    RJMP  l2              ;loop until falling edge is detected
    ;-----------------------------------------------------------
    LDS   R28, ICR1L      ;store count value at falling edge
    ;-----------------------------------------------------------
    SUB   R28, R16        ;count diff R28 = R28 - R16
    OUT   TIFR1, R21      ;clear flag for next sensor reading
    RET
 
 dsp: 
  CPI R28, 9
  BRSH no   ;Jika jarak lebih dari 10 cm, branch ke no
  RJMP yes ;Jika jarak kurang dari 10 cm, branch ke yes

no:
  cbi PORTD, 4 ;mematikan LED
  RJMP loop 

yes:
  sbi PORTD, 4 ;Menyalakan LED
  RJMP loop

;===============================================================
;delay subroutines
;===============================================================
delay_timer0:             ;10 usec delay via Timer 0
;------------
    CLR   R20
    OUT   TCNT0, R20      ;initialize timer0 with count=0
    LDI   R20, 20
    OUT   OCR0A, R20      ;OCR0 = 20
    LDI   R20, 0b00001010
    OUT   TCCR0B, R20     ;timer0: CTC mode, prescaler 8
    ;-----------------------------------------------------------
l0: IN    R20, TIFR0      ;get TIFR0 byte & check
    SBRS  R20, OCF0A      ;if OCF0=1, skip next instruction
    RJMP  l0              ;else, loop back & check OCF0 flag
    ;-----------------------------------------------------------
    CLR   R20
    OUT   TCCR0B, R20     ;stop timer0
    ;-----------------------------------------------------------
    LDI   R20, (1<<OCF0A)
    OUT   TIFR0, R20      ;clear OCF0 flag
    RET
;===============================================================
delay_ms:
;--------
    LDI   R21, 255
l6: LDI   R22, 255
l7: LDI   R23, 50
l8: DEC   R23
    BRNE  l8
    DEC   R22
    BRNE  l7
    DEC   R21
    BRNE  l6
    RET