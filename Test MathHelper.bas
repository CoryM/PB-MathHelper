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
    e = MathHelper.Pi()
    TestString += "  Testing Pi : " + TestExtended(e, 3.14159265358979323846264, 17)

    'Set a Number
    z = MathHelper.ComplexNumber(1.2, 3.4)
    TestString += "  Testing ComplexNumber: " + TestComplex1(z, 1.2, 3.4, 18)

    'Complex Addition
    a = MathHelper.ComplexNumber(1, 2)
    b = MathHelper.ComplexNumber(3, 4)
    z = MathHelper.ComplexAddition(a, b)
    TestString += "  Testing ComplexAddition: " + TestComplex1(z, 4, 6, 18)

    'Complex Subtraction
    a = MathHelper.ComplexNumber(1, 2)
    b = MathHelper.ComplexNumber(3, 5)
    z = MathHelper.ComplexSubtraction(a, b)
    TestString += "  Testing ComplexSubtraction: " + TestComplex1(z, -2, -3, 18)

    'Complex Multplication
    a = MathHelper.ComplexNumber(2, 3)
    b = MathHelper.ComplexNumber(4, 5)
    z = MathHelper.ComplexMultiply(a, b)
    TestString += "  Testing ComplexMultiply: " + TestComplex1(z, -7, 22, 18)

    'Complex division
    a = MathHelper.ComplexNumber(1, 2)
    b = MathHelper.ComplexNumber(2, 3)
    z = MathHelper.ComplexDivide(a, b)
    TestString += "  Testing ComplexDivision: " + TestComplex1(z, (8/13), (1/13), 18)

    'Complex Square root
    a = MathHelper.ComplexNumber(4, 0)
    z = MathHelper.ComplexSquareRoot(a)
    TestString += "  Testing ComplexSQR (1/5): " + TestComplex1(z, 2, 0, 18)

    'Complex Square root
    a = MathHelper.ComplexNumber(0, 8)
    z = MathHelper.ComplexSquareRoot(a)
    TestString += "  Testing ComplexSQR (2/5): " + TestComplex1(z, 2, 2, 18)

    'Complex Square root
    a = MathHelper.ComplexNumber(-48, 64)
    z = MathHelper.ComplexSquareRoot(a)
    TestString += "  Testing ComplexSQR (3/5): " + TestComplex1(z, 4, 8, 18)

    'Complex Square root
    a = MathHelper.ComplexNumber(-48, -64)
    z = MathHelper.ComplexSquareRoot(a)
    TestString += "  Testing ComplexSQR (4/5): " + TestComplex1(z, 4, -8, 18)

    'Complex Square root
    a = MathHelper.ComplexNumber(-4, 0)
    z = MathHelper.ComplexSquareRoot(a)
    TestString += "  Testing ComplexSQR (5/5): " + TestComplex1(z, 0, 2, 18)

    'Complex ATAN2
    e = MathHelper.ATAN2(0.5,0.5)
    TestString += "  Testing ATAN2 (0.5,0.5) : " + TestExtended(e, 0.785398163397448310, 18)

    e = MathHelper.ATAN2(0.5,-0.5)
    TestString += "  Testing ATAN2 (0.5,-0.5) : " + TestExtended(e, -0.785398163397448310, 18)

    e = ROUND(MathHelper.ATAN2(-0.5,0.5), 18)
    TestString += "  Testing ATAN2 (-0.5,0.5) : " + TestExtended(e, 2.356194490192344929, 18)

    e = ROUND(MathHelper.ATAN2(-0.5,-0.5), 18)
    TestString += "  Testing ATAN2 (-0.5,-0.5) : " + TestExtended(e, -2.356194490192344929, 18)

    e = MathHelper.ATAN2(0,0)
    TestString += "  Testing ATAN2 (0,0) : " + TestExtended(e, 0, 18)

    'ComplexToPolar
    a = MathHelper.ComplexNumber(4, -4)
    p = MathHelper.ComplexToPolar(a)
    TestString += "  Testing ComplexToPolar : " + TestPolar(p, 5.656854249492380, -0.785398163397448310, 15)


    'PolarToComplex
    p = MathHelper.PolarNumber(5.656854249492380, -0.785398163397448310)
    a = MathHelper.PolarToComplex(p)
    TestString += "  Testing PolarToComplex : " + TestComplex1(a, 4, -4, 15)

    'ComplexConjugate
    a = MathHelper.ComplexNumber(12, 34)
    a = MathHelper.ComplexConjugate(a)
    TestString += "  Testing ComplexConjugate : " + TestComplex1(a, 12, -34, 15)

    'PolarPower
    p = MathHelper.PolarNumber(2, 3)
    p = MathHelper.PolarPower(p, 4)
    TestString += "  Testing PolarPower : " + TestPolar(p, 16, 12, 18)


    'ComplexPower
    a = MathHelper.ComplexNumber(2, 3)
    a = MathHelper.ComplexPower(a, 4)
    TestString += "  Testing ComplexPower : " + TestComplex1(a, -119, -120, 16)


    'ArcSin
    e = MathHelper.ArcSin(SIN(0.5))
    TestString += "  Testing ArcSin : " + TestExtended(e, 0.5, 18)


    'SinH
    e = MathHelper.SinH(0.5)
    TestString += "  Testing SinH : " + TestExtended(e, 0.521095305493747362, 18)

    'ArcSinH
    e = MathHelper.ArcSinH(0.5)
    TestString += "  Testing ArcSinH : " + TestExtended(e, 0.481211825059603448, 18)

    'CosH
    e = MathHelper.CosH(0.5)
    TestString += "  Testing CosH : " + TestExtended(e, 1.04719755119659774, 17)

    'ArcCosH
    e = MathHelper.ArcCosH(1.5)
    TestString += "  Testing ArcCosH : " + TestExtended(e, 0.962423650119206895, 17)

    'ArcCos
    e = ROUND(MathHelper.ArcCos(COS(0.5)),17)
    TestString += "  Testing ArcCos : " + TestExtended(e, 0.5, 17)

    'DCT
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
    TestString += "  Testing DCT : " + TestArray(DataOut(), DataCheck(), 7, 16)

    'IDCT
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
    TestString += "  Testing IDCT : " + TestArray(DataOut(), DataCheck(), 7, 16)

    'Dot
    DataIn(0)=1
    DataIn(1)=1
    DataIn(2)=2
    DataIn(3)=3
    DataIn(4)=5
    DataIn(5)=8
    DataIn(6)=13
    DataIn(7)=21
    e = MathHelper.DOT(VARPTR(DataIn(0)), VARPTR(DataIn(4)), 3)
    TestString += "  Testing DOT : " + TestExtended(e, 102, 18)

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


