Math Helper
===========
+ New and/or improved
- Removed or degraded
b Known Bug
f Bug Fixed
o Other

0.00.04
=======
 + New METHOD PearsonCorrelationCoefficient(X[], Y[], ArraySize)	: Returns the Pearson's Correlation Coefficient of data array pairs in X and Y
 + New METHOD Rank(In[], Out[], ArraySize)							: Ranking method as defined by Spearman's Rank Correlation Coefficient
 + New METHOD SpearmansRho(X[], Y[], ArraySize)						: Returns the Spearman's Rho ("Spearmans's Ran Correlation Coefficient")
 + New METHOD BBP(MaxK) 											: Return the Bailey–Borwein–Plouffe formula for Pi
 + New METHOD Sum(In[], ArraySize)									: Returns the sum of an array.
 o Changed IUNKNOWN to IAUTOMATION to work around the issues with passing EXTENDED persion values
	o Changed all DOUBLES back to EXTENDED persion
	o ComplexToPolar .. Rounding of test changed from 14 to 15
    o CompelexPower .. Rounding of test changed from 13 to 16
    o ArcCos .. Rounding of test changed from 15 to 16
    o DCT .. Rounding of test changed from 14 to 16
    o iDCT .. Rounding of test changed from 14 to 15
    o All other existing tests did not need to be adjusted.
 

0.00.03
=======
 + New PROPERTY e	: Returns the constant e (2.71828....)
 b Correct the function and test of method CosH
 o Changed Pi and Tau from a METHOD to a "PROPERTY GET"
 - Changed from EXTENDED to DOUBLE percision float types for external interface.  
    o #REGISTER NONE no longer needed
    o ComplexToPolar .. Rounding of test changed from 15 to 14
    o CompelexPower .. Rounding of test changed from 16 to 13
    o ArcCos .. Rounding of test changed from 17 to 15
    o DCT .. Rounding of test changed from 16 to 14
    o iDCT .. Rounding of test changed from 16 to 14
    o All other existing tests did not need to be adjusted.

0.00.02
=======
 + Added Changes.md                           : A change log. (This file)
 + New METHOD SinH(a)                         : Returns the Hyperbolic Sine of a
 + New METHOD ArcSinH(a)                      : Returns the Inverse Hyperbolic Sine of a
 + New METHOD CosH(a)                         : Returns the Hyperbolic Cosine of a
 + New METHOD ArcCosH(a)                      : Returns the Inverse Hyperbolic Cosine of a
 + New METHOD DCT(In, Out, Size)              : Performs a Discrete Cosine Transform on In and Places the results in Out
 + New METHOD IDCT(In, Out, Size)             : Performs a Inverse Discrete Cosine Transform on In and Places the results in Out
 + New METHOD ComplexPower(z, P)              : Raises z to the power of P
 + New METHOD PolarPower(p1, P)               : Raises a Polar number (p1) by the power of P
 + New METHOD Dot(In1, In2, Size)             : Returns the Dot product of two extended arrays
 + New Constant Tau                           : Returns Tau.  Tau = 2*Pi
 o Small improvments to documentation


0.00.01
=======
 + New TYPE ComplexNumber                     : Stores the values of a Complex Number
 + New TYPE PolarNumber                       : Stores the values of a Polar Number
 + New METHOD Pi                              : returns the value of Pi (3.1415....)
 + New METHOD ComplexNumber(real, imanginary) : Helps set Complex Numbers
 + New METHOD PolarNumber(radius, radians)    : Helps set Polar Numbers
 + New METHOD ComplexAddition(z1, z2)         : Adds z1 and z2 together
 + New METHOD ComplexConjugate(z)             : Returns the Conjugate of the complex number z
 + New METHOD ComplexSubtraction(z1, z2)      : Subtracts Z2 from Z1
 + New METHOD ComplexMultiply(z1, z2)         : Multiplies z1 by z2
 + New METHOD ComplexDivide(z1, z2)           : Divides z1 by z2
 + New METHOD ComplexSquareRoot(z)            : Returns the squareroot of z
 + New METHOD ComplexToPolar(z)               : Converts z into a polar number
 + New METHOD PolarToComplex(p)               : Converts a polar number into a complex number
 + New METHOD ATan2(x, y)                     : Returns the ArcTangent of (x,y)
 + New METHOD ArcSin(a)                       : Returns the ArcSine of a
 + New METHOD ArcCos(a)                       : Returns the ArcCosine of a
