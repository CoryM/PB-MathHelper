' This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
' http://creativecommons.org/licenses/by/3.0/ or send a letter to
' Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.


#REGISTER NONE  'Needed for bug in optimazation see: "http://www.powerbasic.com/support/pbforums/showthread.php?p=408285"

TYPE ComplexNumber
  Real AS EXTENDED
  Img AS EXTENDED
END TYPE

TYPE PolarNumber
  radius AS EXTENDED
  radians AS EXTENDED
END TYPE

CLASS cMathHelper
  INSTANCE Pi AS EXTENDED


  CLASS METHOD CREATE()
    Pi = 3.14159265358979323846264
  END METHOD


  INTERFACE iMathHelper

    INHERIT IUNKNOWN


    METHOD Pi () AS EXTENDED
      METHOD = Pi
    END METHOD


    '=======================
    '  Complex Number Math
    '=======================


    'Helps set a complex number
    METHOD ComplexNumber(BYVAL IN r AS EXTENDED,BYVAL IN i AS EXTENDED) AS ComplexNumber
      LOCAL z AS ComplexNumber
      z.real = r
      z.img = i
      METHOD = z
    END METHOD


    'Helps set a Polar number
    METHOD PolarNumber(BYVAL IN radius AS EXTENDED, BYVAL IN radians AS EXTENDED) AS PolarNumber
      LOCAL p AS polarNumber

      p.radius = radius
      p.radians = radians

      METHOD = p
    END METHOD


    'Add two complex number together
    METHOD ComplexAddition(BYVAL IN z1 AS ComplexNumber, BYVAL IN z2 AS ComplexNumber) AS ComplexNumber
      LOCAL z AS ComplexNumber
      z.real = z1.real + z2.real
      z.img = z1.img + z2.img
      METHOD = z
    END METHOD


    'Get the Conjugate of a complex number
    METHOD ComplexConjugate(BYVAL IN z1 AS ComplexNumber) AS ComplexNumber
      LOCAL z AS ComplexNumber
      z.real = z1.real
      z.img = -z1.img
      METHOD = z
    END METHOD


    'Subtract two complex numbers together
    METHOD ComplexSubtraction(BYVAL IN z1 AS ComplexNumber, BYVAL IN z2 AS ComplexNumber) AS ComplexNumber
      LOCAL z AS ComplexNumber
      z.real = z1.real - z2.real
      z.img = z1.img - z2.img
      METHOD = z
    END METHOD


    'Multiply two complex numbers together
    METHOD ComplexMultiply(BYVAL IN z1 AS ComplexNumber, BYVAL IN z2 AS ComplexNumber) AS ComplexNumber
      LOCAL z AS ComplexNumber
      z.real = (z1.real * z2.real) - (z1.img * z2.img)
      z.img = (z1.real * z2.img) + (z2.real * z1.img)
      METHOD = z
    END METHOD


    'Divide complex numbers z1 by z2
    METHOD ComplexDivide(BYVAL IN z1 AS ComplexNumber, BYVAL IN z2 AS ComplexNumber) AS ComplexNumber
      LOCAL z AS ComplexNumber
      LOCAL d AS EXTENDED
      d = (z2.real * z2.real) + (z2.img * z2.img)

      z.real = ((z1.real * z2.real) + (z1.img  * z2.img)) / d
      z.img =  ((z1.img  * z2.real) - (z1.real * z2.img)) / d
      METHOD = z
    END METHOD


    'Get the SquareRoot of a complex number
    METHOD ComplexSquareRoot(BYVAL IN z1 AS ComplexNumber) AS ComplexNumber
      LOCAL z AS ComplexNumber
      LOCAL d AS EXTENDED
      d = SQR((z1.real * z1.real) + (z1.img * z1.img))

      z.real = SQR((z1.real + d)/2)
      z.img =  SQR(((-z1.real) + d)/2)
      IF z1.img < 0 THEN z.img = -z.img
      METHOD = z
    END METHOD


    'Raise a complex number in Polar form by a arbitrary power.
    METHOD PolarPower(BYVAL IN p1 AS PolarNumber, Power AS EXTENDED) AS PolarNumber
      LOCAL p AS PolarNumber

      p = p1
      p.radius = p.radius ^ Power
      p.radians = p.radians * Power

      METHOD = p
    END METHOD


    'Raise a complex number by a arbitrary power.
    METHOD ComplexPower(BYVAL IN z1 AS ComplexNumber, Power AS EXTENDED) AS ComplexNumber
      LOCAL z AS ComplexNumber
      LOCAL p AS PolarNumber

      p = me.ComplexToPolar(z1)
      p = me.PolarPower(p, Power)
      z = me.PolarToComplex(p)

      METHOD = z
    END METHOD


    'Convert a complex number into its polar form
    METHOD ComplexToPolar(BYVAL IN z AS ComplexNumber) AS PolarNumber
      LOCAL p AS polarNumber

      p.radius = SQR((z.real * z.real) + (z.img * z.img))
      p.radians = me.atan2(z.real, z.img)

      METHOD = p
    END METHOD


    'Convert a polar number into its complex form.
    METHOD PolarToComplex(BYVAL IN p AS PolarNumber) AS ComplexNumber
      LOCAL z AS ComplexNumber

      z.real = COS(p.radians) * p.radius
      z.img = SIN(p.radians) * p.radius

      METHOD = z
    END METHOD


    'Get the ArcTangent2 of x and y
    METHOD ATAN2(BYVAL IN x AS EXTENDED, BYVAL IN y AS EXTENDED) AS EXTENDED
      LOCAL result AS EXTENDED

      SELECT CASE x
        CASE 0:
          IF y = 0 THEN
            result = 0
          ELSEIF y > 0 THEN
              result = Pi / 2
          ELSE' y < 0
              result = -Pi / 2
          END IF
        CASE > 0: result = ATN(y/x)
        CASE < 0:
          IF y => 0 THEN
            result = ATN(y / x) + Pi
          ELSE
            result = ATN(y / x) - Pi
          END IF
      END SELECT

      METHOD = result
    END METHOD


    '===================================
    '  Inverse Trigonometric functions
    '===================================


    'The ArcSin function
    METHOD ArcSin(BYVAL IN a AS EXTENDED) AS EXTENDED
      LOCAL result AS EXTENDED

      result = ATN(a / SQR(1 - a * a))

      METHOD = result
    END METHOD


    'The SinH function
    METHOD SinH(BYVAL IN a AS EXTENDED) AS EXTENDED
      LOCAL result AS EXTENDED

      result = (EXP(a) - EXP(-a)) / 2

      METHOD = result
    END METHOD


    'The ArcSinH function
    METHOD ArcSinH(BYVAL IN a AS EXTENDED) AS EXTENDED
      LOCAL result AS EXTENDED

      result = LOG(a + SQR(a * a + 1))

      METHOD = result
    END METHOD


    'The ArcCos Function
    METHOD ArcCos(BYVAL IN a AS EXTENDED) AS EXTENDED
      LOCAL result AS EXTENDED

      result = Pi / 2 - ATN(a / SQR(1 - a * a))

      METHOD = result
    END METHOD


   'The CosH function
    METHOD CosH(BYVAL IN a AS EXTENDED) AS EXTENDED
      LOCAL result AS EXTENDED

      result = Pi / 2 - ATN(a / SQR(1 - a * a))

      METHOD = result
    END METHOD


    'The ArcCosH function
    'If -1 <= a >= 1 then the result of SQR(a*a-1) is in the imaginary plane
    ' To make complex version need to find out how to do a ???LOG of a complex number???
    METHOD ArcCosH(BYVAL IN a AS EXTENDED) AS EXTENDED
      LOCAL result AS EXTENDED

      result = LOG(a + SQR(a * a - 1))

      METHOD = result
    END METHOD



    '===================================
    '  Transforms functions
    '===================================

    'The discrete cosine transform.
    '  pDataIn   A pointer to the source array of extended data type.
    '  pDataOut  A pointer to the destination array of extended data type.
    '  DCTSize   Size of the array that you want to transform including 0.
    '
    'Note pDataIn and pDataOut are POINTERS and need to be giving the memory
    'address of the array.  Example to transform source to destination using a
    'DCT of 8 values use: DCT(VARPTR(Source(0)), VARPTR(Destination(0)), 7)
    METHOD DCT(BYVAL IN pDataIn AS EXTENDED POINTER, BYVAL IN pDataOut AS EXTENDED POINTER, BYVAL IN DCTSize AS LONG)
      LOCAL k AS LONG
      LOCAL n AS LONG
      LOCAL Sum AS EXTENDED
      LOCAL ScaledPi AS EXTENDED
      LOCAL ScaleOut AS EXTENDED

      ScaleOut =  SQR(2 /(DCTSize+1))

      FOR k = 0 TO DCTSize
        sum = 0
        ScaledPi = (me.pi * k) / (DCTSize + 1)
        FOR n = 0 TO DCTSize
          sum += @pDataIn[n] * COS(ScaledPi * (n + 0.5))
        NEXT n
        @pDataOut[k] = sum * ScaleOut
      NEXT k
      @pDataOut[0] = (@pDataOut[0] / ScaleOut) * SQR( 1 /(DCTSize+1))

    END METHOD


    'The inverse discrete cosine transform.
    '  pDataIn   A pointer to the source array of extended data type.
    '  pDataOut  A pointer to the destination array of extended data type.
    '  DCTSize   Size of the array that you want to transform including 0.
    '
    'Note pDataIn and pDataOut are POINTERS and need to be giving the memory
    'address of the array.  Example to transform source to destination using a
    'DCT of 8 values use: IDCT(VARPTR(Source(0)), VARPTR(Destination(0)), 7)
    METHOD IDCT(BYVAL IN pDataIn AS EXTENDED POINTER, BYVAL IN pDataOut AS EXTENDED POINTER, BYVAL IN DCTSize AS LONG)
      LOCAL k AS LONG
      LOCAL n AS LONG
      LOCAL Sum AS EXTENDED
      LOCAL p AS EXTENDED
      LOCAL ScaleOut AS EXTENDED
      LOCAL ScaleOut0 AS EXTENDED
      LOCAL ScaledPi AS EXTENDED

      ScaleOut =  SQR(2 /(DCTSize+1))
      ScaleOut0 =  (@pDataIn[0] * SQR(1 /(DCTSize+1))) / ScaleOut

      FOR n = 0 TO DCTSize
        sum = ScaleOut0
        ScaledPi = (Pi * (n + 0.5))  / (DCTSize + 1)
        FOR k = 1 TO DCTSize
          sum += @pDataIn[k] * COS(ScaledPi * k)
        NEXT k
        sum = sum * ScaleOut
        @pDataOut[n] = ROUND(sum,14)
      NEXT n

    END METHOD


  END INTERFACE
END CLASS