FUNCTION TestExtended(test AS EXTENDED, expected AS EXTENDED, r AS LONG) AS STRING
  LOCAL result AS STRING

  IF ROUND(test, r) = ROUND(expected, r) THEN
    result = "PASS" + $CRLF
  ELSE
    result = "FAILED" + $CRLF + "    recieved  " + STR$(ROUND(test, r)) + $CRLF + "    expected " + STR$(ROUND(expected, r)) + $CRLF
  END IF

  FUNCTION = result
END FUNCTION


FUNCTION TestComplex1(z AS ComplexNumber, Real As EXTENDED, Img AS EXTENDED, r AS LONG) AS STRING
  LOCAL result AS STRING

  IF ROUND(z.real,r) = ROUND(Real,r) AND ROUND(z.img,r) = ROUND(Img,r) THEN
    result += "PASS" + $CRLF
  ELSE
    result += "FAILED" + $CRLF + "    recieved  (" + STR$(ROUND(z.real,r)) + "+" + STR$(ROUND(z.img,r)) + "i)" + $CRLF +_
     "    expected (" + STR$(ROUND(Real,r)) + "+" + STR$(ROUND(Img,r)) + "i)" + $CRLF
  END IF

  FUNCTION = result
END FUNCTION


FUNCTION TestPolar(p AS PolarNumber, Radius As EXTENDED, Radians AS EXTENDED, r AS LONG) AS STRING
  LOCAL result AS STRING

  IF ROUND(p.Radius, r) = ROUND(Radius, r) AND ROUND(p.Radians, r) = ROUND(Radians, r) THEN
    result += "PASS" + $CRLF
  ELSE
    result += "FAILED" + $CRLF + "    recieved  (" + STR$(ROUND(p.Radius,r)) + "+" + STR$(ROUND(p.Radians,r)) + "i)" + $CRLF +_
     "    expected (" + STR$(ROUND(Radius,r)) + "+" + STR$(ROUND(Radians,r)) + "r)" + $CRLF
  END IF

  FUNCTION = result
END FUNCTION


FUNCTION TestArray(a() AS EXTENDED, b() AS EXTENDED, l AS LONG, p AS LONG) AS STRING
  LOCAL i AS LONG
  LOCAL test AS LONG
  LOCAL Result AS STRING

  test = %True
  FOR i=0 TO l
    IF ROUND(a(i), p) <> ROUND(b(i), p) THEN test = %False: EXIT FOR
  NEXT i

  IF test THEN
    Result = "PASS" + $CRLF
  ELSE
    Result = "FAILED recieved  " + $CRLF + ArrayToString(a(), 7, 4) + $CRLF + "    expected " + $CRLF + ArrayToString(b(), 7, 4) + $CRLF
  END IF

  FUNCTION = result
END FUNCTION
