' This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
' http://creativecommons.org/licenses/by/3.0/ or send a letter to
' Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

'MathHelper.INC version 0.00.04
#INCLUDE THIS ONCE

TYPE ComplexNumber
  Real AS EXTENDED
  Img AS EXTENDED
END TYPE

TYPE PolarNumber
  radius AS EXTENDED
  radians AS EXTENDED
END TYPE

TYPE QuaternionNumber
  r AS EXTENDED
  i AS EXTENDED
  j AS EXTENDED
  k AS EXTENDED
END TYPE

CLASS cMathHelper
  INSTANCE HalfPi AS EXTENDED
  INSTANCE Pi AS EXTENDED
  INSTANCE Tau AS EXTENDED
  INSTANCE e AS EXTENDED


  CLASS METHOD CREATE()
    HalfPi  = 1.57079632679489661923132
    Pi      = 3.14159265358979323846264
    Tau     = 6.28318530717958647692528
    e       = 2.71828182845904523536029
  END METHOD

  'Get the ArcTangent2 of x and y
  CLASS METHOD ExtendedAtan2(BYVAL IN x AS EXTENDED, BYVAL IN y AS EXTENDED) AS EXTENDED
      LOCAL result AS EXTENDED

      SELECT CASE x
        CASE 0:
          IF y = 0 THEN
            result = 0
          ELSEIF y > 0 THEN
              result = HalfPi
          ELSE' y < 0
              result = -HalfPi
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


  INTERFACE iMathHelper

    INHERIT IAUTOMATION


    '=======================
    '       Constants
    '=======================


    PROPERTY GET Pi () AS EXTENDED
      PROPERTY = Pi
    END PROPERTY


    'Bailey�Borwein�Plouffe formula for calculating pi
    'http://en.wikipedia.org/wiki/Bailey-Borwein-Plouffe_formula
    METHOD BBP(BYVAL IN MaxK AS LONG) AS EXTENDED
      LOCAL k AS LONG
      LOCAL Sum AS EXTENDED
      LOCAL Product AS EXTENDED

      FOR k = 0 TO MaxK
        Product = 4 / ((8 * k) + 1)
        Product -= 2 / ((8 * k) + 4)
        Product -= 1 / ((8 * k) + 5)
        Product -= 1 / ((8 * k) + 6)
        Product /= 16 ^ k
        Sum += Product
      NEXT k

      METHOD = Sum
    END METHOD


    PROPERTY GET Tau () AS EXTENDED
      PROPERTY = Tau
    END PROPERTY


    PROPERTY GET e () AS EXTENDED
      PROPERTY = e
    END PROPERTY


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
      p.radians = me.ExtendedAtan2(z.real, z.img)

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

      'Function moved to internal CLASS level function
      result = Me.ExtendedAtan2(x, y)

      METHOD = result
    END METHOD


    '===================================
    '       Quaternion functions
    '===================================


    METHOD QuaternionNumber(BYVAL IN r AS EXTENDED, BYVAL IN i AS EXTENDED, BYVAL IN j AS EXTENDED, BYVAL IN k AS EXTENDED) AS QuaternionNumber
      LOCAL Result AS QuaternionNumber

      Result.r = r
      Result.i = i
      Result.j = j
      Result.k = k

      METHOD = Result
    END METHOD


    METHOD QuatAddition(BYVAL IN a AS QuaternionNumber, BYVAL IN b AS QuaternionNumber) AS QuaternionNumber
      LOCAL result AS QuaternionNumber

      Result.r = a.r + b.r
      Result.i = a.i + b.i
      Result.j = a.j + b.j
      Result.k = a.k + b.k

      METHOD = result
    END METHOD

    METHOD QuatMultiplication(BYVAL IN a AS QuaternionNumber, BYVAL IN b AS QuaternionNumber) AS QuaternionNumber
      LOCAL result AS QuaternionNumber

      Result.r = (a.r * b.r) - (a.i * b.i) - (a.j * b.j) - (a.k * b.k)
      Result.i = (a.r * b.i) + (a.i * b.r) + (a.j * b.k) - (a.k * b.j)
      Result.j = (a.r * b.j) - (a.i * b.k) + (a.j * b.r) + (a.k * b.i)
      Result.k = (a.r * b.k) + (a.i * b.j) - (a.j * b.i) + (a.k * b.r)

      METHOD = result
    END METHOD


    METHOD QuatNorm(BYVAL IN a AS QuaternionNumber) AS EXTENDED
      LOCAL result AS EXTENDED

      Result = SQR((a.r * a.r) + (a.i * a.i) + (a.j * a.j) + (a.k * a.k))

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

      result = HalfPi - ATN(a / SQR(1 - a * a))

      METHOD = result
    END METHOD


   'The CosH function
    METHOD CosH(BYVAL IN a AS EXTENDED) AS EXTENDED
      LOCAL result AS EXTENDED

      result = ((e^a)+(e^-a)) / 2

      METHOD = result
    END METHOD


    'The ArcCosH function
    'If  abs(a) < 1 then the result of SQR(a*a-1) is in the imaginary plane
    ' To make complex number version, need to find out how to do a ???LOG of a complex number???
    METHOD ArcCosH(BYVAL IN a AS EXTENDED) AS EXTENDED
      LOCAL result AS EXTENDED

      result = LOG(a + SQR(a * a - 1))

      METHOD = result
    END METHOD



    '===================================
    '  Transforms functions
    '===================================

    'The discrete cosine transform.
    '  pDataIn   A pointer to the source array of EXTENDED data type.
    '  pDataOut  A pointer to the destination array of EXTENDED data type.
    '  DCTSize   Size of the array that you want to transform including 0.
    '
    'Note pDataIn and pDataOut are POINTERS and need to be giving the memory
    'address of the array.  Example to transform source to destination using a
    'DCT of 8 values use: DCT(VARPTR(Source(0)), VARPTR(Destination(0)), 7)
    METHOD DCT(BYVAL IN pDataIn AS EXTENDED POINTER, BYVAL IN pDataOut AS EXTENDED POINTER, BYVAL IN DCTSize AS LONG)
      REGISTER n AS LONG
      REGISTER k AS LONG
      REGISTER Sum AS EXTENDED
      REGISTER ScaledPi AS EXTENDED
      REGISTER ScaleOut AS EXTENDED

      sum = 0
      FOR n = 0 TO DCTSize
          sum += @pDataIn[n]
      NEXT n
      @pDataOut[0] = sum * SQR( 1 /(DCTSize+1))

      ScaleOut =  SQR(2 /(DCTSize+1))
      FOR k = 1 TO DCTSize
        sum = 0
        ScaledPi = (Pi * k) / (DCTSize + 1)
        FOR n = 0 TO DCTSize
          sum += @pDataIn[n] * COS(ScaledPi * (n + 0.5))
        NEXT n
        @pDataOut[k] = sum * ScaleOut
      NEXT k

    END METHOD


    'The inverse discrete cosine transform.
    '  pDataIn   A pointer to the source array of EXTENDED data type.
    '  pDataOut  A pointer to the destination array of EXTENDED data type.
    '  DCTSize   Size of the array that you want to transform including 0.
    '
    'Note pDataIn and pDataOut are POINTERS and need to be giving the memory
    'address of the array.  Example to transform source to destination using a
    'DCT of 8 values use: IDCT(VARPTR(Source(0)), VARPTR(Destination(0)), 7)
    METHOD IDCT(BYVAL IN pDataIn AS EXTENDED POINTER, BYVAL IN pDataOut AS EXTENDED POINTER, BYVAL IN DCTSize AS LONG)
      REGISTER k AS LONG
      REGISTER n AS LONG
      REGISTER Sum AS EXTENDED
      REGISTER ScaledPi AS EXTENDED
      REGISTER ScaleOut AS EXTENDED
      LOCAL ScaleOut0 AS EXTENDED

      ScaleOut =  SQR(2 /(DCTSize+1))
      ScaleOut0 =  (@pDataIn[0] * SQR(1 /(DCTSize+1))) / ScaleOut

      FOR n = 0 TO DCTSize
        sum = ScaleOut0
        ScaledPi = (Pi * (n + 0.5))  / (DCTSize + 1)
        FOR k = 1 TO DCTSize
          sum += @pDataIn[k] * COS(ScaledPi * k)
        NEXT k
        sum = sum * ScaleOut
        @pDataOut[n] = sum
      NEXT n

    END METHOD


    'Returns the Dot product of Two Arrays of EXTENDED type
    METHOD Dot(BYVAL IN pIn1 AS EXTENDED POINTER, BYVAL IN pIn2 AS EXTENDED POINTER, BYVAL IN DotSize AS LONG) AS EXTENDED
      LOCAL Sum AS EXTENDED
      LOCAL i AS LONG

      Sum = 0
      FOR i = 0 TO DotSize
        sum += @pIn1[i] * @pIn2[i]
      NEXT i

      METHOD = Sum
    END METHOD

    'Pearson Correlation Coefficient
    'Source http://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient
    METHOD PearsonCorrelationCoefficient(BYVAL IN pIn1 AS EXTENDED POINTER, BYVAL IN pIn2 AS EXTENDED POINTER, BYVAL IN ArraySize AS LONG) AS EXTENDED
      LOCAL i AS LONG
      LOCAL Average1, Average2 AS EXTENDED
      LOCAL Dif1, Dif2 AS EXTENDED
      LOCAL Sum AS EXTENDED
      LOCAL Sqr1, Sqr2 AS EXTENDED
      LOCAL Result AS EXTENDED

      Average1 = 0
      Average2 = 0
      FOR i = 0 TO ArraySize
        Average1 += @pIn1[i]
        Average2 += @pIn2[i]
      NEXT i
      Average1 = Average1 / (ArraySize + 1)
      Average2 = Average2 / (ArraySize + 1)


      FOR i = 0 TO ArraySize
        Dif1 = @pIn1[i] - Average1
        Dif2 = @pIn2[i] - Average2
        Sum += Dif1 * Dif2
        Sqr1 += Dif1 * Dif1
        Sqr2 += Dif2 * Dif2
      NEXT i

      Result = Sum / SQR(Sqr1 * Sqr2)

      METHOD = Result
    END METHOD


    'Spearman's rank method
    'Used for Spearman's rho ("Spearman's rank correlation coefficient")
    'Source http://en.wikipedia.org/wiki/Spearman%27s_rank_correlation_coefficient
    METHOD Rank(BYVAL IN pIn AS EXTENDED POINTER, BYVAL IN pOut AS EXTENDED POINTER, BYVAL IN ArraySize AS LONG)
      LOCAL i, j AS LONG
      LOCAL Sum, Runlength AS LONG
      LOCAL CheckValue AS EXTENDED
      LOCAL Average AS EXTENDED

      DIM SortedArray(ArraySize) AS EXTENDED
      DIM Tag(ArraySize) AS LONG

      FOR i = 0 TO ArraySize
        SortedArray(i) = @pIn[i]
        Tag(i) = i
      NEXT i

      ARRAY SORT SortedArray(), TAGARRAY Tag(), ASCEND

      FOR i = 0 TO ArraySize
        CheckValue = SortedArray(i)
        Sum = i+1
        RunLength = 1
        FOR j = i+1 TO ArraySize
          IF SortedArray(j) = CheckValue THEN
            Runlength += 1
            Sum += j+1
          ELSE
            EXIT FOR
          END IF
        NEXT j

        Average = Sum / Runlength

        FOR j = i TO i + RunLength - 1
          @pOut[Tag(j)] = Average
        NEXT j
        i = i + RunLength - 1
      NEXT i

      ERASE SortedArray()
      ERASE Tag()


    END METHOD


    'Spearman's rho ("Spearman's rank correlation coefficient")
    'Source http://en.wikipedia.org/wiki/Spearman%27s_rank_correlation_coefficient
    METHOD SpearmansRho(BYVAL IN pIn1 AS EXTENDED POINTER, BYVAL IN pIn2 AS EXTENDED POINTER, BYVAL IN ArraySize AS LONG) AS EXTENDED
      LOCAL i AS LONG
      LOCAL result AS EXTENDED

      DIM X(ArraySize) AS EXTENDED
      DIM Y(ArraySize) AS EXTENDED

      Me.Rank(pIn1, VARPTR(X(0)), ArraySize)
      Me.Rank(pIn2, VARPTR(Y(0)), ArraySize)

      Result = Me.PearsonCorrelationCoefficient(VARPTR(X(0)), VARPTR(Y(0)), ArraySize)

      ERASE X(), Y()

      METHOD = Result

    END METHOD


    'Return the sum value of an array.
    METHOD Sum(BYVAL IN pIn1 AS EXTENDED POINTER, BYVAL IN ArraySize AS LONG) AS EXTENDED
      LOCAL result AS EXTENDED
      LOCAL i AS LONG

      FOR i = 0 TO ArraySize
        result += @pIn1[i]
      NEXT i

      METHOD = result
    END METHOD


    'Return the Average value of an array.
    METHOD Average(BYVAL IN pIn1 AS EXTENDED POINTER, BYVAL IN ArraySize AS LONG) AS EXTENDED
      LOCAL result AS EXTENDED

      result = me.sum(pIn1, ArraySize) / (ArraySize + 1)

      METHOD = result
    END METHOD

    'Return the Sum of the Square Values in an array value of an array.
    METHOD SquareSum(BYVAL IN pIn1 AS EXTENDED POINTER, BYVAL IN ArraySize AS LONG) AS EXTENDED
      LOCAL i AS LONG
      LOCAL SquareSum AS EXTENDED

      FOR i = 0 TO ArraySize
        SquareSum += @pIn1[i] ^ 2
      NEXT i

      METHOD = SquareSum
    END METHOD

    'Return the Population Standard Deviation in an array value of an array.
    'Refrence http://en.wikipedia.org/wiki/Standard_deviation
    METHOD PopulationStandardDeviation(BYVAL IN pIn1 AS EXTENDED POINTER, BYVAL IN ArraySize AS LONG) AS EXTENDED
      LOCAL i AS LONG
      LOCAL SquareSum AS EXTENDED
      LOCAL Average AS EXTENDED
      LOCAL Result AS EXTENDED

      Average = me.Average(pIn1,ArraySize)
      SquareSum = me.SquareSum(pIN1, ArraySize)
      Result = SQR((SquareSum - (Average * Average * (ArraySize+1))) / (ArraySize+1))

      METHOD = Result
    END METHOD


    'Return the Population Standard Deviation in an array value of an array.
    'Refrence http://en.wikipedia.org/wiki/Standard_deviation
    METHOD SampleStandardDeviation(BYVAL IN pIn1 AS EXTENDED POINTER, BYVAL IN ArraySize AS LONG) AS EXTENDED
      LOCAL i AS LONG
      LOCAL SquareSum AS EXTENDED
      LOCAL Average AS EXTENDED
      LOCAL Result AS EXTENDED

      Average = me.Average(pIn1,ArraySize)
      SquareSum = me.SquareSum(pIN1, ArraySize)
      Result = SQR((SquareSum - (Average * Average * (ArraySize + 1))) / ArraySize)

      METHOD = Result
    END METHOD


  END INTERFACE
END CLASS
