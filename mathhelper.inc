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
    METHOD ComplexNumber(BYVAL IN r AS EXTENDED,BYVAL IN i AS EXTENDED) AS ComplexNumber
      LOCAL z AS ComplexNumber
      z.real = r
      z.img = i
      METHOD = z
    END METHOD

    METHOD PolarNumber(BYVAL IN radius AS EXTENDED, BYVAL IN radians AS EXTENDED) AS PolarNumber
      LOCAL p AS polarNumber

      p.radius = radius
      p.radians = radians

      METHOD = p
    END METHOD

    METHOD ComplexAddition(BYVAL IN z1 AS ComplexNumber, BYVAL IN z2 AS ComplexNumber) AS ComplexNumber
      LOCAL z AS ComplexNumber
      z.real = z1.real + z2.real
      z.img = z1.img + z2.img
      METHOD = z
    END METHOD

    METHOD ComplexConjugate(BYVAL IN z1 AS ComplexNumber) AS ComplexNumber
      LOCAL z AS ComplexNumber
      z.real = z1.real
      z.img = -z1.img
      METHOD = z
    END METHOD

    METHOD ComplexSubtraction(BYVAL IN z1 AS ComplexNumber, BYVAL IN z2 AS ComplexNumber) AS ComplexNumber
      LOCAL z AS ComplexNumber
      z.real = z1.real - z2.real
      z.img = z1.img - z2.img
      METHOD = z
    END METHOD

    METHOD ComplexMultiply(BYVAL IN z1 AS ComplexNumber, BYVAL IN z2 AS ComplexNumber) AS ComplexNumber
      LOCAL z AS ComplexNumber
      z.real = (z1.real * z2.real) - (z1.img * z2.img)
      z.img = (z1.real * z2.img) + (z2.real * z1.img)
      METHOD = z
    END METHOD

    METHOD ComplexDivide(BYVAL IN z1 AS ComplexNumber, BYVAL IN z2 AS ComplexNumber) AS ComplexNumber
      LOCAL z AS ComplexNumber
      LOCAL d AS EXTENDED
      d = (z2.real * z2.real) + (z2.img * z2.img)

      z.real = ((z1.real * z2.real) + (z1.img  * z2.img)) / d
      z.img =  ((z1.img  * z2.real) - (z1.real * z2.img)) / d
      METHOD = z
    END METHOD

    METHOD ComplexSquareRoot(BYVAL IN z1 AS ComplexNumber) AS ComplexNumber
      LOCAL z AS ComplexNumber
      LOCAL d AS EXTENDED
      d = SQR((z1.real * z1.real) + (z1.img * z1.img))

      z.real = SQR((z1.real + d)/2)
      z.img =  SQR(((-z1.real) + d)/2)
      IF z1.img < 0 THEN z.img = -z.img
      METHOD = z
    END METHOD

    METHOD ComplexToPolar(BYVAL IN z AS ComplexNumber) AS PolarNumber
      LOCAL p AS polarNumber

      p.radius = SQR((z.real * z.real) + (z.img * z.img))
      p.radians = me.atan2(z.real, z.img)

      METHOD = p
    END METHOD

    METHOD PolarToComplex(BYVAL IN p AS PolarNumber) AS ComplexNumber
      LOCAL z AS ComplexNumber

      z.real = COS(p.radians) * p.radius
      z.img = SIN(p.radians) * p.radius

      METHOD = z
    END METHOD


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
    METHOD ArcSin(BYVAL IN a AS EXTENDED) AS EXTENDED
      LOCAL result AS EXTENDED

      result = ATN(a / SQR(1 - a * a))

      METHOD = result
    END METHOD

    METHOD ArcCos(BYVAL IN a AS EXTENDED) AS EXTENDED
      LOCAL result AS EXTENDED

      result = Pi / 2 - ATN(a / SQR(1 - a * a))

      METHOD = result
    END METHOD


  END INTERFACE
END CLASS
