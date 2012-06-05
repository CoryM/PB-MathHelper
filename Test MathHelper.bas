' This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
' http://creativecommons.org/licenses/by/3.0/ or send a letter to
' Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

#COMPILE EXE
#DIM ALL
#UNIQUE VAR ON

#INCLUDE ONCE "mathhelper.inc"

%False = 0
%True = NOT %False

FUNCTION PBMAIN () AS LONG
  LOCAL a AS ComplexNumber
  LOCAL b AS ComplexNumber
  LOCAL z AS ComplexNumber
  LOCAL e AS EXTENDED
  LOCAL f AS EXTENDED
  LOCAL p AS PolarNumber
  LOCAL q AS PolarNumber
  LOCAL DataIn(), DataOut(), DataCheck() AS EXTENDED

  LOCAL TestString AS STRING

  DIM DataIn(0 TO 7) AS EXTENDED
  DIM DataOut(0 TO 7) AS EXTENDED
  DIM DataCheck(0 TO 7) AS EXTENDED

  TestString = "Testing MathHelper Class setup" + $CRLF

  LOCAL MathHelper AS iMathHelper
  LET MathHelper = CLASS "cMathHelper"

  IF ISNOTHING(MathHelper) THEN
    TestString += "  Unable to make object" + $CRLF
  ELSE
    'Complex Pi
    TestString += "  Testing Pi : "
    e = MathHelper.Pi()
    IF e = 3.14159265358979323846264 THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(e,17) + " expected pi" + $CRLF
    END IF


    'Set a Number
    TestString += "  Testing ComplexNumber: "
    z = MathHelper.ComplexNumber(1.2, 3.4)
    IF z.real = 1.2 AND z.img = 3.4 THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(z.real) + "+" + STR$(z.img) + "i expected 1.2 + 3.4i" + $CRLF
    END IF

    'Complex Addition
    TestString += "  Testing ComplexAddition: "
    a = MathHelper.ComplexNumber(1, 2)
    b = MathHelper.ComplexNumber(3, 4)
    z = MathHelper.ComplexAddition(a, b)
    IF z.real = 4 AND z.img = 6 THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(z.real) + "+" + STR$(z.img) + "i expected 4 + 6i" + $CRLF
    END IF


    'Complex Subtraction
    TestString += "  Testing ComplexSubtraction: "
    a = MathHelper.ComplexNumber(1, 2)
    b = MathHelper.ComplexNumber(3, 4)
    z = MathHelper.ComplexSubtraction(a, b)
    IF z.real = -2 AND z.img = -2 THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(z.real) + "+" + STR$(z.img) + "i expected -2 + -2i" + $CRLF
    END IF

    'Complex Multplication
    TestString += "  Testing ComplexMultiply: "
    a = MathHelper.ComplexNumber(2, 3)
    b = MathHelper.ComplexNumber(4, 5)
    z = MathHelper.ComplexMultiply(a, b)
    IF z.real = -7 AND z.img = 22 THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(z.real) + "+" + STR$(z.img) + "i expected -7 + 22i" + $CRLF
    END IF

    'Complex division
    TestString += "  Testing ComplexDivision: "
    a = MathHelper.ComplexNumber(1, 2)
    b = MathHelper.ComplexNumber(2, 3)
    z = MathHelper.ComplexDivide(a, b)
    IF z.real = (8/13) AND z.img = (1/13) THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(z.real) + "+" + STR$(z.img) + "i expected (8/13) + (1/13)i" + $CRLF
    END IF

    'Complex Square root
    TestString += "  Testing ComplexSQR (1/5): "
    a = MathHelper.ComplexNumber(4, 0)
    z = MathHelper.ComplexSquareRoot(a)
    IF z.real = 2 AND z.img = 0 THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(z.real) + "+" + STR$(z.img) + "i expected 2 + 0i" + $CRLF
    END IF

    'Complex Square root
    TestString += "  Testing ComplexSQR (2/5): "
    a = MathHelper.ComplexNumber(0, 8)
    z = MathHelper.ComplexSquareRoot(a)
    IF z.real = 2 AND z.img = 2 THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(z.real) + "+" + STR$(z.img) + "i expected 2 + 2i" + $CRLF
    END IF

    'Complex Square root
    TestString += "  Testing ComplexSQR (3/5): "
    a = MathHelper.ComplexNumber(-48, 64)
    z = MathHelper.ComplexSquareRoot(a)
    IF z.real = 4 AND z.img = 8 THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(z.real) + "+" + STR$(z.img) + "i expected 4 + 8i" + $CRLF
    END IF

    'Complex Square root
    TestString += "  Testing ComplexSQR (4/5): "
    a = MathHelper.ComplexNumber(-48, -64)
    z = MathHelper.ComplexSquareRoot(a)
    IF z.real = 4 AND z.img = -8 THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(z.real) + "+" + STR$(z.img) + "i expected 4 + (-8)i" + $CRLF
    END IF

    TestString += "  Testing ComplexSQR (5/5): "
    a = MathHelper.ComplexNumber(-4, 0)
    z = MathHelper.ComplexSquareRoot(a)
    IF z.real = 0 AND z.img = 2 THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(z.real) + "+" + STR$(z.img) + "i expected 0 + 2i" + $CRLF
    END IF


    'Complex ATAN2
    TestString += "  Testing ATAN2 (0.5,0.5) : "
    e = ROUND(MathHelper.ATAN2(0.5,0.5), 18)
    f = 0.785398163397448310
    IF e = f THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(e,18) + " expected " + STR$(f,18) + $CRLF
    END IF

    TestString += "  Testing ATAN2 (0.5,-0.5) : "
    e = ROUND(MathHelper.ATAN2(0.5,-0.5), 18)
    f = -0.785398163397448310
    IF e = f THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(e,18) + " expected " + STR$(f,18) + $CRLF
    END IF

    TestString += "  Testing ATAN2 (-0.5,0.5) : "
    e = ROUND(MathHelper.ATAN2(-0.5,0.5), 18)
    f = 2.356194490192344929
    IF e = f THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(e,18) + " expected " + STR$(f,18) + $CRLF
    END IF

    TestString += "  Testing ATAN2 (-0.5,-0.5) : "
    e = ROUND(MathHelper.ATAN2(-0.5,-0.5), 18)
    f = -2.356194490192344929
    IF e = f THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(e,18) + " expected " + STR$(f,18) + $CRLF
    END IF

    TestString += "  Testing ATAN2 (0,0) : "
    e = MathHelper.ATAN2(0,0)
    f = 0
    IF e = f THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved " + STR$(e,18) + " expected pi/2" + $CRLF
    END IF


    TestString += "  Testing ComplexToPolar : "
    a = MathHelper.ComplexNumber(4, -4)
    p = MathHelper.ComplexToPolar(a)
    p.radius = ROUND(p.radius, 15)
    p.radians = ROUND(p.radians, 18)
    q.radius = 5.656854249492380
    q.radians = -0.785398163397448310
    IF p = q THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED "+$CRLF +"    recieved  r=" + STR$(p.radius,18) + " º=" + STR$(p.radians,18) + $CRLF + "    expected r=" + STR$(q.radius,18) + " º=" + STR$(q.radians,18) + $CRLF
    END IF

    TestString += "  Testing PolarToComplex : "
    p = MathHelper.PolarNumber(5.656854249492380, -0.785398163397448310)
    a = MathHelper.PolarToComplex(p)
    a.real = ROUND(a.real, 15) 'Seem to lose 3 to 4 digits of persion
    a.img = ROUND(a.img, 15)
    b = MathHelper.ComplexNumber(4, -4)
    IF a = b THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED "+$CRLF +"    recieved  r=" + STR$(a.real,18) + " i=" + STR$(a.img,18) + $CRLF + "    expected r=" + STR$(b.real,18) + " i=" + STR$(b.img,18) + $CRLF
    END IF

    TestString += "  Testing ComplexConjugate : "
    a = MathHelper.ComplexNumber(12, 34)
    a = MathHelper.ComplexConjugate(a)
    b = MathHelper.ComplexNumber(12, -34)
    IF a = b THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED "+$CRLF +"    recieved  r=" + STR$(a.real,18) + " i=" + STR$(a.img,18) + $CRLF + "    expected r=" + STR$(b.real,18) + " i=" + STR$(b.img,18) + $CRLF
    END IF

    TestString += "  Testing ArcSin : "
    e = MathHelper.ArcSin(SIN(0.5))
    f = 0.5
    IF e = f THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED "+$CRLF +"    recieved  " + STR$(e,18)  + $CRLF + "    expected " + STR$(f,18)  + $CRLF
    END IF

    TestString += "  Testing ArcCos : "
    e = ROUND(MathHelper.ArcCos(COS(0.5)),17)
    f = 0.5
    IF e = f THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED "+$CRLF +"    recieved  " + STR$(e,18)  + $CRLF + "    expected " + STR$(f,18)  + $CRLF
    END IF

    TestString += "  Testing DCT : "
    DataIn(0)=21
    DataIn(1)=1
    DataIn(2)=8
    DataIn(3)=3
    DataIn(4)=5
    DataIn(5)=2
    DataIn(6)=13
    DataIn(7)=1
    MathHelper.DCT(VARPTR(DataIn(0)), VARPTR(DataOut(0)), 7)
    DataCheck(0)=19.0918830920367832
    DataCheck(1)=6.29065550725971153
    DataCheck(2)=7.23252359230918676
    DataCheck(3)=7.09845244693213297
    DataCheck(4)=2.12132034355964246
    DataCheck(5)=11.1942153663612446
    DataCheck(6)=.831024961533054953
    DataCheck(7)=8.75951873558976203
    IF CompareArray(DataOut(), DataCheck(), 7, 16) THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved  " + $CRLF + ArrayToString(DataOut(), 7, 4) + $CRLF + "    expected " + $CRLF + ArrayToString(DataCheck(), 7, 4) + $CRLF
    END IF

    TestString += "  Testing IDCT : "
    DataIn(0)=19.0918830920367832
    DataIn(1)=6.29065550725971153
    DataIn(2)=7.23252359230918676
    DataIn(3)=7.09845244693213297
    DataIn(4)=2.12132034355964246
    DataIn(5)=11.1942153663612446
    DataIn(6)=.831024961533054953
    DataIn(7)=8.75951873558976203
    MathHelper.IDCT(VARPTR(DataIn(0)), VARPTR(DataOut(0)), 7)
    DataCheck(0)=21
    DataCheck(1)=1
    DataCheck(2)=8
    DataCheck(3)=3
    DataCheck(4)=5
    DataCheck(5)=2
    DataCheck(6)=13
    DataCheck(7)=1
    IF CompareArray(DataOut(), DataCheck(), 7, 16) THEN
      TestString += "PASS" + $CRLF
    ELSE
      TestString += "FAILED recieved  " + $CRLF + ArrayToString(DataOut(), 7, 4) + $CRLF + "    expected " + $CRLF + ArrayToString(DataCheck(), 7, 4) + $CRLF
    END IF

  END IF

  'Show the results
  MSGBOX TestString

END FUNCTION

FUNCTION ArrayToString(DataIn() AS EXTENDED, SizeOfArray AS LONG, Indent AS LONG) AS STRING
  LOCAL i AS LONG
  LOCAL StringOut AS STRING

  FOR i = 0 TO SizeOfArray
    StringOut += SPACE$(Indent) + STR$(DataIn(i), 18)' + $CRLF
  NEXT i

  FUNCTION = StringOut
END FUNCTION

FUNCTION CompareArray(a() AS EXTENDED, b() AS EXTENDED, l AS LONG, p AS LONG) AS LONG
  LOCAL i AS LONG
  LOCAL result AS LONG

  result = %True
  FOR i=0 TO l
    IF ROUND(a(i), p) <> ROUND(b(i), p) THEN Result = %False: EXIT FOR
  NEXT i

  FUNCTION = result
END FUNCTION
