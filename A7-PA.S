;------------------------
; Assembly Code
;------------------------
#define __SFR_OFFSET 0x00
#include "avr/io.h"

;------------------------
.global main
main:
RCALL HC_SR04_sensor
RJMP main

;===============================================================

HC_SR04_sensor:
;--------------
    SBI DDRD, 4
    SBI   DDRB, 1         ;pin PB1 as o/p (Trigger)
    CBI   DDRB, 0         ;pin PB0 as i/p (Echo)
    ;-----------------------------------------------------------
    SBI   PORTB, 1
    RCALL delay_timer0
    CBI   PORTB, 1        ;send 10us high pulse to sensor
    ;-----------------------------------------------------------
    RCALL echo_PW         ;compute Echo pulse width count
    ;-----------------------------------------------------------
    RCALL byte2decimal    ;convert & display on MAX7219
    ;-----------------------------------------------------------
    RCALL delay_ms
    RET

;===============================================================
echo_PW:
;-------
    LDI   R20, 0b00000000
    STS   TCCR1A, R20     ;Timer 1 normal mode
    LDI   R20, 0b11000101 ;set for rising edge detection &
    STS   TCCR1B, R20     ;prescaler=1024, noise cancellation ON
    ;-----------------------------------------------------------
lh1: IN    R21, TIFR1
    SBRS  R21, ICF1
    RJMP  lh1              ;loop until rising edge is detected
    ;-----------------------------------------------------------
    LDS   R16, ICR1L      ;store count value at rising edge
    ;-----------------------------------------------------------
    OUT   TIFR1, R21      ;clear flag for falling edge detection
    LDI   R20, 0b10000101
    STS   TCCR1B, R20     ;set for falling edge detection
    ;-----------------------------------------------------------
lh2: IN    R21, TIFR1
    SBRS  R21, ICF1
    RJMP  lh2              ;loop until falling edge is detected
    ;-----------------------------------------------------------
    LDS   R28, ICR1L      ;store count value at falling edge
    ;-----------------------------------------------------------
    SUB   R28, R16        ;count diff R22 = R22 - R16
    OUT   TIFR1, R21      ;clear flag for next sensor reading
    RET

;===============================================================
; MAX7219 subroutines
;===============================================================
byte2decimal:
;------------
      CLR   R26             ;set counter1, initial value 0
      CLR   R27             ;set counter2, initial value 0
      ;--------------------------------------------------------
lh70:  CPI   R28, 100        ;compare R28 with 100
Ret:  BRMI  lh80             ;jump when R28 < 100
      INC   R26             ;increment counter1 by 1
      SUBI  R28, 100        ;R28 = R28 - 100
      RJMP  lh70
      ;--------------------------------------------------------
lh80:  CPI   R28, 10         ;compare R28 with 10
      BRMI  dsp             ;jump when R 28 < 10
      INC R27 ;increment counter2 by 1
SUBI R28, 10 ;R28 = R28 - 10
RJMP lh80
;--------------------------------------------------------
dsp:
CPI R27, 3
BRSH mati_led ; If distance is greater than 30 cm, branch to no
CPI R27, 2
BRLO servo_led ; If distance is less than 10 cm, branch to servo
continue:
RET

; Kode nyalain LED
servo_led:
; Turn on the LED
SBI PORTD, 4
; Call the servo control subroutine
RCALL servo_control
RJMP continue

; Kode matiin LED
mati_led:
    ; Turn off the LED
    CBI PORTD, 4

    ; Reset the servo position
    RCALL servo_reset

    RJMP continue

; Servo reset subroutine
servo_reset:
    ; Set servo control pin (e.g., PD5) as output
    SBI DDRD, 5

    ; Move the servo to the reset position (adjust values as per servo specifications)
    LDI R30, 0  ; Set servo angle to the reset position (0 degrees)
    LDI R31, 0  ; Set upper byte of the servo angle to 0 (if necessary)

    ; Loop to generate servo control pulse
l2: SBI PORTD, 5   ; Set servo control pin HIGH
    RCALL delay_timer0  ; Delay for pulse width (adjust as per servo specifications)
    CBI PORTD, 5   ; Set servo control pin LOW
    RCALL delay_timer0  ; Delay for remaining pulse period (adjust as per servo specifications)
    DEC R30        ; Decrement servo angle by 1
    BRNE l2        ; Loop until the servo reaches the reset position
    RET


; Servo control subroutine
servo_control:
; Set servo control pin (e.g., PD5) as output
SBI DDRD, 5
; Move the servo to a specific angle (adjust values as per servo specifications)
LDI R30, 90  ; Set servo angle to 90 degrees
LDI R31, 0   ; Set upper byte of the servo angle to 0 (if necessary)

; Loop to generate servo control pulse
l1: SBI PORTD, 5   ; Set servo control pin HIGH
    RCALL delay_timer0  ; Delay for pulse width (adjust as per servo specifications)
    CBI PORTD, 5   ; Set servo control pin LOW
    RCALL delay_timer0  ; Delay for remaining pulse period (adjust as per servo specifications)
    DEC R30        ; Decrement servo angle by 1
    BRNE l1        ; Loop until the servo reaches the desired angle
RET

;===============================================================
; Delay subroutines
;===============================================================
delay_timer0: ;10 usec delay via Timer 0
;------------
CLR R20
OUT TCNT0, R20 ;initialize timer0 with count=0
LDI R20, 20
OUT OCR0A, R20 ;OCR0 = 20
LDI R20, 0b00001010
OUT TCCR0B, R20 ;timer0: CTC mode, prescaler 8
;-----------------------------------------------------------
l0: IN R20, TIFR0 ;get TIFR0 byte & check
SBRS R20, OCF0A ;if OCF0=1, skip next instruction
RJMP l0 ;else, loop back & check OCF0 flag
;-----------------------------------------------------------
CLR R20
OUT TCCR0B, R20 ;stop timer0
;-----------------------------------------------------------
LDI R20, (1<<OCF0A)
OUT TIFR0, R20 ;clear OCF0 flag
RET

;===============================================================
delay_ms: ;delay 0.5s
LDI R21, 255
ls7 :LDI R22, 255
ls8 :LDI R23, 41
l9 :DEC R23
BRNE l9
DEC R22
BRNE ls8
DEC R21
BRNE ls7
RET