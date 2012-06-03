' This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
' http://creativecommons.org/licenses/by/3.0/ or send a letter to
' Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

#COMPILE EXE
#DIM ALL
#UNIQUE VAR ON

#INCLUDE ONCE "mathhelper.inc"

FUNCTION PBMAIN () AS LONG

  DrawMand (500, 500)

END FUNCTION


SUB DrawMand (WindowWidth AS LONG, WindowHeight AS LONG)
  LOCAL hWindow AS DWORD
  LOCAL x, y, i AS LONG
  LOCAL ex, ey AS EXTENDED
  LOCAL tmr AS EXTENDED
  LOCAL colors() AS DWORD, gray AS EXTENDED
  LOCAL z AS ComplexNumber
  LOCAL c AS ComplexNumber
  LOCAL DesktopX, DesktopY AS LONG

  DIM colors(255) AS DWORD
  FOR i = 0 TO 255
    gray = ((i/255) ^ 0.4545) * 255 'Gama adjust
    colors(i) = RGB(gray, gray, gray)
  NEXT i

  LOCAL mh AS iMathHelper
  LET mh = CLASS "cMathHelper"

  IF ISNOTHING(mh) THEN EXIT SUB

  DESKTOP GET SIZE TO DesktopX, DesktopY

  GRAPHIC WINDOW NEW "Mandulbrot", (DesktopX - WindowWidth)/2, (DesktopY - WindowHeight)/2, WindowWidth, WindowHeight TO hWindow
  GRAPHIC ATTACH hWindow, 0, REDRAW



  tmr = TIMER

  FOR y=0 TO WindowHeight
    ey = ((y/WindowHeight) * 3) - 1.5
    FOR x=0 TO WindowWidth
      ex = ((x/WindowWidth) * 3!) - 2!
      c = mh.ComplexNumber(ex, ey)
      z = mh.ComplexNumber(0,0)

      FOR i = 0 TO 254
        IF ((z.real * z.real) + (z.img * z.img)) > 4 THEN EXIT FOR
        z = mh.ComplexMultiply(z,z)
        z = mh.ComplexAddition(z,c)
      NEXT i

      GRAPHIC SET PIXEL (x,y), Colors(i)

      IF (TIMER - tmr) > 1 THEN
        GRAPHIC REDRAW
        tmr = TIMER
      END IF

    NEXT x
    GRAPHIC REDRAW
  NEXT y

  MSGBOX "Done"

  GRAPHIC WINDOW END hWindow

END SUB
