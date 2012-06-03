' This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
' http://creativecommons.org/licenses/by/3.0/ or send a letter to
' Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

#COMPILE EXE
#DIM ALL
#UNIQUE VAR ON

#INCLUDE ONCE "mathhelper.inc"

FUNCTION PBMAIN () AS LONG
  LOCAL a AS ComplexNumber
  LOCAL b AS ComplexNumber
  LOCAL z AS ComplexNumber
  LOCAL e AS EXTENDED
  LOCAL f AS EXTENDED
  LOCAL p AS PolarNumber
  LOCAL q AS PolarNumber

  LOCAL TestString AS STRING

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


  END IF

  'Show the results
  MSGBOX TestString

END FUNCTION
