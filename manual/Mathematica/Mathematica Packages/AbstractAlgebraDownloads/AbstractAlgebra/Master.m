(* ::Package:: *)

(* ::Title:: *)
(*AbstractAlgebra`Master` package*)


(* ::Subsubtitle:: *)
(*Exploring Abstract Algebra with Mathematica*)
(*Al Hibbard and Ken Levasseur*)
(*\[Copyright] Copyright 1998 by Al Hibbard and Ken Levasseur*)


(* ::Section:: *)
(* 0. Prelims*)


(* :Title:  AbstractAlgebra`Master *)

(* :Context: AbstractAlgebra`Master` *)

(* :Authors: 	
	
	Allen C. Hibbard
	hibbarda@central.edu
	http://www.central.edu/homepages/hibbarda/
							 
	Kenneth M. Levasseur
	Kenneth_Levasseur@uml.edu
	http://faculty.uml.edu/klevasseur/
	
	Homepage for Exploring Abstract Algebra with Mathematica:
	http://www.central.edu/eaam/

*)

(* :Package Version: 9.0.0 *)

(* :Mathematica Version: 8.x, NOT 3.x, 4.x, 5.x since graphics output has been modified *)

(* :Copyright: Copyright 2006, Allen C. Hibbard and 
			 Kenneth M. Levasseur*)
			 
			 


(* ::Subsection:: *)
(*History of sections of code*)


(* ::Input:: *)
(*(* :History:*)
(*See AAChanges.nb notebook for details*)
(*	*)
(**)*)


(* ::Section:: *)
(* 1. Startup*)


BeginPackage["AbstractAlgebra`Master`"(*,{ Removed "Utilities`FilterRules`" from list 1/7/2013}*)
(* Removed ,"Graphics`Colors`" from list 7/24/08 *)];
Off[General::"spell",General::"spell1"];
Off[AppendTo::"rvalue"];
Off[Function::"slotn"];
	(*should shut off bug message about problems with Mod[#1+#2,5]&*)

SetOptions[Graphics,AspectRatio->Automatic];
Format[LineBreak[_]]="";
(*Format[Indent[_]]="";*)
Format[StringBreak[_]]="";


(* ::Section:: *)
(* 2. Usage statements*)


(* ::Input:: *)
(*(* CycleToList::usage = "CycleToList[c] converts Cycle[a1, a2, ...] into {a1, a2, ...}."; - doesn't need to be public *)*)
(**)
(**)
(*(* NormalizePermutations::usage = "NormalizePermutations[p1, p2] will take two permutations of possibly different lengths and rewrite them as a Sequence of the same permutations in S[n] where n is the maximum of the lengths of p1 and p2."; - doesn't need to be public *)*)
(**)
(*(* StructureName::usage = "StructureName[S] returns the built-in or assigned name of the particular gropuoid (group) or ringoid (ring) under investigation."; remove so that calculators work - can use GroupoidName and RingoidName *)*)
(**)
(*(*CycleQ::usage = "CycleQ[c] returns True if c is a cycle, and False otherwise. To be a cycle, c must have Head Cycle and have one or more arguments that are distinct positive integers.";*)*)
(**)
(*(*ExtensionEvaluation::usage = "ExtensionEvaluation[E, q], given E as the quotient ring of F over the irreducible polynomial p, evaluates the induced coset polynomial equivalent to p at the element q in E. The function InducedCosetPolynomialFunction is related.";*)*)
(**)
(*(*InducedCosetPolynomialFunction::usage = "InducedCosetPolynomialFunction[E], given E as the quotient ring of F over the irreducible polynomial p, returns (as a function) the coset polynomial equivalent to p. In other words, the function that is returned represents the polynomial function induced from p by replacing the coefficients (from F) of p with the corresponding (coset) polynomials from E and replacing the addition and multiplication of F from within p to the multiplication and addition within E.";*)*)
(**)
(*(*ListToCycle::usage = "ListToCycle[{a1, a2, ...}] converts {a1, a2, ...} into Cycle[a1, a2, ...].";*)*)
(**)
(*(*NormalizeCycle::usage = "NormalizeCycle[c] returns the Cycle c in the canonical form where the elements are rotated until the smallest entry occurs first.";*)
(**)
(*NormalizeCycleList::usage = "NormalizeCycleList[cl], given a list of cycles, returns a list of cycles in a canonical form. If cl consists only of cycles of length 1, it drops all of them except the one with maximal value; otherwise, all cycles of length one are dropped, the remaining cycles are normalized by NormalizeCycle, and then the list is sorted from shortest to longest.";*)
(**)*)
(**)


ComputationalMouseovers::usage = "ComputationalMouseovers is a global variable (within AbstractAlgebra) that controls whether Mouseovers over computational results will be displayed or not. Set it to True or False.";

UseKey::usage = "UseKey is an option for CayleyTable. When set to True, the actual names of the group or ring elements will be replaced with generic names g1, g2, and so on and then a key showing the correspondence is given below. When set to False, the actual labels for the elements will be used in the Cayley table without using a key, even if normally the elements are wide and a key would be used by default.";

TooltipInfo::usage = "This is an option for CayleyTable that determines what information should be shown in the ToolTip when the mouse hovers over an element in the table. The default value is Automatic which means that the element's order and inverse will be shown (and the actual element when a key is used).";

Pascal::usage = "Pascal[g, h, G, n] returns the first n+1 rows of group elements from G generated in much the same way as Pascal's triangle is generated. The left side is seeded with the value of g while the right side with the value of h (both from G) and then the triangle is completed by performing the group operation from G.";

A::usage = "A[n] returns the group of even permutations on the set {1,2,..n} under composition. See Alternating for more details.";

AbelianQ::usage = "AbelianQ[G] returns True if the Groupoid G is Abelian (commutative), and False otherwise. This is equivalent to CommutativeQ[G]. Available options: Mode (possible values: Computational, Textual, Visual, All, and Interactive (for indexed groups)).";

Addition::usage = "Addition[S] returns the addition operator in the Ringoid S. If S is a Groupoid, Addition[S] is simply the Groupoid's operation. Given an extension Ext of a ring, Addition[Ext] is the addition in this extension. Addition is also a value for the Operation option that is used with some ring functions.";

AdditiveGroupoid::usage = "AdditiveGroupoid[R] returns the additive Groupoid of the ring R. A shortcut is AGroupoid[R].";

AdditiveToMultiplicative::usage = "AdditiveToMultiplicative[R, add] returns the multiplicative form of the element add (given in additive form) from the ringoid R (typically a Galois field).";

Adjoin::usage = "Adjoin[list, num] returns the elements in list with num adjoined. If num is the nth root of rad, then the set of all 'polynomials' of degree less than n in the 'indeterminate' rad with coefficients from list is returned. If num is anything else, the function fails. Adjoin[S, num], for a structured set S, is equivalent to Adjoin[Elements[S], num]. Adjoin[list, ind, deg] returns the set of polynomials in the indeterminate ind of degree deg (or less) with coefficients from list. Adjoin[S, ind, deg], for a structured set S, is equivalent to Adjoin[Elements[S], ind, deg].";

Adjoint::usage = "Adjoint[A] returns Transpose[MatrixConjugate[A]], the transpose of the conjugate of a matrix. (For the usage of adjoint as it relates to determinants, see DetAdjoint.)";

AGroupoid::usage = "AGroupoid[R] returns the additive Groupoid associated with the Ringoid R. This is equivalent to AdditiveGroupoid[R].";

Alternating::usage = "Alternating[n] returns the group of even permutations on the set {1,2,..n} under composition. There are two options for this function, ProductOrder and IndexLimit. Since the elements of this group are permutations, one can specify the order that the product is taken. See ProductOrder for more information, including the values that can be used. IndexLimit defaults to 6 and indicates the upper limit for the value of the index n. There is also the Textual Mode for this group.";

AlternatingGroupAA::usage = "AlternatingGroupAA[n] - see Alternating.";

Annihilator::usage = "Annihilator[R, S] returns the annihilator of S in R. This consists of all elements r in R such that r s = Zero[R] for all elements s in S.";

AntiCommutingMatricesQ::usage = "AntiCommutingMatricesQ[R, A, B] returns True or False depending on whether the matrices A and B over the Ringoid R anti-commute in the sense that A B = - B A. AntiCommutingMatricesQ[MatricesOver[R,{n,n}], A, B] works similarly. For matrices with numeric entries (over Integers, Rationals, Reals or Complex), AntiCommutingMatricesQ[A, B] works similarly.";

Any::usage = "Any is a value for the SelectFrom option for RandomElement and RandomElements. This value allows any element to be returned. Alternatively, one may use NonIdentity (or NonZero or NonUnity when working with rings).";

AsIJK::usage = "AsIJK is a value for the Form option for the QuaternionGroup function. This specifies that the quaternion group is to be represented by the elements {\[PlusMinus] 1, \[PlusMinus] I, \[PlusMinus] JJ, \[PlusMinus] KK}, with a set of relations governing these elements. (Note that K is a reserved symbol starting in version 3 and J is used with rings.)";

AsMatrices::usage = "AsMatrices is a value for the Form option for the QuaternionGroup function. This specifies that the quaternion group is to be represented by 2-by-2 matrices. This is the default value.";

Associates::usage = "Associates is a value for the Combine option of IntegerDivisors and ZdDivisors. With this value, the divisors of n are grouped in pairs {a, b} such that a and b are associates.";

AssociativeQ::usage = "AssociativeQ[S] returns True if the structure S is associative, and False otherwise. When used with rings, one has the Operation option, which can have the value Addition, Multiplication or Both. Another option: Mode (possible values: Computational, Textual, Visual, and All)";

AsSymbols::usage = "AsSymbols is a value for the Form option for the QuaternionGroup function. This specifies that the quaternion group is to be generated by the symbols {a, b} subject to a set of relations governing these symbols. In this form, the elements used are given in the form of Mathematica strings. ";

Aut::usage ="Aut[G] is a shortcut for AutomorphismGroup[G].";

Automorphism::usage="Automorphism[G, a \[Rule] b] forms the automorphism determined by the single rule a \[Rule] b, if a and b are both generators of the cyclic group G. Available option : Mode (possible values : Computational, Textual, Visual, and All).";

AutomorphismGroup::usage="AutomorphismGroup[G] returns the group of automorphisms of a cyclic group G.";

BackgroundColors::usage = "BackgroundColors is a global constant consisting of a string of colors originally from the Graphics`Colors` package (and now either built-in or called from Legacy suite) that are used for colors in the Cayley table and other similar places. Although the colors are given in RGBColor format, the default list for this variable uses the following names of colors:\n {Yellow, Orange, Violet, Blue, Mint, Turquoise, EmeraldGreen, GreenDark, Pink, BlueLight, Banana, Green, Brown, Gray, Red, Purple, CadmiumYellow, Maroon, Navy, Salmon, Aquamarine, Indigo, Lavender, Antique, Bisque, Burlywood, Eggshell, Khaki, BlueViolet, CadmiumOrange, CadmiumRedDeep, Cerulean, Chartreuse, Cyan, DeepPink, Magenta, OrangeRed, Peacock, SkyBlueDeep, TurquoiseDark, Ultramarine}";

BaseRing::usage="BaseRing[R] returns the base ring of an extension or quotient ring. If p is a polynomial, BaseRing[p] returns the underlying base ring for the polynomial p.";

BodyColored::usage = "BodyColored is an option for CayleyTable. When set to True (default value), the table is colored. When set to False, the table appears with a white background. This may be useful for printing tables.";

BooleanRing::usage = "BooleanRing[n] constructs the Boolean Ring consisting of the set of subsets of {1, 2, ..., n} with the operations symmetric difference and intersection. BooleanRing[B] constructs the ring with subsets of the list B.";

Both::usage = "Both is a value for the Operation option used in various ring functions.";

Canonical::usage = "Canonical is a value for the Representatives option for the QuotientGroup (and QuotientRing) function. This value causes QuotientGroup to use the 'first' element in the coset.";

CartesianProduct::usage = "CartesianProduct[els1, els2] returns the Cartesian product, as a list of ordered pairs, of the two sets  els1 and els2. CartesianProduct[els1, els2, Partition \[Rule] True] partitions the ordered pairs using the Partition function, cut to the length of els2. CartesianProduct[ListOfLists] returns the Cartesian product of the lists of elements in ListOfLists.";

Cautious::usage="Cautious is an option for IsomorphismQ, indicating whether MorphismQ (using value True) or ProbableMorphismQ (using value False) should be used. The default value is False.";

CayleyForm::usage = "CayleyForm is an option for CayleyTable (and functions that form Groupoids or Ringoids) to indicate whether the elements in the Cayley table should be displayed in InputForm, OutputForm or some other form. The default value is OutputForm.";

CayleyTable::usage = "CayleyTable[G] returns the Cayley table for the structure G colored with a different color for each element in G. If it is desired that the elements (Elements[G]) be reordered, then CayleyTable[G, TheSet \[Rule] NewOrder] will return a new Cayley table according to the new ordering of the elements as found in the list NewOrder. When used with rings, the Operation option can be used, which can have the value Addition, Multiplication or Both. Other options specific to CayleyTable (with the default value given in parentheses) are HeadingsColored (True), ShowOperator (True), ShowName (True), ShowBodyText (True), ShowSidesText (True), ShowKey (True), VarToUse ('g'), KeyForm (InputForm), and CayleyForm (InputForm). CayleyTable[{G1,G2,..Gn},opts] returns CayleyTable[G1,opts], CayleyTable[G2,opts] and so on. Multiple CayleyTables can also be obtained by using the following variant forms: CayleyTable[{G1,G2,..Gn}, {opts1, opts2, .. optsn}] (optsi applies to Gi) and CayleyTable[{{G1, opts1}, {G2, opts2},..{Gn, optsn}}] (optsi applies to Gi).";

CayleyTables::usage = "CayleyTables[R] returns the Cayley tables (in double array form), for the additive and multiplicative Groupoids associated with the Ringoid R. CayleyTables[R, Mode \[Rule] Visual] returns a graphical view of these tables. See CayleyTable for a description of the available options.";

Center::usage = "Center[G] returns the center of the group G. This is identical to GroupCenter. \nThe standard (built-in) usage still exists: Center is used to specify alignment in printforms such as ColumnForm and TableForm.";

Centralizer::usage = "Centralizer[G, g] returns the centralizer of g in the group G. Centralizer[G, H] returns the centralizer of the subgroup H in the group G. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (on group elements)).";

Characteristic::usage = "Characteristic[R] returns the characteristic of the structure R.";

ClosedDiffQ::usage = "ClosedDiffQ[R, S] returns True if S is closed with respect to subtraction in the structure R, and False otherwise.";

ClosedPlusQ::usage = "ClosedPlusQ[R, S] returns True if S is closed with respect to addition in the structure R, and False otherwise.";

ClosedQ::usage = "ClosedQ[S] returns True if the set of elements in the structure S is closed under its operation, and False otherwise. Additionally, ClosedQ[S, H] determines whether H is a closed subset of the structure S. When used with rings, the Operation option can be used, which can have the value Addition, Multiplication or Both. Another available option: Mode (possible values: Computational, Textual, Visual, and All).";

ClosedTimesQ::usage = "ClosedTimesQ[R, S] returns True if S is closed with respect to multiplication in the structure R, and False otherwise.";

CloseSets::usage = "CloseSets[list1, list2, op] returns a list of all the distinct elements obtained by applying the operation op on the Cartesian product of list1 and list2]";

Closure::usage = "Closure[G, H] returns the subgroup of G generated by the elements in the set H (assuming H is a subset of G or a Groupoid whose elements are a subset of G). The option ReportIterations (defaulting to False) indicates whether the result of each iteration is also returned. The option Sort, when set to False (default), returns the elements in the order they are generated, while when set to True, returns the elements sorted. Another available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (on group elements)).";

Codomain::usage = "Codomain[f] returns the structure used in the image of the Morphoid f.";

Coefficient::usage = "Coefficient[poly, ind, n], given a polynomial over some ring in the indeterminate ind, returns the coefficient of ind^n. Coefficient[poly, n] works similarly, without the indeterminate needing to be specified. \nThe standard (built-in) usage still exists: Coefficient[expr, form] gives the coefficient of form in the polynomial expr. Coefficient[expr, form, n] gives the coefficient of form^n in expr.";

CoefficientList::usage = "CoefficientList[poly] returns the list of coefficients used in the polynomial poly over some ring R. Note that these are returned in the order as if PowersIncrease \[Rule] RightToLeft was given. In other words, CoefficientList[x^2 + 2x + 3] returns {3,2,1}. \nThe standard (built-in) usage still exists: CoefficientList[poly, var] gives a list of coefficients of powers of var in poly, starting with power 0. CoefficientList[poly, {var1, var2, ...}] gives a matrix of coefficients of the vari.";

ColorCodomain::usage = "ColorCodomain is an option for the VisualizeMorphoid function. By specifying ColorCodomain \[Rule] {{color1, cod1}, {color2, cod2},...}, the arrows to the codomain element codi will be colored colori. Note that these requests supercede those requests from the ColorDomain option, if an arrow is requested to be colored by both ColorDomain and ColorCodomain.";

ColorDomain::usage = "ColorDomain is an option for the VisualizeMorphoid function. By specifying ColorDomain \[Rule] {{color1, dom1}, {color2, dom2},...}, the arrow from domain element domi will be colored colori, unless superseded by a color request by the ColorCodomain option.";

Combine::usage = "Combine is an option name for both IntegerDivisors and ZdDivisors. Its default value is False, which means the divisors are not grouped in any fashion. Other values are Products, Associates, or Negations.";

CommutativeQ::usage = "CommutativeQ[S] returns True if the structure S is commutative, and False otherwise. When S is a group, this is identical to AbelianQ[S]. When used with rings, one has the Operation option, which can take on the values Addition, Multiplication or Both. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (for indexed groups)).";

Commutator::usage = "Commutator[G, x, y] returns the commutator xyx^(-1)y^(-1) in the Groupoid G.";

Commutators::usage = "Commutators[G] returns the complete set of commutators in the Groupoid G. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (for indexed groups)).";

CommutatorSubgroup::usage = "CommutatorSubgroup[G] returns the commutator subgroup of the Groupoid G generated by the commutators of G. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (for indexed groups)).";

CommuteQ::usage = "CommuteQ[G, x, y] returns True if x and y commute as elements in G and False otherwise. Options Available: Mode (Computational, Textual, Visual, All, and Interactive).";

CommutingMatricesQ::usage = "CommutingMatricesQ[R, A, B] returns True or False depending on whether the matrices A and B commute over the Ringoid R. CommutingMatricesQ[MatricesOver[R,{n,n}], A, B] works similarly. For matrices with numeric entries (over Integers, Rationals, Reals or Complex), CommutingMatricesQ[A, B] works similarly.";

ComplementNoSort::usage = "ComplementNoSort[eall, e1, e2, ...] gives the elements in eall which are not in any of the ei. This is similar to Complement except the returned values are NOT sorted as they are with Complement.";

ComplexMatrixQ::usage = "ComplexMatrixQ[A] returns True or False depending on whether the matrix A has all of its entries being complex numbers (in the mathematical sense - entries can be Integer, Rational, Algebraic, Real, or Complex).";

ComplexToPoint::usage = "ComplexToPoint[z] returns {Re[z], Im[z]} given any complex number z.";

Computational::usage = "Computational is the default setting for the Mode option for most functions. When Mode \[Rule] Computational is set, the function returns the desired computation with no textual, visual, or interactive information given.";

ConjugacyClass::usage = "ConjugacyClass[G, h] returns the conjugacy class of the element h in G.";



Conjugate::usage = "Conjugate[G, h, x] returns the element x h x^(-1) in the Groupoid G. Additionally, Conjugate[G, H, x] returns the set x H x^(-1) for the subgroup H of the group G. \nThe standard (built-in) usage still exists: Conjugate[z] gives the complex conjugate of the complex number z. \n(Note that the Listable attribute has been turned off.)";

CosetLists::usage = "CosetLists is a value for the Form option of QuotientGroup and QuotientRing. With this option, the output is a list of the cosets in list form.";

Cosets::usage = "Cosets is a value for the Form option of QuotientGroup and QuotientRing. This causes the elements to be written as cosets of the form gNS or g + NS, where NS represents the normal subgroup (or ideal for rings).";

CosetToList::usage = "CosetToList[G, coset] returns the coset (represented as a list) in the quotient group/ring corresponding to the coset represented in the form g + NS (or g NS).";

Cycle::usage = "Cycle[e1, e2, ...] represents an object that is a cycle of a permutation. Cycle is also a value for the CycleAs option of the ToCycles and FromCycles functions.";

CycleAs::usage = "CycleAs is an option for ToCycles and FromCycles that indicates whether a cycle is given as a list or with the head Cycle. In these packages, the default value is Cycle; to conform with the DiscreteMath`Permutations` package's use, use the value List.";

Cyclic::usage = "Cyclic[n] returns the cyclic group of order n with the default generator the string 'g'. Cyclic[n, Generator \[Rule] gen] returns the same group but written with generator gen (which could be a string or a symbol with no value). Cyclic[n, k] returns the Groupoid generated by g^k. Another available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (on n)).";

CyclicGenerators::usage = "CyclicGenerators[G] returns a list of elements that are generators for the cyclic group G. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (for indexed groups)).";

CyclicGroupAA::usage = "CyclicGroupAA[n] - see Cyclic.";

CyclicQ::usage = "CyclicQ[G] returns True if the Groupoid G is cyclic, and False otherwise. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (for indexed groups)).";

CyclicSubgroups::usage = "CyclicSubgroups[G] returns the list of the cyclic subgroups of the group G. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (for indexed groups)).";

D::usage = "D[n] returns the dihedral group of index n with order 2n. See Dihedral for more information.\nThe standard (built-in) usage still exists: D[f, x] gives the partial derivative of f with respect to x. D[f, {x, n}] gives the nth partial derivative with respect to x. D[f, x1, x2, ...] gives a mixed derivative.";

DefaultOrder::usage = "DefaultOrder is a global variable that contains the order that permutations are to be multiplied. It starts out with the value RightToLeft, until changed by an option or directly.";

DefaultStructure::usage = "DefaultStructure is a global variable that has one of two values, Group or Ring. This value indicates what the default assumption is for various functions that have meanings for both groups and rings. For these functions, this default value can always be temporarily overridden by using the option Structure \[Rule] Group or Structure \[Rule] Ring. This variable can be changed manually or by using the function SwitchStructureTo.";

Degree::usage = "Degree[PolynomialsOver[R], p] determines the degree of the polynomial p when viewed as an element in the ring of polynomials over the Ringoid R. Degree[p] assumes p is defined in some ring of polynomials. \nThe standard (built-in) usage still exists: Degree gives the number of radians in one degree. It has a numerical value of Pi/180.";

Det::usage="Det[R, A] returns the determinant of the square matrix A over the Ringoid R. Det[MatricesOver[R,{n,n}],A] is equivalent to Det[R, A]. \nThe standard (built-in) usage still exists: Det[m] gives the determinant of the square matrix m.";

DetAdjoint::usage = "DetAdjoint[A] returns the adjoint of a matrix A, which is defined as (-1)^(i+j) Det[Transpose[Bij]], where Bij is the matrix Aij with the ith row and jth column removed.";

Diag::usage = "Diag[n, R] (alternately, Diag[R, n]) returns the extension of invertible n-by-n diagonal matrices over the Ringoid R.";

DiagonalMatrices::usage = "DiagonalMatrices[n, R] (alternately, DiagonalMatrices[R, n]) - see Diag.";

DiagQ::usage = "DiagQ[R, A] returns True or False depending on whether the matrix A over the Ringoid R is in Diag[R, n] (where A is an n-by-n matrix).";

Dihedral::usage = "Dihedral[n] returns the dihedral group of index n with order 2n. By default, the generators are indicated by Rot (for the smallest angle of rotation) and Ref (for any reflection). D[n, Form \[Rule] Permutations] uses the permutations corresponding to Rot and Ref; the default is Form \[Rule] RotRef. D[n, RotSym \[Rule] newsy1, RefSym \[Rule] newsy2] uses the symbols newsy1 and newsy2 for Rot and Ref respectively. Alternate names for Dihedral are D and DihedralGroupAA.";

DihedralGroupAA::usage = "DihedralGroupAA[n] - see Dihedral.";

DirectProduct::usage = "DirectProduct[S1, S2] returns the direct product of the structured sets (Groupoids or Ringoids) S1 and S2. (Any number of arguments can be used.)";

DirectSum::usage = "DirectSum[S1, S2] returns the direct sum of the structured sets (Groupoids or Ringoids) S1 and S2. (Any number of arguments can be used.)";

DisguiseGroupoid::usage = "DisguiseGroupoid[G] returns the Groupoid G with the elements of G replaced with the strings 'a', 'b', etc. The purpose is to present a generic Groupoid without any indication of the form of the elements or operation. DisguiseGroupoid[G, rules] does the same except that rules is a list of Rules which specify how the matching should occur. Adding the option Randomize \[Rule] True will randomize the original elements before the rules are assigned; the default for this option is False.";

DisguiseRingoid::usage="DisguiseRingoid[R] returns the Ringoid R with the elements of R replaced with the strings 'a', 'b', etc. The purpose is to present a generic ring without any indication of the form of the elements or operation. Adding the option Randomize \[Rule] True will randomize the original elements in the Ringoid; the default for this option is False. One can also add one's own mapping rules, as in DisguiseGroupoid.";

DisjointCyclesQ::usage = "DisjointCyclesQ[cyclist] returns True if the cycles in cyclist are disjoint, and False otherwise. The cycles in cyclist can be either in List form or using Cycle notation. Also, cyclist can be of any length and either given as a list or a sequence of cycles.";

DistributiveQ::usage = "DistributiveQ[R] returns True if the Multiplication is (two-sided) distributive over the Addition in the structure R, and False otherwise.";

DividesQ::usage = "DividesQ[r, s] returns True if the integer s divided by the integer r is an integer, and False otherwise. DividesQ[r, s, Radical \[Rule] d] works similarly in \[DoubleStruckCapitalZ][\!\(\@d\)], returning True if r | s over this ring, and False otherwise.";

DivisorsComplete::usage = "DivisorsComplete is an option for IntegerDivisors and ZdDivisors. Its default value is False. With this, only one divisor from each class of associates is given. For integers, when set to False, this returns the positive divisors. For Gaussian integers (d = -1), when set to False, this returns the Gaussian integers in the first quadrant. In all other cases, when set to False, this returns the one that is in the right half-plane (or first quadrant for those on the imaginary axis) when the number a + b \!\(\@d\) is considered the ordered pair (a, b). In contrast, with the value True, all the divisors are included.";

Domain::usage = "Domain[f] returns the structure used in the domain of the Morphoid f. Domain[S] returns the elements in the Groupoid or Ringoid S; this is equivalent to the Elements function.";

Dot::usage="Dot[R, a, b] generalizes the (scalar) dot product over a Ringoid R and computes a.b (for vectors a and b over R) using the arithmetic of R. \nThe standard (built-in) usage still exists: a.b.c or Dot[a, b, c] gives products of vectors, matrices and tensors.";

DrawNgon::usage = "DrawNgon[n] draws a regular n-gon (n > 2) with the vertices labeled with the integers 1 through n.";

e::usage="e is the symblol used by GenerateGroupoidByRelations to signify the group identity.";

EisensteinsCriterionQ::usage = "EisensteinsCriterionQ[zpoly] returns True if Eisenstein's Criterion indicates that the polynomial zpoly, with coefficients from the integers, is irreducible, and False otherwise. The Textual mode is available.";

ElementConjugate::usage = "ElementConjugate[G, h, x] returns the element x h x^(-1) in the Groupoid G.";

ElementOnLeft::usage = "See LeftMeans.";

ElementOnRight::usage = "See LeftMeans.";

ElementQ::usage = "ElementQ[x, S] yields True or False depending on whether or not x is an element of the structured set S.";

Elements::usage = "Elements[S] returns the list of elements contained in the structured set S (either a Groupoid or Ringoid). Elements[{S1,S2,..}] returns the elements in each of the structured sets.";

ElementsQ::usage = "ElementsQ[els, S] yields True or False depending on whether or not all the items in the list els are elements of the structured set S.";

ElementToCoset::usage = "ElementToCoset[Q, el], assuming Q is the quotient group G/N and el is an element in G, this returns the coset containing el.";

ElementToKey::usage = "ElementToKey[G, el] returns the key value used for el in the Key that is made when the elements in the structure S are too wide for a graphical image.";

ElementToPower::usage = "ElementToPower[G, g, n] returns the nth power (multiple, in an additive groupoid) of the element g in the structure G, where n can be any integer).";

Equal::usage = "Equal[PolynomialsOver[R], p, q] returns True or False depending on whether the polynomials p and q are equal as elements in the ring of polynomials over the Ringoid R. Equal[p, q] assumes that both p and q are well-defined in some ring of polynomials. The option IgnoreIndeterminate can be set to True (default) or False and determines whether the indeterminate used should be considered when deciding equality. \nThe standard (built-in) usage still exists: lhs == rhs returns True if lhs and rhs are identical.";

EqualGroupoidQ::usage = "EqualGroupoidQ[G1, G2] returns True if G1 and G2 can be considered equal as Groupoids, and False otherwise.";

EqualMorphoidQ::usage="EqualMorphoidQ[f, g] compares two Morphoids f and g and returns True if their functions are identical and are between identical types of structures, and False otherwise. The operations of the structures are not compared.";

ESG::usage = "ESG[code] returns the group corresponding to the one given by 'code' as used in the software package Exploring Small Groups.";

EvaluationInExtension::usage = "EvaluationInExtension[E, p, q] evaluates the polynomial p (a polynomial over the base ring of the extension E) at q, an element of that extension. Note: Both p and q should both be polynomials over the base ring with identical indeterminates.";

EvenPermutationQ::usage = "EvenPermutationQ[p] returns True if p is an even permutation, and False otherwise.";

Exponent::usage = "Exponent[PolynomialsOver[R], p] determines the degree of the polynomial p when viewed as an element in the ring of polynomials over the Ringoid R. Exponent[p] assumes p is defined in some ring of polynomials. \nThe standard (built-in) usage still exists: Exponent[expr, form] gives the maximum power with which form appears in expr. Exponent[expr, form, h] applies h to the set of exponents with which form appears in expr.";

ExtendPermutation::usage = "ExtendPermutation[p, n] takes a permutation p in S[m] (for m < n) and returns a permutation in S[n] using the components of p in the first m positions and filling out positions m+1 to n with the integers m+1 to n, so that p is naturally extended.";

ExtensionDegree::usage = "ExtensionDegree[GF[n]] gives the degree of the extension of GF[n]. In other words, when n is written as n = p^d for some prime p, d is the ExtensionDegree of GF[n].";

ExtensionType::usage = "ExtensionType[ext] returns the type of extension for this extension ring ext.";

FactorGroup::usage = "FactorGroup[G, N, opts] is equivalent to QuotientGroup[G, N, opts]; see this function for further details.";

FactorRing::usage = "FactorRing[R, S] is equivalent to QuotientRing[R, S]; see QuotientRing for details.";

Fiber::usage="Fiber[f, S] is equivalent to InverseImage[f, S].";

FieldIrreducible::usage = "FieldIrreducible[GF[n]] returns the irreducible polynomial used in  establishing the Galois field GF[n].";

FieldQ::usage = "FieldQ[R] returns True if the Ringoid R is a field, and False otherwise.";

FirstTaker::usage = "FirstTaker[n] returns the Groupoid with elements {1,2,...n} and the operation that returns the first of the two inputs.";

FixQ::usage = "FixQ[S, p, el] returns True if the permutation p (where p permutes the elements of S) fixes the element el, and False otherwise. If p is a permutation in S[n], then FixQ[p, el] is equivalent to FixQ[Range[n], p, el].";

FlexibleEntering::usage = "FlexibleEntering is an option, taking either True or False, for the Poly function, which creates polynomials. When set to True (the default value), the function call Poly[R, x^2 - 2x + 1] is treated as Poly[R, x^2 + NegationOf[R, 2]x + 1]. Additionally, if R = Z[n], then the coefficients can be any integers and are reduced mod n before processing.";

Form::usage = "Form is an option when working with the dihedral group D[n]. By default we have Form \[Rule] RotRef. Also possible is Form \[Rule] Permutations. See Dihedral for more information. Form is also an option for QuotientGroup and QuotientRing. Form \[Rule] Cosets is the default here and specifies that the elements of the quotient group (or quotient ring) should appear in coset form. Form \[Rule] Representatives causes the quotient elements to be represented by a representative from the cosets. The option Representatives can be used to specify these representatives. Form \[Rule] CosetLists is yet another option, where the cosets appear as lists of elements. Finally, Form is also an option for QuaternionGroup; see this function for more information.";

FormatElements::usage = "FormatElements is an option for functions which form Groupoids or Ringoids, whose default value is False. When set to True, whenever a structured set is displayed, {-Elements-} will be displayed instead of the actual list of elements.";

FormatFunction::usage = "FormatFunction is an option for the FormMorphoid function that indicates whether a Morphoid\[CloseCurlyQuote]s function should be displayed in an abbreviated (or formatted) form. While the default value is False, it can also be set to True.";

FormatOperator::usage = "FormatOperator is an option for functions which form Groupoids or Ringoids, whose default value is True. When set to True, whenever a structured set is displayed, -Operation- (or -Addition- and -Multiplication- for Ringoids) will be displayed instead of the actual definition of the operator(s).";

FormGroupoid::usage = "FormGroupoid[els, op, opsym, opts] is the basic command for forming a Groupoid consisting of the list els governed by the operation op. The symbol opsym defaults to * if not specified. The available options for opts are WideElements, IsAGroup, Generators, GroupoidDescription, GroupoidName, FormatOperator, FormatElements, MaxElementsToList, KeyForm, and CayleyForm. See each one for more information. \n\nThis function, rather than just wrapping Groupoid around a list and an operation, is strongly recommended.";

FormGroupoidByRelations::usage = "FormGroupoidByRelations[gens_List,rels_List] forms a Groupoid from elements in gens, reducing the products using the relations in rels.";

FormGroupoidByTable::usage = "FormGroupoidByTable[els, tab, opsym, opts] is a command for forming a Groupoid consisting of the list els and governed by the operation implicit in the Cayley table tab. The symbol opsym defaults to * unless specified. The available options for opts are WideElements, IsAGroup, Generators, GroupoidDescription, GroupoidName, FormatOperator, FormatElements, MaxElementsToList, KeyForm, and CayleyForm. See each of these individually for more information.";

FormGroupoidFromCycles::usage = "FormGroupoidFromCycles[cl, opts] forms the Groupoid of permutations whose elements are (initially) written as either cycles or products of cycles. The option opts takes on values similar to FormGroupoid, as well as the option ProductOrder (since we are working with permutations).";

FormMorphoid::usage = "FormMorphoid[f, S1, S2, (opts)] is the standard means for creating a Morphoid. Here, S1 and S2 are Groupoids or Ringoids, and f is either a list of Rules, a Function, or a Symbol. In the special case where S1 is a cyclic Groupoid, f can consist of just one rule that sets up the morphism. Additionally, if S1 consists of n elements and S2 consists of m elements, then FormMorphoid[{p1, p2, ... pn}, S1, S2] forms the Morphoid by sending the first element in S1 to the element in S2 in position p1, the second element in S1 to the element in position p2 in S2, until finally the nth element goes to the element in position pn in S2. FormMorphoidSetup may be useful in using this method. The options opts can consist of setting the Mode or the value of FormatFunction (default is False), which determines if the function should be formatted or not. Another alternative to consider is to use MorphoidSetupMenu. This function uses drop-down menus to make the function assignments. See this function for further details.";

FormMorphoidSetup::usage= "FormMorphoidSetup[S1, S2] produces a graphic that assists in the preparation of a list of positions to use in FormMorphoid. The arguments S2 and S2 must be Groupoids or Ringoids. An alternative to consider is to use MorphoidSetupMenu. This function uses drop-down menus to make the function assignments. See this function for further details.";

FormRingoid::usage = "FormRingoid[list, addition, multiplication, {plussym, multsymb}, opts] is the basic command for forming a Ringoid consisting of the list of elements found in list governed by the operations addition and multiplication. The symbol plussym defaults to + and the multsymb defaults to *, if not specified. The options for opts can be WideElements, IsARing, RingoidDescription, RingoidName, FormatOperator, FormatElements, MaxElementsToList, KeyForm, and CayleyForm. See each one for more information. Alternatively, FormRingoid[AG, MG, opts] forms the Ringoid using the Groupoid AG for the additive part and the Groupoid MG for the multiplicative part (assuming the same elements are used).\n\n This function, rather than just wrapping Ringoid around a list and the operations, is strongly recommended.";

FormRingoidByTable::usage = "FormRingoidByTable[list, additiontab, multiplicationtab, opts] is used for generating a Ringoid consisting of the elements in list and governed by the operations implicit in the Cayley tables additiontab and multiplicationtab. The options for opts can be WideElements, IsARing, RingoidDescription, RingoidName, FormatOperator, FormatElements, MaxElementsToList, KeyForm, and CayleyForm. See each of these individually for more information.";

FromCycles::usage ="FromCycles[{c1, c2,...,cn}] gives the permutation that corresponds to the product of the cycles c1, c2, ...cn, assuming that the cycles ci are disjoint. This is a modification and improvement on the function from the DiscreteMath`Permutations` package.";

Func::usage="Func is the head for a function in a FunctionsOver extension.";

FuncRing::usage="FuncRing is the first parameter for any function extension.";

FunctionForm::usage="FunctionForm is an option for InnerAutomorphism that controls whether the Morphoid is defined by Rules (default value) or by a function is to be created.";

FunctionsOver::usage="FunctionsOver[R] returns the extension of functions on the Ringoid R.";

FuncToRules::usage="FuncToRules[f, FunctionsOver[R]] converts f to a list of rules.";

GaloisFieldQ::usage = "GaloisFieldQ[R] returns True or False depending on whether the ring R is a Galois field and was created using the GF function.";

GaussianIntegerQ::usage = "GaussianIntegerQ[z] returns True if the complex number z is a Gaussian integer and false otherwise.";

GaussianIntegers::usage = "GaussianIntegers[n] returns the Ringoid of Gaussian integers mod n under ordinary complex addition and multiplication mod n. \nThe standard use of this name as an option for several built-in functions still works and is described as follows: GaussianIntegers is an option for FactorInteger, PrimeQ, Factor and related functions. With GaussianIntegers \[Rule] True, factorization is done over the Gaussian integers when possible. With GaussianIntegers \[Rule] False, factorization is done over the integers.";

GaussianIntegersAdditive::usage = "GaussianIntegersAdditive[n] returns the additive Groupoid of Gaussian integers mod n. This is equivalent to Z[n, I].";

GaussianIntegersMultiplicative::usage = "GaussianIntegersMultiplicative[n] returns the multiplicative Groupoid of Gaussian integers mod n. This is equivalent to Zx[n, I].";

GaussianUnits::usage = "GaussianUnits returns the Groupoid consisting of {1,-1, I, -I} under ordinary complex multiplication.";

GeneralLinear::usage = "GeneralLinear[args] - see GL.";

GeneralLinearGroup::usage = "GeneralLinearGroup[args] - see GL.";

GenerateGroupoid::usage = "GenerateGroupoid[gens, op, opsym, opts] is a command for generating a Groupoid by using the generators in the list gens governed by the operation op. The symbol opsym defaults to * unless specified otherwise. The options for opts can be WideElements, IsAGroup, SizeLimit, Generators, GroupoidDescription, GroupoidName, FormatOperator, FormatElements, MaxElementsToList, KeyForm, and CayleyForm. See each of these individually for more information.";

GenerateGroupoidByRelations::usage = "GenerateGroupoidByRelations[gens_List,rels_List] generates a Groupoid from elements in gens using the relations in rels to reduce products. Relations take the form of Mathematica equations, with == separating the two sides. The option SizeLimit may be used to control the maximum number of elements generated.";

GenerateGroupoidByStages::usage = "GenerateGroupoidByStages is a utility function for GenerateGroupoidByRelations.";

GeneratingSet::usage = "GeneratingSet[G] gives a set of generators for determining G. If $Failed is returned, this indicates that a generating set is not yet known to Mathematica. The option Generators for FormGroupooid is used to specify a generating set, as is the first argument for GenerateGroupoid.";

Generator::usage = "Generator is an option for the Cyclic function, specifying which symbol should be used for the generator of the group.";

Generators::usage = "Generators is an option for functions which form Groupoids, whose default value is {}. Specifying Generators \[Rule] {g1,g2,...} indicates that these generators are known to generate this Groupoid.";

GF::usage = "GF[n] returns the Galois field of order n (if n = p^d for some prime p and positive integer d), while GF[p, d] returns the field of order p^d (where p is the prime modulus and d is the degree of a irreducible polynomial to create the field). The field takes the form of a quotient ring of polynomials over Z[p] mod the ideal generated by the irreducible polynomial, and consequently consisting of polynomials of degree less than d. GF[n, poly] or GF[p, d, poly] returns the finite field using the specified irreducible polynomial. The option Indeterminate can be used to specify the symbol to be used for the indeterminate.";

GL::usage = "GL[n, R] (alternately, GL[R, n]) returns the extension of invertible n-by-n matrices over the Ringoid R. For a positive integer k, GL[n,k] is equivalent to GL[n,Z[k]].";

GLQ::usage = "GLQ[R, A] returns True or False depending on whether the matrix A over the Ringoid R is in GL[R, n] (where A is an n-by-n matrix).";

Graphics::usage = "Obsolete with version 6 onwards, Graphics is a value for the Output option that can be used when a function uses the Visual Mode. Adding the option Output \[Rule] Graphics will cause the graphics of the Visual mode to be the output (given as -Graphics-). This is a method of capturing the graphics involved in a computation instead of the actual computation. (Using GraphicsArray instead of Graphics works similarly when the output is going to be a series of graphics. These are then put into an array of graphics.) \nThe standard (built-in) definition still exists: Graphics[primitives, options] represents a two-dimensional graphical image.";

Group::usage = "Group is a value for the Structure option that is used for the functions FormMorphoid, ZMap, and Z (including Z[n] and Z[n, I]). It is also the argument for the SwitchStructureTo function when switching from rings to groups.";

GroupCenter::usage = "GroupCenter[G] returns the center of the group G. This is identical to Center.";

GroupExponent::usage = "GroupExponent[G] returns the smallest positive integer n such that g^n is the identity for all elements g in the Groupoid G. Available option: Mode (possible values: Computational, Textual, Visual, and All).";

GroupIdentity::usage = "GroupIdentity[G] returns the (two-sided) identity of the Groupoid G, if it exists. If there is no identity, a message indicates this and $Failed is returned. HasIdentityQ[G] is similar, except it only returns True or False regarding the existence of an identity. Available option: Mode (possible values: Computational, Textual, Visual, and All).";

GroupInfo::usage = "GroupInfo[G] returns a list of information obtained about the Groupoid G that has been gathered thus far by calling various functions.";

GroupInverse::usage = "GroupInverse[G, g] returns the inverse of g in G, if it exists, and $Failed otherwise. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (on group elements)).";

Groupoid::usage = "Groupoid is the head for an ordered pair where the first component is a set of elements and the second is an operation. A Groupoid is one of the basic structures of these packages.";

GroupoidDescription::usage = "GroupoidDescription[G] yields a description, if available, of the Groupoid G. This can be set with the option GroupoidDescription when using the functions FormGroupoid or GenerateGroupoid. If the empty string is returned (default value), no description has been given.";

GroupoidName::usage = "GroupoidName[G] yields the name, if given, of the group G. This can be set with the option GroupoidName in FormGroupoid and GenerateGroupoid. If the empty string or TheGroup (default) is returned, no name has yet been given.";

GroupQ::usage = "GroupQ[G] returns True if G is a group, and False otherwise. Available option: Mode (possible values: Computational, Textual, Visual, and All).";

Groups::usage = "Groups is an acceptable argument for the SwitchStructureTo function.";

HasIdentityQ::usage = "HasIdentityQ[S] returns True or False depending on whether or not the (two-sided) identity (or identities for rings) of the structure S exists. When used with rings, the Operation option can be used, which can have the value Addition, Multiplication or Both. If S is a group, GroupIdentity[S] returns the identity, if one exists, while for rings, Zero[S] and Unity[S] return the additive and multiplicative identities, if they exist. Available option: Mode (possible values: Computational, Textual, Visual, and All).";

HasInversesQ::usage = "HasInversesQ[G] returns True or False depending on whether all the elements in G have inverses or not. When used with rings,  the Operation option can be used, which can have the value Addition, Multiplication or Both. Available option: Mode (possible values: Computational, Textual, Visual1, Visual2, and All).";

HasLeftIdentityQ::usage = "HasLeftIdentityQ[G] returns True or False depending on whether the Groupoid G has a left identity or not. If one exists, LeftIdentity[G] returns its value.";

HasNegativeQ::usage = "HasNegativeQ[R, r] returns True if r has a negative in the structure R, and False otherwise.";

HasRightIdentityQ::usage = "HasRightIdentityQ[G] returns True or False depending on whether the Groupoid G has a right identity or not. If one exists, RightIdentity[G] returns its value.";

HasUnityQ::usage = "HasUnityQ[R] returns True if the structure R has a unity, and False otherwise.";

HasZeroQ::usage = "HasZeroQ[R] returns True if the structure R has a zero, and False otherwise.";

HeadingsColored::usage = "HeadingsColored is an option for CayleyTable. Setting it to True or False determines whether the top row and left column are colored according to the default coloring of the elements residing in these positions.";

headingsGrid::usage "headingsGrid[data,headings,loc] returns a Grid with the data and with the headings on either Top or Left for a location. ";

HermitianQ::usage = "HermitianQ[A] returns True or False depending on whether the matrix A is Hermitian (i.e., A = Adjoint[A]).";

HomomorphismQ::usage = "HomomorphismQ[f] returns True if the Morphoid f is a homomorphism, and False otherwise. This is equivalent to MorphismQ. Available option: Mode (possible values: Computational, Textual, Visual, and All).";

IdealQ::usage = "IdealQ[S, R] returns True if the set S is an ideal of the structure R, and False otherwise.";

IdempotentQ::usage = "IdempotentQ[R, r] returns True if r is an idempotent in the structure R, and False otherwise.";

Idempotents::usage = "Idempotents[R] returns all the idempotent elements in the structure R.";

Identity::usage = "Identity[G] returns the (two-sided) identity of the structure G, if it exists. If there is no identity, a message indicates this. For groups, this is identical in functionality to GroupIdentity[G]. HasIdentityQ[G] is similar, except it only returns True or False regarding the existence. When used with rings, the Operation option can be used, which can have the value Addition, Multiplication or Both. This use is equivalent to RingIdentity. Available option: Mode (possible values: Computational, Textual, Visual, and All). \nThe standard (built-in) usage still exists: Identity[expr] gives expr (the identity operation).";

IgnoreIndeterminate::usage = "IgnoreIndeterminate is an option for the Equal command that is used when determining when two polynomials are equal. The default value for this option is True, which means that 4x^2 + 3x + 1 and 4y^2 + 3y + 1 are considered equal as polynomials. One can optionally set this to False.";

MorphoidImage::usage = "MorphoidImage[f] returns a Groupoid or Ringoid (as appropriate) consisting of the image values of the Morphoid f. Additionally, MorphoidImage[f, S] returns the images of the substructure S of the domain of f. Available option: Mode (possible values: Computational, Textual, Visual, and All). Formerly, this function was just called Image.";

Indeterminate::usage = "Indeterminate is an option for the Poly function (that creates polynomials). The default value is 'x', though one can specify any other symbol as the indeterminate to be used in a polynomial. \nThe standard (built-in) usage still exists: Indeterminate is a symbol that represents a numerical quantity whose magnitude cannot be determined.";

Index::usage = "Index[G, H] returns the index of the subgroup H in the group G. Available option: Mode (possible values: Computational, Textual, Visual, and All).";

IndexLimit::usage = "IndexLimit is an option for some groups to enable one to obtain larger groups (whose index is more than the default limit on the index). Examples where this is used is with the Symmetric and Alternating groups with the default value of 6.";

InducedCanonical::usage = "InducedCanonical[f], given a Morphoid f: G \[Rule] H, returns the Morphoid g : G \[Rule] G/Ker[f].";

InducedIsomorphism::usage = "InducedIsomorphism[f], given a Morphoid f: G \[Rule] H, returns the Morphoid g : G/Kernel[f] \[Rule] Image[H].";

InjectiveQ::usage="InjectiveQ[f] returns True if the Morphoid f is injective (one-to-one), and False otherwise.";

Inn::usage = "Inn[G] is identical to InnerAutomorphismGroup[G].";

InnerAutomorphism::usage = "InnerAutomorphism[G, g], when given an element g in the group G, returns the inner automorphism of G induced by g.";

InnerAutomorphismGroup::usage="InnerAutomorphismGroup[G] returns the group of inner automorphisms of G, if G is a group.";

IntegerDivisors::usage = "IntegerDivisors[n, opts] returns the divisors of the integer n, just as the built-in function Divisors[n] does. The options are Combine, NonTrivialOnly and DivisorsComplete. See these for more details.";

IntegerLatticeGrid::usage = "IntegerLatticeGrid[{a, b}, {c, d}, opts] returns a ListPlot of an integer lattice with domain [a,b] and range [c,d]. Any opts given are used by ListPlot.";

IntegerMatrixQ::usage = "IntegerMatrixQ[A] returns True or False depending on whether the matrix A has all of its entries being integers.";

IntegerUnits::usage = "IntegerUnits returns the Groupoid consisting of {1, -1} under ordinary multiplication.";

IntegralDomainQ::usage = "IntegralDomainQ[R] returns True if the structure R is an integral domain, and False otherwise.";

InterpolatingPolynomial::usage = "InterpolatingPolynomial[R,{{x,y},...}] returns the interpolating polynomial of degree at most n-1 where n is the number of pairs in {{x,y},...}. The x coordinates must all be distinct and R should be a field, for example Z[p] for prime p.\nThe standard (built-in) usage still exists: InterpolatingPolynomial[data, var] gives a polynomial in the variable var which provides an exact fit to a list of data. The data can have the forms {{x1, f1}, {x2, f2}, ...} or {f1, f2, ...}, where in the second case, the xi are taken to have values 1, 2, .... The fi can be replaced by {fi, dfi, ddfi, ...}, specifying derivatives at the points xi.";

Inverse::usage = "Inverse[G, g] returns the inverse of g in G, if it exists, otherwise $Failed. When used with rings,  the Operation option can be used, which can have the value Addition, Multiplication or Both. \nThe standard (built-in) usage still exists: Inverse[m] gives the inverse of a square matrix m. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (on group elements)).";

InverseImage::usage="InverseImage[f, S] returns the elements of the domain of the Morphoid f that map into elements of the list or element S (from the codomain). There is a Visual mode for this function.";

InverseImages::usage = "InverseImages[f] returns the set of inverse images. This is partially equivalent to InverseImage[f, Elements[Codomain[f]]] except the latter returns a single (unsorted) list of the inverse images while this function partitions them according to the elements in Codomain[f]. The option WithImages (defaulting to False) indicates whether the image elements should be included in the output. There is a Visual mode for this function.";

Inverses::usage = "Inverses[G] returns a list of ordered pairs of the form {g, h}. If g has an inverse in G, then h is that element; otherwise h is 'no inverse'. When used with rings,  the Operation option can be used, which can have the value Addition, Multiplication or Both. Available option: Mode (possible values: Computational, Textual, Visual1, Visual2, and All).";

InvertibleQ::usage = "InvertibleQ[S, g] returns True if the (two-sided) inverse of g in the structure S exists, and False otherwise. When used with rings,  the Operation option can be used, which can have the value Addition, Multiplication or Both. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (on group elements)).";

IrreduciblePolynomial::usage = "IrreduciblePolynomial[ind, p, d] finds an irreducible polynomial in the indeterminate ind of degree d over the integers mod p (where p is prime). The code for this comes from the Mathematica package Algebra`FiniteFields`.";

IrreduciblePolyOverZpQ::usage = "IrreduciblePolyOverZpQ[poly, p] returns True or False depending on whether the polynomial poly is irreducible over the ring Z[p]. Note that poly can be a standard Mathematica polynomial in some indeterminate or it can be constructed from the Poly function in the RingExtensions package.";

IsAGroup::usage = "IsAGroup is an option for functions which form Groupoids, whose default value is False. When set to True, the Groupoid constructed will be assumed to be known as a group.";

IsARing::usage = "IsARing is an option for functions which form Ringoids, whose default value is False. When set to True, the Ringoid constructed will be assumed to be known to be a ring.";



IsomorphismQ::usage = "IsomorphismQ[f] returns True if the Morphoid f is an isomorphism (group or ring, as appropriate), and False otherwise. The option Cautious (defaulting to False) indicates whether MorphismQ (if True) or ProbableMorphismQ (if False) should be used for the testing.";

J::usage = "J is the symbol to represent an ideal in the quotient ring Z[I]/<z> for a Gaussian integer z.";

JoinDivisors::usage = "JoinDivisors[n] returns the Groupoid consisting of the divisors of n with operation LCM.";



Kernel::usage = "Kernel[f] returns the kernel of the Morphoid f, if the codomain has an identity element. It is not necessary that f satisfies MorphismQ. The object returned is a Groupoid or Ringoid (as appropriate). Available option: Mode (possible values: Computational, Textual, Visual, and All).";

KeyForm::usage = "KeyForm is an option for CayleyTable (and functions that form Groupoids or Ringoids) to indicate whether the elements in the Key of the Cayley table should be displayed in InputForm, OutputForm or some other form. The default value is InputForm.";

KeyToElement::usage = "KeyToElement[S, key] returns the element corresponding to the value key found in the Key, when the elements in the structure S are too wide for a graphical image.";

Klein4::usage = "Klein4 returns the Klein-4 group (Viergruppe).";

KSubsets::usage = "KSubsets[L, k] returns all subsets of set L containing exactly k elements, ordered lexicographically. (From DiscreteMath`Combinatorica`.)";

LatticeRing::usage = "LatticeRing[n] returns the Ringoid of divisors of n with LCM/GCD for the addition and GCD for the multiplication.";

LeftCoset::usage = "LeftCoset[G, H, g] returns the left coset gH (or g + H) when given the element g from G and the subgroup H of G. G is assumed to be either a Groupoid or Ringoid (for which H needs to be a subring). Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (on group elements)).";

LeftCosets::usage = "LeftCosets[G, H] returns the set of cosets of the subgroup (or subring) H in the Groupoid (or Ringoid) G. Available option: Mode (possible values: Computational, Textual, Visual, and All).";

LeftDistributiveQ::usage = "LeftDistributiveQ[ R] returns True if the Multiplication is left distributive over the Addition in the structure R, and False otherwise.";

LeftIdealQ::usage = "LeftIdealQ[S, R] returns True if the set S is a left ideal of the structure R, and False otherwise.";

LeftIdentity::usage = "LeftIdentity[G] returns the left identity of the Groupoid G, if one exists, or $Failed otherwise.";

LeftInverse::usage = "LeftInverse[G, g] returns the left inverse of g in G, if it exists, otherwise $Failed.";

LeftInvertibleQ::usage = "LeftInvertibleQ[G, g] returns True if the left inverse of g in G exists, and False otherwise.";

LeftMeans::usage = "LeftMeans is an option for some coset functions. It is included to handle different interpretations of what is meant by a left coset versus a right coset. The two values that can be used are ElementOnRight and ElementOnLeft.";

LeftToRight::usage = "LeftToRight is a value for the ProductOrder option of MultiplyPermutations and MultiplyCycles, as well for the PowersIncrease option for Poly (when working with polynomials over a ring). When ProductOrder is set to this value, then MultiplyPermutations[p1,p2] will be computed by taking p1 followed by p2. For the use in Poly, see PowersIncrease.";

LowerDegreeOK::usage = "LowerDegreeOK is an option for RandomElement[RingExtension[PolyRing,...]] that controls whether random polynomials MUST have the specified degree (using the value False, the default value) or may have a degree less than or equal to the specified degree (using the value True).";

LT::usage = "LT[n, R] (alternately, LT[R, n]) returns the extension of n-by-n lower triangular matrices (fully below the diagonal) over the Ringoid R.";

LTD::usage = "LTD[n, R] (alternately, LTD[R, n]) returns the extension of n-by-n lower triangular matrices (including the diagonal) over the Ringoid R.";

Mat::usage = "Mat[R,n] (alternatively, Mat[n, R]) returns the extension ring of n-by-n matrices over the Ringoid R. Mat[R, {m,n}] (or Mat[{m,n},R]) returns the extension ring of m-by-n matrices over R.";

MatA::usage = "MatA[R,{m,n}] (alternatively, MatA[{m,n}, R]) returns the extension of m-by-n matrices over the Ringoid R with the operation being addition of matrices.";

MatM::usage = "MatM[R,n] (alternatively, MatM[n, R]) returns the extension of n-by-n matrices over the Ringoid R with the operation being multiplication of matrices.";

Matrices::usage = "Matrices is a possible type of RingExtension.";

MatricesOver::usage="MatricesOver[R,{m,n}] generates the ring extension of m-by-n matrices over R. MatricesOver[R,n] is equivalent to MatricesOver[R,{n,n}].";

MatrixConjugate::usage = "MatrixConjugate[A], where A is a matrix, returns the matrix with all of the entries being the complex conjugate of those that occur in A.";

MatrixDelete::usage = "MatrixDelete[A, {i, j}] returns the matrix remaining when the ith row and jth column of the matrix A are removed.";

MatrixOperation::usage = "MatrixOperation[MatricesOver[R, {m,n}]] returns the operation inherent in the matrix extension. Values are the same as for Operation (Both, Addition, or Multiplication).";

MatrixOverQ::usage = "MatrixOverQ[R, A] returns True or False depending on whether the elements of the matrix A come from the Ringoid R.";

MatrixPower::usage = "MatrixPower[MatricesOver[R, {n,n}], A, k] returns the kth power of the matrix A, as an element of the n-by-n matrices over the Ringoid R. MatrixPower[R, A, k] works similarly. \nThe standard (built-in) usage still exists: MatrixPower[mat, n] gives the nth matrix power of mat.";

MatrixTrace::usage = "MatrixTrace[R, A] returns the trace of the square matrix A. MatrixTrace[MatricesOver[R,{n,n}], A] works similarly. For matrices with numeric entries (over Integers, Rationals, Reals or Complex), MatrixTrace[A] works similarly.";

MatrixType::usage = "MatrixType is the name of an option for working with matrix extension rings. It can have the value GL, SL, Diag, UT, LT, UTD, or LTD (and defaults to All).";

MaxElementsToList::usage = "MaxElementsToList is an option for functions which form Groupoids or Ringoids, whose default value is 50. This means that if a structured set has more than 50 elements, it will default to showing simply {-Elements-} instead of the actual list. Some groups/rings may have lower values.";

MaximalIdealQ::usage = "MaximalIdealQ[S, R] returns if the set S is a maximal ideal in the structure R, and False otherwise.";

MaxTaker::usage = "MaxTaker[n] returns the Groupoid with elements {1,2,...n} and the operation that returns the maximum of the two inputs. MaxTaker[m, n] is similar but the elements range over [m, n].";

MeetDivisors::usage = "MeetDivisors[n] returns the Groupoid consisting of the divisors of n with operation GCD.";

MGroupoid::usage = "MGroupoid[R] returns the multiplicative Groupoid associated with the Ringoid R. This is equivalent to MultiplicativeGroupoid[R].";

MinTaker::usage = "MinTaker[n] returns the Groupoid with elements {1,2,...n} and the operation that returns the minimum of the two inputs. MinTaker[m, n] is similar but the elements range over [m, n].";

MixedDivisors::usage = "MixedDivisors[n] returns the Groupoid consisting of the divisors of n with operation LCM/GCD.";

Mode::usage = "Mode is an option for many of the functions in these packages. Standard modes are Computational, Textual and Visual, and sometimes Visual2. Additionally, there is often All and Interactive. See each of these individually for more information. \nThe standard (built-in) definition still exists: Mode is an option to Solve and related functions that specifies in what sense the equations are to be solved. The possible settings for Mode are Generic, Modular, and Rational.";

ModpIrreducibilityQ::usage = "ModpIrreducibilityQ[zpoly] returns True if the Mod p Irreducibility Test indicates that the polynomial zpoly, with coefficients from the integers, is irreducible, and False otherwise. (This method tries the first 25 primes.) The Textual mode is available. ModpIrreducibilityQ[p, zpoly] tests the polynomial zpoly specifically with the prime p.";

ModulusPolynomial::usage="ModulusPolynomial[Q] is the polynomial from which a quotient ring Q has been created.";

Monic::usage = "Monic is an option to RandomElement for Polynomial Rings. When set to True, the random polynomial is to be monic, having the unit for the leading coefficient, while False does not impose this restriction.";

MonoidQ::usage = "MonoidQ[G] returns True if G is a monoid (the set is closed under a binary operation that is associative with an identity), and False otherwise.";

Monomial::usage="Monomial[R, c, n] returns the monomial c x^n in the ring extension PolynomialsOver[R]; Monomial[PolynomialsOver[R], c, n] returns the same.";

MorphismQ::usage = "MorphismQ[f] returns True if the Morphoid f is a homomorphism, and False otherwise. This function automatically checks to see if f represents a group homomorphism or a ring homomorphism according to whether the structures involved are groups or rings. The Visual mode can be used with this function. MorphismQ[f, {S1, op1}, {S2, op2}] or MorphismQ[f, {S1, op1, op3}, {S2, op2, op4}] are alternative usages, where f is either a list of Rules, a Function or a Symbol. Available option: Mode (possible values: Computational, Textual, Visual, and All).";

Morphoid::usage = "Morphoid is the data structure for possible morphisms. This is the head of the object returned by FormMorphoid when one creates a morphism. This is one of the basic structures in these packages.";

MorphoidComposition::usage="MorphoidComposition[g, f] forms the composition of f and g if the codomain of f and the domain of g are the same structured system. Note: This function creates a Morphoid with function g[f[#]]& and then converts it to rules.";

MorphoidFunction::usage = "MorphoidFunction[f] returns the function defining the Morphoid f.";

MorphoidRules::usage = "MorphoidRules[f] returns the list of rules defining the Morphoid f.";

MultipleOfElement::usage = "MultipleOfElement[R, r, n] returns the nth multiple of the element r in the structure R. In other words, r + r + ... + r (n times) is returned. This is the additive version of ElementToPower.";

Multiplication::usage = "Multiplication[R] is the multiplication in the Ringoid R. Given an extension Ext of a ring, Multiplication[Ext] is the multiplication in this extension. Multiplication is also a value for the Operation option that is used in some ring functions.";

MultiplicationTable::usage = "MultiplicationTable[R] returns the multiplication table of the Ringoid R. MultiplicationTable[R, Mode \[Rule] Visual] returns a graphical view of this table.";

MultiplicativeGroupoid::usage = "MultiplicativeGroupoid[R] returns the multiplicative Groupoid of the ring R. A shortcut is MGroupoid[R].";

MultiplicativeInverse::usage = "MultiplicativeInverse[R, a] returns the multiplicative inverse of a in the structure R, if it exists, and $Failed otherwise.";

MultiplicativeToAdditive::usage = "MultiplicativeToAdditive[R, mult] returns the additive form of the element mult, currently in multiplicative form, from the ringoid (typically a Galois field) R.";

MultiplyCycles::usage = "MultiplyCycles[c2, c1, n] views both cycles c1 and c2 as in S[n] and determines the permutation representing their product. Note that the order of the multiplication is from right to left (unless specified otherwise by ProductOrder). MultiplyCycles[c2, c1] does the same but determines the value for n by the equation n = Max[Join[c1, c2]]. MultiplyCycles[c3, c2, c1] starts from the right and multiplies the cycles as it moves left through c2 and c3. MultiplyCycles[cyclelist] or MultiplyCycles[{cyclelist}] will work on any length of list of cycles and finds the product, working from right to left if the option ProductOrder is set to RightToLeft, or from left to right if set to LeftToRight. See ProductOrder for details on its values.";

MultiplyPermutations::usage = "MultiplyPermutations[perm2, perm1], by default, computes the product of perm1 followed by perm2 (right to left). The option ProductOrder is by default set to RightToLeft, but can also be set to LeftToRight. Note that the permutations can be expressed as rules (eg., {1\[Rule]3, 2\[Rule]2,3\[Rule]1}), or lists (eg., {3,2,1}) or mixed, though the output will always be a list.";

MyOrdering::usage = "MyOrdering[list] gives the permutation that puts the elements in list in (a canonical) order. If list is a permutation, this is equivalent to PermutationInverse. (This is from the DiscreteMath`Permutations` package.)";

NegationOf::usage = "NegationOf[R, r] returns the additive inverse of r in the structure R, if it exists, and $Failed otherwise.";

Negations::usage = "Negations is a value for the Combine option of IntegerDivisors and ZdDivisors. With this value, the divisors of n are grouped in pairs {a, b} such that a and b are negations.";

NextStage::usage = "NextStage[func] returns the next stage of an animation for the function func when Mode is set to Visual. NextStage[func, k] indicates that k steps forward should be taken (or backwards, if negative). The functions supporting this include Closure, SubgroupClosure, and QuotientRing in some cases. As of version 6, this has been mostly superceded by the use of Interactive in each function.";

NilpotentDegree::usage = "NilpotentDeg ree[R, r] returns 0 if the element r is NOT nilpotent in the structure R; otherwise a positive integer n is returned, which is the least positive integer such that r^n is the zero element.";

NilpotentQ::usage = "NilpotentQ[R, r] returns True if r is a nilpotent element in the structure R, and False otherwise.";

Nilpotents::usage = "Nilpotents[R] returns all the nilpotent elements in the structure R.";

NonAssociatingTriples::usage = "NonAssociatingTriples[G] returns the triples of elements {a, b, c} in the Groupoid G that do not associate.";

NonCommutingPairs::usage = "NonCommutingPairs[G] returns the pairs of elements in the Groupoid G that do not commute.";

NonIdentity::usage = "NonIdentity is a value for the SelectFrom option for RandomElement and RandomElements. This allows any element to be returned except the identity element, if it exists. Alternatively, one may use the value Any. Note: for rings, this option excludes both the zero and unity (if they exist) and other related options are NonUnity and NonZero.";

NonTrivialOnly::usage = "NonTrivialOnly is an option name for both IntegerDivisors and ZdDivisors. Its default value is False, which means that trivial divisors (\[PlusMinus] 1 and \[PlusMinus] n) are included, but excluded if set to True.";

NonUnity::usage = "NonUnity is value for the SelectFrom option for the RandomElement function, which when having the value True specifies that the chosen element should not be the unity.";

NonZero::usage = "NonZero is value for the SelectFrom option for the RandomElement function, which when having the value True specifies that the chosen element should not be the zero.";

NonZeroMGroupoid::usage = "NonZeroMGroupoid[R] returns the Groupoid of nonzero elements of R with the Multiplication from R. If R is a field, this is the group of units.";

Normalize::usage = "Normalize is an option for ToCycles and FromCycles that indicates whether a list of cycles in Cycle notation (this assumes that we have CycleAs \[Rule] Cycle as an option) is normalized. If the list consists only of cycles of length 1, it drops all of them except the one with maximal value; otherwise, all cycles of length one are dropped (unless needed to show the length of the permutation), the remaining cycles are normalized by rotating until the smallest entry occurs first, and then the list of cycles is sorted from shortest to longest.";

Normalizer::usage = "Normalizer[G, H] returns the normalizer of the subgroup H in G.";

NormalQ::usage = "NormalQ[H, G] returns True if H is a normal subgroup of G, and False otherwise.";

NS::usage = "NS is a symbol for Input and Output to represent whatever Normal Subgroup is in use at the time.";

OddPermutationQ::usage = "OddPermutationQ[p] returns True if p is an odd permutation, and False otherwise.";

OneToOneQ::usage="OneToOneQ[f] is equivalent to InjectiveQ[f].";

OntoQ::usage = "OntoQ[f] is equivalent to SurjectiveQ[f].";

Operation::usage = "Operation[G] returns the operation used in the Groupoid G. Operation is also an option for various functions when working with rings; possible settings are Addition, Multiplication, and Both.";

OperatorSymbol::usage = "OperatorSymbol[G] returns the symbol used for the operation in the Groupoid G. FormGroupoid and GenerateGroupoid set this to be * by default.";

Orbit::usage = "Orbit[G, S, x] is the orbit of x (from S) under G. Here, G is a group of permutations of the set S. Orbit[S, x] assumes G is the full set of all permutations of S.";

Order::usage = "Order[G] returns the cardinality of the set of elements in the group G. This is identical to the function Size. Order[G, g] gives the order of the element g in G. This is identical to the function OrderOfElement. \nThe standard (built-in) definition still exists: Order[expr1, expr2] gives 1 if expr1 is before expr2 in canonical order, and -1 if expr1 is after expr2 in canonical order. It gives 0 if expr1 is identical to expr2.";

OrderOfAllElements::usage = "OrderOfAllElements[G] returns a list of the orders of each element in the Groupoid G in the form {element, order}. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (for indexed groups)).";



OrderOfElement::usage = "OrderOfElement[G, g] returns the order of the element g in the Groupoid G. OrderOfElement[G,{g1,g2,..}] returns the orders of g1, g2, and so on if they are elements of G. Alternatively, OrderOfElement[{{G1,g1}, {G2, g2},..}] returns the orders of g1 in G1, g2 in G2 and so on. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (on group elements)).";



Orders::usage = "Orders[G] returns a list of the orders of each element in the Groupoid G in the form {element, order}. Orders[G, list] works similarly, where list is a list of elements from the Groupoid G. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (for indexed groups)).";

OrthogonalQ::usage = "OrthogonalQ[R, A] returns True or False depending on whether the matrix A over the Ringoid R is an orthogonal matrix (i.e., the product of the transpose of A and A itself is the identity matrix). For matrices with real entries, OrthogonalQ[A] works similarly.";

OtherColors::usage = "OtherColors is a global constant consisting of a list of colors from the Graphics`Colors` package that are used for colors in functions other than CayleyTable. Although the colors are given in RGBColor format, the default list for this variable uses the following names of colors:\n {Yellow, Red, Brown, Blue, Mint, Cyan}. See PrintingOtherColors for a suggested list to replace these when printing to paper with black and white.";

Output::usage = "Obsolete with version 6 and onwards, Output is an option that can be used when a Visual mode is used and determines the form of the output. By default, the value of the option is Computational, which means that the output is the normal computation. Alternatively, using Output \[Rule] Graphics will cause the graphics of the Visual mode to be the output (given as -Graphics-). This is a method of capturing the graphics involved in a computation instead of the actual computation. Additionally, in a few cases were a series of graphics are produced, the value GraphicsArray option can be used.";

Parity::usage = "Parity[perm] returns 1 if the permutation perm is an even permutation and -1 if odd.";

Partition::usage = "Partition is an option for Cartesian Product. By default, it is set to False. When set to True, the list is partitioned according to the size of the second (last) list. \nThe standard (built-in) definition still exists: Partition[list, n] partitions list into non-overlapping sublists of length n. Partition[list, n, d] generates sublists with offset d. Partition[list, {n1, n2, ...}, {d1, d2, ...}] partitions successive levels in list into length ni sublists with offsets di.";

PermutationComposition::usage = "PermutationComposition[p2, p1] returns the product of permutation p1 followed by permutation p2.";

PermutationGroupAA::usage = "PermutationGroupAA[list] returns the permutation group on the elements in list. It is assumed that the length of list is less than 7. PermutationGroupAA[n] acts just as Symmetric[n].";

PermutationImage::usage = "PermutationImage[S, p, el] returns the image of the element el under the action of the permutation p, where p permutes the elements of S. If p is a permutation in S[n], then PermutationImage[p, el] is equivalent to PermutationImage[Range[n], p, el].";

PermutationInverse::usage = "PermutationInverse[perm] gives the permutation that is the inverse of perm";

PermutationMatrix::usage = "PermutationMatrix[p] shows a permutation in matrix form, where the top row consists of 1, 2, ... Length[p] and the bottom row consists of the corresponding images.";

PermutationQ::usage = "PermutationQ[e] yields True if e is a list representing a permutation. (This is a modified version of that found in the DiscreteMath`Permutations` package.)";

Permutations::usage = "Permutations is a value for the Form option when working with the dihedral group. See Dihedral for more information. \nThe standard (built-in) definition still works: Permutations[list] generates a list of all possible permutations of the elements in list.";



Permutations::usage = "Permutations is a value for the Form option when working with the dihedral group. See Dihedral for more information.\nThe standard (built-in) definition still works: Permutations[list] generates a list of all possible permutations of the elements in list.";

PermutationToPower::usage = "PermutationToPower[perm, n] returns the nth power of the permutation perm, where n is any integer. (If n < 0, this returns the nth power of the inverse of perm.)";

PermuteColoredSquares::usage = "PermuteColoredSquares[p] will show a row of randomly colored squares (as in RandomColoredSquares) and below this a row of squares obtained by permuting the first list using the permutation given by p. This function only works after RandomColoredSquares has been called. See ShowColoredPermutation also.";

PlusSymbol::usage = "PlusSymbol is an option for FormRingoid to specify the symbol used for addition in forming a Ringoid. The default is PlusSymbol \[Rule] +.";

Poly::usage = "Poly[R, expr, opts] creates the polynomial over the Ringoid R given by expr and using the options given by opts. A polynomial such as 2 + 3x + x^3 (over some ring R) can be constructed by Poly[R, 2 + 3x + x^3], which, by default, would return 2 + 3x + x^3. The form x^3 + 3x + 2 could be returned by entering Poly[R, 2 + 3x + x^3, PowersIncrease \[Rule] RightToLeft], or by changing this option globally. One can also specify a polynomial by just using the coefficients. Thus, Poly[R, 1, 0, 3, 2] returns 1 + 3x^2 + 2x^3, while Poly[R, 1, 0, 3, 2, PowersIncrease \[Rule] RightToLeft] returns x^3 + 3x + 2. When entering just the coefficients, the default indeterminate is 'x', but this can be changed by using the option Indeterminate \[Rule] var, where var is any (undefined) symbol. FlexibleEntering, an option taking either True or False (defaulting to True), can be used if one wishes to enter polynomials allowing subtraction of terms or allowing entering the negation of an element by using -r. It also allows all coefficients of the polynomial to be reduced mod n if the base ring is Z[n]. If RP is a ring of polynomials, Poly[RP, expr, opts] works in a similar fashion.";

PolynomialDivision::usage="PolynomialDivision[PolynomialsOver[R], a, b], for polynomials a and b in the ring of polynomials over R, returns the pair of polynomials {q, r} where a = b q + r with r = 0 or deg r < deg b, provided that the leading coefficient of b is a unit in R. PolynomialDivision[a, b] works similarly as long as polynomials a and b are both from the same ring of polynomials. \nThe standard (built-in) usage still exists: PolynomialDivision[p, q, x] gives a list of the quotient and remainder obtained by division of the polynomials p and q in x.";

PolynomialEvaluation::usage = "PolynomialEvaluation[PolynomialsOver[R], p, alpha] evaluates the polynomial p at alpha using the operations of the Ringoid R. PolynomialEvaluation[p, alpha] works similarly.";

PolynomialGCD::usage = "PolynomialGCD[PolynomialsOver[R], p, q] returns the greatest common divisor of the polynomials p and q (as elements of the ring of polynomials over R). PolynomialGCD[p, q] works similarly as long as polynomials p and q are both from the same ring of polynomials. \nThe standard (built-in) usage still exists: PolynomialGCD[poly1, poly2, ...] gives the greatest common divisor of the polynomials poly1, poly2, ... . PolynomialGCD[poly1, poly2, ..., Modulus\[Rule]p] gives the GCD modulo the prime p.";

PolynomialLCM::usage = "PolynomialLCM[PolynomialsOver[R], p, q] returns the least common multiple of the polynomials p and q (as elements of the ring of polynomials over R). PolynomialLCM[p, q] works similarly as long as polynomials p and q are both from the same ring of polynomials. \nThe standard (built-in) usage still exists: PolynomialLCM[poly1, poly2, ...] gives the least common multiple of the polynomials poly1, poly2, ... . PolynomialLCM[poly1, poly2, ..., Modulus\[Rule]p] gives the LCM modulo the prime p.";

PolynomialQuotient::usage = "PolynomialQuotient[PolynomialsOver[R], p, q] returns the quotient when the polynomial p is divided by the polynomial q (as elements of the ring of polynomials over R), provided that the leading coefficient of q is a unit in R. PolynomialQuotient[p, q] works similarly as long as polynomials p and q are both from the same ring of polynomials. \nThe standard (built-in) usage still exists: PolynomialQuotient[p, q, x] gives the quotient of p and q, treated as polynomials in x, with any remainder dropped.";

PolynomialRemainder::usage = "PolynomialRemainder[PolynomialsOver[R], p, q] returns the remainder when the polynomial p is divided by the polynomial q (as elements of the ring of polynomials over R), provided that the leading coefficient of q is a unit in R. PolynomialRemainder[p, q] works similarly as long as polynomials p and q are both from the same ring of polynomials. \nThe standard (built-in) usage still exists: PolynomialRemainder[p, q, x] gives the remainder from dividing p by q, treated as polynomials in x.";

PolynomialsOfDegreeN::usage = "PolynomialsOfDegreeN[R, n, opts] returns all polynomials of degree n over the ring R. Since this number can increase rather quickly, the option SizeLimit provides a maximum for the number of polynomials that will be produced. The default value is 125, but this can be changed using the option. Unless Indeterminate \[Rule] symbol is set, the default indeterminate is 'x'. A related function is PolynomialsUpToDegreeN.";

PolynomialsOver::usage="PolynomialsOver[R] generates the RingExtension of polynomials over R.";

PolynomialsUpToDegreeN::usage = "PolynomialsUpToDegreeN[R, n, opts] returns all polynomials of degree n or less over the ring R. Since this number can increase rather quickly, the option SizeLimit provides a maximum for the number of polynomials that will be produced. The default value is 125, but this can be changed using the option. Unless Indeterminate \[Rule] symbol is set, the default indeterminate is 'x'. A related function is PolynomialsOfDegreeN.";

PolyQ::usage = "PolyQ[p] returns True if p is a polynomial obtained by the Poly function in AbstractAlgebra, and False otherwise.";

PolyRing::usage="PolyRing is a parameter of RingExtension.";

PolyToFunction::usage = "PolyToFunction[R, p] constructs the function on the ringoid R that is defined by the polynomial p (constructed with Poly). If R has no unity, then $Failed is returned.";

PowerList::usage = "PowerList[GF[n]] is equivalent to TableOfPowers, added for compatibility with the Algebra`FiniteFields` package.";

PowersIncrease::usage = "PowersIncrease is an option that is used in specifying how a polynomial should be presented when called with the Poly function. It takes two values, RightToLeft and LeftToRight. The former returns a polynomial in the form 4x^2 + 3x + 1 while the latter returns 1 + 3x + 4x^2 for the same polynomial.";

PreservesQ::usage = "PreservesQ[f, {a, b}] returns True if the Morphoid f preserves the binary operation(s) for the pair (a,b), and False otherwise. Alternatively, if f is either a list of Rules, a Function or a Symbol, Si is a set of Elements, and opi is a binary operation, then the following are also acceptable usages: PreservesQ[f, {S1, op1}, {S2, op2}, {a, b}], PreservesQ[f, {S1, op1, op3}, {S2, op2, op4}, {a, b}]. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (on group elements)).";

PreviousStage::usage = "PreviousStage[func] returns the previous stage of an animation for the function func when Mode is set to Visual. PreviousStage[func, k] indicates that k steps backwards (or forward, if negative) should be taken. The functions supporting this include Closure, SubgroupClosure, and QuotientRing in some cases. As of version 6, this has largely been replaced by using Manipulate with these functions.";

PrimeIdealQ::usage = "PrimeIdealQ[S, R] returns True if the set S is a prime ideal in the structure R, and False otherwise.";

PrimitivePolynomials::usage = "PrimitivePolynomials[GF[n]] returns the set of primitive polynomials in GF[n]. (Actually, GF[n] can be replaced by any ring R and this will return the set of elements that generate the multiplicative Groupoid of non-zero elements in R.)";

PrincipalIdeal::usage = "PrincipalIdeal[ R, r] returns the Ringoid <r> in the Ringoid R. This is the principal ideal generated by r in R.";

PrintingBackgroundColors::usage="PrintingBackgroundColors is a global constant consisting of a list of colors that are meant to replace those used in BackgroundColors when printing to a black and white printer. To use this, just before printing evaluate 'temp = BackgroundColors' followed by 'BackgroundColors = PrintingBackgroundColors'. Then print. When done,restore by entering 'BackgroundColors = temp'.";

PrintingOtherColors::usage="PrintingOtherColors is a global constant consisting of a list of colors that are meant to replace those used in OtherColors when printing to a black and white printer. To use this, just before printing evaluate 'temp = OtherColors' followed by 'OtherColors = PrintingOtherColors'. Then print. When done,restore by entering 'OtherColors = temp'.";

PrintMessage::usage="PrintMessage is an option for the ProbableMorphismQ function. When set to True (the default value), it will warn the user that a positive result is not absolutely certain, but only probabilistic.";

ProbableGroupQ::usage = "ProbableGroupQ[G] returns True or False depending on whether the tests for a group are valid, using RandomAssociativeQ instead of AssociativeQ.";

ProbableMorphismQ::usage="ProbableMorphismQ[f] returns True if checking random pairs of elements in the domain of Morphoid f indicates that f preserves the operation(s), and False otherwise. This is a fast, effective, although not foolproof, way of testing whether a Morphoid is a morphism. The option SampleSize controls the number of pairs tested. SamplePairs, by default set to Random, controls the specific pairs (by giving positions or indices in the domain) to be tested, if not chosen randomly.";

ProbableRingQ::usage = "ProbableRingQ[R] returns True if R is probably a ring (all properties are checked, except associativity and distributivity use the randomized versions), and False otherwise.";

ProductOrder::usage = "ProductOrder is an option for the function MultiplyPermutations and other functions that call this. The value of this, which defaults to RightToLeft, specifies the order in which the permutations are multiplied. Alternatively, one can specify LeftToRight.";

Products::usage = "Products is a value for the Combine option of IntegerDivisors and ZdDivisors. With this value, the divisors of n are grouped in pairs {a, b} such that a*b = n.";

ProperSubsetQAA::usage = "ProperSubsetQAA[A, B] returns True if A is a proper subset of B, and False otherwise.";

QuaternionGroup::usage = "QuaternionGroup[] returns the 8 element quaternion group. This group can be represented in various forms; the default is to represent it as 2-by-2 matrices. The option Form controls what form to use, with the default value being AsMatrices. Other values are AsIJK and AsSymbols.";

QuotientGroup::usage = "QuotientGroup[G, N] returns the quotient group formed by the group G and the normal subgroup N. Options for this function are Form and Representatives. Form can have the value Cosets (default) which returns the elements in coset form g + NS or g NS where NS is a symbol representing the Normal Subgroup. The value CosetLists returns the quotient group as a list of all the cosets in list form. Alternatively, one can use Form \[Rule] Representatives and then only the representatives of the cosets will be returned. The default list of representatives uses the 'smallest' element in the coset and is indicated by Representatives \[Rule] Canonical; if you wish to change this list, use Representatives \[Rule] list, where list is a list of one element from each coset, or use Representatives \[Rule] Random to have these representatives randomly chosen. This can be used also if one has Form \[Rule] Cosets. By default, left cosets are used.";

QuotientRing::usage = "QuotientRing[R, S] returns the quotient ring formed by the ring R and the ideal S. Options for this function are Form and Representatives. Form can have the value Cosets (default) which returns the elements in coset form g + NS or g NS where NS is a symbol representing the Ideal (normal subgroup). Alternatively, one can use Form \[Rule] Representatives and then only the representatives of the cosets will be returned. The default list of representatives uses the 'smallest' element in the coset and is indicated by Representatives \[Rule] Canonical; if you wish to change this list, use Representatives \[Rule] list, where list is a list of one element from each coset. This can be used also if one has Form \[Rule] Cosets. By default, left cosets are used. For a polynomial p over the base ring R, QuotientRing[R, p] returns the Ringoid of polynomials mod p, if R is a Ringoid with unity and the leading coefficient of p is a unit of R. QuotientRing[Z[I], z] returns the quotient ring Z[I]/<z> for a Gaussian integer z; this has a Visual mode. WARNING: This function may use a lot of memory if R is large and/or the degree of p is large. (Note: A portion of the code that creates the Visual mode of QuotientRing[Z[I], z] utilize several functions in Stan Wagon's 'Mathematica in Action' book, pages 334, 335 (in the first edition from Freeman).)";

Radical::usage = "Radical is an option for DividesQ that specifies the value of d when division takes place in \[DoubleStruckCapitalZ][\!\(\@d\)]. The value for this option needs to be a square-free integer.";

RandomAssociativeQ::usage = "RandomAssociativeQ[S] returns a Boolean value of True or False depending on whether the structure S appears to be associative after 50 random choices of testing a triple of elements from S. RandomAssociativeQ[S, n] will randomly test n times. When used with rings, the Operation option can be used, which can have the value Addition, Multiplication or Both.";

RandomColoredSquares::usage = "RandomColoredSquares[n] returns a row of n colored squares chosen randomly from a default list. Optionally, RandomColoredSquares[n,colors] will choose the n from the list provided in colors.";

RandomDistributiveQ::usage = "RandomDistributiveQ[R] returns True if the Multiplication is likely to be distributive over the Addition in structure R (by checking 20 triples), and False otherwise. RandomDistributive[R, n] checks n triples.";

RandomElement::usage = "RandomElement[S] returns a random element from the Groupoid or Ringoid (or simply the list) S. Available options are SelectFrom \[Rule] NonIdentity (this, the default, guarantees that the identity is not selected for Groupoids and neither the zero nor the unit is selected for Ringoids), SelectFrom \[Rule] NonUnity (which guarantees the unity is not selected with Ringoids), SelectFrom \[Rule] NonZero (which guarantees the zero is not selected with Ringoids), and SelectFrom \[Rule] Any (which imposes no restrictions). For polynomial extension rings, the options LowerDegreeOK and Monic are also available; see these for details (after working with rings). Additionally, one can obtain a random element from some specialized sets as follows: RandomElement[Z[Sqrt[p]],max] (for p square-free and max defaulting to 100) returns a + b Sqrt[p] with both a and b in the range [-max, max]. One can use p = -1 also, or use equivalently use Z[I].";

RandomElements::usage = "RandomElements[S, n] returns a set of n random elements from the Groupoid or Ringoid (or list) S. Available options are SelectFrom \[Rule] NonIdentity (this default guarantees that the identity is not selected for Groupoids and neither the zero nor the unit is selected for Ringoids), SelectFrom \[Rule] NonZero (which guarantees the zero is not selected with Ringoids), and SelectFrom \[Rule] Any (which imposes no restrictions). Additionally, Replacement \[Rule] True will allow an element to be selected more than once (while set to False will not allow this). Additionally, one obtain a random element from some specialized sets as indicated under RandomElement, by adding the final parameter indicating how many to choose.";

RandomGroupoid::usage = "RandomGroupoid[n, k] returns a random Groupoid of order n. If k = 1, the Cayley table is a collection of n^2 random elements from a list of n generic elements; if k = 2, each row is a permutation of a list of n generic elements; if k = 3, each column is a permutation of a list of n generic elements.";

Randomize::usage = "Randomize[list] will randomly permute the elements in list. It is also an option, which takes True or False, to DisguiseGroupoid.";

RandomMatrix::usage = "RandomMatrix[R, n, MatrixType \[Rule] type] returns a random n-by-n matrix over the Ringoid R of the specified type; see MatrixType for the possible values.";

RandomPermutationAA::usage = "RandomPermutationAA[n] returns a random permutation of length n. (This is a modified version of that found in the DiscreteMath`Permutations` package.)";

RationalMatrixQ::usage = "RationalMatrixQ[A] returns True or False depending on whether the matrix A has all of its entries being rational numbers (in the mathematical sense - entries can be Integer or Rational).";

RationalRootCandidates::usage = "Ration alRootCandidates[poly] returns a list of candidates for the Rational Root Theorem, given the polynomial poly.";

RationalRootTheorem::usage = "RationalRootTheorem[poly] returns a list of two lists, given a polynomial poly. The first list consists of those rational candidates which are zeros for poly, while the second list consists of those rational candidates which are not zeros for poly.";

RealMatrixQ::usage = "RealMatrixQ[A] returns True or False depending on whether the matrix A has all of its entries being real numbers (in the mathematical sense - entries can be Integer, Rational, Algebraic, or Real).";

Ref::usage = "This is the standard (default) symbol to represent a reflection when working with the dihedral group D[n].";

RefSym::usage = "When working with dihedral groups, by default we use the option RefSym \[Rule] Ref. This can be changed so that any other symbol is used to represent the reflection. See Dihedral for more information.";

ReorderGroupoid::usage = "ReorderGroupoid[G, neworder] takes the Groupoid G and forms a new Groupoid with all the properties of G using the order of the elements presented in neworder. (Note that mathematically the result of this and G are identical since groups do not have an order assumed among the elements. This is simply for the convenience of using the functions in these packages.)";

ReorderRingoid::usage = "ReorderRingoid[R, neworder] takes the Ringoid R and forms a new Ringoid with all the properties of R using the order of the elements presented in neworder. (Note that mathematically the result of this and R are identical since rings do not have an order assumed among the elements. This is simply for the convenience of using the functions in these packages.)";

Replacement::usage = "Replacement is an option for RandomElement and RandomElements. The value True means that replacement is to be allowed while False if not.";

ReportIterations::usage = "ReportIterations is a Boolean option for Closure. If set to true, all of the iterations of the closure process will also be shown, in addition to the final result.";

Representatives::usage = "Representatives is a value for the Form option of QuotientGroup and QuotientRing. This causes the elements to be written as representatives of the cosets. Representatives is also an option name for QuotientGroup and QuotientRing. It can take values Canonical (default), Random, or {g1, g2,...} where the gi's are representatives from the cosets. The Canonical option uses the 'first' element in the coset, while the Random chooses them randomly.";

RightCoset::usage = "RightCoset[G, H, g] returns the right coset Hg (or H + g) when given the element g from G and the subgroup H of G. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (on group elements)).";

RightCosets::usage = "RightCosets[G, H] returns a list of the cosets of the subgroup (or subring) H in the Groupoid (or Ringoid) G. Available option: Mode (possible values: Computational, Textual, Visual, and All).";

RightDistributiveQ::usage = "RightDistributiveQ[R] returns True if the Multiplication is right distributive over the Addition in the structure R, and False otherwise.";

RightIdealQ::usage = "RightIdealQ[S, R] returns True if the set S is a right ideal of the structure R, and False otherwise.";

RightIdentity::usage = "RightIdentity[G] returns the right identity of the Groupoid G, if one exists, or $Failed otherwise.";

RightInverse::usage = "RightInverse[G, g] returns the right inverse of g in G, if it exists, otherwise $Failed.";

RightInvertibleQ::usage = "RightInvertibleQ[G, g] returns True if the right inverse of g in G exists, and False otherwise.";

RightToLeft::usage = "RightToLeft is a value for the ProductOrder option of MultiplyPermutations and MultiplyCycles, as well for the PowersIncrease option for Poly (when working with polynomials over a ring). When ProductOrder is set to this value, then MultiplyPermutations[p2,p1] will be computed by taking p1 followed by p2. For the use in Poly, see PowersIncrease.";

Ring::usage = "Ring is a value for the Structure option that is used for several functions, including FormMorphoid, ZMap, and Z (including Z[n] and Z[n, I]). It is also an acceptable argument for the SwitchStructureTo function.";

RingExtension::usage="RingExtension is the head for ring extensions.";

RingInfo::usage = "RingInfo[R] is a list of facts about R that are generated by various tests of R.";

RingInfo::usage = "RingInfo[R] returns a list of information obtained about the Ringoid R which has been gathered by calling various functions.";

Ringoid::usage = "Ringoid is the head for a triple where the first component is a set of elements and the second and third are the addition and multiplication operations. A Ringoid is one of the basic structures of these packages.";

RingoidDescription::usage = "RingoidDescription[R] returns a description, if given, of the ring R. This can be set with the RingoidDescription option (of the same name) in FormRingoid. If the empty string is returned, no description has been given.";

RingoidName::usage = "RingoidName[R] yields the name, if given, of the Ringoid R. This can be set with the RingoidName option (of the same name) in FormRingoid. If the empty string is returned (or TheRing, the default value), no name has been given.";

RingQ::usage = "RingQ[R] returns True if R is a ring, and False otherwise.";

Rings::usage = "Rings is an acceptable name for the SwitchStructureTo function.";

RingSolve::usage = "RingSolve[R, a, b] solves the linear equation a x == b in the Ringoid R, returning a list of elements that solve the equation. The Solve command may also be useful.";

RootsOfUnity::usage = "RootsOfUnity[n] returns the Groupoid consisting of the n complex roots of the equation z^n = 1, under multiplication. Available options: Mode (possible values: Computational, Textual, Visual, All, and Interactive (on n)).";

Rot::usage = "This is the standard (default) symbol used to represent the rotation of the smallest angle when working with the dihedral group D[n].";

RotRef::usage = "RotRef is a value for the Form option when working with the dihedral group. See Dihedral for more information.";

RotSym::usage = "When working with dihedral groups, by default we use the option RotSym \[Rule] Rot. This can be changed so that any other symbol is used to represent the rotation. See Dihedral for more information.";

Rules::usage="Rules is a value for the FunctionForm option.";

S::usage = "S[n] returns the group of permutations on the set {1,2,..n} under composition. See Symmetric.";

SamePermutationQ::usage = "SamePermutationQ[cyclist1, cyclist2] returns True if the cycle representation for the permutation found in cyclist1 yields the same permutation represented by cyclist2, and False otherwise.";

SameSetQ::usage = "SameSetQ[list1, list2] returns True if the sets list1 and list2 are equal as sets, and False otherwise. Note that this tests the mathematical equality of two sets and so SameSetQ[{2,3,1},{1,3,2}] returns True while SameQ[{2,3,1},{1,3,2}] returns False.";

SamplePairs::usage="SamplePairs is an option for ProbableMorphismQ, whose default value is Random, meaning the pairs are chosen randomly. Alternatively, the value Default uses a short, built-in list of pairs, one can give a list of pairs of indices (not elements) to test, for example: {{2,3},{3,5}}.";

SampleSize::usage="SampleSize is an option for ProbableMorphismQ that specifies the number of tests to perform.";

SelectBaseElementsFrom::usage = "SelectBaseElementsFrom is an option for RandomElement and RandomElements when using extension rings. The acceptable values for this option are Any, NonZero, NonUnity and NonIdentity.";

SelectFrom::usage = "SelectFrom is an option for RandomElement and RandomElements. For Groups, the values are Any and NonIdentity; the former allows any element to be returned while the latter will not return the identity element, if one exists. For Ringoids, NonZero and NonUnity are also available values.";

SemiGroupQ::usage = "SemiGroupQ[G] returns True if G is a semi-group (a set that is closed under a binary operation that is associative), and False otherwise.";

Sgn::usage = "Sgn[G] gives the Morphoid whose domain is the group of permutations G and codomain is the group IntegerUnits and the function is the Parity function.";

ShowBodyText::usage = "ShowBodyText is an option for CayleyTable with settings True or False depending on whether the text in the body of the table is to be shown.";

ShowCircle::usage = "ShowCircle[n] creates a unit circle with n points labeled {0,1,..n-1} starting at (0,1). ShowCircle[n,labels] is similar except the set labels is used for the labeling.";

ShowColoredPermutation::usage = "ShowColoredPermutation[p] is similar to PermuteColoredSquares except that it does not require RandomColoredSquares to be called first.";

ShowExtraCayleyInformation::usage = "ShowExtraCayleyInformation is an option for CayleyTable that specifies whether or not buttons are displayed that provide additional information about the group and its elements and a calculator.";

ShowFigure::usage = "ShowFigure[n, perm, sym] draws an ngon with permutation perm applied to the vertices and having Dihedral or Cyclic symmetry group if sym is D or Z respectively. ShowFigure[perm] will apply the permutation perm to the vertices of the figure, with the permutation in list or rule form. Additionally, assuming a figure has already been drawn, ShowFigure[] will redraw it.";

ShowKey::usage = "ShowKey is an option for CayleyTable with settings True or False depending on whether a key is shown when the elements in the set are too wide and a key needs to be used for identification purposes.";

ShowName::usage = "ShowName is an option for CayleyTable with settings True or False depending on whether the name of the structured set is to be shown.";

ShowOperator::usage = "ShowOperator is an option for CayleyTable with settings True or False depending on whether the symbol for the operation of the structured set is to be shown.";

ShowPermutation::usage = "ShowPermutation[perm] shows a graphics array of the (predetermined) n-gon (if n>2) 'before' and 'after' the permutation perm has been applied. The permutation can be in list form or rule form. ShowPermutation[n, perm, symtype] combines ShowFigure[n, IdentityPermutation, symtype] with ShowPermutation[perm].";

ShowSidesText::usage = "ShowSidesText is an option for CayleyTable with settings True or False depending on whether the text in the top row and left column (representing the elements of the Groupoid) is to be shown.";

SideBySideMatrices::usage = "SideBySideMatrices[p,q] displays permutation p as a matrix on the left and permutation q as a matrix on the right, with some space in between. This simply illustrates how we begin to multiply matrices.";

Size::usage = "Size[S] returns the cardinality of the set of elements in the structured set S. This is identical to the function Order.";

SizeLimit::usage = "SizeLimit is an option for the GenerateGroupoid function. By default it is set to 25. When the size of the generated set exceeds this limit, no further generation will take place.";

SizeOfMatrices::usage = "SizeOfMatrices[matrixExtension] returns the dimensions of the matrices used in this extension ring.";

SkewHermitianQ::usage = "SkewHermitianQ[A] returns True or False depending on whether the matrix A is skew-Hermitian in the sense that A = -Adjoint[A].";

SkewSymmetricQ::usage = "SkewSymmetricQ[R, A] returns True or False depending on whether the matrix A is skew-symmetric in the sense that A = -Transpose[A]. For matrices with numeric entries (over Integers, Rationals, Reals or Complex), SkewSymmetricQ[A] works similarly.";

SL::usage = "SL[n, R] (alternately, SL[R, n]) returns the extension of invertible n-by-n matrices over the Ringoid R that have determinant Unity[R]. For a positive integer k, SL[n,k] is equivalent to SL[n,Z[k]].";

SLQ::usage = "SLQ[R, A] returns True or False depending on whether the matrix A over the Ringoid R is in SL[R, n] (where A is an n-by-n matrix).";

Solve::usage = "Solve[PolynomialsOver[R], poly == r], when given a polynomial poly from the ring of polynomials over the Ringoid R and an element r from R, solves the equation poly == r in the indeterminate x. (Solve[poly == r] can also be used, with the underlying ring extracted from poly.) Solutions are returned as a list of rules (as per normal usage). These solutions can be used with ReplaceAll (or its equivalent, /.) just as the results of the ordinary (built-in) Solve, whose functionality still works: \nSolve[eqns, vars] attempts to solve an equation or set of equations for the variables vars. Any variable in eqns but not vars is regarded as a parameter. Solve[eqns] treats all variables encountered as vars above. Solve[eqns, vars, elims] attempts to solve the equations for vars, eliminating the variables elims.";

SortGroupoid::usage = "SortGroupoid[G] returns the Groupoid with the elements sorted by the Sort function. Typically, this is already the case.";

SortRingoid::usage = "SortRingoid[R] returns the Ringoid with the elements sorted by the Sort function. Typically, this is already the case.";

SpecialLinear::usage = "SpecialLinear[args] - see SL.";

SpecialLinearGroup::usage = "SpecialLinearGroup[args] - see SL.";

Stabilizer::usage = "Stabilizer[G, S, x] returns the stabilizer of the element x (from S) in the group G. Here, G is a group of permutations of the set S. Stabilizer[S, x] assumes G is the full set of all permutations of S.";

Staged::usage = "This is an option for some functions (including Closure, SubgroupClosure, and QuotientRing in some cases) and can be set to True if an animation is to be conducted manually using NextStage and PreviousStage, and False otherwise.";

Structure::usage = "Structure is an option for several functions. Using Structure \[Rule] Group (default when working with groups) specifies that we are working with a group structure, while Structure \[Rule] Ring (default in Rings) specifies that rings are involved. Functions that have this option are ZMap, FormMorphoid, and Z (and related functions).";

SubgroupClosure::usage = "SubgroupClosure[G, H] returns the subgroup of G generated by the elements in the set H (which is a subset of G). The option ReportIterations (defaults to False) indicates whether the result of each iteration is also returned. Available option: Mode (possible values: Computational, Textual, Visual, All, and Interactive (on group elements)).";

SubgroupConjugate::usage = "SubgroupConjugate[G, H, x] returns the set x H x^(-1) for the subgroup H of the Groupoid G.";

SubgroupGenerated::usage = "SubgroupGenerated[G, g] returns the subgroup generated by the element g in the group G. Available option: Mode (possible values: Computational, Textual, Visual1, Visual2, All, and Interactive (on group elements)). ";

SubgroupIntersection::usage = "SubgroupIntersection[G, H, K] returns the subGroupoid of G which is the intersection of subgroups H and K.";

SubgroupJoin::usage = "SubgroupJoin[G, H, K] returns the subGroupoid of G generated by the elements in the subgroups H and K.";

Subgroupoid::usage = "Subgroupoid[G, H] creates the Groupoid with the elements from the list H (assumed to be elements from G) and the operation from the Groupoid G. Subgroupoid[G,{H1, H2}] or Subgroupoid[{G, H1}, {G, H2}] can be used if there are 2 (or more) subsets H.";

SubgroupProduct::usage = "SubgroupProduct[G, H, K] returns the subGroupoid (of G) HK = {hk | h in H, k in K} for subgroups H and K.";

SubgroupQ::usage = "SubgroupQ[H, G] returns True if H is a subgroup of the group G, and False otherwise. H can be in the form of a list of elements or a Groupoid consisting of elements from G. Available option: Mode (possible values: Computational, Textual, Visual1, Visual2, and All).";

SubgroupVisualText::usage = "Obsolete with version 6, SubgroupVisualText is an option for SubgroupQ that controls how/when the explanatory text accompanying the visualization of SubgroupQ should be processed. The default is Automatic, which means the text should be shown the first two times; use False to shut it off or True to keep it on.";

Subgroups::usage = "Subgroups[G] returns a list of all the subgroups of the group G. Warning: This may take a long time for high order (non-cyclic) groups!";

SubgroupUnion::usage = "SubgroupUnion[G, H, K] returns the subGroupoid of G which is the union of subgroups H and K.";

SubringQ::usage = "SubringQ[S, R] returns True if S is a subring of R, and False otherwise. (This function tests whether S is nonempty and closed with respect to difference and multiplication in R.)";

SubsetQAA::usage = "SubsetQAA[A, B] returns True if A is a subset of B, and False otherwise.";

SurjectiveQ::usage="Surjective[f] returns True if the Morphoid f is surjective (onto), and False otherwise.";

SwitchStructureTo::usage = "SwitchStructureTo[structure] sets various options and definitions so that the given structure is the default. Acceptable values are Group (or Groups or Groupoid) and Ring (or Rings or Ringoid).";

If[$VersionNumber<9.0,
Symmetric::usage = "Symmetric[n,opts] returns the group of permutations on the set {1,2,..n} under composition. There are two options for this function, ProductOrder and IndexLimit. Since the elements of this group are permutations, one can specify the order that the product is taken by using ProductOrder; see ProductOrder for more information, including the values which can be used. IndexLimit defaults to 6 and indicates the upper limit for the value of the index n.";
];

SymmetricGroupAA::usage = "SymmetricGroupAA[n] behaves just as the function Symmetric, but also has the functionality of PermutationGroupAA.";

SymmetricQ::usage = "SymmetricQ[R, A] returns True or False depending on whether the matrix A is symmetric.  For matrices with numeric entries (over Integers, Rationals, Reals or Complex), SymmetricQ[A] works similarly.";

TableOfPowers::usage = "TableOfPowers[GF[n]] returns a table consisting of first the element {0, 0} followed by pairs of the form {poly^j, r} where r is an element in GF[n], poly is the 'simplest' primitive polynomial for this ring, and j is the power to which poly needs to be raised to be equal to r."; 

TestFunction::usage = "TestFunction[ext] returns the function for the ring extension ext that determines if an element is a member of the extension.";

TextCayley::usage = "TextCayley[G] returns a simple, text-only version equivalent of CayleyTable[G, Mode \[Rule] Visual].";

Textual::usage = "Mode \[Rule] Textual is a common option for many functions in these packages. Generally, a written description and/or definition will be given to help clarify the function/concept being explored.";

TheSet::usage = "TheSet is an option for the CayleyTable function to be used to change the order that the elements appear in the construction of the table. TheSet \[Rule] list indicates that Elements[S] are to be arranged according to the order in list and then the Cayley table is constructed with this ordering. To change the ordering on a more permanent basis, see ReorderGroupoid.";

TimesSymbol::usage = "TimesSymbol is an option to FormRingoid to specify the symbol used for multiplication in forming a Ringoid. The default value is *.";

ToCycles::usage ="ToCycles[p] writes the permutation p as a list of disjoint cyclic permutations (i.e., cycles) whose product is p. If p is a list of permutations, this will return a list of cycles for each permutation. There are two options for ToCycles, CycleAs and Normalize. Using CycleAs \[Rule] List, the cycles are returned in the form returned by the ToCycles function in the DiscreteMath`Permutations` package (so that the permutation {2,1,4,3} is returned as {{2,1},{4,3}}), while CycleAs \[Rule] Cycle (default) uses Cycle[2,1] for {2,1} in the cycle list. If CycleAs \[Rule] Cycle is used, Normalize \[Rule] True (default) applies NormalizeCycleList to the list of cycles. See Normalize for details on how this works.";

ToFunction::usage = "ToFunction[rules] returns a function of the form ffx (where x is an integer), which is the result of converting the list of rules to a function. ToFunction[rules, f] specifies that the returned function is represented by the symbol f. ToFunction[f] converts the Morphoid based on the Rules definition to one based on a Function (or Symbol) definition, using a function of the form ffx (where x is an integer). ToFunction[f, g] specifies that the returned function is represented by the symbol g.";

ToGroupoid::usage = "ToGroupoid[extension], where extension might be GL[R,n] or some similar extension (such as MatricesOver[R, {m,n}, opts]), calculates the actual elements and forms a Groupoid when the number of elements is not larger than the default value of the option SizeLimit. Setting this option higher allows more Groupoids to be formed, but one needs to be sure there is sufficient memory to do so, since these Groupoids can become rather large. Using Size first may be a good idea, to see how many elements there are. To just get the list of elements, use the function Elements (which uses the same SizeLimit restriction).";

ToOrdinaryPolynomial::usage = "ToOrdinaryPolynomial[p] returns an expression that will be regarded as a polynomial in Mathematica's ordinary sense. Note that the underlying ring is lost in this transition and the new polynomial may or may not make sense (for ordinary Mathematica functions), depending on the ring.";

ToPermutation::usage = "ToPermutation[RuleList] returns the permutation determined by a list of rules. For example, {1\[Rule]2, 2\[Rule]1} becomes {2,1}. Similarly, {{1\[Rule]2}, {2\[Rule]1}} becomes {2,1}. ToPermutation[c, n] rewrites the cycle c of length <= n as a permutation of length n (or in S[n]). ToPermutation[c] uses the maximum value appearing in c for n.";

ToRingoid::usage = "ToRingoid[Mat[R, n]], if the SizeLimit permits, returns the Ringoid consisting of the n-by-n matrices over the Ringoid R. See ToGroupoid for more details.";

ToRules::usage = "ToRules[f, S] converts the function f with domain S to a list of rules of the form x \[Rule] f[x]. When it is important to check that the range values belong to a set T, use ToRules[f, S, T] (which returns $Failed if T does not contain all the images). S can be a list of values, a Groupoid, or a Ringoid. ToRules[f], where f is a Morphoid, converts the Morphoid based on a Function (or Symbol) to one based on a list of rules. ToRules[perm] converts any permutation perm (presented as a list) to a list of rules. For example, {2,1,3} becomes {1\[Rule]2, 2\[Rule]1, 3\[Rule]3}. \nThe standard (built-in) usage still exists: ToRules[eqns] takes logical combinations of equations, in the form generated by Reduce or Roots, and converts them to a sequence of lists of rules where the sequence corresponds to Or and the lists correspond to And. {ToRules[eqns]} gives a result of the form produced by Solve.";

ToTranspositions::usage = "ToTranspositions[c] rewrites the cycle c as a product of transpositions. ToTranspositions[perm] rewrites the permutation perm as a product of transpositions.";

Trivial::usage = "Trivial returns the trivial Groupoid consisting of just a single element.";

TrivialZR::usage = "TrivialZR[n] returns the ring of integers mod n with mod n addition but a multiplication with all products being zero.";

TwistedZ::usage = "TwistedZ[n] returns the Groupoid with elements {0, 1, ... n-2} and operation Mod[#1 + #2 + #1 #2, n]&.";

U::usage = "U[n] returns the group of integers mod n which are relatively prime to n, under multiplication. These elements are also the units in the ring Z[n]. (In other words, these are the elements that have inverses in the Groupoid Zx[n].) Other available options: Mode (possible values: Computational, Textual, Visual, All, and Interactive (on n)).";

UnionNoSort::usage = "UnionNoSort[list] removes duplicates in list but does NOT sort list as the Union function does. UnionNoSort[list1, list2,...] returns a single list with all duplicates removed, but unsorted. (This also works with other structures besides Lists.)";

UnitaryQ::usage = "UnitaryQ[A] returns True or False depending on whether the matrix A (over the complex numbers) is an unitary matrix in the sense that the product of the adjoint of A and A itself is the identity matrix.";

UnitQ::usage = "UnitQ[R, r] returns True if r is a unit in the structure R, and False otherwise.";

Units::usage = "Units[R] returns the list of units of the structure R.";

Unity::usage = "Unity[R] returns the unity of R, if one exists in R, and $Failed otherwise.";

UT::usage = "UT[n, R] (alternately, UT[R, n]) returns the extension of n-by-n upper triangular matrices (fully above the diagonal) over the Ringoid R.";

UTD::usage = "UTD[n, R] (alternately, UTD[R, n]) returns the extension of n-by-n upper triangular matrices (including the diagonal) over the Ringoid R.";

ValuesHavingGivenNorm::usage = "ValuesHavingGivenNorm[d, nrm], for negative d, returns the list (possibly empty) of values in Z[Sqrt[d]] that have the norm value of nrm. For positive d, ValuesHavingGivenNorm[d, nrm, iter] returns a (partial) list of values having the given norm obtained after iter number of iterations of an algorithm to search along the relevant hyperbola. The value for iter defaults to 50 if omitted. For positive d, the list is incomplete.";

VarToUse::usage = "VarToUse is an option for CayleyTable to specify the generic label for elements in the body of the Cayley table when the elements are wide and a key is used. (See ShowKey.)";

Visual::usage = "Mode \[Rule] Visual is a common option for many functions in these packages. Generally, some visual component will be drawn which is intended to further clarify the meaning of a concept/function.";

Visual2::usage = "Mode \[Rule] Visual2 is an option for some functions in these packages. Generally, some visual component will be drawn that is intended to further clarify the meaning of a concept/function.";

VisualizeMorphoid::usage = "VisualizeMorphoid[f, opts] provides a visualization of the Morphoid f by using arrows from the domain to the codomain to indicate the map. Available options are ColorDomain and ColorCodomain, both of whose default value is {}. See these names for more details.";

VisualTextShown::usage = "VisualTextShown is a global variable whose value indicates the number of times any text accompanying a graphic image should be shown. (If multiple graphic images are shown, the text will never be displayed.) For single images, the variable can be set to Infinity, to always display the text; n, to only show it the first n times (a particular function is called); or 0, to never show the text.";

WideElements::usage = "WideElements is an option for functions which form Groupoids or Ringoids, whose default value is False. When set to True, any formation of a Cayley table will set up a key, under the assumption that the elements are too wide to fit in the grid of the Cayley table.";

WithImages::usage = "WithImages is an option for the InverseImages function. If set to False (default), only the list of inverse images are listed, while if set to True, each inverse image is listed with its image element.";

WithUnityQ::usage = "WithUnityQ[R] returns True if the structure R has a unity, and False otherwise.";

Z::usage = "Z[n] returns the cyclic group of integers mod n under addition when in the context of groups or the ring of integers mod n when in the context of rings. The option Structure can be set to Group or Ring; by default, when working with groups, it is set to Group and set to Ring when working with rings. (See SwitchStructureTo for further information.) Note that ZG[args] is equivalent to Z[args, Structure \[Rule] Group], while ZR[args] is equivalent to Z[args, Structure \[Rule] Ring]. Z[n, k] returns the group (or ring) of multiples of k mod n, if k is a divisor of n. Additionally, Z[n, I] when working with groups (or Z[n, I, Structure \[Rule] Group] while working with rings) returns the additive Gaussian integers mod n, while Z[n, I] returns the ring of Gaussian integers mod n when working with rings. Other available options: Mode (possible values: Computational, Textual, Visual, All, and Interactive (on n)).";

ZdAssociatesQ::usage = "ZdAssociatesQ[d, a, b] returns True if a and b are associates over \[DoubleStruckCapitalZ][\!\(\@d\)], and False otherwise.";

ZdCombineAssociates::usage = "ZdCombineAssociates[d, lst] takes the list of elements lst from \[DoubleStruckCapitalZ][\!\(\@d\)] and returns a new list of lists, with each new list containing those elements in lst that are associates with each other.";

ZdConjugate::usage = "ZdConjugate[a + b Sqrt[d]] returns a - b \!\(\@d\), the conjugate in \[DoubleStruckCapitalZ][\!\(\@d\)].";

ZdDivide::usage = "ZdDivide[x, y] returns the quotient x/y in the form r + s \!\(\@d\) when x and y are both in \[DoubleStruckCapitalZ][\!\(\@d\)].";

ZdDividesQ::usage = "ZdDividesQ[d, a, b] is equivalent to DividesQ[a, b, Radical \[Rule] d].";

ZdDivisors::usage = "ZdDivisors[d, x, (opts)], when d is negative, returns all the divisors of the number x in \[DoubleStruckCapitalZ][\!\(\@d\)], possibly restricted by the options in opts. When d is positive, ZdDivisors[d, x, max] returns all the divisors of x (possibly modified by opts) in \[DoubleStruckCapitalZ][\!\(\@d\)] whose norm is less than or equal to the norm of the integer max. Available options are Combine, NonTrivialOnly, and DivisorsComplete. See them for more details.";

ZdIrreducibleQ::usage = "ZdIrreducibleQ[d, x], for negative d, returns True if x is irreducible in \[DoubleStruckCapitalZ][\!\(\@d\)], and False otherwise.";

ZdNorm::usage = "ZdNorm[x] returns the norm of x as an element in \[DoubleStruckCapitalZ][\!\(\@d\)] for some d, which is the value |a^2 - d b^2| when x = a + b \!\(\@d\).";

ZdPossibleNormQ::usage = "ZdPossibleNormQ[d, nrm], for negative d only, returns True if the value nrm can occur (i.e., it is possible) in \[DoubleStruckCapitalZ][\!\(\@d\)], and False otherwise.";

ZdPossibleNorms::usage = "ZdPossibleNorms[d, max], for negative d only, returns all the norms that can occur in \[DoubleStruckCapitalZ][\!\(\@d\)] that are less than or equal to max. This function has a Visual mode available.";

ZdQ::usage = "ZdQ[x] returns True if x can be viewed as an element in \[DoubleStruckCapitalZ][\!\(\@d\)] for some d, and False otherwise.";

ZdUnitQ::usage = "ZdUnitQ[d, x] returns True if x is a unit in \[DoubleStruckCapitalZ][\!\(\@d\)], and False otherwise."; 

Zero::usage = "Zero[R] returns the zero of R, if one exists in R, and $Failed otherwise.";

ZeroDivisorQ::usage = "ZeroDivisorQ[R, r] returns True if r is a zero divisor of the structure R, and False otherwise. Since this calls ZeroDivisors (which generates a complete list of zero divisors), a noticeable delay may be noticed upon the first call for large Ringoids.";

ZeroDivisors::usage = "ZeroDivisors[R] returns a list of all the zero divisors in the structure R. If R does not have a zero (HasZeroQ[R] == False), a message is returned. This calculation is based on the definition that if nonzero r and nonzero s have the product Zero[R], then r and s are both zero divisors."; 

Zeros::usage = "Zeros[PolynomialsOver[R], p] returns the zeros, if any, of the polynomial p as a polynomial with coefficients from R. In other words, if z is the zero of R, this returns {x : p(x) = z}. Zeros[p] is another method of obtaining the same result.";

ZG::usage = "ZG[n] returns the group of integers mod n with the operation addition mod n. ZG[n, k] returns the group of multiples of k mod n if k is a divisor of n. This is equivalent to Z[n, Structure \[Rule] Group]. See Z for information about available Modes.";

ZMap::usage = "ZMap[m, n] creates Morphoid[Mod[#, n]&, Z[m], Z[n]]. ZMap[m, n, g \[Rule] h] creates Morphoid[g \[Rule] h, Z[m], Z[n]], where g must be a generator in Z[m]. In either case, one can add the option Structure \[Rule] Ring to indicate that Z[m] and Z[n] should be considered rings.";

ZR::usage = "ZR[n] returns the ring of integers mod n with operations addition mod n and multiplication mod n. ZR[n, k] returns the ring of multiples of k mod n if k is a divisor of n. This is equivalent to Z[n, Structure \[Rule] Ring].";

Zx::usage = "Zx[n] returns the Groupoid of integers mod n under multiplication. Zx[n, k] returns the Groupoid of multiples of k mod n, if k is a divisor of n. Finally, Zx[n, I] returns the Groupoid of the Gaussian integers under mod n multiplication. Available options: Mode (possible values: Computational, Textual, Visual, and All)."; 

GroupCalculator::usage = "GroupCalculator is a function used in several locations including the GroupCalculator palette and as an option to CayleyTable.";
pushedGroup::usage = "";
pushedGroupName::usage = "";
FormElements::usage ="";
GroupCalculatorPC::usage ="";
ElementInformation::usage ="";
RElementInformation::usage ="";
GroupInformation::usage ="";
RingInformation::usage ="";
EAAMOn::usage = "";
EAAMOff::usage = "";
ShowHelp::usage = "";
ShowConvert::usage = "";
HelpMessages::usage = "HelpMessages is a list of options that are used to effect the visibility, placement, and magnification of the help messages that accompany the Visual mode for some functions";
InteractiveMode::usage = "InteractiveMode is an option for the Interactive mode";
MorphoidSetupMenu::usage = "MorphoidSetupMenu[G1, G2, opts] will present a tool to set up a Morphoid between G1 and G2 using a menu for each domain element giving options of the images in the codomain. There are several options for this function that control whether certain aspects are visible or not: ShowVisualization, ShowRules, ShowOrders, ShowRemaining";
ShowVisualization::usage = "ShowVisualization is a Boolean option for the MorphoidSetupMenu function. If set to true, a graphical visualization of the map is updated as it is made."; 
ShowRules::usage = "ShowRules is a Boolean option for the MorphoidSetupMenu function. If set to true, a listing of the rules of the map (form a \[Rule] b) is updated as it is made."; 
ShowOrders::usage = "ShowOrders is a Boolean option for the MorphoidSetupMenu function. If set to true, a listing of the orders of all elements from both groups is given.";
ShowRemaining::usage = "ShowRemaining is a Boolean option for the MorphoidSetupMenu function. If set to true, listings of the remaining elements in the domain and codomain of the map are updated as it is made.";






(* ::Section:: *)
(* 3. Error messages*)


Adjoin::fail = "The expression `1` needs be an nth root of some number for this function to work.";

CayleyTable::version = "The Version that you specified, `1`, is not an acceptable value. Use 6 or 5.";

GenerateGroupoid::size = "The size of the set generated thus far exceeds the current value of `1` given by the option SizeLimit. (The elements generated thus far are shown below.)";

Group::fail = "The Groupoid `1` fails at least one of the tests for being a group, which is needed for this function.";

Group::noord = "The element `1` in the Groupoid `2` does not have an order.";

Group::notnorm = "`1` is not a normal subgroup of `2`.";

Closure::stage = "NextStage and PreviousStage have been replaced by using the option 'Mode \[Rule] Visual' with Closure and then using the slider bar to go to the next or previous stage.";

Groupoid::fail = "In applying this function, it has to act on a Groupoid. Check to be sure `1` has been properly formed using FormGroupoid or GenerateGroupoid (or other acceptable means).";

Groupoid::reorderfail = "The elements `2` cannot be used to reorder the elements in `1` since they are not the same list.";

Identity::fail = "`1` does not have an identity.";

Identity::lfail = "`1` does not have a left identity.";

Identity::lmultiple = "`1` has the following left identities: `2`.";

Identity::rfail = "`1` does not have a right identity.";

Identity::rmultiple = "`1` has the following right identities: `2`.";

Inverse::fail = "`1` does not have an inverse in `2`.";

Inverse::noId = "`1` does not have an identity, so the notion of inverse does not make sense.";

List::lngth = "The two lists are not of the same length.";

MemberQ::elmnt = "`1` is not an element of `2`.";

MemberQ::elmnts = "At least one of `1` is not an element of `2`.";

MemberQ::elsbst = "`1` is neither an element nor a subset of `2`.";

MemberQ::sbgrp = "`1` is not a subgroup of `2`.";

Mode::notavail = "The function `1` does not support the `2` mode.";

Mode::novis = "This function does not support the Visual mode.";

Mode::notext = "This function does not support the Visual mode.";

Operation::fail = "The operation of the substructure(s) does not match that of the parent structure.";

OrderOfElement::badpairs = "At least one of the pairs has an 'element' that is not truly an element of the corresponding Groupoid.";

RandomElement::gfail = "Trying to comply with the option SelectFrom \[Rule] `1`, this Groupoid does not have enough elements to still choose a random element.";

RandomElement::sqrfree = "The index to the Z function must be square-free to work here.";

RandomElements::toomany = "You can't ask for `1` random elements when there are only `2` available.";

RandomElements::toomanyni = "You can't ask for `1` non-identity random elements when there are only `2` to start with and you don't want the identity.";

Rule::form = "The list of rules is ill-formed. Each integer from 1 to `1` should appear exactly once before and after each \[CapitalAE].";

TheSet::error = "Some of the elements in `1` do not belong to the set of elements of this Groupoid. Default value for TheSet, Elements[G], will be used.";

Groupoid::modd = "The integer `1` does not divide the modulus `2`.";



GF::notdef = "First define a field by using the GF function.";

GF::badindex = "The index for GF needs to be a power of a prime, which `1` is not.";

GF::deg = "To form a Galois field GF[`1`^`2`], the polynomial `3` must be of degree `2`, but this has degree `4`.";

GF::irr = "The polynomial `1` needs to be irreducible over Z[`2`].";

GF::poly = "The expression `1` needs to be a polynomial in the indeterminate `2`.";

GF::bases = "The polynomial `1` was given over the base ring `2`, while it should be over the base ring Z[`3`].";

GF::var = "The polynomial `1` and indeterminate `2` do not match.";

IrreduciblePolynomial::badindex = "Bad input: the second parameter, `1`, for IrreduciblePolynomial needs to be a prime and the third, `2`, needs to be a positive integer.";

IrreduciblePolyOverZpQ::prime = "The polynomial needs to be over a prime index, not `1`.";


Generator::string = "This function requires the generator to be a string or an undefined symbol. Your symbol `1` is not a string.";

Klein4::warning = "The elements e, a, b, c are considered strings and thus need to have double quotes around them when being used.";

QuaternionGroup::JJKK = "(Note that KK is used because K is a reserved symbol since version 3 of Mathematica and JJ is used because J is reserved as a generic name for an ideal.)"; 


Group::notcyclic = "The group `1` is not a cyclic group.";

Groupoid::fail = "In applying this function, it has to act on a Groupoid. Check to be sure `1` has been properly formed using FormGroupoid or GenerateGroupoid (or equivalent).";

Conjugate::fail = "For ElementConjugate, both `1` and `2` need to be elements of the group, while for SubgroupConjugate `1` needs to be a subgroup and `2` an element.";


(* From Joint *)

CosetToList::illformed = "The coset `1` is ill-formed.";

DirectProduct::ArgErr="Direct Product called with incorrect arguments.";

GenerateGroupoid::size = "The size of the set generated thus far exceeds the current value of `1` given by the option SizeLimit. (The elements generated thus far are shown below.)";

QuotientGroup::NS = "This quotient group uses NS to represent the normal subgroup `1` that you specified. Use CosetToList to convert this coset representation to a list of elements.";

QuotientGroup::badrep = "Your choice of `1` for representatives is a bad representation. Make sure you have only one from each coset.";

QuotientGroup::replngth = "Your choice of representatives is not of the correct length. There should be `1` elements.";


(* From Matrices *)

Dot::DimErr="Dimensions of parameters to Dot fail to match.";

Random::toomany = "After 500 attempts, a random matrix meeting these conditions was not found.";

Random::notype = "`1` is not an acceptable value for MatrixType.";

SizeLimit::toobig = "With the present restriction on SizeLimit, there are too many elements to form a Groupoid that determines all of the elements.";

Identity::nonsquare = "To have an Identity matrix, one needs to consider square matrices.";

Multiplication::fail = "A `1` by `2` matrix can not be multiplied by a `3` by `4` matrix.";


(* From Morphism *)

Automorphism::badrule="The rule provided does not uniquely define an automorphism on `1`. The rule must map a generator to a generator.";

Automorphism::nosup="Automorphism only supports cyclic groups at this time.";

AutomorphismGroup::nosup="AutomorphismGroup only supports cyclic groups at this time.";

FormMorphoid::badpos="Invalid list of positions.";

ProbableMorphismQ::warning = "The ProbableMorphismQ function is being used; 'True' results are only probable, not certain.";

FormMorphoid::badstruc = "In creating a Morphoid between two structures A and B, these structures must be both Groupoids or both Ringoids.";

InnerAutomorphism::noinv="InnerAutomorphism is not defined; group element `1` does not have an inverse.";

InnerAutomorphismGroup::nogroup="`1` is not a group, which is necessary for this function.";

IsomorphismQ::notHom = "The Morphoid is not a homomorphism, so it is not possible to be an isomorphism.";

Kernel::noid="Kernel is undefined; the codomain `1` does not have an identity";

Morphoid::badarg="Invalid argument(s) to `1`.";

Morphoid::dff = "The number of elements in `1` is not the same as in `2`, so it cannot be an isomorphism.";

Morphoid::domain = "The list of rules `1` needs to have exactly one instance of the elements of the domain `2` occurring on the left-hand side of the rules before we can have a Morphoid.";

Morphoid::fail = "The function or rules `1` need to carry the elements of `2` to `3` before we can have a Morphoid.";

Morphoid::notonto="Since the Morphoid is not onto, it can not be an isomorphism.";

Morphoid::npres="This Morphoid does not preserve the operation(s) for at least one pair of elements.";

Morphoid::range = "The values on the right-hand side of each rule in `1` need to form a subset of the codomain `2` before we can have a Morphoid.";

MorphoidComposition::notdef2="The composition is not defined because the first Morphoid is based on `1` while the second is based on `2`, which are not the same.";

MorphoidComposition::notdef="The composition is not defined because the image of the first map is `1` while the domain of the second map is `2`, which are not the same.";

ZMap::relpr = "In forming ZMap[`1`, `2`, `3` \[Rule] `4`], the element `3` must be a generator in Z[`1`].";

Structure::nosup="`1` does not support structures of type `2`.";


(* From Permutations *)

Cycle::disjoint = "The cycles in the list `1` need to be disjoint to use this function.";

Group::size = "Are you sure you want `1`? This group has `2` elements in it. By default, the index must be less than or equal to `3`. If you wish to increase it, add the option 'IndexLimit \[Rule] k' to this function, where k is the new desired maximum for the index.";

PermutationQ::diffels = "`1` is not a permutation of `2` since they do not have the same elements.";

PermutationQ::difflen = "`1` is not a permutation of `2` since they do not have the same length.";

PermutationQ::duplicates = "A permutation can not have elements listed twice as `1` does.";

PermutationQ::fail = "`1` is not a permutation.";

PermutationQ::length = "The permutation `1` should have exactly the `2` elements from 1 to `2` in some order. If `1` is actually a cycle and you are trying to use it as a permutation, convert it by using the ToPermutation function.";

PermutationQ::missing = "A permutation on `1` must be a list containing all of the integers from 1 to `2`. `3` is missing some values.";

PermutationQ::notrule = "The list `1` needs to have every element either in the form a \[Rule] b or {a \[Rule] b} in order to represent a permutation by using rules.";


(* From RingExtensions *)

Coefficient::ind = "Since `1` uses the indeterminate `2`, `3` shouldn't be specified as the indeterminate. Mention of the indeterminate is optional; it can be omitted.";

PolynomialDivision::undef="Since the leading coefficient, `1`, is not a unit in `2`, division is undefined.";

FuncToRules::invalid="The length of the Func object does not match the size of the base ring.";

Poly::badInd = "The indeterminate chosen for this polynomial, `1`, can not be used. (Perhaps it is a symbol with an assigned value.) The symbol 'x' will be the indeterminate used.";

Poly::bragrm = "To perform operations on polynomials, one must use the same base ring for both polynomials.";

Poly::extagrm = "To perform operations on polynomials, one must use the same base ring for the polynomials as for the specified base ring in the extension.";

Poly::mixvars = "In your polynomial `1`, you should be using only a single variable (such as x), but the variables `2` were used.";

PolynomialGCD::undefined= "The result of PolynomialGCD is undefined because the base is not a ring or there is an undefined division.";

PolynomialsOfDegreeN::toobig ="Using degree `1`, there would be about `2` polynomials, which is larger than the current limit of `3`. You can override this limit by using the option SizeLimit \[Rule] `2`.";

RandomElements::toomanyk = "You can not obtain `1` random elements from this structure using the given options.";

RingExtension::NoInverse="There is no multiplicative inverse in the extension ring because of the lack of a multiplicative inverse in the base ring.";

RingExtension::NoNegat="There is no negation in extension ring because of the lack of a negation in the base ring.";

RingExtension::NoUnity = "The extension ring does not have a unity because the base ring does not have a unity (or possibly a zero).";

RingExtension::NoZero ="The extension ring does not have a zero because the base ring does not have a zero.";

RingExtension::NotBaseElement = "The element `1` is not in the base ring.";


(* From Ringoids *)

(* Dot::DimErr="Dimensions of parameters to Dot fail to
match.";*)

FormRingoid::diffels = "In forming a Ringoid in this fashion, the list of elements in the first Groupoid, `1`, must match those in the second Groupoid, `2`.";

FormRingoid::size = "The index for this structure needs to be less than `1`, which `2` is not.";


(* From RingProperties *)

Characteristic::fail = "This Ringoid either is not a ring or does not have a unity, and so it does not make sense to find its characteristic.";

IdealQ::fail = "The Ringoid needs to be commutative and with a unity.";

ModpIrreducibilityQ::baddeg = "Using the prime number `1`, the degree of the reduced polynomial does not match the degree of the original. This is necessary.";

ModpIrreducibilityQ::badpoly = "The expression `1` is an ill-formed polynomial.";

QuotientRing::NS = "This quotient ring uses NS to represent the ideal (normal subgroup) `1` that you specified. Use CosetToList to convert this coset representation to a list of the elements.";

QuotientRing::notideal = "The set `1` is not an ideal of the Ringoid `2`.";

QuotientRing::toobig="The requested quotient ring is likely to be too large. The SizeLimit option can be reset to a higher value.";

QuotientRing::J = "This quotient ring uses J to represent the principal ideal generated by `1`.";

QuotientRing::badz = "For this function, the parameter z must be a Gaussian integer other than 1, -1, I, -I, which `1` is not.";

RandomElement::fail = "When trying to comply with the option SelectFrom \[Rule] `1`, this Ringoid does not have enough elements to still choose a random element.";

Ring::fail = "The structure `1` fails to be a ring.";

Ringoid::NotUnit="`1` is not a unit of `2`";

Ring::subringfail = "The set `1` fails to be a subring of the ring.";

UnitQ::nounity="The ring does not have a unity; no units are possible.";

ZeroDivisors::NA = "The Ringoid does not have a zero and so the notion of zero divisors does not make sense.";


ZdNorm::sqfree = "The number `1` is not square-free, as is required for this function.";

ZdNorm::one = "The number 1 cannot be used as a value for the parameter d for this function.";

ZdNorm::int = "The number `1` cannot be used as a value for the parameter d for this function, since it needs to be an integer.";


(* ::Section::Closed:: *)
(* 4. Begin private section*)


Begin["`Private`"];


(* ::Section:: *)
(*5. Code for special projects*)


(* ::Subsection:: *)
(*MorphoidSetupMenu*)


FormIncompleteMorphoid[rules_List,S1_,S2_,opts___?OptionQ]:=
	Module[{head1=Head[S1],head2=Head[S2],structure,
	ff=FormatFunction/.Flatten[{opts,Options[FormMorphoid]}]},
	If[head1===head2,
		structure=Switch[head1,groupoid,Group,ringoid,Ring];
		morphoid[rules,S1,S2,structure,Rule,FormatFunction->ff],$Failed]]

MakeOnePopupMenu[el_,codomain_,index_]:=
	(CandidateRules[index]=Rule[el,"?"];
	PopupMenu[Dynamic[CandidateRules[index]],Map[Rule[Rule[el,#],
		ToString[el,TraditionalForm]<>" \[Rule] "<>ToString[#,TraditionalForm]]&,codomain],
		"image of "<>ToString[el,TraditionalForm]<>"?"])

MakeAllPopupMenus[domainGroup_,codomainGroup_]:=
	Table[MakeOnePopupMenu[Elements[domainGroup][[k]],Elements[codomainGroup],k],
		{k,1,Length[Elements[domainGroup]]}]

ActualImagesEstablished[rules_,max_]:=
	Select[Union[Table[CandidateRules[k],{k,1,max}]],(#[[2]]=!="?")&]

TableOfOrders[domainGroup_,codomainGroup_]:=
	Row[{Style["Orders:  ",Gray],Column[{Row[{"Domain:  ",
	Grid[Transpose[Prepend[Orders[domainGroup],{"elmt","ord"}]],Frame->All]}],
	Row[{"Codomain:  ",Grid[Transpose[Prepend[Orders[codomainGroup],{"elmt","ord"}]],Frame->All]}]},Center]}]

Options[MorphoidSetupMenu]={ShowVisualization->True,ShowRules->True,ShowOrders->True,ShowRemaining->True};

MorphoidSetupMenu[G1_,G2_,opts___?OptionQ]:=Module[{len=Length[Elements[G1]],dom = Elements[G1],cod = Elements[G2], showVisualization =True,showRules=True,showRemaining=True, showOrders=True,temp},
showVisualization = ShowVisualization/.Flatten[{opts, Options[MorphoidSetupMenu]}];
showRules = ShowRules/.Flatten[{opts, Options[MorphoidSetupMenu]}];
showRemaining = ShowRemaining/.Flatten[{opts, Options[MorphoidSetupMenu]}];
showOrders = ShowOrders/.Flatten[{opts, Options[MorphoidSetupMenu]}];
Column[{Row[{"Match elements for map: ",Apply[Sequence,MakeAllPopupMenus[G1,G2]]}],
Row[{"Show: ",Checkbox[Dynamic[showOrders]],Style["Orders  ",Gray, Small],Checkbox[Dynamic[showVisualization]],Style["visualization  ",Pink, Small],Checkbox[Dynamic[showRules]],Style["function rules  ",Brown, Small],Checkbox[Dynamic[showRemaining]],Style["elements not chosen  ",Magenta, Small]}],Dynamic[If[showOrders,TableOfOrders[G1,G2],""]],
Dynamic[If[showRules,Row[{Style["function rules: ",Brown],Table[CandidateRules[k],{k,1,len}]}],""]],Dynamic[If[showRemaining,Row[{Style["domain elements not chosen: ",Magenta],Select[Table[CandidateRules[k],{k,1,len}],(#[[2]]=="?")&]/.Rule[x_,"?"]:> x}],""]],
Dynamic[If[showRemaining,Row[{Style["codomain elements not chosen: ",Magenta],Complement[cod,Select[Union[Table[CandidateRules[k],{k,1,len}]],(#[[2]]=!="?")&]/.Rule[_,a_]:> a]}],""]],
Dynamic[If[showVisualization &&Length[ActualImagesEstablished[Table[CandidateRules[k],{k,1,len}],len]]>0,VisualizeMorphoid[FormIncompleteMorphoid[ActualImagesEstablished[Table[CandidateRules[k],{k,1,len}],len],G1,G2], ColorDomain -> Automatic],""]],
Dynamic[If[(Select[Table[CandidateRules[k],{k,1,len}],(#[[2]]=="?")&]/.Rule[x_,"?"]:> x)=={},Button["Make Morphoid",(CellPrint[TextCell["f = FormMorphoid["<>StringReplace[ToString[Table[CandidateRules[k],{k,1,len}],InputForm],"->"-> "\[Rule]"]<>", "<>AbstractAlgebra`Master`Private`GroupoidInputString[G1]<>", "<>AbstractAlgebra`Master`Private`GroupoidInputString[G2]<>"]\nMorphismQ[f, Mode->Visual]","Input"]];SelectionMove[ButtonNotebook[],Previous,Cell]),Enabled->True, Background->Green],""]]}//.{{pre___,Dynamic[""],post___}->{pre,post}},Center]
]


(* ::Subsubsection:: *)
(*Mode to Computational*)


(* ::Section:: *)
(*6. GroupCalculator*)


NeedsOperandQ  := !  NeedsOperatorQ; 
EqualsLastQ = False;
CalculatorNumber = 0;

PushOperand[elm_,tag_]:=Module[{nb,el=elm[[1]]},
	If[NeedsOperandQ,nb=ButtonNotebook[]; 
	NotebookFind[nb,tag,All,CellTags,AutoScroll->False]; 
	If[Operands==={},PushClearScreen[tag]];
	SelectionMove[nb,After,CellContents,AutoScroll->False];
	NotebookWrite[nb,Cell[FormBox[el,StandardForm]],AutoScroll->False]; 
	AppendTo[Operands,elm]; 
	NeedsOperatorQ=True;
	EqualsLastQ=False;]]

PushRandEl[tag_]:=Module[{nb,el},
	If[NeedsOperandQ,nb=ButtonNotebook[]; 
	NotebookFind[nb,tag,All,CellTags,AutoScroll->False]; 
	If[Operands==={},PushClearScreen[tag]]; 
	SelectionMove[nb,After,CellContents,AutoScroll->False]; 
	el=RandomElement[pushedGroup//Elements]//ToBoxes; 
	NotebookWrite[nb,Cell[FormBox[el,StandardForm]],AutoScroll->False]; 
	el=el//BoxData; 
	AppendTo[Operands,el];
	NeedsOperatorQ=True;
	EqualsLastQ=False;]]

PushBinOp[tag_]:=Module[{nb},
	If[NeedsOperatorQ||EqualsLastQ,nb=ButtonNotebook[]; 
	NotebookFind[nb,tag,All,CellTags,AutoScroll->False];
	If[EqualsLastQ,PushBinOpWithResult[tag,nb]]; 
	SelectionMove[nb,After,CellContents,AutoScroll->False];
	NotebookWrite[nb,TextData[{" ",opSymb," "}],AutoScroll->False];
	NeedsOperatorQ=False;
	EqualsLastQ=False;]]

PushBinOpWithResult[tag_, nb_] := Module[{el = groupResult},
	ClearCell[tag];
	SelectionMove[nb, After, CellContents,AutoScroll -> False];
	NotebookWrite[nb, Cell[FormBox[el//First, StandardForm]],AutoScroll -> False]; 
	AppendTo[Operands, el];
]

PushEqual[tag_]:=Module[{nb,g,ops,el},
	If[NeedsOperatorQ,nb=ButtonNotebook[]; 
	NotebookFind[nb,tag,All,CellTags,AutoScroll->False];
	ops=Map[ToExpression,Operands];
	SelectionMove[nb,After,CellContents,AutoScroll->False];
	g=Fold[Operation[pushedGroup],First[ops],Rest[ops]];
	el=g//ToBoxes;
	NotebookWrite[nb,TextData[{" = "}],AutoScroll->False];
	NotebookWrite[nb,Cell[FormBox[el,StandardForm]],AutoScroll->False];
	NeedsOperatorQ=False;
	Operands={};
	EqualsLastQ=True;
	groupResult=BoxData[el]]];

WipeLastItem[tag_]:=Module[{nb,read},nb=ButtonNotebook[];
	NotebookFind[nb,tag,All,CellTags,AutoScroll->False]; 
	SelectionMove[nb,All,CellContents,AutoScroll->False];
	read=NotebookRead[nb];
	If[Head[read]===List,NotebookWrite[nb,TextData[Drop[read,-1]],AutoScroll->False],NotebookDelete[nb]];
	SelectionMove[nb,After,CellContents,AutoScroll->False];
	nb]

PushInverse[tag_] := Module[{nb,g, inv},  
	If[NeedsOperatorQ,
		nb =WipeLastItem[tag];
		g = Last[Operands];
		inv = GroupInverse[pushedGroup,ToExpression[g]];
		Operands = Join[Drop[Operands,-1],{BoxData[ToBoxes[inv]]}];
		NotebookWrite[nb,Cell[FormBox[ToBoxes[inv],StandardForm]],AutoScroll -> False]]]

PushSquare[tag_] := Module[{nb,g,sq},  
	If[NeedsOperatorQ, 
		nb =WipeLastItem[tag];
		g = Last[Operands]//First//ToExpression;
		sq = Operation[pushedGroup][g,g];
		Operands = Join[Drop[Operands,-1],{BoxData[ToBoxes[sq]]}];
		NotebookWrite[nb,Cell[FormBox[ToBoxes[sq],StandardForm]],AutoScroll -> False]]]

 PushDelete[tag_] := Module[{nb},  
	If[Operands  =!=  {},
			nb =WipeLastItem[tag];
			NeedsOperatorQ = ! NeedsOperatorQ;
			If[NeedsOperandQ, Operands =  Drop[Operands,-1]]];]

PushClearAll[tag_]:=Module[{nb},nb=ButtonNotebook[];
	ClearCell["memory"];ClearCell[tag];
	Operands={};
	NeedsOperatorQ=False;
	groupResult=BoxData[""];
	MemoryItem="";]

PushClearScreen[tag_]:=Module[{nb},nb=ButtonNotebook[];
	ClearCell[tag];
	Operands={};
	NeedsOperatorQ=False;
	groupResult=BoxData[""];]

ClearCell[tag_]:=Module[{nb},
	nb=ButtonNotebook[]; 
	NotebookFind[nb,tag,All,CellTags,AutoScroll->False]; 
	SelectionMove[nb,All,CellContents,AutoScroll->False];
	NotebookDelete[nb]];

 PushStore[tag_] := Module[{nb, ok = False, item},  
	If[NeedsOperatorQ,
			ok = True;
			MemoryItem = item = Last[Operands]//First];
	If[NeedsOperandQ && Operands ==={},
			ok = True;
			MemoryItem = item =groupResult//First];
	If[ok,
		nb  =ButtonNotebook[]; 
		NotebookFind[nb, tag, All, CellTags, AutoScroll -> False]; 
		SelectionMove[nb,All,CellContents,AutoScroll -> False];
		NotebookDelete[nb];
		NotebookWrite[nb,Cell[FormBox[item,StandardForm]],AutoScroll -> False]]]

PushRecall[tag_]:=Module[{nb,el=MemoryItem},
	If[NeedsOperandQ&&MemoryItem=!="",nb=ButtonNotebook[]; 
	NotebookFind[nb,tag,All,CellTags,AutoScroll->False]; 
	If[Operands==={},PushClearScreen[tag]]; 
	SelectionMove[nb,After,CellContents,AutoScroll->False];
	NotebookWrite[nb,Cell[FormBox[el,StandardForm]],AutoScroll->False]; 
	AppendTo[Operands,BoxData[el]]; 
	NeedsOperatorQ=True;
	EqualsLastQ=False;]];


GroupCalculator := Module[{ nb2,G =pushedGroup, square,inv},
	NeedsOperatorQ = False;
	Operands = {};
	CalculatorNumber++;
    MemoryItem = "";
	opSymb = OperatorSymbol[G];
	inv = If[opSymb === "+",FormBox[
        RowBox[{"-", "x"}], TraditionalForm], FormBox[
        SuperscriptBox["x", 
        RowBox[{"-", "1"}]], TraditionalForm]];
	square = If[opSymb === "+", FormBox[
        RowBox[{"2", "x"}], TraditionalForm], FormBox[
        SuperscriptBox["x", "2"], TraditionalForm]];
	nb2 = NotebookCreate[WindowFrame->"Normal",WindowSize -> {480, 375},WindowElements->{"HorizontalScrollBar","VerticalScrollBar"},
				WindowFrameElements->{"CloseBox", "ZoomBox", "ResizeArea"},
	WindowTitle ->"GroupCalculator"<>ToString[CalculatorNumber],
				WindowMargins->{{4,Automatic},{Automatic,4}}];
	NotebookPut[Notebook[{
			Cell[RowBox[{"A calculator for the group "<>pushedGroupName}], "Text",FontSize -> 20,TextAlignment->Center,ShowCellBracket->True,Editable -> False, Selectable -> False, Deletable -> False],
			Cell["", "Text",Editable->True,PageWidth->450, TextAlignment->Center,
         Background -> RGBColor[1,1,0],FontColor -> RGBColor[0,0,1],
				FontSize -> 14, CellTags->"screen",ShowCellBracket->False],
			 Cell[BoxData[RowBox[Join[{"Elements:"}, Map[ButtonBox[ToBoxes[#],ButtonSource->ButtonContents,
								  ButtonFunction:>(PushOperand[#,"screen"]&),
                Evaluator->"Automatic"]&, Elements[G]]]]],
			 Enabled->True,AutoIndent->True, ZeroWidthTimes->False,LineIndent->0,FontFamily->"Courier",FontWeight->"Plain",FontSize -> 14, TextAlignment->Center,LineSpacing->{1.25, 0},ShowCellBracket->False],
			Cell[BoxData[GridBox[{{ButtonBox[
			opSymb,ButtonFunction:>PushBinOp[ "screen"],
			Evaluator->"Automatic"], 
										ButtonBox["=",ButtonFunction:>PushEqual[ "screen"], Evaluator->"Automatic"], 
										ButtonBox[RowBox[{"Random", " ", "element"}],ButtonFunction:>PushRandEl[ "screen"], Evaluator->"Automatic"]}, 
          {ButtonBox[inv,ButtonFunction:>PushInverse[ "screen"],Evaluator->"Automatic"], 
										ButtonBox["Store",ButtonFunction:>PushStore[ "memory"], Evaluator->"Automatic"], 
										ButtonBox[RowBox[{"Delete", " ", "last", " ", "entry"}],ButtonFunction:>PushDelete[ "screen"], Evaluator->"Automatic"]},
          {ButtonBox[square,ButtonFunction:>PushSquare[ "screen"],Evaluator->"Automatic"], ButtonBox["Recall",ButtonFunction:>PushRecall[ "screen"],Evaluator->"Automatic"],
        ButtonBox[RowBox[{"Clear", " ","all"}], ButtonFunction:>PushClearAll[ "screen"],Evaluator->"Automatic"]}}, RowLines->True,ColumnLines->True,RowSpacings->0,ColumnSpacings->0]], Enabled->True,LineSpacing->{1.25, 0},ShowCellBracket->False,FontFamily->"Courier", TextAlignment->Center,FontWeight->"Plain", FontSize -> 14],
Cell["", "Text", Editable -> True, PageWidth->150, TextAlignment->Center,
         Background -> RGBColor[1,1,0], FontColor -> RGBColor[0,0,1],
				FontSize -> 14, CellTags->
"memory",CellMargins->{{200, -150}, {Inherited, Inherited}}, ShowCellBracket->False, CellFrame -> False], 
			Cell[BoxData[RowBox[{ ButtonBox[RowBox[{"Help"}],ButtonFunction:>NotebookPut[  Notebook[{Cell[TextData[{"This calculator is capable of a few basic operations with group elements. You can choose an element by simply clicking on the appropriate button in the first palette reflecting the desired element. The following explains the other buttons.
	\nSecond Palette:
\tFirst row:\n\t\t+ (or * or  ",StyleBox["\[Degree]",FontSize->14],") : This is the binary operator symbol for the group at hand; it must follow an element.
\t\t= : This will calculate the value of the sum or product in the display.
\t\tRandom Element : This produces a random element from the group.	
\n\tSecond row:\n\t\t",Cell[BoxData[FormBox[RowBox[{"-","x"}],TraditionalForm]]]," (or ",Cell[BoxData[FormBox[SuperscriptBox["x",RowBox[{"-","1"}]],TraditionalForm]]],") : This replaces the last operand with its inverse (additive or multiplicative, depending on the group).
\t\tStore : This will place the last operand (or result) into the memory cell below.
\t\tDelete last entry : This button deletes the last entry, whether an operand or operator.
\n\tThird row:\n\t\t",Cell[BoxData[FormBox[RowBox[{"2","x"}],TraditionalForm]]]," (or ",Cell[BoxData[FormBox[SuperscriptBox["x","2"],TraditionalForm]]],") : This replaces the last operand with its square (or double).
\t\tRecall : This causes the stored value to become an operand in the calculation.
\t\tClear all : This clears all of the contents of the screen.
\nThird Palette:
\tHelp : Brings up this box.
\tCredits : Brings up a box indicating authorship and a copyright notice. 
\n (Note that the permutation given by {2, 3, 1} means {1 -> 2, 2 -> 3, 3 -> 1}.)"}],"Text"]},ShowCellBracket->False,WindowClickSelect->True,Editable->True,Background->Automatic,WindowSize->{700,400},WindowMargins->{{Automatic,Automatic},{Automatic,Automatic}},WindowTitle->"Help",WindowFrame->"Normal",WindowElements->{},WindowFrameElements->"CloseBox"]], Evaluator->"Automatic"],
		ButtonBox[RowBox[{"Credits"}],
	ButtonFunction:>NotebookPut[  Notebook[{Cell[TextData[{"This group calculator is brought you by ",StyleForm["Exploring Abstract Algebra with Mathematica",FontSlant->"Italic"],", \[Copyright]1997 Al Hibbard  (hibbarda@central.edu) and Ken Levasseur (Kenneth_Levasseur@uml.edu). Check out the web page at ",ButtonBox["http://www.central.edu/eaam/",ButtonData:>{URL["http://www.central.edu/eaam/"],None},BaseStyle->"Hyperlink"]," for information on available labs, packages and book."}],"Text",FontSize->14]},ShowCellBracket->False,WindowClickSelect->True,Saveable->False,WindowTitle->"Credits",Editable->True,WindowSize->{425,140},WindowMargins->{{Automatic,Automatic},{Automatic,Automatic}},WindowFrame->"Normal",WindowElements->{},WindowFrameElements->"CloseBox"]],Evaluator->"Automatic"]}]],
					"Text",Enabled->True,CellMargins->{{205, -150}, {Inherited, Inherited}},ShowCellBracket->False]},WindowFrameElements->{"CloseBox",  "ResizeArea"},Background->Automatic,Saveable->False,WindowMargins->{{4,Automatic},{Automatic,4}},WindowClickSelect->True, WindowSize -> {520, Automatic}],nb2];
		NotebookLocate["screen"];
		SelectionMove[nb2,After,CellContents];]


(* ::Section:: *)
(*7. Properties Calculators*)


(* ::Subsection:: *)
(*Basics*)


Structure::error="Enter either a Groupoid or Ringoid; this is neither.";

GetStructure:=Module[{G,nb=ButtonNotebook[] (* was InputNotebook[] *)},NotebookFind[nb,"structure",All,CellTags,AutoScroll->False];
SelectionMove[nb,All,Cell,AutoScroll->False];
G=NotebookRead[nb];
G=G[[1]]//ToExpression;
If[ValidStructure[G],pushedGroup=G; pushedGroupName=AbstractAlgebra`Master`Private`StructureName[G]; G,Message[Structure::error]; $Failed]]

ValidStructure[G_]:=ValidStructure[G]=AbstractAlgebra`Master`Private`GroupoidQ[G]||AbstractAlgebra`Master`Private`RingoidQ[G]

ValidGroupoid[G_]:=ValidGroupoid[G]=AbstractAlgebra`Master`Private`GroupoidQ[G]

ValidRingoid[G_]:=ValidRingoid[G]=AbstractAlgebra`Master`Private`RingoidQ[G]

GroupCalculatorPC:= Module[{G = GetStructure},pushedGroup = G; pushedGroupName=GroupoidName[G];
GroupCalculator]

EAAMOn:=(On[Adjoin::"fail"];
On[Automorphism::"badrule"];
On[Automorphism::"nosup"];
On[AutomorphismGroup::"nosup"];
On[Characteristic::"fail"];
On[Coefficient::"ind"];
On[Conjugate::"fail"];
On[CosetToList::"illformed"];
On[Cycle::"disjoint"];
On[DirectProduct::"ArgErr"];
On[Dot::"DimErr"];
On[FormMorphoid::"badpos"];
On[FormMorphoid::"badstruc"];
On[FormRingoid::"diffels"];
On[FormRingoid::"size"];
On[FuncToRules::"invalid"];
On[GenerateGroupoid::"size"];
On[GenerateGroupoid::"size"];
On[Generator::"string"];
On[GF::"badindex"];
On[GF::"bases"];
On[GF::"deg"];
On[GF::"irr"];
On[GF::"notdef"];On[GF::"poly"];
On[GF::"var"];On[Group::"fail"];
On[Group::"noord"];On[Group::"notcyclic"];
On[Group::"notnorm"];On[Group::"size"];
On[Groupoid::"fail"];On[Groupoid::"fail"];
On[Groupoid::"modd"];On[Groupoid::"reorderfail"];
On[IdealQ::"fail"];On[Identity::"fail"];
On[Identity::"lfail"];On[Identity::"lmultiple"];
On[Identity::"nonsquare"];On[Identity::"rfail"];
On[Identity::"rmultiple"];
On[InnerAutomorphism::"noinv"];
On[InnerAutomorphismGroup::"nogroup"];
On[Inverse::"fail"];On[Inverse::"noId"];
On[IrreduciblePolynomial::"badindex"];
On[IrreduciblePolyOverZpQ::"prime"];
On[IsomorphismQ::"notHom"];On[Kernel::"noid"];
On[Klein4::"warning"];On[List::"lngth"];
On[MemberQ::"elmnt"];On[MemberQ::"elmnts"];
On[MemberQ::"elsbst"];On[MemberQ::"sbgrp"];
On[Mode::"notavail"];On[Mode::"notext"];
On[Mode::"novis"];
On[ModpIrreducibilityQ::"baddeg"];
On[ModpIrreducibilityQ::"badpoly"];
On[Morphoid::"badarg"];On[Morphoid::"dff"];
On[Morphoid::"domain"];On[Morphoid::"fail"];
On[Morphoid::"notonto"];On[Morphoid::"npres"];
On[Morphoid::"range"];
On[MorphoidComposition::"notdef"];
On[MorphoidComposition::"notdef2"];
On[Multiplication::"fail"];On[Operation::"fail"];
On[PermutationQ::"diffels"];
On[PermutationQ::"difflen"];
On[PermutationQ::"duplicates"];
On[PermutationQ::"fail"];
On[PermutationQ::"length"];On[PermutationQ::"missing"];On[PermutationQ::"notrule"];On[Poly::"badInd"];On[Poly::"bragrm"];On[Poly::"extagrm"];On[Poly::"mixvars"];On[PolynomialDivision::"undef"];On[PolynomialGCD::"undefined"];On[PolynomialsOfDegreeN::"toobig"];On[ProbableMorphismQ::"warning"];On[QuaternionGroup::"JJKK"];On[QuotientGroup::"badrep"];On[QuotientGroup::"NS"];On[QuotientGroup::"replngth"];On[QuotientRing::"badz"];On[QuotientRing::"J"];On[QuotientRing::"notideal"];On[QuotientRing::"NS"];On[QuotientRing::"toobig"];On[Random::"notype"];On[Random::"toomany"];On[RandomElement::"fail"];On[RandomElement::"gfail"];On[RandomElement::"sqrfree"];On[RandomElements::"toomany"];On[RandomElements::"toomanyk"];On[RandomElements::"toomanyni"];On[Ring::"fail"];On[Ring::"subringfail"];On[RingExtension::"NoInverse"];On[RingExtension::"NoNegat"];On[RingExtension::"NotBaseElement"];On[RingExtension::"NoUnity"];On[RingExtension::"NoZero"];On[Ringoid::"NotUnit"];On[Rule::"form"];On[SizeLimit::"toobig"];On[Structure::"nosup"];On[TheSet::"error"];On[UnitQ::"nounity"];On[ZdNorm::"int"];On[ZdNorm::"one"];On[ZdNorm::"sqfree"];On[ZeroDivisors::"NA"];On[ZMap::"relpr"];On[Center::fail];)

EAAMOff:=(Off[Adjoin::"fail"];
Off[Automorphism::"badrule"];
Off[Automorphism::"nosup"];
Off[AutomorphismGroup::"nosup"];
Off[Characteristic::"fail"];
Off[Coefficient::"ind"];
Off[Conjugate::"fail"];Off[CosetToList::"illformed"];Off[Cycle::"disjoint"];Off[DirectProduct::"ArgErr"];Off[Dot::"DimErr"];Off[FormMorphoid::"badpos"];Off[Center::fail];Off[FormMorphoid::"badstruc"];Off[FormRingoid::"diffels"];Off[FormRingoid::"size"];Off[FuncToRules::"invalid"];Off[GenerateGroupoid::"size"];Off[GenerateGroupoid::"size"];Off[Generator::"string"];Off[GF::"badindex"];Off[GF::"bases"];Off[GF::"deg"];Off[GF::"irr"];Off[GF::"notdef"];Off[GF::"poly"];Off[GF::"var"];Off[Group::"fail"];Off[Group::"noord"];Off[Group::"notcyclic"];Off[Group::"notnorm"];Off[Group::"size"];Off[Groupoid::"fail"];Off[Groupoid::"fail"];Off[Groupoid::"modd"];Off[Groupoid::"reorderfail"];Off[IdealQ::"fail"];Off[Identity::"fail"];Off[Identity::"lfail"];Off[Identity::"lmultiple"];Off[Identity::"nonsquare"];Off[Identity::"rfail"];Off[Identity::"rmultiple"];Off[InnerAutomorphism::"noinv"];Off[InnerAutomorphismGroup::"nogroup"];Off[Inverse::"fail"];Off[Inverse::"noId"];Off[IrreduciblePolynomial::"badindex"];Off[IrreduciblePolyOverZpQ::"prime"];Off[IsomorphismQ::"notHom"];Off[Kernel::"noid"];Off[Klein4::"warning"];Off[List::"lngth"];Off[MemberQ::"elmnt"];Off[MemberQ::"elmnts"];Off[MemberQ::"elsbst"];Off[MemberQ::"sbgrp"];Off[Mode::"notavail"];Off[Mode::"notext"];Off[Mode::"novis"];Off[ModpIrreducibilityQ::"baddeg"];Off[ModpIrreducibilityQ::"badpoly"];Off[Morphoid::"badarg"];Off[Morphoid::"dff"];Off[Morphoid::"domain"];Off[Morphoid::"fail"];Off[Morphoid::"notonto"];Off[Morphoid::"npres"];Off[Morphoid::"range"];Off[MorphoidComposition::"notdef"];Off[MorphoidComposition::"notdef2"];Off[Multiplication::"fail"];Off[Operation::"fail"];Off[PermutationQ::"diffels"];Off[PermutationQ::"difflen"];Off[PermutationQ::"duplicates"];Off[PermutationQ::"fail"];Off[PermutationQ::"length"];Off[PermutationQ::"missing"];Off[PermutationQ::"notrule"];Off[Poly::"badInd"];Off[Poly::"bragrm"];Off[Poly::"extagrm"];Off[Poly::"mixvars"];Off[PolynomialDivision::"undef"];Off[PolynomialGCD::"undefined"];Off[PolynomialsOfDegreeN::"toobig"];Off[ProbableMorphismQ::"warning"];Off[QuaternionGroup::"JJKK"];Off[QuotientGroup::"badrep"];Off[QuotientGroup::"NS"];Off[QuotientGroup::"replngth"];Off[QuotientRing::"badz"];Off[QuotientRing::"J"];Off[QuotientRing::"notideal"];Off[QuotientRing::"NS"];Off[QuotientRing::"toobig"];Off[Random::"notype"];Off[Random::"toomany"];Off[RandomElement::"fail"];Off[RandomElement::"gfail"];Off[RandomElement::"sqrfree"];Off[RandomElements::"toomany"];Off[RandomElements::"toomanyk"];Off[RandomElements::"toomanyni"];Off[Ring::"fail"];Off[Ring::"subringfail"];Off[RingExtension::"NoInverse"];Off[RingExtension::"NoNegat"];Off[RingExtension::"NotBaseElement"];Off[RingExtension::"NoUnity"];Off[RingExtension::"NoZero"];Off[Ringoid::"NotUnit"];Off[Rule::"form"];Off[SizeLimit::"toobig"];Off[Structure::"nosup"];Off[TheSet::"error"];Off[UnitQ::"nounity"];Off[ZdNorm::"int"];Off[ZdNorm::"one"];Off[ZdNorm::"sqfree"];Off[ZeroDivisors::"NA"];Off[ZMap::"relpr"];)


(* ::Subsection:: *)
(*Palette of elements*)


MakeElementGrid[G_]:=Module[{els=Elements[G]},Cell[BoxData[GridBox[Prepend[Table[{ButtonBox[ToBoxes[els[[i]]]]},{i,Length[els]}],{ButtonBox[pushedGroupName,ButtonFunction:>Null,ButtonNote->"elements of structure",Background->RGBColor[1,0.749996,0.8]]}],RowSpacings->0,ColumnSpacings->0,RowLines->True,ColumnLines->True]],NotebookDefault,Enabled->True]]


FormElements:=Module[{G,els,out},
	G=GetStructure;
	If[ValidStructure[G],
		NotebookPut[Notebook[{MakeElementGrid[G]},WindowToolbars->{},PageWidth->402,WindowSize->{Fit,Fit},WindowMargins->{{4,Automatic},{4,Automatic}},WindowFrame->"Palette",CellMargins->{{0,0},{Inherited,0}},WindowFrameElements->"CloseBox",WindowElements->{},WindowClickSelect->False,Enabled->True,ScrollingOptions->{"PagewiseScrolling"->True},ShowCellBracket->False,CellMargins->{{0,0},{Inherited,0}}]];
SetSelectedNotebook[ButtonNotebook[]]]]


(* ::Subsection:: *)
(*Group Element properties*)


ElementInformation:=Module[{G, H},H=GetStructure; ElementInformationWork[H]]

ElementInformationWork[G_]:=Module[{els,n,table,H,propn,properties,blankrow,nb,funcs,FillInColumn2,FillInRow}, 
	If[ValidGroupoid[G],
		properties={"left\ninverse","right\ninverse","inver-\ntible?",If[OperatorSymbol[G]==="+","2x","\!\(x\^2\)"],"order","conjugacy\nclass","centra-\nlizer","subgroup\ngenerated"}; 
		els=Elements[G]; 
		funcs:={LeftInverse[G,#1]&,RightInverse[G,#1]&,InvertibleQ[G,#1]&,Operation[G][#1,#1]&,OrderOfElement[G,#1]&,ConjugacyClass[G,#1]&,Elements[Centralizer[G,#1]]&,Elements[SubgroupGenerated[G,#]]&}; 
		n=Length[els]; 
		propn=Length[properties]; 
		blankrow=Table["?",{propn}];
		DoAllRows[]:=Do[FillInRow[k],{k,1,n}];
		FillInRow[n_]:=Module[{nb2,vals,old,oldin,new,m=n+1},
			EAAMOff;
			nb2=ButtonNotebook[]; 
			NotebookFind[nb2,"table",All,CellTags,AutoScroll->False]; 
			SelectionMove[nb2,All,Cell,AutoScroll->False]; 
			old=NotebookRead[nb2]; 
			oldin=old[[1,1,1]]; 
			new=Join[Table[oldin[[i]],{i,1,m-1}],{Join[{oldin[[m,1]]},(ToBoxes[#1[els[[n]]]]&)/@funcs]},Table[oldin[[i]],{i,m+1,Length[els]+1}]]; 
			old=ReplacePart[old,new,{1,1,1}]; 
			NotebookWrite[nb2,old,AutoScroll->False];
			EAAMOn;]; 
		FillInColumn2[n_,f_]:=Module[{nb2,vals,old,oldin,new,m=propn+1,opts},
			EAAMOff;
			nb2=ButtonNotebook[]; 
			NotebookFind[nb2,"table",All,CellTags,AutoScroll->False]; 
			SelectionMove[nb2,All,Cell,AutoScroll->False]; 
			old=NotebookRead[nb2]; oldin=old[[1,1,1]]; 
			new=Transpose[Join[Table[Transpose[oldin][[i]],{i,1,n-1}],{Join[{oldin[[1,n]]},(ToBoxes[f[#1]]&)/@els]},Table[Transpose[oldin][[i]],{i,n+1,m}]]]; 
			old=ReplacePart[old,new,{1,1,1}]; 
			NotebookWrite[nb2,old,AutoScroll->False];
			EAAMOn;]; 
		table=GridBox[Prepend[(Prepend[blankrow,ButtonBox[ToBoxes[#1],ButtonFunction:>FillInRow[First[First[Position[els,#1,1]]]],Evaluator->Automatic,ButtonNote->"fills in row",Background->RGBColor[1,0,1]]]&)/@els,Prepend[(ButtonBox[#1[[1]],Evaluator->Automatic,ButtonNote->"fills in column",Background->RGBColor[0,1,1],ButtonFunction:>FillInColumn2[#1[[2]],#1[[3]]]]&)/@Transpose[{properties,Range[2,propn+1],funcs}],ButtonBox["Do All",ButtonFunction:>DoAllRows[],Evaluator->Automatic,ButtonNote->"fills in table",Background->RGBColor[1,0.75,0.8]]]],RowSpacings->0,ColumnSpacings->0,RowLines->True,GridFrame->True,GridFrameMargins->False,ColumnLines->True]; 
		nb=ButtonNotebook[]; (* was InputNotebook[] *)
		SelectionMove[nb,After,Cell,AutoScroll->False]; 
		NotebookPut[Notebook[{Cell["Element Properties","Section",ShowCellBracket->False],Cell["Clicking on a Magenta-colored button containing an element fills in the row of values for each of the properties at the top.\nSimilarly, clicking on a Cyan-colored button containing a property will fill in values for this property applied to each element.\nFinally, clicking on the 'Do All' button in pink will do all the rows with one click.","Text",ShowCellBracket->False],
		Cell[BoxData[table],NotebookDefault,Enabled->True,CellTags->"table",ShowCellBracket->False,CellMargins->{{0,0},{Inherited,0}}]},WindowSize->{FitAll,FitAll},WindowMargins->{{50,Automatic},{4,Automatic}},WindowTitle->"ElementPropertiesIn"<>AbstractAlgebra`Master`Private`StructureName[G]]];]]


(* ::Subsection:: *)
(*Group properties*)


GroupInformation:=Module[{H}, H=GetStructure;GroupInformationWork[H]]

GroupInformationWork[G_]:=Module[{els,n,table,H,propn,properties,blankrow,nb,funcs,FillInColumn2,FillInRow}, 
	If[ValidGroupoid[G],
		properties={"closed?","has identity?","has inverses?","associative?","group?","abelian?","has left identity?","left identity","has right identity?","right identity","non-associating triples","order","non-commuting pairs","commutators","commutator subgroup","center","cyclic?","cyclic generators","group exponent"}; 
		els=Elements[G]; 
		funcs:={ClosedQ,HasIdentityQ,HasInversesQ,AssociativeQ,GroupQ,AbelianQ,HasLeftIdentityQ,LeftIdentity,HasRightIdentityQ,RightIdentity,NonAssociatingTriples,Order,NonCommutingPairs,Commutators,Elements[CommutatorSubgroup[#]]&,GroupCenter,CyclicQ,CyclicGenerators,GroupExponent}; 
		n=Length[els]; 
		propn=Length[properties]; 
		blankrow=Table["?",{propn}]; 
		DoAllRows[]:= Do[FillInRow[k,funcs[[k]]],{k,1, Length[funcs]}];
		FillInRow[n_,f_]:=Module[{nb,vals,old,oldin,new,pos=n+1, m=n},
			EAAMOff;
			nb=ButtonNotebook[]; 
			NotebookFind[nb,"table",All,CellTags,AutoScroll->False]; 
			SelectionMove[nb,All,Cell,AutoScroll->False]; 
			old=NotebookRead[nb]; 
			oldin=old[[1,1,1]]; 
			new=Join[Table[oldin[[i]],{i,1,pos-1}],{Join[{oldin[[pos,1]]},{ToBoxes[funcs[[m]][G]]}]},Table[oldin[[i]],{i,pos+1,Length[funcs]+1}]]; 
			old=ReplacePart[old,new,{1,1,1}]; 
			NotebookWrite[nb,old,AutoScroll->False];
			EAAMOn;]; 
		table=GridBox[Prepend[Map[{ButtonBox[ToBoxes[#1[[1]]],ButtonFunction:>FillInRow[#[[3]],#[[2]]],Evaluator->Automatic,ButtonNote->"fills in row",Background->RGBColor[0,1,1]],"?"}&,Transpose[{properties,funcs,Range[1,Length[funcs]]}]],{ButtonBox["Do All",ButtonFunction:>DoAllRows[],Evaluator->Automatic,ButtonNote->"fills in table",Background->RGBColor[1,0.75,0.8]],""}],RowSpacings->0,ColumnSpacings->0,RowLines->True,GridFrame->True,GridFrameMargins->False,ColumnLines->True,ColumnAlignments->{Left}]; 
		nb=ButtonNotebook[]; (* was InputNotebook[] *)
		SelectionMove[nb,After,Cell,AutoScroll->False]; 
		NotebookPut[Notebook[{Cell["Group Properties","Section",ShowCellBracket->False],
		Cell["Clicking on a Cyan-colored button containing a property fills in the value of this property for the chosen group.\nAlternatively, clicking on the 'Do All' button will perform all the clicks and fill in each value.","Text",ShowCellBracket->False],
		Cell[BoxData[table],NotebookDefault,Enabled->True,CellTags->"table",ShowCellBracket->False,CellMargins->{{0,0},{Inherited,0}}]},WindowSize->{FitAll,FitAll},WindowMargins->{{50,Automatic},{4,Automatic}},WindowTitle->"PropertiesIn"<>AbstractAlgebra`Master`Private`StructureName[G]]];]]


(* ::Subsection:: *)
(*Ring Element properties*)


RElementInformation:=Module[{G,els,n,table,H,propn,properties,blankrow,nb,funcs,FillInColumn2,FillInRow},
	H=GetStructure; 
	G:=H; 
	If[ValidRingoid[G],
		properties={"has\nnegative?","negative\nof","unit?","multiplicative\ninverse","\!\(x\^2\)","zero\ndivisor?","idempo\ntent?","nilpo-\ntent?"}; 
		els=Elements[G]; 
		funcs:={HasNegativeQ[G,#1]&,NegationOf[G,#1]&,InvertibleQ[G,#1,Operation->Multiplication]&,MultiplicativeInverse[G,#1]&,Multiplication[G][#1,#1]&,ZeroDivisorQ[G,#1]&,IdempotentQ[G,#1]&,NilpotentQ[G,#1]&}; 
		n=Length[els]; 
		propn=Length[properties]; 
		blankrow=Table["?",{propn}]; 
		FillInRow[n_]:=Module[{nb,vals,old,oldin,new,m=n+1},nb=ButtonNotebook[]; NotebookFind[nb,"table",All,CellTags,AutoScroll->False]; SelectionMove[nb,All,Cell,AutoScroll->False]; old=NotebookRead[nb]; oldin=old[[1,1,1]]; new=Join[Table[oldin[[i]],{i,1,m-1}],{Join[{oldin[[m,1]]},(ToBoxes[#1[els[[n]]]]&)/@funcs]},Table[oldin[[i]],{i,m+1,Length[els]+1}]]; old=ReplacePart[old,new,{1,1,1}]; NotebookWrite[nb,old,AutoScroll->False]]; 
		FillInColumn2[n_,f_]:=Module[{nb,vals,old,oldin,new,m=propn+1,opts},nb=ButtonNotebook[]; NotebookFind[nb,"table",All,CellTags,AutoScroll->False]; SelectionMove[nb,All,Cell,AutoScroll->False]; old=NotebookRead[nb]; oldin=old[[1,1,1]]; new=Transpose[Join[Table[Transpose[oldin][[i]],{i,1,n-1}],{Join[{oldin[[1,n]]},(ToBoxes[f[#1]]&)/@els]},Table[Transpose[oldin][[i]],{i,n+1,m}]]]; old=ReplacePart[old,new,{1,1,1}]; NotebookWrite[nb,old,AutoScroll->False]]; 
		table=GridBox[Prepend[(Prepend[blankrow,ButtonBox[ToBoxes[#1],ButtonFunction:>FillInRow[First[First[Position[els,#1,1]]]],Evaluator->Automatic,ButtonNote->"fills in row",Background->RGBColor[1,0,1]]]&)/@els,Prepend[(ButtonBox[#1[[1]],Evaluator->Automatic,ButtonNote->"fills in column",Background->RGBColor[0,1,1],ButtonFunction:>FillInColumn2[#1[[2]],#1[[3]]]]&)/@Transpose[{properties,Range[2,propn+1],funcs}],ButtonBox["elements",RuleDelayed[ButtonFunction,Null],Rule[Background,RGBColor[1,0.75,0.8]]]]],RowSpacings->0,ColumnSpacings->0,RowLines->True,GridFrame->True,GridFrameMargins->False,ColumnLines->True]; 
		nb=ButtonNotebook[]; (* was InputNotebook[] *)
		SelectionMove[nb,After,Cell,AutoScroll->False]; 
		NotebookPut[Notebook[{Cell[BoxData[table],NotebookDefault,Enabled->True,CellTags->"table",ShowCellBracket->False,CellMargins->{{0,0},{Inherited,0}}]},WindowSize->{FitAll,FitAll},WindowMargins->{{50,Automatic},{4,Automatic}},WindowTitle->AbstractAlgebra`Master`Private`StructureName[G]]];]]


(* ::Subsection:: *)
(*Ring properties*)


RingInformation:=Module[{G,els,n,table,H,propn,properties,blankrow,nb,funcs,FillInColumn2,FillInRow},
	H=GetStructure; 
	G:=H; 
	If[ValidRingoid[G],
		properties={"addition closed?","multiplication closed?","has zero?","zero element","has unity?","unity element","additive inverses?","multiplicative inverses?","addition associative?","multiplication associative?","addition commutative?","multiplication commutative?","distributive?","ring?","units","idempotents","nilpotents","field?","integral domain?","characteristic"}; 
		els=Elements[G]; 
		funcs:={ClosedQ[#,Operation->Addition]&,ClosedQ[#,Operation->Multiplication]&,HasZeroQ,Zero,WithUnityQ,Unity,HasInversesQ[#,Operation->Addition]&,HasInversesQ[#,Operation->Multiplication]&,AssociativeQ[#,Operation->Addition]&,AssociativeQ[#,Operation->Multiplication]&,CommutativeQ[#,Operation->Addition]&,CommutativeQ[#,Operation->Multiplication]&,DistributiveQ,RingQ,Units,Idempotents,Nilpotents,FieldQ,IntegralDomainQ,Characteristic}; 
		n=Length[els]; 
		propn=Length[properties]; 
		blankrow=Table["?",{propn}]; 
		FillInRow[n_,f_]:=Module[{nb,vals,old,oldin,new,m=n},nb=ButtonNotebook[]; NotebookFind[nb,"table",All,CellTags,AutoScroll->False]; SelectionMove[nb,All,Cell,AutoScroll->False]; old=NotebookRead[nb]; oldin=old[[1,1,1]]; new=Join[Table[oldin[[i]],{i,1,m-1}],{Join[{oldin[[m,1]]},{ToBoxes[funcs[[m]][G]]}]},Table[oldin[[i]],{i,m+1,Length[funcs]}]]; old=ReplacePart[old,new,{1,1,1}]; NotebookWrite[nb,old,AutoScroll->False]]; 
		table=GridBox[Map[{ButtonBox[ToBoxes[#1[[1]]],ButtonFunction:>FillInRow[#[[3]],#[[2]]],Evaluator->Automatic,ButtonNote->"fills in row",Background->RGBColor[0,1,1]],"?"}&,Transpose[{properties,funcs,Range[1,Length[funcs]]}]],RowSpacings->0,ColumnSpacings->0,RowLines->True,GridFrame->True,GridFrameMargins->False,ColumnLines->True,ColumnAlignments->{Left}]; 
		nb=ButtonNotebook[]; 
		SelectionMove[nb,After,Cell,AutoScroll->False]; 
		NotebookPut[Notebook[{Cell[BoxData[table],NotebookDefault,Enabled->True,CellTags->"table",ShowCellBracket->False,CellMargins->{{0,0},{Inherited,0}}]},WindowSize->{FitAll,FitAll},WindowMargins->{{50,Automatic},{4,Automatic}},WindowTitle->AbstractAlgebra`Master`Private`StructureName[G]]];]]


(* ::Section:: *)
(* 8. Core parts*)


(* ::Subsection:: *)
(*global variables/constants*)


ComputationalMouseovers = True;


$FormatType = OutputForm;
(* to speed up graphics  in version 3.0 *)

If[$VersionNumber < 3.0, StandardForm = OutputForm];
(* to override above, where needed *)

(* $TextStyle = {FontSize -> 9};*)

InStdForm = If[$VersionNumber < 3.0, InputForm, StandardForm];
OutStdForm = If[$VersionNumber < 3.0, OutputForm, StandardForm];

DefaultStructure = Group;

DefaultOrder = RightToLeft;

defaultFont = {"Times", 12};

Off[Graphics::optx]; (* only needed for Version 2.2  to handle not
knowing FormatType option to Graphics *)

VisualTextShown = 2; 
(* how often to show text when Visual mode is used *)

multipleQ = False; (* flag showing whether multiple arguments *)
firstPassQ = True;

BackgroundColors = {Yellow, Orange, ColorData["Legacy", "Violet"], Blue, ColorData["Legacy", "Mint"], 
ColorData["Legacy", "Turquoise"],
ColorData["Legacy", "EmeraldGreen"], RGBColor[0.`,0.392193`,0.`], Pink, RGBColor[0.678396`,0.847102`,0.902005`],
ColorData["Legacy", "Banana"], Green, Brown,
Gray, Red, Purple, ColorData["Legacy", "CadmiumYellow"], ColorData["Legacy", "Maroon"], ColorData["Legacy", "Navy"], ColorData["Legacy", "Salmon"], ColorData["Legacy", "Aquamarine"],
ColorData["Legacy", "Indigo"], ColorData["Legacy", "Lavender"], ColorData["Legacy", "Antique"], ColorData["Legacy", "Bisque"], ColorData["Legacy", "Burlywood"], ColorData["Legacy", "Eggshell"], ColorData["Legacy", "Khaki"],
ColorData["Legacy", "BlueViolet"], ColorData["Legacy", "CadmiumOrange"], RGBColor[0.889996`,0.089999`,0.050005`],
ColorData["Legacy", "Cerulean"], ColorData["Legacy", "Chartreuse"],
Cyan, ColorData["Legacy", "DeepPink"], Magenta, ColorData["Legacy", "OrangeRed"], ColorData["Legacy", "Peacock"], 
RGBColor[0.`,0.749`,1.`],
RGBColor[0.`,0.807794`,0.819605`], ColorData["Legacy", "Ultramarine"]};

(* Legacy color names were modified with the ColorData command using "Legacy" 8/26/08 
some did not come through:
GreenDark = RGBColor[0.`,0.392193`,0.`]
BlueLight = RGBColor[0.678396`,0.847102`,0.902005`]
CadmiumRedDeep = RGBColor[0.889996`,0.089999`,0.050005`]
SkyBlueDeep = RGBColor[0.`,0.749`,1.`]
TurquoiseDark = RGBColor[0.`,0.807794`,0.819605`]
*)

BackgroundColors = Join[BackgroundColors,BackgroundColors,BackgroundColors];

PrintingBackgroundColors = BackgroundColors;

OtherColors = {Yellow, Orange, Red, Brown, Blue, ColorData["Legacy", "Mint"], Cyan, Green,
 Purple, RGBColor[0.747, 0.885, 0.977], ColorData["Legacy", "Antique"], RGBColor[1, .72, 1], 
 Magenta, RGBColor[.54,1,0]};

PrintingOtherColors = {Orange, Orange, Red, Brown, Blue, ColorData["Legacy", "Mint"], Cyan, 
Green, Purple, RGBColor[0.747, 0.885, 0.977], ColorData["Legacy", "Antique"], RGBColor[1, .72, 1], 
Magenta, RGBColor[.54,1,0]};

GoodElementsColor = ColorData["HTML"]["LawnGreen"];
BadElementsColor = ColorData["HTML"]["Tomato"];

visualModes = {Visual, Visual2, Visual3};

Options[HelpMessages] = {WindowMargins -> {{40,Automatic},{Automatic,40}},
	WindowSize->{620, All}, Magnification -> 1.5, ShowHelp->True, 
	ShowConvert->True};

ShowVisualMessage[{arglist___},helpName_]:= Module[{show},
	show = ShowHelp/.Options[HelpMessages];
	If[show,Tooltip[Button[Style["?",White,Small], helpName[arglist],
		Background->Brown, BaseStyle -> Small, BaselinePosition->Bottom(*ImageSize->Tiny,*)],"Click for further explanation of the image"],""]
]

ChangeModeToComputational[mode_,line_]:=
	Module[{nb,cellcontents, nbfind, found = False},nb=ButtonNotebook[];
		NotebookFind[nb,"Out["<>ToString[line]<>"]=",All,CellLabel,AutoScroll->False];
	SelectionMove[nb,Previous,CellContents,AutoScroll->False];
	SelectionMove[nb,Before,CellContents,AutoScroll->False];
	nbfind = NotebookFind[nb, mode, Next, CellContents, AutoScroll -> False];
	If[nbfind === $Failed, nbfind = NotebookFind[nb, "Textual", Next, CellContents, AutoScroll -> False]];
	If[nbfind === $Failed, nbfind = NotebookFind[nb, "Visual", Next, CellContents, AutoScroll -> False]];
	If[nbfind === $Failed, nbfind = NotebookFind[nb, "Visual2", Next, CellContents, AutoScroll -> False]];
	If[nbfind === $Failed, nbfind = NotebookFind[nb, "All", Next, CellContents, AutoScroll -> False]];
	If[nbfind === $Failed, nbfind = NotebookFind[nb, "Interactive", Next, CellContents, AutoScroll -> False]];
	NotebookWrite[nb,"Computational"];
	SelectionMove[nb,All, Cell];
	SelectionEvaluate[nb,After]
]

MakeComputationalButton[mode_]:=
	With[{line=$Line},Tooltip[Button[Style["\[RightArrow]",Small, White],
		ChangeModeToComputational[mode,line],
		Background-> Brown,ImageSize->Tiny, BaselinePosition->Bottom],
		"In the input, convert \"Mode \[RightArrow] "<>ToString[mode]<>"\" to \"Mode \[RightArrow] Computational\" and reevaluate"]]
(*Convert the Mode to Computational*)

DoVisualization[visual_,visMessArgs_List,opts___?OptionQ]:= 
	Module[{showhelp1,showhelp,showcomp, cm},
		showhelp = ShowHelp/.Flatten[{opts, Options[HelpMessages]}];
		showcomp = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
		cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Visual"}];
	If[showhelp || showcomp,
	Column[{
		visual,Grid[If[showhelp && showcomp,{{ShowVisualMessage[Sequence@@visMessArgs],
	MakeComputationalButton[cm]}},If[showhelp,{{ShowVisualMessage[Sequence@@visMessArgs]}},
	If[showcomp,{{MakeComputationalButton[cm]}}]]],ItemSize->All, Spacings -> 0,
		BaselinePosition->Bottom]},Center],
		visual]]

DoHelpMessage[windowtitle->wt_,help-> help_]:= Module[{wm, ws,mag},
	wm = WindowMargins/.Options[HelpMessages];
	ws = WindowSize/.Options[HelpMessages];
	mag = Magnification/.Options[HelpMessages];
	NotebookPut[Notebook[{Cell[TextData[help],"Text",
		ShowCellBracket->False, FontFamily->"Times", CellMargins->5]},WindowSize->ws, WindowMargins->wm,
		WindowTitle->wt, Magnification->mag ]]
]

InteractiveThroughGroups[function_, G_,  InteractiveMode->mode_, opts___?OptionQ]:=
	Module[{min, max,showhelp,nm, index="Al", info},
	info = GroupoidNameToInfo[GroupoidName[G]];
	If[Length[info]===2,{nm,index}=info,nm=info];
If[Head[index] === Integer && index > 0,
	min = Min/.Flatten[{opts, Options[AbelianQInteractive]}];
	max = Max/.Flatten[{opts, Options[AbelianQInteractive]}];
	showhelp = ShowHelp/.Flatten[{opts, Options[HelpMessages]}];
	If[mode===Visual || mode===Textual,
		Manipulate[function[ToExpression[nm<>"["<>ToString[k]<>"]"], Mode -> mode, ShowHelp->showhelp, opts],{{k, index, "n"}, min, max, 1,
	Appearance->"Open"}],
		Manipulate[function[ToExpression[nm<>"["<>ToString[k]<>"]"], Mode -> mode],{{k, index, "n"}, min, max, 1,
	Appearance->"Open"}]],
$Failed]
]

GroupoidNameToInfo[nm_String]:=Module[{findleftsq, nam, index},
	findleftsq=StringPosition[nm,"["]//Flatten;
	If[Length[findleftsq]>0,findleftsq=First[findleftsq],findleftsq=0];
If[findleftsq==0,
	{},
	{StringTake[nm,findleftsq-1],ToExpression[StringTake[nm,{findleftsq+1,StringLength[nm]-1}]]}
]]



(* ::Subsection:: *)
(*core functions*)


UnionNoSort[lst_] := Apply[Head[lst],Fold[If[MemberQ[#1,#2],#1,
	Append[#1,#2]]&, {First[lst]}, Rest[lst]]]
	
UnionNoSort[first_, rest__] := 
	If[{Head[first]} === Union[Map[Head,{rest}]],
		Apply[Head[first],UnionNoSort[Flatten[Map[Apply[List,#]&,
		{first, rest}],1]]]]

ComplementNoSort[orig_?VectorQ, remove__?VectorQ] := 
	Fold[DeleteCases, orig, Union[remove]]
	
ComplementNoSort[orig_, remove__] := 
	If[{Head[orig]} === Union[Map[Head,{remove}]],
		Apply[Head[orig],Fold[DeleteCases, Apply[List,orig], 
			Union[Flatten[Map[Apply[List,#]&, {remove}],1]]]]]

CartesianProduct[els1_List,els2_List] :=
	Distribute[{els1,els2},List]
	
CartesianProduct[els1_List,els2_List, Partition-> True] :=
	Partition[CartesianProduct[els1,els2],Length[els2]]

CartesianProduct[els1_List,els2_List, Partition-> False] :=
	CartesianProduct[els1,els2]

CartesianProduct[lists__] :=
	Distribute[List[lists],List]

CloseSets[list1_List,list2_List,op_] := 
	Apply[op,CartesianProduct[list1,list2],{1}]//UnionNoSort
	
gtxQ[n_Integer?Positive, x_Integer] := n > x
gt2Q[n_Integer?Positive] := gtxQ[n,2]
gtyQ[y_Integer?Positive] := (# > y)&
ltyQ[y_Integer?Positive] := (# < y)&

Randomize[S_List]:= 
    Map[S[[#]]&,RandomPermutationAA[Length[S]]];

showVisTextQ[fn_] := Module[{ok},
	ok = firstPassQ && Which[VisualTextShown === Infinity, True,
		VisualTextShown <= 0, False,
		True, If[Head[visualTextCount[fn]] === visualTextCount,
					visualTextCount[fn] = 1, 
					visualTextCount[fn]++];
			If[visualTextCount[fn] > VisualTextShown,
				False, True]];
	If[multipleQ && firstPassQ, firstPassQ = False];
	ok]

printOtherKey[Els_List] := Module[{fff,rules},
	fff[x_,{n_}] := Rule[ToString[n], x];
	rules = MapIndexed[fff, Els];
	Print[ToString[Join[{Rule["KEY: number",
	"element: "]},rules/.Rule[x_,y_]:> Rule[x,InputForm[y]]]]];
		]

MakeSubstitutionRules[G_, Els_List, lab_String:"g"] := 
Module[{fff, x, n, out},
	fff[x_,{n_}] := Rule[lab<>ToString[n],x];
	out = MapIndexed[fff, Els];
	KeyRules[G] = out]

ConvertGridToKeyed[G_,grid_]:=Module[{els=Elements[G],rules},
	rules =Map[Reverse,MakeSubstitutionRules[G,els,"g"]];
	rules = rules/.Rule[x_,y_]-> Rule[StandardForm[x],y];
	grid/.rules
]

showkeyQ[G_,opts___]:=Module[{showkey,wide,SKopt},
	If[Length[{opts}]> 0,showkey = ShowKey/.{opts};SKopt=True,SKopt=False ];
	If[SKopt && showkey===ShowKey,SKopt = False];
	If[Not[SKopt && (showkey===True || showkey===False)],
	showkey = WideElementsQ[G]];
showkey ]

ChangeItemCayleyForm[item_,newForm_]:=
	item/.Item[form_[el_],opts___]-> Item[newForm[el],opts]

ChangeItemBackground[item_,newColor_]:=
	item/.Rule[Background,_]-> Rule[Background,newColor]

ChangeItemBackgroundElement[Item[el_,opts___],ColorFunc_]:=
	Item[el,opts]/.Rule[Background,_]-> Rule[Background,ColorFunc[el]]

PrintCayleyKeyQ = True;

PrintCayleyKey[Els_List,name_,G_,form_,lab_String:"g"] := 
	Module[{rules,
		nform},
	nform = If[Head[form] === KeyForm, InputForm, form];
	rules = MakeSubstitutionRules[G,Els, lab];
	If[PrintCayleyKeyQ,
		Print["KEY for "<>ToString[name]<>": label used "<>
		If[$VersionNumber >2.5, "\[Rule]","->"]<>" element: "<>
		StringRules[rules,nform]],
		PrintCayleyKeyQ = True];]

TextCayleyKey[Els_List,name_,G_,form_,lab_String:"g"] := 
	Module[{rules, txt,
		nform},
	nform = If[Head[form] === KeyForm, InputForm, form];
	rules = MakeSubstitutionRules[G,Els, lab];
	If[PrintCayleyKeyQ,
		txt = "KEY for "<>ToString[name]<>": label used "<>
		If[$VersionNumber >2.5, "\[Rule]","->"]<>" element: "<>
		StringRules[rules,nform],
		PrintCayleyKeyQ = True;]]

StringRules[rules_, form_] := Module[{lst},
		lst = rules /. Rule[x_,y_] :> Rule[x,ToString[form[y]]];
		If[$VersionNumber < 2.5, ToString[lst],
			lst = lst /. Rule[x_, y_] :> x<>" \[Rule] "<>y;
			lst = "{"<>Table[lst[[i]]<>", ",{i,Length[lst]-1}]<>
			lst[[Length[lst]]]<>"}"]]
 
genericSublist[els_List, sub_List, lab_:"g"] := 
		Module[{temp},
	temp = Transpose[{els,Table[lab<>ToString[i],
		{i,Length[els]}]}];
	Select[temp, MemberQ[sub,#[[1]]]&]//Transpose//Last
]
(* This is useful for finding the corresponding 'g' labels
for a sublist of a Groupoid whose elements are wide. *)

KeyToElement[G_, key_] := (If[untestedQ[KeyRules[G]], 
	KeyRules[G] = Map[Rule[#,#]&, Elements[G]]];
	If[Head[key]===String, key, ToString[key]] /. KeyRules[G])
	
ElementToKey[G_, el_] := (If[untestedQ[KeyRules[G]], 
	KeyRules[G] = Map[Rule[#,#]&, Elements[G]]];
	Hold[el] /. (Map[Reverse,KeyRules[G]]/. Rule[a_, b_] :> 
		Rule[Hold[a],b]))

headingsRectanglesForSublist[els_List, sub_List] := 
		Module[{temp,len = Length[els]},
	temp = Transpose[{els,Table[Rectangle[{i, len},
		{i+1, len+1}],{i,0,len-1}]}];
	Select[temp, MemberQ[sub,#[[1]]]&]//Transpose//Last
]
(* This is useful for finding the rectangles used in the top
headings for a sublist of a Groupoid. *)

SetAttributes[untestedQ, HoldAll];	

untestedQ[thefunction_[args___]] := 
		Head[Evaluate[thefunction[args]]] === thefunction;
(* used to see if a private function has been 'called' 
(actually, whether the array value thefunction[args] has anything
assigned to it or not) *)

headingsGrid[data_List, headings_List,loc_:Top]:=
	If [loc ===Top,
		Grid[Prepend[data,Map[Item[Style[#,Blue,Larger],Background -> Yellow]&,headings]],Frame -> All],
		If[loc===Left,
			Grid[Transpose@Prepend[Transpose@data,Map[Item[Style[#,Blue,Larger],Background -> Yellow]&,headings]],Frame -> All]]
	]


SubsetQAA[sub_List, main_List] := Module[{i=1,len,ok=True},
	len = Length[sub];
	While[ok && i<=len,
		ok = ok && MemberQ[main,sub[[i]]];
		i++];
	ok]
	
SubsetQAA[_, _] := False
	
ProperSubsetQAA[sub_List, main_List] := 
	SubsetQAA[sub,main] && Union[main] =!= Union[sub]
	
ProperSubsetQAA[_, _] := False

SameSetQ[list1_List,list2_List] :=
		SubsetQAA[list1,list2] && SubsetQAA[list2,list1]
		
SameSetQ[_, _] := False 
(* If we are not testing two lists, it is False. *)

KSubsets[l_List,0] := { {} }
KSubsets[l_List,1] := Partition[l,1]
KSubsets[l_List,k_Integer?Positive] := {l} /; (k == Length[l])
KSubsets[l_List,k_Integer?Positive] := {}  /; (k > Length[l])
KSubsets[l_List,k_Integer?Positive] :=
	Join[
		Map[(Prepend[#,First[l]])&, KSubsets[Rest[l],k-1]],
		KSubsets[Rest[l],k]
	]
(* KSubsets from Combinatorica *)

ModifiedPartition[els_List, width_Integer?Positive, filler_:""] := 
	Module[{array, rem},
	array = Partition[els, width];
	rem = Mod[Length[els], width];
	If[rem =!= 0, AppendTo[array, Join[Take[els,-rem],
		Table[filler,{width - rem}]]]];
	array]


(* ::Section::Closed:: *)
(* 9. Ngon functions*)


(* ::Subsection:: *)
(*constants*)


insideLabelFactor = 0.75; (* extension factor for inner labeling *)
firstLabelFactor = 1.25; (* extension factor for outer labeling *)
secondLabelFactor = 1.50; (* extension factor for outer labeling *)
thirdLabelFactor = 1.75; (* extension factor for most outer labeling *)

myColorList = {OtherColors[[3]], OtherColors[[8]], OtherColors[[5]], OtherColors[[1]], OtherColors[[9]], OtherColors[[2]],
	ColorData["Legacy", "Turquoise"],   ColorData["Legacy", "Maroon"], ColorData["Legacy", "Navy"],
	ColorData["Legacy", "Salmon"], ColorData["Legacy", "Aquamarine"],
	ColorData["Legacy", "Violet"],ColorData["Legacy", "Indigo"],
	ColorData["Legacy", "Lavender"],OtherColors[[7]], ColorData["Legacy", "DeepPink"]};

myColorList = Join[myColorList,myColorList];

myColorInitials = {"R", "G", "B", "Y", "P", "O", "T", "M",
	"N", "S","A", "V", "I", "L","C", "D"};


(* ::Subsection:: *)
(*basic functions*)


ngonCoords[2] = {{2,1},{2,-1},{-2,-1},{-2,1}};
(* special coordinates to make a rectangle and/or Z *)

Ogt2Q[n_Integer?Positive] := n > 2 && OddQ[n]
Egt2Q[n_Integer?Positive] := n > 2 && EvenQ[n]

ngonCoords[n_?Ogt2Q] := 
	ngonCoords[n] =
	Module[{i},
	Table[N[{Sin[2 Pi i/n], Cos[2 Pi i/n]}],
		{i,n}]]
(* coordinates for an ngon such that the "flat" side is
at the "bottom" and point at top; order is such that
we start from the first point AFTER (0,1) and work
clockwise *)

ngonCoords[n_?Egt2Q] := 
	ngonCoords[n] =
	Module[{i},
	Table[N[{Sin[2 Pi i/n - Pi/n], 
		Cos[2 Pi i/n - Pi/n]}],
		{i,n}]]
(* coordinates for an ngon such that a "flat" side is
at the "bottom" and at the "top"; order is such that
we start from the first point AFTER (0,1) and work
clockwise *)

pointsize = 0.045;

ngonColoredDots[n_,perm_?PermutationQ] := 
	ngonColoredDots[n,perm] =
	Module[{num},
	If[n==2,num=4,num=n];
	Graphics[Map[{PointSize[pointsize],
		myColorList[[Part[PermutationInverse[perm],#]]], 
		Point[ngonCoords[n][[#]]]}&, Range[num]]]
	]
(* this simply colors the dots in the order as created
by ngonCoords and then permuted by permutation perm
and then uses colors as found in myColorList *)

ngonGraphics[2,type_] := 
	ngonGraphics[2,type] =
	Module[{l=ngonCoords[2]},
	Which[type === "D",
		Graphics[{OtherColors[[6]], Polygon[l]}],
	type === "Z",
		Graphics[{OtherColors[[6]], Thickness[0.02], 
		Line[{First[l],l[[2]],Last[l],l[[3]]}]}]
	]]
(* creates the basic graphic for a 2-gon, being
either a rectangle ("D") or a Z shape ("Z"). *)

ngonGraphics[n_?gt2Q] := ngonGraphics[n] =
	Module[{i,crds},
	crds = ngonCoords[n];
	Graphics[{{OtherColors[[6]], Polygon[crds]},
		{Black,Line[Append[crds,First[crds]]]}}]
	]
(* creates basic graphic for an ngon *)

ngonLabeling[n_Integer?Positive, perm_?PermutationQ, 
	scale_,labelList_List:{}] := ngonLabeling[n,perm,
		scale,labelList] = 
	Module[{i,num,p,lablst},
		If[n == 2, num = 4, num = n];
		p = PermutationInverse[perm];
		If[labelList === {}, lablst = Range[num],
			lablst = labelList];
		Graphics[Release[Table[Text[lablst[[Part[p,i]]],
			scale*ngonCoords[n][[i]]], {i,num}]]]
	]
(* This creates the labels for the ngon, by default using
the integers 1..n, but alternatively labelList. These are
then permuted by perm. With 1 being the distance from
origin to ngon, scale indicates where labels should
appear.*)

makeExtensions[n_?gt2Q] := makeExtensions[n] =
	Module[{i,mylist,extfact},
		extfact = .05 n;
		mylist=Table[Line[{ngonCoords[n][[i+1]],
			{(1+extfact) ngonCoords[n][[i+1]][[1]] -
			extfact ngonCoords[n][[i]][[1]], 
			(1+extfact) ngonCoords[n][[i+1]][[2]] -
			extfact ngonCoords[n][[i]][[2]]}}],{i,n-1}];
			AppendTo[mylist,
			Line[{ngonCoords[n][[1]],
			{(1+extfact) ngonCoords[n][[1]][[1]] -
			extfact ngonCoords[n][[n]][[1]], 
			(1+extfact) ngonCoords[n][[1]][[2]] -
			extfact ngonCoords[n][[n]][[2]]}}]];
		Graphics[mylist,AspectRatio->Automatic]]
(* this adds "wings" to an ngon so as to destroy any
reflectional symmetry, forcing only rotational symmetry *)


(* ::Subsection:: *)
(*drawing them now *)


DrawNgon[n_?gt2Q] := 
	Show[{ngonGraphics[n],ngonLabeling[n,Range[n],
		firstLabelFactor]}]

makeGraphicsForFigure[n_,num_,perm_,third___] :=
	makeGraphicsForFigure[n,num,perm,third] =
	Module[{extra={},type},
		If[n==2,type = third,extra = third];
		{Switch[n, 2, ngonGraphics[2,type],
							_,ngonGraphics[n]],
				ngonLabeling[n,perm,firstLabelFactor,Range[num]],
				(*ngonLabeling[n,perm,secondLabelFactor,
					myColorInitials],
				extra,*)
				ngonColoredDots[n,perm]}
	] (* see showFigure for explanations of 'third' argument *)	
	(* added extra in comments - changed  11/3/06 *)

makeFigure[n_Integer?Positive, perm_?PermutationQ, opt___] :=
	Module[{num},
		If[n == 2, num = 4, num = n];
		Show[makeGraphicsForFigure[n,num,perm,opt]]]
(* opt would be "Z" or "D" if n = 2; otherwise it can be
an optional graphics image imposed on the rest if n > 2 
Note that this does NOT show it - only make it.*)

showFigure[n_Integer?Positive, perm_?PermutationQ, opt___] :=
	Module[{num},
		If[n == 2, num = 4, num = n];
		Show[makeGraphicsForFigure[n,num,perm,opt]]]
(* opt would be "Z" or "D" if n = 2; otherwise it can be
an optional graphics image imposed on the rest if n > 2 *)

showFigure[n_Integer?Positive, perm_?PermutationByRulesQ, opt___] :=
	showFigure[n, ToPermutation[perm], opt]

ShowFigure[n_Integer?Positive,perm_?PermutationQ,sym___] := 
	(currentFigureData = {n,perm,sym};
	If[n==2, showFigure[n,perm,sym],
		Switch[ToString[sym],
			"D",showFigure[n,perm],
			"Z",showFigure[n,perm,makeExtensions[n]],
			_,showFigure[n,perm,sym]]]);

ShowFigure[perm_?PermutationQ] := Module[{n,sym,myperm},
	If[Head[currentFigureData] =!= List,
		Print["You have not yet created a figure! I am guessing!"];
		Print["Read your directions or try ?ShowFigure."];
		n = 5; sym = "D";myperm = Range[n],
		n = currentFigureData[[1]];
		myperm = perm;
		sym = currentFigureData[[3]]];
	ShowFigure[n,myperm,sym] (* removed ; 11/3/06 *)
	]

ShowFigure[] := 
	If[Head[currentFigureData] =!= List,
		ShowFigure[{1,2}],
		ShowFigure[currentFigureData[[2]]]]

ShowFigure[perm_?PermutationByRulesQ] := 
	ShowFigure[ToPermutation[perm]]

ShowPermutation[perm_?PermutationByRulesQ] := 
	ShowPermutation[ToPermutation[perm]]

ShowPermutation[perm_?PermutationQ] := Module[{n,sym,myperm},
	If[Head[currentFigureData] =!= List,
		Print["You have not yet created a figure! I am guessing!"];
		Print["Read your directions or try ?ShowFigure."];
		n = 5; sym = "D";myperm = Range[n],
		n = currentFigureData[[1]];
		myperm = perm;
		sym = currentFigureData[[3]]];
	If[n==2,
		ShowPermutation[n,myperm,sym],
		If[sym =!= "Z", ShowPermutation[n,myperm],
			ShowPermutation[n,myperm,makeExtensions[n]]]]
	]

(* removed perm from being the final output to allow graphic to be shown
changed 11/2/06 *)

displayTextYet = 0;	


ShowPermutation[n_Integer?Positive,perm_?PermutationQ,opt___]:=
	Module[{num, img},
	If[n==2,num=4,num=n];
	img = Row[{Show[makeGraphicsForFigure[n,num,Range[num],opt],PlotLabel->"Before"],Show[makeGraphicsForFigure[n,num,perm,opt],PlotLabel->"After"]}];
	DoVisualization[img,{{perm},ShowPermutationHelp},ShowConvert->False,opt]
]

ShowPermutationHelp[perm_]:= DoHelpMessage[windowtitle->"Help for ShowPermutation",
	help-> List["The figure on the left represents the original figure and the one on the right exhibits the effect of the transformation determined by the given permutation."
		]]

ShowPermutation[n_Integer?Positive,perm_?PermutationByRulesQ,opt___]:=ShowPermutation[n,ToPermutation[perm],opt]


(* ::Section:: *)
(* 10. Permutation Functions*)


(* ::Subsection:: *)
(*(* my permutation stuff *)*)


MessagePermutationQ[e_] := Module[{n = Length[e], ue = Union[e], m, max},
	m = Length[ue];
	max = Max[ue];
	If[n > m, Message[PermutationQ::duplicates,e]];
	If[n < max,	Message[PermutationQ::missing, Range[max], max, e]];
	TrueQ[Sort[e] === Range[Length[e]]]]

Parity[x_?PermutationQ] := ToCycles[x, CycleAs -> List]//
	Map[(Length[#]-1)&,#]&//Apply[Plus,#]&//((-1)^#)&

Parity[x_] := If[!MessagePermutationQ[x], $Failed]

OddPermutationQ[x_?PermutationQ] := Parity[x] == -1

EvenPermutationQ[x_?PermutationQ] := Parity[x] == 1

CycleToList[c_] := Apply[List, c]

ListToCycle[c_List] := Apply[Cycle, c]

CycleQ[c_] := Head[c] === Cycle &&
	Length[c] == Length[Union[c]] &&
	Length[c] > 0 &&
	Apply[And, Map[IntegerQ[#] && Positive[#]&,
		CycleToList[c]]]
		
PermutationOrCycleQ[c_] := PermutationQ[c] || CycleQ[c]

NormalizeCycle[c_?CycleQ] := Module[{lst},
	lst = CycleToList[c];
	ListToCycle[RotateRight[lst, Length[lst] - First[Flatten[
		Position[lst, Min[lst]]]] + 1]]]
		
NormalizeCycle[{c__}] := NormalizeCycle[Cycle[c]]
		
NormalizeCycleList[cl:{_?CycleQ..}] := Module[{reduced, a, b, x, max},
	reduced = cl //. {a___, Cycle[x_Integer], b___} :> {a, b};
	If[reduced === {}, reduced = {Cycle[Max[cl /. Cycle[x_] -> x]]}];
	If[Max[Flatten[Map[CycleToList,reduced]]] =!= 
		(max = Max[Flatten[Map[CycleToList,cl]]]), AppendTo[reduced, Cycle[max]]];
	Map[NormalizeCycle, reduced]//Sort[#, CyclesOrderedQ]&]
   
NormalizeCycleList[cl__?CycleQ] := NormalizeCycleList[{cl}]

CyclesOrderedQ[Cycle[list1__], Cycle[list2__]] := 
	If[First[{list1}] <= First[{list2}], True, False]
	
DisjointCyclesQ[list_List] := 
	Flatten[Apply[List,list,{1}]]===UnionNoSort[Flatten[Apply[List,list,{1}]]]
	
DisjointCyclesQ[cl:Sequence[_?CycleQ..]] := DisjointCyclesQ[{cl}]

Unprotect[ToCycles];

Options[ToCycles]={CycleAs -> Cycle,
	Normalize -> True};
			
ToCycles[perm_?PermutationQ, opts___?OptionQ] := (* modified from Permutation.m *)
	Module[{a, t, n, l, i, len, cl,
		cyctype = CycleAs/.Flatten[{opts, Options[ToCycles]}],
		 norm = Normalize/.Flatten[{opts, Options[ToCycles]}]},
		len = Length[perm];
		a = {} ;
		t = Table[True, {len}];
		For[i=1, i<=len, i++,
			If[t[[i]], 
				For[n = perm[[i]]; l = {}, 
					t[[n]], 
					n = perm[[n]],
					t[[n]] = False; AppendTo[l, n]
				   ];
			AppendTo[a, l]
			]
		] ;
		Return[If[cyctype === List, a,
			If[cyctype === Cycle, cl = Map[Apply[Cycle,#]&, a, {1}];
				If[norm === True, NormalizeCycleList[cl], cl]]]]
	]
	
ToCycles[pl:{_?PermutationQ..}, opts___?OptionQ] := 
	Map[ToCycles[#,opts]&,pl]

ToCycles[p__, opts___?OptionQ] := Module[{out},
	out = If[MessagePermutationByRulesQ[Flatten[{p}]],
		ToCycles[ToPermutation[p], opts], $Failed];
	If[out === $Failed,
		out = If[Apply[And,Map[PermutationQ,p]], Map[ToCycles[#,opts]&,p], $Failed]];
	out] 

Protect[ToCycles];
Unprotect[FromCycles];

FromCycles[cyc_List] := Module[{cyclist = cyc/. Cycle -> List, temp,
		missing},
	If[DisjointCyclesQ[cyc],
   temp = Last /@ Sort[Transpose[Flatten /@ 
   	{RotateRight /@ cyclist, cyclist}]];
   missing = Complement[Range[Max[temp]],temp];
   Fold[Insert[#1, #2,#2]&, temp, missing],
   	Message[Cycle::disjoint,cyc];$Failed]]
	
Protect[FromCycles];

MessagePermutationByRulesQ[e_] := Module[{t,ne,ok},
	Off[Part::partd];
	ne = Flatten[e];
	t = Apply[And,Map[(Head[#] === Rule)&,ne]];
	ok = t;
	If[!t, Message[PermutationQ::notrule,e]];
	If[t,
		If[Apply[Equal,Map[Union,Transpose[ne/.Rule->List]]],
		ok = True, Message[Rule::form,Length[e]];ok= False]];
	On[Part::partd];
	ok]

ListCycleQ[c_List] := CycleQ[ListToCycle[c]]

SamePermutationQ[cyc1_?CycleQ,cyc2_?CycleQ] :=
	MultiplyCycles[cyc1]===MultiplyCycles[cyc2]

SamePermutationQ[{cyc1__?CycleQ},{cyc2__?CycleQ}] :=
	MultiplyCycles[{cyc1}]===MultiplyCycles[{cyc2}]

SamePermutationQ[{cyc1__List},{cyc2__List}] :=
	MultiplyCycles[Map[ListToCycle,{cyc1}]]===
	MultiplyCycles[Map[ListToCycle,{cyc2}]]
	
SamePermutationQ[cyc1_List,cyc2_List] :=
	MultiplyCycles[cyc1]===MultiplyCycles[cyc2]
	
ToPermutation[cyc_?CycleQ, n_Integer?Positive] := 
		Module[{c = Apply[List,cyc]},
	Union[Map[{First[#]->Last[#]}&,{c,RotateLeft[c]}//Transpose],
	Map[{#->#}&,Complement[Range[n],c]]]//ToPermutation]
	
ToPermutation[c_Cycle] := ToPermutation[c,Max[CycleToList[c]]]

ToPermutation[c_?ListCycleQ] := ToPermutation[ListToCycle[c]]

ToPermutation[c_?ListCycleQ, n_Integer?Positive] := 
	ToPermutation[ListToCycle[c],n]
	
ToPermutation[cyclelist__Cycle] := MultiplyCycles[{cyclelist}]

ToPermutation[cyclelist:{_?CycleQ..}] := MultiplyCycles[cyclelist]

MultiplyCycles[c1_Cycle]:= ToPermutation[c1]

MultiplyCycles[c1_?ListCycleQ]:= ToPermutation[ListToCycle[c1]]

MultiplyCycles[c1_Cycle, c2_Cycle,n_Integer?Positive,opts___?OptionQ]:= 
	MultiplyPermutations[ToPermutation[c1,n],ToPermutation[c2,n],opts]
	
MultiplyCycles[c1_?ListCycleQ, c2_?ListCycleQ, n_Integer?Positive,opts___?OptionQ]:=
  MultiplyCycles[ListToCycle[c1], ListToCycle[c2], n, opts]
	
MultiplyCycles[c1_Cycle, c2_Cycle,opts___?OptionQ]:= 
		Module[{max = Max[Flatten[Apply[List, {c1, c2}, {1}]]]},
	MultiplyPermutations[ToPermutation[c1,max],
		ToPermutation[c2,max],opts]]
	
MultiplyCycles[cyclelist__Cycle,opts___?OptionQ] := MultiplyCycles[{cyclelist},opts]

MultiplyCycles[cyclelist:{_?CycleQ..},opts___?OptionQ] := 
		Module[{n = Length[{cyclelist}],rl,perms,ans,po, max},
	po = ProductOrder/.Flatten[{opts, Options[MultiplyPermutations]}];
	rl=If[po===RightToLeft,Reverse[cyclelist],cyclelist];
	max = Max[Map[CycleToList,cyclelist]//Union];
	perms = Map[ToPermutation[#,max]&, rl];
	Fold[MultiplyPermutations[#1,#2,ProductOrder -> LeftToRight]&,
		First[perms],Rest[perms]]]
		
Cycle[c1__][Cycle[c2__]] := MultiplyCycles[Cycle[c1], Cycle[c2]]

Cycle[c1__][c2_?PermutationQ] := 
	MultiplyPermutations[ToPermutation[Cycle[c1]], c2]

ToTranspositions[Cycle[1]] := {Cycle[1,2],Cycle[2,1]}

ToTranspositions[Cycle[x_]] := {Cycle[1,x], Cycle[x,1]}

ToTranspositions[cyc_Cycle] := Module[{c = Apply[List,cyc]},
	Map[Cycle[First[c],#]&, Rest[c]//Reverse]]

ToTranspositions[p_?PermutationQ] := 
	p//ToCycles//Map[ToTranspositions,#]&//Flatten[#,1]&
	
ToTranspositions[p_] := (Message[PermutationQ::fail, p]; $Failed)

Unprotect[ToRules];
 	
ToRules[perm_?PermutationQ] :=  
 	MapThread[Rule,{Range[Length[perm]],perm}]
 	
Protect[ToRules];

permutationToFunction[perm_?PermutationQ,f_] := 
   Module[{i}, 
   	Do[f[i] = perm[[i]],{i, Length[perm]}]; 
   	f]
(* given a permutation in list form, this produces a 
function representing this permutation *)

permutationToFunction[(perm_)?PermutationQ] := 
   Module[{i,f}, 
   	Do[f[i] = perm[[i]],{i, Length[perm]}]; 
   	f]
(* similar to above except here f is a local variable *)

NormalizePermutations[perm1_,perm2_] := 
	If[Union[perm1]=!=Range[Length[perm1]],
		Message[PermutationQ::length,perm1,Length[perm1]],
		If[Union[perm2]=!=Range[Length[perm2]],
			Message[PermutationQ::length,perm2,Length[perm2]],
			Apply[Sequence,Map[ExtendPermutation[#, Max[Map[Length,
				{perm1,perm2}]]]&, {perm1,perm2}]]]]
	
ExtendPermutation[p_?PermutationQ, n_Integer?Positive] :=	
	If[Length[p] <= n, Join[p, Range[Length[p] + 1, n]]]
	
permutationProductrl[(perm1_)?PermutationQ, 
		(perm2_)?PermutationQ] := 
	permutationComposition[NormalizePermutations[perm1,perm2]]

permutationProductlr[(perm1_)?PermutationQ, 
		(perm2_)?PermutationQ] := 
	permutationComposition[NormalizePermutations[perm2,perm1]]

permutationComposition=Module[{k},
	Map[Function[k,Part[#1,k]],#2]&];

Options[MultiplyPermutations]={Mode -> Computational,
	ProductOrder -> RightToLeft};

MultiplyPermutations[perm1_, perm2_, Mode -> Textual, opts___?OptionQ] :=
	Module[{p1=Flatten[perm1],p2=Flatten[perm2],mymode,po,prod,
			ok=True, txt},
		mymode = Mode/.Flatten[{opts, Options[MultiplyPermutations]}];
		po = ProductOrder/.Flatten[{opts, Options[MultiplyPermutations]}];
		If[Head[p1[[1]]]===Rule,
			If[MessagePermutationByRulesQ[p1],p1 = ToPermutation[p1]]];
		If[Head[p2[[1]]]===Rule,
			If[MessagePermutationByRulesQ[p2],p2 = ToPermutation[p2]]];
		p1 = If[MessagePermutationQ[p1],p1,Null];
		p2 = If[MessagePermutationQ[p2],p2,Null];
		If[p1===Null || p2 === Null, $Failed,
			prod = If[po === RightToLeft,
				permutationProductrl[p1,p2], 
				If[po === LeftToRight,permutationProductlr[p1,p2],
					Message[MultiplyPermutations::optx,po,ProductOrder]]]];
		txt = "The permutation resulting from the product of \n";
		txt = txt <> "\t" <> ToString[If[po === RightToLeft, perm2, perm1]]<>"\n";
		txt = txt <> "followed by\n";
		txt = txt <> "\t" <> ToString[If[po === RightToLeft, perm1, perm2]]<>"\n";
		txt = txt <> "can be given as "<>"\n";
		txt = txt <> "\t" <> ToString[ToRules[prod]]<>"\n";
		txt = txt <> "or as" <> "\n\t" <> ToString[prod];
		StringReplace[txt,"->"-> "\[Rule]"]
	]
	
MultiplyPermutations[perm1_, perm2_, opts___?OptionQ, Mode -> Textual] :=
	MultiplyPermutations[perm1, perm2, Mode->Textual, opts]
	
MultiplyPermutations[c1_?CycleQ, c2_?CycleQ, opts___?OptionQ] := 
	MultiplyPermutations[ToPermutation[c1], ToPermutation[c2], opts]

MultiplyPermutations[perm1_, perm2_,opts___?OptionQ] :=
	Module[{p1=Flatten[perm1],p2=Flatten[perm2],mymode,po,prod,
			ok=True},
		mymode = Mode/.Flatten[{opts, Options[MultiplyPermutations]}];
		po = ProductOrder/.Flatten[{opts, Options[MultiplyPermutations]}];
		If[Head[p1[[1]]]===Rule,
			If[MessagePermutationByRulesQ[p1],p1 = ToPermutation[p1]]];
		If[Head[p2[[1]]]===Rule,
			If[MessagePermutationByRulesQ[p2],p2 = ToPermutation[p2]]];
		p1 = If[MessagePermutationQ[p1],p1,Null];
		p2 = If[MessagePermutationQ[p2],p2,Null];
		If[p1===Null || p2 === Null, $Failed,
			If[po === RightToLeft,
				permutationProductrl[p1,p2], 
				If[po === LeftToRight,permutationProductlr[p1,p2],
					Message[MultiplyPermutations::optx,po,ProductOrder]]]]]

MultiplyPermutations[perm1_?PermutationQ, perm2_?PermutationQ,
	perm3_?PermutationQ] :=
MultiplyPermutations[perm1,MultiplyPermutations[perm2,perm3]]

PermutationToPower[perm_?PermutationQ, 0] := Table[i, {i, Length[perm]}]

PermutationToPower[perm_?PermutationQ, 1] := perm

PermutationToPower[perm_?PermutationQ, -1] := PermutationInverse[perm]

PermutationToPower[perm_?PermutationQ, n_Integer?Positive] := 
	Fold[MultiplyPermutations[#1,#2]&, perm, Table[perm, {i, n-1}]]

PermutationToPower[perm_?PermutationQ, n_Integer?Negative] := 
	Module[{p = PermutationInverse[perm]},
		Fold[MultiplyPermutations[#1,#2]&, p, Table[p, {i, n-1}]]]
		
PermutationMatrix[list_?PermutationQ]:=
		MatrixForm[{Range[Length[list]],list}]
		
PermutationMatrix[list_?PermutationByRulesQ]:=
		MatrixForm[{Range[Length[list]],list//ToPermutation}]

FixQ[S_List, p_, el_] := 
	If[Union[S]===Union[p],
		If[Length[S]==Length[p],
			If[MemberQ[S,el],
				Position[S,el]===Position[p,el],
				Message[MemberQ::elmnt,el,S];$Failed],
			Message[PermutationQ::difflen,p,S];$Failed],
		Message[PermutationQ::diffels,p,S];$Failed]

FixQ[p_?PermutationQ, el_] := FixQ[Range[Max[p]], p, el]

PermutationImage[S_List, p_, el_] := 
	If[Union[S]===Union[p],
		If[Length[S]==Length[p],
			If[MemberQ[p,el],
				p[[Flatten[Position[S,el]]]][[1]],
				Message[MemberQ::elmnt,el,S];$Failed],
			Message[PermutationQ::difflen,p,S];$Failed],
		Message[PermutationQ::diffels,p,S];$Failed]
		
PermutationImage[p_?PermutationQ, el_] := PermutationImage[Range[Max[p]], p, el]

PermutationComposition = Module[{k},
	Map[Function[k,Part[#1,k]],#2]&];


(* ::Section::Closed:: *)
(* 11. Functions for unit circles*)


SetAttributes[ngonDot,Listable];

ngonDot[pos_Integer,n_Integer?Positive, theColor_] := 
	ngonDot[pos,n,theColor] = 
		Graphics[{PointSize[0.055], theColor, 
			Point[ngonCoordsC[n][[pos]]]}]
(* produces graphics for a dot on an ngon on unit circle at
position pos with color theColor *)

ngonDot[pos_Integer,n_Integer?Positive, theColor_, theSize_] := 
	ngonDot[pos,n,theColor,theSize] = 
		Graphics[{PointSize[theSize], theColor, 
			Point[ngonCoordsC[n][[pos]]]}]
(* as above but allows specifying the size as well *)

ngonLine[pos_Integer,n_Integer?Positive, theColor_] :=
	ngonLine[pos,n,theColor] =
	Graphics[{theColor,Line[{ngonCoordsC[n][[pos-1]],
		ngonCoordsC[n][[pos]]}]}]
(* is this used? *)

ngonLine[pos1_Integer?Positive,pos2_Integer?Positive, 
		n_Integer?Positive, theColor_] :=
		ngonLine[pos1,pos2,n,theColor] = 
	Graphics[{theColor,Line[{ngonCoordsC[n][[pos1]],
		ngonCoordsC[n][[pos2]]}]}]
(* can this be used? *)

(* modNgonLabeling[n_Integer?Positive] := 
	modNgonLabeling[Range[0,n-1],insideLabelFactor]*)

modNgonLabeling[n_Integer?Positive] := 
	LabelingNgon[Range[0,n-1], Range[0,n-1], insideLabelFactor, 
	InStdForm]
	 	
LabelingNgon[points_List, chosenLabels_List, scale_, form_] := 
	Module[{lst, n = Length[points],pos},
	lst = Table[Text[form[points[[i]]], 
	 	scale ngonCoordsC[n][[i]],{0,0}], {i,n}];
	pos = (Map[Position[points,#]&, chosenLabels]//Flatten);
	Graphics[lst[[pos]], BaseStyle -> defaultFont]]

(* Changed DefaultFont to BaseStyle - 11/3/06 *)
	
(* modNgonLabeling[Labels_List] := 
	modNgonLabeling[Labels,firstLabelFactor] *)

modNgonLabeling[Labels_List] := 
	LabelingNgon[Labels,Labels, firstLabelFactor, InStdForm]

(* modNgonLabeling[Labels_List,scale_] :=  
	Module[{i,n},
		n = Length[Labels];
		Graphics[Release[Table[Text[StandardForm[Labels[[i]]], 
	 	scale ngonCoordsC[n][[i]],{0,0}], {i,n}]]]
	]*)

modNgonLabeling[Labels_List,scale_] :=  
	LabelingNgon[Labels,Labels, scale, InStdForm]
	
(* places Labels on the unit circle uniformly starting at
(0,1) and proceeding clockwise at location scale times
a unit vector (to circle) *)

AngleList[n_Integer?Positive] :=
Table[k, {k, -3 Pi/2 + 2 Pi/n, Pi/2, 2 Pi/n}]//Reverse

ptLabeling[crd_,lab_] := Graphics[Text[InStdForm[lab],
	firstLabelFactor*crd, {0,0}]]
(* used if a single pt is to be labeled *)

ngonCoordsC[(n_Integer?Positive)] := ngonCoordsC[n] =
	Module[{i},
	Table[N[{Cos[Pi/2 - 2 Pi i/n], Sin[Pi/2 - 2 Pi i/n]}],
		{i,0, n-1 }]]
(* similar to ngonCoords, but this always starts at (0,1) *)

rad = 1.3;

modCircle[n_Integer?Positive, k_Integer?Positive] := 
	{Graphics[{White,Rectangle[{-rad,-rad},{rad,rad}],
	OtherColors[[9]],Circle[{0,0},1]}],
	Map[ngonDot[#,n,OtherColors[[3]],0.035]&,Range[n]], 
	Map[ngonDot[#,n,OtherColors[[5]],0.055]&,Table[i, {i, 1, n, k}]]}//Flatten
		
modCircle[n_Integer?Positive] := 
	modCircle[n, OtherColors[[5]], 0.055]

modCircle[n_Integer?Positive, color_] := 
	modCircle[n, color, 0.055]

modCircle[n_Integer?Positive, color_, size_] := 
	{Graphics[{White,Rectangle[{-rad,-rad},{rad,rad}],
	OtherColors[[9]],Circle[{0,0},1]}],
	Map[ngonDot[#,n,color,size]&,Range[n]]}//Flatten
(* make circle with n uniform points dotted *)

modPoint[a_Integer,n_Integer?Positive, theColor_] := 
	modPoint[a,n,theColor] = 
	ngonDot[Mod[a,n]+1,n,theColor]
(* only differs from ngonDot in that we apply mod (n) to a *)

modPoint[a_Integer,n_Integer?Positive, theColor_, size_] := 
	modPoint[a,n,theColor] = 
	ngonDot[Mod[a,n]+1,n,theColor, size]
(* only differs from ngonDot in that we apply mod (n) to a *)

(* Added Flatten 11/2/06 to see if it would take care of graphics problem not outputting correctly*)
MakeCircle[n_Integer?Positive, k_Integer?Positive, labels_] := 
	Show[Flatten[{modCircle[n,k], LabelingNgon[labels,labels,
		insideLabelFactor,InputForm]}],
	 DisplayFunction -> Identity, 
		BaseStyle -> defaultFont,
		If[$VersionNumber > 2.5, FormatType -> StandardForm,
			Ticks -> Automatic (* dummy statement *)]]

(* Changed DefaultFont to BaseStyle - 11/3/06 *)

MakeCircle[n_Integer?Positive, k_Integer?Positive, labels_, form_] := 
	Show[{modCircle[n,k], LabelingNgon[labels,labels,
		insideLabelFactor,form]}, 
		BaseStyle -> defaultFont,
		If[$VersionNumber > 2.5, FormatType -> StandardForm,
			Ticks -> Automatic (* dummy statement *)]]

(* Changed DefaultFont to BaseStyle - 11/3/06 *)
		
MakeCircle[n_Integer?Positive, labels_] := 
	Show[{modCircle[n], LabelingNgon[labels,labels,
		insideLabelFactor,InputForm]},
	DisplayFunction -> Identity, 
		BaseStyle -> defaultFont,
		If[$VersionNumber > 2.5, FormatType -> StandardForm,
			Ticks -> Automatic (* dummy statement *)]]
			
(* Changed DefaultFont to BaseStyle - 11/3/06 *)

MakeCircle[n_Integer?Positive, labels_, color_] := 
	Show[{modCircle[n, color], LabelingNgon[labels,labels,
		insideLabelFactor,InputForm]},
	DisplayFunction -> Identity, 
		BaseStyle -> defaultFont,
		If[$VersionNumber > 2.5, FormatType -> StandardForm,
			Ticks -> Automatic (* dummy statement *)]]

MakeCircle[n_Integer?Positive, labels_, color_, form_] := 
	Show[{modCircle[n, color], LabelingNgon[labels,labels,
		insideLabelFactor,form]},
	DisplayFunction -> Identity, 
		BaseStyle -> defaultFont,
		If[$VersionNumber > 2.5, FormatType -> StandardForm,
			Ticks -> Automatic (* dummy statement *)]]
			
ShowCircle[labels_List, form_] :=  
	Show[{modCircle[Length[labels]],
	LabelingNgon[labels, labels, insideLabelFactor, form]},
		BaseStyle -> defaultFont, 
			If[$VersionNumber > 2.5, FormatType -> StandardForm,
			Ticks -> Automatic (* dummy statement *)]]

ShowCircle[labels_List] := ShowCircle[labels, InputForm]
	
ShowCircle[n_Integer?Positive,labels_] := 
	ShowCircle[labels]

ShowCircle[n_Integer?Positive] := 
	ShowCircle[Range[0,n-1]]


(* ::Section::Closed:: *)
(* 12. Structured sets*)


GroupoidQ[G_] := (Head[G]===Groupoid || Head[G]===groupoid || Head[G]===AbstractAlgebra`Master`Private`groupoid) && 
	Head[First[G]]===List
(* Added || Head[G]===AbstractAlgebra`Master`Private`groupoid on July 14, 2004 *)

GroupoidQ[many:{_groupoid..}] := Map[GroupoidQ,many]

GroupoidQ[many:{_Groupoid..}] := Map[GroupoidQ,many]

RingoidQ[R_] := (Head[R]===Ringoid || Head[R]===ringoid || Head[R]===AbstractAlgebra`Master`Private`ringoid) && 
	Head[First[R]]===List

RingoidQ[many:{_ringoid..}] := Map[RingoidQ,many]

RingoidQ[many:{_?RingoidQ..}] := Map[RingoidQ,many]

StructuredSetQ[S_] := GroupoidQ[S] || RingoidQ[S]

StructuredSetQ[S_List] := Map[StructuredSetQ,S]


(* ::Section:: *)
(* 13. Misc.*)


(* ::Subsection:: *)
(*permutation stuff*)


RandomPermutationAA[n_Integer?Positive] :=
		Map[ #[[2]] &, Sort[Array[{Random[], #} &, n]]]
		(* slightly modified from Permutation package*)
	
RandomPermutationAA[n_] :=	
	(Message[RandomPermutationAA::intpm, "RandomPermutationAA["<>
	ToString[n]<>"]",1]; $Failed)
	
PermutationQ[e_] := Module[{t},
	Off[Sort::normal];
	t = TrueQ[Sort[e] == Range[Length[e]]];
	Off[Sort::normal];
	t](* slightly modified from Permutation package*)

MyOrdering[list_List] :=
   Map[Last, Sort[Transpose[{list, 
   		Range[Length[list]]}]]]
   		
(* The above is from the permutation package from Mathematica *)

PermutationInverse[list_?PermutationQ] := MyOrdering[list]

PermutationByRulesQ[e_] := Module[{t},
	Off[Part::partd];
	t = Apply[And,Map[(Head[#] === Rule)&,Flatten[e]]];
	On[Part::partd];
	t]

ToPermutation[args__] := 
	ToPermutation[Flatten[{args}]]

ToPermutation[myrule:{_List..}] := 
	ToPermutation[Flatten[myrule]]
(* this assumes the full set of rules is given and then
produces the list form of a permutation *)

ToPermutation[somerules:{_Rule..}] := 
		Module[{listrules = Transpose[somerules/.Rule->List],dom},
	dom = listrules//First;
	If[Apply[Equal,Map[Union,listrules]],
		Transpose[Sort[Join[Map[#->#&,Complement[Range[Max[dom]],dom]],
		somerules]/.(x_Integer -> y_Integer) :> {x,y}]][[2]],
		Message[Rule::form,Length[myrule]];$Failed]]
(* this assumes the full set of rules is given and then
produces the list form of a permutation *)


(* ::Subsection:: *)
(*other stuff*)


GroupStuff := 
(DefaultStructure = Group;
	Options[ClosedQ]={Mode -> Computational, Structure :> DefaultStructure};
	Options[AssociativeQ]={Mode -> Computational, Structure :> DefaultStructure};
	Options[RandomAssociativeQ]={Mode -> Computational, Structure :> DefaultStructure};
	Options[HasIdentityQ]={Mode -> Computational, Structure :> DefaultStructure};
	Options[GroupIdentity]={Mode -> Computational, Structure :> DefaultStructure};
	Options[InvertibleQ]={Mode -> Computational, Structure :> DefaultStructure};
	Options[GroupInverse]={Mode -> Computational, Structure :> DefaultStructure};
	Options[HasInversesQ]={Mode -> Computational, Structure :> DefaultStructure};
	Options[RandomElement]={SelectFrom -> NonIdentity};
	Options[Inverses]={Mode -> Computational, Structure :> DefaultStructure};
	Unprotect[Z];
	Options[Z]={Mode -> Computational, Structure :> DefaultStructure};
	Protect[Z];
	Group)


RingStuff:=
(DefaultStructure = Ring;
		Options[ClosedQ]={Mode -> Computational, Structure :> DefaultStructure, 
			Operation -> Both};
		Options[AssociativeQ]={Mode -> Computational, Structure :> DefaultStructure,
			Operation -> Both};
		Options[RandomAssociativeQ]={Mode -> Computational, 
			Structure :> DefaultStructure, Operation -> Both};
		Options[HasIdentityQ]={Mode -> Computational, Structure :> DefaultStructure, 
			Operation -> Both};
		Options[GroupIdentity]={Mode -> Computational, Structure :> DefaultStructure};
		Options[InvertibleQ]={Mode -> Computational, Structure :> DefaultStructure,
			Operation -> Both};
		Options[GroupInverse]={Mode -> Computational, Structure :> DefaultStructure};
		Options[HasInversesQ]={Mode -> Computational, Structure :> DefaultStructure,
			Operation -> Both};
		Options[Inverses]={Mode -> Computational, Structure :> DefaultStructure,
			Operation -> Both};
		Options[RandomElement]= {SelectFrom -> NonZero, LowerDegreeOK -> False, 
			Monic -> False, SelectBaseElementsFrom -> Any};
		Unprotect[Z];
		Options[Z]={Mode -> Computational, Structure :> DefaultStructure};
		Protect[Z];
		Ring)


SwitchStructureTo[Group] := GroupStuff

SwitchStructureTo[Groups] := GroupStuff

SwitchStructureTo[Groupoid] := GroupStuff

SwitchStructureTo[Groupoids] := GroupStuff

SwitchStructureTo[Ring] := RingStuff

SwitchStructureTo[Rings] := RingStuff

SwitchStructureTo[Ringoid] := RingStuff

SwitchStructureTo[Ringoids] := RingStuff

SwitchStructureTo[Group];


(* ::Subsection:: *)
(*Adjoin*)


Adjoin[R_?StructuredSetQ, alpha_Symbol, deg_Integer?Positive] := 
		Adjoin[Elements[R], alpha, deg]

Adjoin[R_List, alpha_Symbol, 0] := R

Adjoin[R_?StructuredSetQ, alpha_Symbol, 0] := Elements[R]
		
Adjoin[R_List, alpha_Symbol, deg_Integer?Positive] := 
		Module[{els = R, k},
	Map[Expand,Map[Dot[Table[alpha^k,{k,0,deg}], #]&, 
	CartesianProduct[Sequence@@Table[els,{deg+1}]]]]]
		
Adjoin[R_?StructuredSetQ, num_] := 
		Adjoin[Elements[R], num]

Adjoin[R_List, Times[Complex[0,1], Power[d_?squareFreeQ, 
	Rational[1,2]]]] := 	Module[{deg,n,x},
	deg = 2;
	Adjoin[R,x,deg-1]/.x -> Sqrt[-d]]

Adjoin[R_List, num_] := 
		Module[{deg,n,x},
	If[Head[num]===Power,
			deg = num/. Power[_,Rational[_,n_]] :> n;
			Adjoin[R,x,deg-1]/.x -> num,
			Message[Adjoin::fail, num]; $Failed]]
			
(*Adjoin[R_List, num_] := 
		Module[{deg,n,x},
	If[MemberQ[R, num], Adjoin[R, x, 0],
		If[Head[num]===Power,
			deg = num/. Power[_,Rational[_,n_]] :> n;
			Adjoin[R,x,deg-1]/.x -> num,
			Message[Adjoin::fail, num]; $Failed]]]*)


(* ::Subsection:: *)
(*Other*)


EqualGroupoidQ[G1_?GroupoidQ, G2_?GroupoidQ] := Module[{els1, els2},
	Sort[els1 = Elements[G1]] === Sort[els2 = Elements[G2]] &&
	CayleyTable[ReorderGroupoid[G1, els1]] === CayleyTable[ReorderGroupoid[G2, els2]]]


(* ::Section:: *)
(* 16. Constructing Groupoids and Ringoids*)


(* ::Subsection:: *)
(* 16.1 general information*)


Format[groupoid[list_,op_, ei___]] := 
	If[FormatElsQ[groupoid[list,op, ei]],
		If[FormatOpQ[groupoid[list,op,ei]],
			Groupoid[{"-Elements-"},"-Operation-"],
			Groupoid[{"-Elements-"},op]],
		If[FormatOpQ[groupoid[list,op,ei]],
			Groupoid[list,"-Operation-"],
			Groupoid[list,op]]]
						
Format[ringoid[list_,aop_,mop_, ei___]] := 
	If[FormatElsQ[ringoid[list,aop,mop,ei]],
		If[FormatOpQ[ringoid[list,aop,mop,ei]],
			Ringoid[{"-Elements-"},"-Addition-","-Multiplication-"],
			Ringoid[{"-Elements-"},aop,mop]],
		If[FormatOpQ[ringoid[list,aop,mop,ei]],
			Ringoid[list,"-Addition-","-Multiplication-"],
			Ringoid[list,aop,mop]]]

Elements[S_?StructuredSetQ] := Elements[S] = First[S]

Elements[many_List] := Map[Elements,many]

Domain[S__] := Elements[S]

theGroupName[G_] := If[GroupoidName[G]==="" || 
	untestedQ[GroupoidName[G]], "TheGroup", GroupoidName[G]]
	
theRingName[R_] := If[RingoidName[R]==="" || 
	untestedQ[RingoidName[R]], "TheRing", RingoidName[R]]	
	
StructureName[S_?GroupoidQ] := theGroupName[S]

StructureName[S_?RingoidQ] := theRingName[S]

Operation[G_?GroupoidQ] := Operation[G] = G[[2]]

Operation[many:{_?GroupoidQ..}] := Map[Operation,many]

Operation[G_?RingoidQ] := Operation[G] = G[[2]]

Randomize[G_?GroupoidQ]:= FormGroupoid[Randomize[Elements[G]],Operation[G]]

Randomize[R_?RingoidQ]:= FormRingoid[Randomize[Elements[R]],
	Addition[R], Multiplication[R],{PlusSymbol[R], TimesSymbol[R]}]

Addition[G_?GroupoidQ] := Operation[G]

Addition[R_?RingoidQ] := Addition[R] = R[[2]];

Addition[many:{_?StructuredSetQ..}] := Map[Addition,many]

Multiplication[R_?RingoidQ] := Multiplication[R] = R[[3]];

Multiplication[many:{_?RingoidQ..}] := Map[Multiplication,many]
		
ProcessInfo[G_?GroupoidQ,opts___] := Module[{gQ,test},
	gQ = If[!untestedQ[groupQ[G]],groupQ[G],False];
	test = IsAGroup/.{opts};
	If[test || gQ, gQ = True, gQ = False];
	If[gQ, HasIdentityQ[G] = True;
		ClosedQ[G] = True;
		AssociativeQ[G] = True;
		HasInversesQ[G] = True];]
		
ProcessRingInfo[G_?RingoidQ,opts___] := Module[{gQ,test},
	gQ = If[!untestedQ[ringQ[G]],ringQ[G],False];
	test = IsARing/.{opts};
	If[test || gQ, gQ = True, gQ = False];
	ringQ[G] = gQ;
	If[gQ, HasIdentityQ[G, Operation -> Addition] = True;
		ClosedQ[G, Operation -> Both] = True;
		AssociativeQ[G, Operation -> Both] = True;
		CommutativeQ[G, Operation -> Addition] = True;
		(* DistributiveQ[G] = True;*)
		HasInversesQ[G, Operation -> Addition] = True];]


(* ::Subsection:: *)
(* 16.2 FormGroupoid*)


Options[FormGroupoid] = {CayleyForm -> StandardForm, 
FormatElements -> False, FormatOperator -> True, 
Generators -> {}, GroupoidDescription -> "", GroupoidName -> 
"TheGroup", IsAGroup -> False, KeyForm -> TraditionalForm, 
MaxElementsToList -> 50, WideElements -> False, GroupoidInputString->""};

(* changed CayleyForm from OutputForm to StandardForm 11/8/06
changed KeyForm from InputForm to TraditionalForm 9/14/08 *)
	
Options[FormGroupoidExtra] = {ExtraInformation -> {{},{},{},{},{}}};
(* Information that can go here: {{True/False if group or not},
	{identity or Null}, {quick function to
	calculate inverses}, 
	{a minimal generating set for additive group}, {any other extra
	information entered on ad hoc basis for special functions - best
	to use rules here}}. Finally, in the forming functions, a sixth
	list includes all options given when formed. *)

GatherGroupoidOptions[G_?GroupoidQ] := Sequence[WideElements -> 
	WideElementsQ[G], GroupoidDescription -> GroupoidDescription[G], 
	GroupoidName -> GroupoidName[G],
	FormatOperator -> FormatOpQ[G], FormatElements -> FormatElsQ[G],
	KeyForm -> KeyForm[G], CayleyForm -> CayleyForm[G]]

GatherSubGroupoidOptions[G_?GroupoidQ] := Sequence[WideElements ->
	WideElementsQ[G],GroupoidDescription -> "Subgroupoid of "<>
	GroupoidDescription[G], GroupoidName -> "sub "<>GroupoidName[G],
	FormatOperator -> FormatOpQ[G], FormatElements -> FormatElsQ[G],
	KeyForm -> KeyForm[G], CayleyForm -> CayleyForm[G]]

FormGroupoid[list_List, op_, opsymb_String:"*", opts___?OptionQ] :=
	Module[{G,wideq,groupq,genset,grpdesc,grpnm,optional,formop,
	formels,maxshow,keyForm,cayleyForm,ei, grpinpstr},
		wideq = WideElements/.Flatten[{opts, Options[FormGroupoid]}];
		groupq = IsAGroup/.Flatten[{opts, Options[FormGroupoid]}];
		genset = Generators/.Flatten[{opts, Options[FormGroupoid]}];
		ei = ExtraInformation/.Flatten[{opts, Options[FormGroupoidExtra]}];
		grpdesc = GroupoidDescription/.Flatten[{opts, Options[FormGroupoid]}];
		grpnm = GroupoidName/.Flatten[{opts, Options[FormGroupoid]}];
		grpinpstr = GroupoidInputString/.Flatten[{opts, Options[FormGroupoid]}];
		formop = FormatOperator/.Flatten[{opts, Options[FormGroupoid]}];
		formels = FormatElements/.Flatten[{opts, Options[FormGroupoid]}];
		keyForm = KeyForm/.Flatten[{opts, Options[FormGroupoid]}];
		cayleyForm = CayleyForm/.Flatten[{opts, Options[FormGroupoid]}];
		maxshow = MaxElementsToList/.Flatten[{opts, Options[FormGroupoid]}];
		AppendTo[ei, {opts}];
		G = groupoid[list, op, ei];
		FormatOpQ[G] = formop;
		FormatElsQ[G] = If[Length[list] > maxshow, True, formels];
		currentGroupoid = G;
		WideElementsQ[G] = wideq;
		KeyForm[G] = keyForm;
		CayleyForm[G] = cayleyForm;
		If[groupq,groupQ[G] = groupq];
		GroupoidDescription[G] = grpdesc;
		GroupoidName[G] = If[grpnm === "", "TheGroup", grpnm];
		GroupoidInputString[G] = If[grpnm === "", 
			"FormGroupoid["<>ToString[list]<>", "<>ToString[op]<>"]", 
			grpinpstr];
		GeneratingSet[G] = If[genset === {}, $Failed,
			If[Union[Elements[Closure[G,genset]]]===Union[list],
			genset,$Failed]];
		If[untestedQ[GroupInfo[G]],
			GroupInfo[G] = {};
			If[grpnm =!= "", AppendTo[GroupInfo[G],grpnm]];
			If[grpdesc =!= "", AppendTo[GroupInfo[G],grpdesc]];
			];
		(* start tracking info about groupoid if not yet started *)
		OperatorSymbol[G] = opsymb;
		ProcessInfo[G,opts];
		G]


(* ::Subsection:: *)
(* 16.3 FormGroupoidByTable*)


FormGroupoidByTable[list_List,tab_List,opsymb_String:"*",
		opts___?OptionQ] :=
	Module[{G,op,wideq,groupq,genset,grpdesc,grpnm,maxshow,formop,
			formels,keyForm,cayleyForm, ei},
		wideq = WideElements/.Flatten[{opts, Options[FormGroupoid]}];
		groupq = IsAGroup/.Flatten[{opts, Options[FormGroupoid]}];
		genset = Generators/.Flatten[{opts, Options[FormGroupoid]}];
		ei = ExtraInformation/.Flatten[{opts, Options[FormGroupoidExtra]}];
		grpdesc = GroupoidDescription/.Flatten[{opts, Options[FormGroupoid]}];
		grpnm = GroupoidName/.Flatten[{opts, Options[FormGroupoid]}];
	  formop = FormatOperator/.Flatten[{opts, Options[FormGroupoid]}];
		formels = FormatElements/.Flatten[{opts, Options[FormGroupoid]}];
		keyForm = KeyForm/.Flatten[{opts, Options[FormGroupoid]}];
		cayleyForm = CayleyForm/.Flatten[{opts, Options[FormGroupoid]}];
		maxshow = MaxElementsToList/.Flatten[{opts, Options[FormGroupoid]}];
		op = (tab[[#1//Position[list,#]&//First,
               #2//Position[list,#]&//First]]//
               Flatten//First)&;
    AppendTo[ei, {opts}];
		G = groupoid[list, op, ei];
		FormatOpQ[G] = formop;
		FormatElsQ[G] = If[Length[list] > maxshow, True, formels];
		currentGroupoid = G;
		WideElementsQ[G] = wideq;
		KeyForm[G] = keyForm;
		CayleyForm[G] = cayleyForm;
		GeneratingSet[G] = If[genset === {}, $Failed,
			If[Union[Elements[Closure[G,genset]]]===Union[list],
			genset,$Failed]];
		If[groupq,groupQ[G] = groupq];
		GroupoidDescription[G] = grpdesc;
		GroupoidName[G] = If[grpnm === "", "TheGroup", grpnm];
		If[untestedQ[GroupInfo[G]],
			GroupInfo[G] = {};
			If[grpnm =!= "", AppendTo[GroupInfo[G],grpnm]];
			If[grpdesc =!= "", AppendTo[GroupInfo[G],grpdesc]];
			];
		(* start tracking info about groupoid if not yet started *)
		OperatorSymbol[G] = opsymb;
		ProcessInfo[G,opts];
		G]


(* ::Subsection::Closed:: *)
(* 16.5 GenerateGroupoid*)


Options[GenerateGroupoid] := {CayleyForm -> StandardForm, 
FormatElements -> False, FormatOperator -> True, Generators -> {},
GroupoidDescription -> "", GroupoidName -> "TheGroup", 
IsAGroup -> False, KeyForm -> InputForm, MaxElementsToList -> 50, 
SizeLimit -> 25, WideElements -> False};

(* changed CayleyForm from OutputForm to StandardForm 11/8/06 *)

GenerateGroupoid[generators_List,op_,opsymb_String:"*",opts___?OptionQ]:=
	Module[{n,elem=generators,optable,G,done=False,max, wideq, ei,
		groupq,grpdesc,grpnm,list,maxshow,formels,formop,iter=0,
		keyForm,cayleyForm, genset},
	max = SizeLimit/.Flatten[{opts, Options[GenerateGroupoid]}];
	wideq = WideElements/.Flatten[{opts, Options[GenerateGroupoid]}];
	groupq = IsAGroup/.Flatten[{opts, Options[GenerateGroupoid]}];
	ei = ExtraInformation/.Flatten[{opts, Options[FormGroupoidExtra]}];
	genset = Generators/.Flatten[{opts, Options[GenerateGroupoid]}];
	grpdesc = GroupoidDescription/.Flatten[{opts, Options[GenerateGroupoid]}];
	grpnm = GroupoidName/.Flatten[{opts, Options[GenerateGroupoid]}];
	grpinpstr = GroupoidInputString/.Flatten[{opts, Options[FormGroupoid]}];
	formop = FormatOperator/.Flatten[{opts, Options[GenerateGroupoid]}];
	formels = FormatElements/.Flatten[{opts, Options[GenerateGroupoid]}];
	keyForm = KeyForm/.Flatten[{opts, Options[GenerateGroupoid]}];
	cayleyForm = CayleyForm/.Flatten[{opts, Options[GenerateGroupoid]}];
	maxshow = MaxElementsToList/.Flatten[{opts, Options[GenerateGroupoid]}];
	n = Length[elem];
	AppendTo[ei, {opts}];
	While[(Length[elem]<=max) && Not[done],
		(*optable=Apply[op,Table[{elem[[i]],elem[[j]]},
			{i,1,n},{j,1,n}],{2}];
		If[Sort[Union[elem,Flatten[optable,1]]]===Sort[elem],
			list = Sort[elem];*)
		iter++;
		optable=CloseSets[elem,elem,op];
		If[Sort[Union[elem,optable]]===Sort[elem],
			list = Sort[elem];
			G = groupoid[list, op, ei];
			FormatOpQ[G] = formop;
			FormatElsQ[G] = If[Length[list] > maxshow, True, formels];
			GeneratingSet[G] = generators;
			done=True,
		elem=Union[elem,optable]];
		n = Length[elem];
	];(*end of While *)
	If[done,
		If[untestedQ[GroupInfo[G]],
			GroupInfo[G] = {};
			If[grpnm =!= "", AppendTo[GroupInfo[G],grpnm]];
			If[grpdesc =!= "", AppendTo[GroupInfo[G],grpdesc]];
			];
		WideElementsQ[G] = wideq;
		KeyForm[G] = keyForm;
		CayleyForm[G] = cayleyForm;
		If[groupq,groupQ[G] = groupq];
		GroupoidDescription[G] = grpdesc;
		GroupoidInputString[G] = If[grpnm === "", 
			"GenerateGroupoid["<>ToString[generators]<>", "<>ToString[op]<>"]", 
			grpinpstr];
		GroupoidName[G] = If[grpnm === "", "TheGroup", grpnm];
		OperatorSymbol[G] = opsymb;
		ProcessInfo[G,opts];
		G,
		(* start tracking info about groupoid if not yet started *)
		(*else*) Message[GenerateGroupoid::size,max];
			elem]];


(* ::Subsection:: *)
(* 16.7 FormGroupoidFromCycles*)


Options[FormGroupoidFromCycles] = {WideElements -> True, IsAGroup -> False,
	Generators -> {}, GroupoidDescription -> "this is a group of permutations", 
	GroupoidName -> "TheGroup", 
	FormatOperator->True,
	FormatElements -> False, MaxElementsToList -> 25,
	KeyForm -> InputForm, CayleyForm -> StandardForm, ProductOrder -> RightToLeft};

(* changed CayleyForm from OutputForm to StandardForm 11/8/06 *)

FormGroupoidFromCycles[cl_List, opts___?OptionQ] :=
	Module[{G,wideq,groupq,genset,grpdesc,grpnm,optional,formop,
	formels,maxshow,keyForm, perms,c,po,ei, cayleyForm},
		ei = ExtraInformation/.Flatten[{opts, 
			Options[FormGroupoidExtra]}];
		wideq = WideElements/.Flatten[{opts, Options[FormGroupoidFromCycles]}];
		groupq = IsAGroup/.Flatten[{opts, Options[FormGroupoidFromCycles]}];
		genset = Generators/.Flatten[{opts, Options[FormGroupoidFromCycles]}];
		grpdesc = GroupoidDescription/.Flatten[{opts, Options[FormGroupoidFromCycles]}];
		grpnm = GroupoidName/.Flatten[{opts, Options[FormGroupoidFromCycles]}];
		grpinpstr = GroupoidInputString/.Flatten[{opts, Options[FormGroupoid]}];
		formop = FormatOperator/.Flatten[{opts, Options[FormGroupoidFromCycles]}];
		formels = FormatElements/.Flatten[{opts, Options[FormGroupoidFromCycles]}];
		keyForm = KeyForm/.Flatten[{opts, Options[FormGroupoidFromCycles]}];
		cayleyForm = CayleyForm/.Flatten[{opts, Options[FormGroupoidFromCycles]}];
		po = ProductOrder/.Flatten[{opts, Options[FormGroupoidFromCycles]}];
		maxshow = MaxElementsToList/.Flatten[{opts, Options[FormGroupoidFromCycles]}];
		If[Apply[And,Map[PermutationOrCycleQ,cl]],
			perms = cl /. Cycle[c__] :> ToPermutation[Cycle[c]];
			AppendTo[ei, {opts}];
			perms = Map[ExtendPermutation[#,Max[Map[Length,perms]]]&,perms];
			G = groupoid[perms, MultiplyPermutations[#1,#2,
				ProductOrder -> po]&, ei];
			FormatOpQ[G] = formop;
			FormatElsQ[G] = If[Length[perms] > maxshow, True, formels];
			WideElementsQ[G] = wideq;
			If[wideq, KeyForm[G] = keyForm;
				CayleyForm[G] = cayleyForm];
			GeneratingSet[G] = {};
			If[groupq, groupQ[G] = groupq];
			GroupoidDescription[G] = grpdesc;
			GroupoidName[G] = If[grpnm === "", "TheGroup", grpnm];
			If[untestedQ[GroupInfo[G]],
				GroupInfo[G] = {};
				If[grpnm =!= "", AppendTo[GroupInfo[G],grpnm]];
				If[grpdesc =!= "", AppendTo[GroupInfo[G],grpdesc]];
			];
		(* start tracking info about groupoid if not yet started *)
			OperatorSymbol[G] = "*";
			ProcessInfo[G,opts];
			G]]

FormGroupoidFromCycles[cl__?PermutationOrCycleQ, opts___?OptionQ] := 
	FormGroupoidFromCycles[{cl}, opts]


(* ::Subsection::Closed:: *)
(* 16.8 FormRingoid*)


Options[FormRingoid] = {CayleyForm -> StandardForm, FormatElements -> 
False, FormatOperator -> True, IsARing -> False, KeyForm -> 
InputForm, MaxElementsToList -> 50, RingoidDescription -> "", 
RingoidName -> "TheRing", WideElements -> False};

(* changed CayleyForm from OutputForm to StandardForm 11/8/06 *)

Options[FormRingoidExtra] = {ExtraInformation -> {{},{},{},{},{}}};
(* Information that can go here: {{True/False if ring or not},
	{Zero of Ring or Null, Unity of Ring or Null}, {quick function to
	calculate negations, quick function to calculate mult. inverses}, 
	{a minimal generating set for additive group}, {any other extra
	information entered on ad hoc basis for special functions - best
	to use rules here}}*)

GatherRingoidOptions[G_?RingoidQ] := Sequence[WideElements -> 
WideElementsQ[G],	RingoidDescription -> RingoidDescription[G], 
RingoidName -> RingoidName[G], FormatOperator -> FormatOpQ[G], 
FormatElements -> FormatElsQ[G], KeyForm -> KeyForm[G], 
CayleyForm -> CayleyForm[G]]
	
GatherSubRingoidOptions[G_?RingoidQ] := Sequence[WideElements -> 
WideElementsQ[G],	RingoidDescription -> "Subringoid of "<> 
RingoidDescription[G], 	RingoidName -> "sub "<>RingoidName[G],
	FormatOperator -> FormatOpQ[G], FormatElements -> FormatElsQ[G],
	KeyForm -> KeyForm[G], CayleyForm -> CayleyForm[G]]

FormRingoid[list_List, addition_, multiplication_,
		opsymbols_List:{"+","*"}, opts___?OptionQ] :=
	Module[{R,wideq,ringq,genset,rngdesc,rngnm,optional,formop,
	formels,maxshow,keyForm,cayleyForm, ei},
		wideq = WideElements/.Flatten[{opts, Options[FormRingoid]}];
		ei = ExtraInformation/.Flatten[{opts, Options[FormRingoidExtra]}];
		ringq = IsARing/.Flatten[{opts, Options[FormRingoid]}];
		rngdesc = RingoidDescription/.Flatten[{opts, Options[FormRingoid]}];
		rngnm = RingoidName/.Flatten[{opts, Options[FormRingoid]}];
		formop = FormatOperator/.Flatten[{opts, Options[FormRingoid]}];
		keyForm = KeyForm/.Flatten[{opts, Options[FormRingoid]}];
		cayleyForm = CayleyForm/.Flatten[{opts, Options[FormRingoid]}];
		formels = FormatElements/.Flatten[{opts, Options[FormRingoid]}];
		maxshow = MaxElementsToList/.Flatten[{opts, Options[FormRingoid]}];
		AppendTo[ei, {opts}];
		R = ringoid[list, addition, multiplication, ei];
		FormatOpQ[R] = formop;
		FormatElsQ[R] = If[Length[list] > maxshow, True, formels];
		WideElementsQ[R] = wideq;
		KeyForm[R] = keyForm;
		CayleyForm[R] = cayleyForm;
		If[ringq,ringQ[R] = ringq];
		RingoidDescription[R] = rngdesc;
		RingoidName[R] = If[rngnm === "", "TheRing", rngnm];
		If[untestedQ[RingInfo[R]],
			RingInfo[R] = {};
			If[rngnm =!= "", AppendTo[RingInfo[R],rngnm]];
			If[rngdesc =!= "", AppendTo[RingInfo[R],rngdesc]];
			];
		(* start tracking info about groupoid if not yet started *)
		PlusSymbol[R] = opsymbols[[1]];
		TimesSymbol[R] = opsymbols[[2]];
		ProcessRingInfo[R,opts];
		R]
(* note that the R created is a ringoid not Ringoid *)


(* ::Subsection:: *)
(* 16.10 ReorderGroupoid*)


ReorderGroupoid[G_?GroupoidQ, neworder_List] :=
	If[SameSetQ[neworder, Elements[G]],
		FormGroupoid[neworder, Operation[G], OperatorSymbol[G], 
			GatherGroupoidOptions[G]],
		Message[Groupoid::reorderfail, theGroupName[G], neworder]]


(* ::Subsection:: *)
(* 16.10.5 ReorderRingoid*)


ReorderRingoid[G_?RingoidQ, neworder_List] :=
	If[SameSetQ[neworder, Elements[G]],
		FormRingoid[neworder, Addition[G], Multiplication[G], 
			{PlusSymbol[G], TimesSymbol[G]}, 
			GatherRingoidOptions[G]],
		Message[Groupoid::reorderfail, theRingName[G], neworder]]


(* ::Subsection:: *)
(* 16.11 RandomGroupoid*)


RandomGroupoid[n_Integer?Positive, 1] := Module[{els, tab},
	els = Table["g"<>ToString[i], {i, n}];
	tab = Partition[RandomElements[els, n^2],n];
	FormGroupoidByTable[els, tab, GroupoidName -> "Random1"]]
	
RandomGroupoid[n_Integer?Positive, 2] := Module[{els, tab},
	els = Table["g"<>ToString[i], {i, n}];
	tab = Table[Randomize[els],{n}];
	FormGroupoidByTable[els, tab, GroupoidName -> "Random2"]]
	
RandomGroupoid[n_Integer?Positive, 3] := Module[{els, tab},
	els = Table["g"<>ToString[i], {i, n}];
	tab = Transpose[Table[Randomize[els],{n}]];
	FormGroupoidByTable[els, tab, GroupoidName -> "Random3"]]
	
RandomGroupoid[n_Integer?Positive, 4] := 	$Failed
(* still under construction *)


(* ::Subsection::Closed:: *)
(* 16.12 SortGroupoid*)


SortGroupoid[G_?GroupoidQ] := ReorderGroupoid[G, Sort[Elements[G]]]


(* ::Subsection:: *)
(* 16.12.5 SortRingoid*)


SortRingoid[G_?RingoidQ] := SortRingoid[G, Sort[Elements[G]]]


(* ::Subsection:: *)
(*16.13 GenerateGroupoidByRelations and FormGroupoidByRelations*)


(* ::Subsubsection:: *)
(*GenerateGroupoidByRelations*)


GenerateGroupoidByRelations[gens_List,rels_List,opts___]:=Module[{RelationGRule,a,s,t,i,j,x,p,q,eq,lhs,rhs,g,dom,max},
RelationGRule[eq_Equal]:=(lhs=(g@@{Pattern[p,BlankNullSequence[]],Sequence@@((If[Head[eq[[1]]]===NonCommutativeMultiply,List@@eq[[1]],{eq[[1]]}]//.({s___,x_^i_,t___}:>{s,x^(i-1),x,t}/;(i>1)))),Pattern[q,BlankNullSequence[]]});rhs=g@@((If[Head[eq[[2]]]===NonCommutativeMultiply,List@@eq[[2]],{eq[[2]]}]//.{{s___,x_^i_,t___}:>{s,x^(i-1),x,t}/;(i>1),{s___,e,t___}:>{s,t}})//{p,Sequence@@#,q}&);SetDelayed@@{lhs,rhs};eq);(Map[RelationGRule[#]&,rels];
Format[g[]]=e;g[pre___,e,post___]:=g[pre,post];
     Format[g[p__]]:=(NonCommutativeMultiply[p]//.{s___**x_^(i_:1)**x_^(j_:1)**t___:>s**x^(i+j)**t}/.{NonCommutativeMultiply[a_]:>a});
max=(SizeLimit/.{opts})/.Options[GenerateGroupoid];
dom=Flatten[GenerateGroupoidByStages[g/@gens,g[Sequence@@#1,Sequence@@#2]&,max]];If[Length[dom]<=max,
FormGroupoid[dom,g[Sequence@@#1,Sequence@@#2]&,WideElements->True],Message[GenerateGroupoid::size,SizeLimit/.Options[GenerateGroupoid]];dom])]


(* ::Subsubsection:: *)
(*FormGroupoidByRelations*)


FormGroupoidByRelations[gens_List,rels_List]:=Module[{RelationGRule,a,s,t,i,j,x,p,q,eq,lhs,rhs,g},
	RelationGRule[eq_Equal]:=(lhs=(g@@{Pattern[p,BlankNullSequence[]],Sequence@@((If[Head[eq[[1]]]===NonCommutativeMultiply,List@@eq[[1]],{eq[[1]]}]//.({s___,x_^i_,t___}:>{s,x^(i-1),x,t}/;(i>1)))),Pattern[q,BlankNullSequence[]]});rhs=g@@((If[Head[eq[[2]]]===NonCommutativeMultiply,List@@eq[[2]],{eq[[2]]}]//.{{s___,x_^i_,t___}:>{s,x^(i-1),x,t}/;(i>1),{s___,e,t___}:>{s,t}})//{p,Sequence@@#,q}&);SetDelayed@@{lhs,rhs};eq);Clear[g];(Map[RelationGRule[#]&,rels];
Format[g[]]=e;
     Format[g[p__]]:=(NonCommutativeMultiply[p]//.{s___**x_^(i_:1)**x_^(j_:1)**t___:>s**x^(i+j)**t}/.{NonCommutativeMultiply[a_]:>a});FormGroupoid[g/@gens,g[Sequence@@#1,Sequence@@#2]&,WideElements->True])]


(* ::Subsubsection:: *)
(*Staged Generation*)


GenerateGroupoidByStages[gens_,op_Function,maxsize_,k_:Infinity]:=FixedPointList[(FormGroupoid[#,op]//Union[#[[1]],Flatten[CayleyTable[#, Mode->Computational]]]&)&,gens,k,SameTest->(((#1==#2)||(Length[#2]>maxsize))&)]//Prepend[#,{}]&//Partition[#,2,1]&//Map[Complement[#[[2]],#[[1]]]&,#]&

GenerateGroupoidByStages[gens_,rels_List]:=Module[{G=FormGroupoidByRelations[gens,rels]},
GenerateGroupoidByStages[G[[1]],G[[2]]]]

GenerateGroupoidByStages[gens_,rels_List,maxsize_]:=Module[{G=FormGroupoidByRelations[gens,rels]},
GenerateGroupoidByStages[G[[1]],G[[2]],maxsize]]

GenerateGroupoidByStages[gens_,rels_List,maxsize_,k_]:=Module[{G=FormGroupoidByRelations[gens,rels]},
GenerateGroupoidByStages[G[[1]],G[[2]],maxsize,k]]


(* ::Section:: *)
(* 17. Families of groupoids*)


(* ::Subsection:: *)
(*17.0 Palette defs*)


(* ::Subsection:: *)
(*17.1 - Cyclic group of order n*)


Options[CyclicGroupAA]={Mode->Computational,Generator->"g"};

CyclicGroupAA[args___]:=Cyclic[args]

Options[Cyclic]={Mode->Computational,Generator->"g"};

SetAttributes[CyclicProd,Listable]

CyclicProd[a_^(b_:1),c_^(d_:1),order_Integer?Positive]:=Which[a===1&&c===1,1,a===1&&c=!=1,c^(Mod[d,order]),a=!=1&&c===1,a^(Mod[b,order]),a=!=1&&c=!=1&&a===c,c^(Mod[b+d,order]),True,Print["Nonsense!"]];

Cyclic[n_Integer?Positive,opts___?OptionQ]:=
	Module[{mymode,G,gen,sc},
		mymode=Mode/.Flatten[{opts,Options[Cyclic]}];
		gen=Generator/.Flatten[{opts,Options[Cyclic]}];
		If[mymode===Textual && Head[gen]===String,Return[CyclicT[n,Mode->Textual,Generator-> gen, opts]]];
		If[mymode===Visual && Head[gen]===String,Return[CyclicV[n,Mode->Visual,Generator-> gen, opts]]];
		If[mymode===Interactive && Head[gen]===String,Return[CyclicI[n,Mode->Interactive,Generator-> gen, opts]]];
		If[mymode===All && Head[gen]===String,Return[CyclicA[n,Mode->All,Generator-> gen, opts]]];
		If[Head[gen]=!=String&&Head[gen]=!=Symbol,
			Message[Generator::"string",gen];$Failed,
			If[gen===1&&n>1,
				Z[n],
				If[n==1,
					G=FormGroupoid[{gen},trivProd,"*",IsAGroup->True,
						Generators->{gen},
						GroupoidDescription->"Trivial group expressed multiplicatively",
						GroupoidInputString->"Cyclic[1]",
						GroupoidName->StringJoin["Cyclic[1]"]],
					G=GenerateGroupoid[{gen},CyclicProd[#1,#2,n]&,IsAGroup->True,
						Generators->{gen},WideElements->If[n<9,False,True],
						SizeLimit -> 100,
						GroupoidDescription->"Cyclic group expressed multiplicatively",
						GroupoidInputString->"Cyclic["<>ToString[n]<>"]",
						GroupoidName->"Cyclic["<>ToString[n]<>"]",opts]]
		]]]/;n < 100

(* TODO add message if n>=100 *)

CyclicT[n_Integer?Positive,Mode->Textual, Generator->gen_, opts___?OptionQ]:= 
	CyclicTextual[n,Elements[Cyclic[n,Generator->gen]],opts]

CyclicV[n_Integer?Positive,Mode->Visual, Generator->gen_, opts___?OptionQ]:= 
	CyclicVisual[n,-1,Elements[Cyclic[n,Generator->gen]],gen, opts]

CyclicA[n_Integer?Positive, Mode -> All, Generator->gen_, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> Cyclic[n, Generator->gen],
	"Explanation" -> Cyclic[n, Mode->Textual, Generator->gen, opts, ConvertMode -> "All"],
	"Visualization" -> Cyclic[n, Mode->Visual, Generator->gen, opts, ConvertMode -> "All"],
	"Interactive" -> Cyclic[n, Mode->Interactive, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"The cyclic group of order "<>ToString[n]<>" with generator "<>ToString[gen], Top]

Options[CyclicInteractive]={Min -> 2, Max -> 99};

CyclicIn[n_Integer?Positive, Mode -> Interactive, Generator->gen_, InteractiveMode->mode_, opts___?OptionQ]:=
	Module[{min, max,showhelp},
	min = Min/.Flatten[{opts, Options[CyclicInteractive]}];
	max = Max/.Flatten[{opts, Options[CyclicInteractive]}];
	showhelp = ShowHelp/.Flatten[{opts, Options[HelpMessages]}];
	If[mode===Visual || mode===Textual,
		Manipulate[Cyclic[k, Mode -> mode, Generator->gen, ShowHelp->showhelp, opts, ShowConvert -> False],{{k, n, "n"}, min, max, 1,
	Appearance->"Open"}],
		Manipulate[Cyclic[k, Mode -> mode, Generator->gen],{{k, n, "n"}, min, max, 1,
	Appearance->"Open"}]]
	
]

CyclicI[n_Integer?Positive, Mode -> Interactive, Generator->gen_, opts___?OptionQ]:= Module[{im},
	im = InteractiveMode/.Flatten[{opts}];
	Which[im===Computational,
		CyclicIn[n,Mode->Interactive, Generator->gen, InteractiveMode -> Computational, opts],
		im === Textual,
		CyclicIn[n,Mode->Interactive, Generator->gen, InteractiveMode -> Textual, opts],
		im ===Visual,
		CyclicIn[n, Mode->Interactive, Generator->gen, InteractiveMode -> Visual, opts],
		True,
		Labeled[TabView[{"Computation" -> 
		CyclicIn[n,Mode->Interactive, Generator->gen, InteractiveMode -> Computational, opts],
	"Explanation" -> CyclicIn[n,Mode->Interactive, Generator->gen, InteractiveMode -> Textual, opts],
	"Visualization" -> CyclicIn[n, Mode->Interactive, Generator->gen, InteractiveMode -> Visual, opts]}, 
	ImageSize->Automatic],"Interacting with Cyclic[n]", Top]]
]

CyclicHelp[n_,gen_]:=DoHelpMessage[windowtitle->"Help for the group Cyclic["<>ToString[n]<>"]",
	help-> List["Think of the elements in the group Cyclic[",
		ToString[n],
		"] as the numbers on a (modified) clock where we identity 12 (noon or midnight) with the first element in the group, 1. The rest of the elements are viewed as powers of the generator ",
		Cell[BoxData[
 FormBox[gen, TraditionalForm]],
 FormatType->"TraditionalForm"],". Multiplication of two elements is done by adding the exponents on the elements (and then reducing, if necessary, mod "<>ToString[n]<>"), just like adding the hours of a clock."
		]]



CyclicHelp[n_,k_,gen_]:= DoHelpMessage[windowtitle->"Help for the group Cyclic["<>ToString[n]<>","<>ToString[k]<>"]",
	help-> List["Think of the elements in the group Cyclic[",
		ToString[n],
		"] as the numbers on a (modified) clock where we identity 12 (noon or midnight) with the first element in the group, 1. The rest of the elements are viewed as powers of the generator ",
		Cell[BoxData[
 FormBox[gen, TraditionalForm]],
 FormatType->"TraditionalForm"],". Multiplication of two elements is done by adding the exponents on the elements (and then reducing, if necessary, mod "<>ToString[n]<>"), just like adding the hours of a clock. Note that here we only have the ",
	ToString[n/k]<>" elements in blue that are part of the group, occurring with exponents as multiples of ",
	ToString[k]<>". Thus, the red ones are skipped over and not part of the group."
		]]

Cyclic[n_Integer?Positive,k_Integer?Positive,opts___?OptionQ]:=
	Module[{G,gen,sc,mymode},
		gen=Generator/.Flatten[{Options[Cyclic]}];
		mymode=Mode/.Flatten[{opts,Options[Cyclic]}];
		If[mymode===Textual && Head[gen]===String && Mod[n,k]==0,
			Return[CyclicT[n,k,Mode->Textual,Generator-> gen, opts]]];
		If[mymode===Visual && Head[gen]===String && Mod[n,k]==0,
			Return[CyclicV[n,k,Mode->Visual,Generator-> gen, opts]]];
		If[mymode===All && Head[gen]===String && Mod[n,k]==0,
			Return[CyclicA[n,k,Mode->All,Generator-> gen, opts]]];
		If[Head[gen]=!=String&&Head[gen]=!=Symbol,
			Message[Generator::"string",gen],
			If[Mod[n,k]==0,
				If[gen===1&&n>1,
					G=Z[n,k],
					G=GenerateGroupoid[{gen^k},CyclicProd[#1,#2,n]&,
						IsAGroup->True,Generators->{gen},
						GroupoidDescription->"Cyclic group expressed multiplicatively",
						GroupoidInputString->"Cyclic["<>ToString[n]<>","<>ToString[k]<>"]",
						GroupoidName->"Cyclic["<>ToString[n]<>","<>ToString[k]<>"]"]],
				Message[Groupoid::"modd",k,n];G=$Failed];G]]

CyclicT[n_Integer?Positive, k_, Mode->Textual, Generator->gen_,opts___?OptionQ]:= 
	CyclicTextual[n,Elements[Cyclic[n,k,Generator->gen]], opts]

CyclicV[n_Integer?Positive,k_, Mode->Visual, Generator->gen_,opts___?OptionQ]:= 
	CyclicVisual[n,k,Elements[Cyclic[n,Generator->gen]],gen, opts]

CyclicA[n_Integer?Positive, k_, Mode -> All, Generator->gen_, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> Cyclic[n, k, Generator->gen],
	"Explanation" -> Cyclic[n,k,Mode->Textual, Generator->gen, opts, ConvertMode -> "All"],
	"Visualization" -> Cyclic[n, k, Mode->Visual, Generator->gen,opts, ShowConvert -> False]}, 
	ImageSize->Automatic],"The cyclic group of order "<>ToString[n]<>" with generator "<>ToString[gen], Top]

CyclicTextual[n_,els_, opts___?OptionQ]:= Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	text = Column[{"This groupoid consists of the following elements:",els,"The group operation is multiplication and so the exponents are added and then reduced mod "<>ToString[n]<>"."}];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]

CyclicVisual[n_,k_,els_,gen_,  opts___?OptionQ]:=
	If[k==-1,
		DoVisualization[MakeCircle[n,els,Blue,SequenceForm],{{n,gen},CyclicHelp},opts],
		DoVisualization[MakeCircle[n,k,els,SequenceForm],{{n,k,gen},CyclicHelp},opts]]
	

Cyclic[many:{_Integer?Positive..},Mode->mode_]:=
	Column[Map[Cyclic[#,Mode->mode]&,many]]

Cyclic[many:{_Integer?Positive..}]:=
	Map[Cyclic,many]

Cyclic[n_,opts___]:=(Message[Cyclic::"intpm","Cyclic["<>ToString[n]<>"]",1];$Failed)


(* ::Subsection:: *)
(*17.2 - Z - integers mod n under addition*)


Unprotect[Z];

Options[Z]={Mode -> Computational, Structure :> DefaultStructure};

Z[n_Integer?Positive] := If[(Structure/. Options[Z]) === Group,
	ZG[n], ZR[n]];
	
(* Z[Sqrt[n_Integer?Positive]] := ZSq[n]

Z[Power[n_Integer?Positive, Rational[1,2]]] := ZSq[n]

comment out on 7/26/04 *)

Z[n_Integer?Positive, Structure -> Group] := ZG[n]

Z[n_Integer?Positive, Structure -> Ring] := ZR[n]

Z[n_Integer?Positive, k_Integer?Positive] := 
If[(Structure/. Options[Z]) === Group, ZG[n,k], ZR[n,k]];
	
Z[n_Integer?Positive,  opts__?OptionQ] := 
	If[(Structure/.Flatten[{opts, Options[Z]}]) === Group,
		ZG[n, opts], ZR[n, opts]];

Z[n_Integer?Positive, k_Integer?Positive, Structure -> Group,
	opts___?OptionQ] := ZG[n, k, opts]
	
Z[n_Integer?Positive, k_Integer?Positive, Structure -> Ring,
	opts___?OptionQ] := ZR[n, k, opts]

Z[n_Integer?Positive, k_Integer?Positive, opts__?OptionQ] := 
	If[(Structure/.Flatten[{opts, Options[Z]}]) === Group,
		ZG[n, k, opts], ZR[n, k, opts]];

Z[n_Integer?Positive, Structure -> Group, opts__?OptionQ] :=
	ZG[n, opts]
	
Z[n_Integer?Positive, Structure -> Ring, opts__?OptionQ] :=
	ZR[n, opts]

Z[n_Integer?Positive, opts__?OptionQ, Structure -> Group, opts2__?OptionQ] :=
	ZG[n, Join[opts,opts2]]
	
Z[n_Integer?Positive, opts__?OptionQ, Structure -> Ring, opts__?OptionQ] :=
	ZR[n, opts]
	
Unprotect[ZG];
ZG[n_Integer?Positive] := (Unprotect[ZG];
	ZG[n] =
		FormGroupoid[Range[0,n-1], Mod[#1 + #2,n]&,"+",
			IsAGroup -> True, FormatOperator->False, Generators -> {1},
			GroupoidDescription -> "Integers mod n under addition",
			GroupoidInputString ->StringJoin["Z[",ToString[n],"]"],
			GroupoidName ->StringJoin["Z[",ToString[n],"]"]];
		Protect[ZG]; ZG[n])

Unprotect[ZG];

ZG[n_Integer?Positive, Mode -> Textual, opts___?OptionQ]:=ZGTextual[n, opts]

ZG[n_Integer?Positive, Mode -> Visual, opts___?OptionQ]:=ZGVisual[n, opts]

ZG[n_Integer?Positive, Mode -> Computational] := ZG[n]

Options[ZGInteractive]={Min -> 2, Max -> 100};

ZG[n_Integer?Positive, Mode -> Interactive, InteractiveMode->mode_, opts___?OptionQ]:=
	Module[{min, max,showhelp},
	min = Min/.Flatten[{opts, Options[ZGInteractive]}];
	max = Max/.Flatten[{opts, Options[ZGInteractive]}];
	showhelp = ShowHelp/.Flatten[{opts, Options[HelpMessages]}];
	If[mode===Visual || mode===Textual,
		Manipulate[ZG[k, Mode -> mode, ShowHelp->showhelp, opts, ShowConvert -> False],{{k, n, "n"}, min, max, 1,
	Appearance->"Open"}],
		Manipulate[ZG[k, Mode -> mode],{{k, n, "n"}, min, max, 1,
	Appearance->"Open"}]]
	
]

ZG[n_Integer?Positive, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		ZG[n,Mode->Interactive, InteractiveMode -> Computational, opts],
	"Explanation" -> ZG[n,Mode->Interactive, InteractiveMode -> Textual, opts],
	"Visualization" -> ZG[n, Mode->Interactive, InteractiveMode -> Visual, opts]}, 
	ImageSize->Automatic],"Interacting with Z[n]", Top]

ZG[n_Integer?Positive, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> ZG[n],
	"Explanation" -> ZG[n, Mode->Textual, opts , ConvertMode -> "All"],
	"Visualization" -> ZG[n, Mode->Visual,opts, ConvertMode -> "All"],
	"Interactive" -> ZG[n, Mode->Interactive,opts, ShowConvert -> False]}, 
	ImageSize->Automatic],"The group Z["<>ToString[n]<>"]", Top]
	
ZG[n_Integer?Positive, k_Integer?Positive, opts___?OptionQ] :=
		Module[{mymode,G,st,sc},
	mymode = Mode/.Flatten[{opts, Options[Z]}];
	If[Mod[n, k]==0,
		If[mymode===Textual,Return[ZGTextual[n,k,opts]]];
		If[mymode===Visual,Return[ZGVisual[n,k,opts]]];
		If[mymode===All,Return[ZGAllnk[n,k,opts]]];
		G = FormGroupoid[Range[0,n-1,k], Mod[#1 + #2,n]&,"+",
			IsAGroup -> True,
			FormatOperator->False,
			Generators -> {k},
			GroupoidDescription -> "subgoup of integers mod n under addition",
			GroupoidInputString ->StringJoin["Z[",ToString[n],",",ToString[k],"]"],
			GroupoidName ->StringJoin["Z[",ToString[n],",",ToString[k],"]"]],
	Message[Groupoid::modd,k,n]; $Failed]]
	
Protect[ZG];

ZGAllnk[n_Integer?Positive, k_Integer?Positive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> ZG[n, k],
	"Explanation" -> ZG[n, k, Mode->Textual, opts, ConvertMode -> "All"],
	"Visualization" -> ZG[n, k, Mode->Visual,opts, ConvertMode -> "All"]}, 
	ImageSize->Automatic],"The group Z["<>ToString[n]<>","<>ToString[k]<>"]", Top]

Z[many:{_Integer?Positive..}] := Map[Z, many]
	
Z[many:{_Integer?Positive..}, Mode -> mode_] :=
	Column[Map[ZG[#, Mode -> mode]&, many]]
		
Z[n_Integer, opts___?OptionQ] := (Message[Z::intpm,"Z["<>
ToString[n]<>"]",1];$Failed)
			
ZGVisual[n_Integer?Positive, opts___?OptionQ] := 
	DoVisualization[MakeCircle[n, Range[0,n-1]],{{n},ZGHelp},opts]


ZGHelp[n_]:= DoHelpMessage[windowtitle -> "Help for the group Z["<>ToString[n]<>"]", help ->
	StringJoin["Think of the elements of Z[", ToString[n], 
		"] as the numbers on a (modified) clock, where we identify 12 (noon or midnight) with the first element in the group, 0, and the rest of the elements are 1, 2, and so on. In this particular group, Z[",
		ToString[n], "], we also view 0 the same as  ",
		ToString[n],
		", the modulus used for this group. Addition of two numbers is just like adding hours on the clock except afterwards we reduce the sum using the modulus ",
		ToString[n],
		". (In other words, we subtract any multiples of this modulus.)"]]

ZGVisual[n_Integer?Positive, k_Integer, opts___?OptionQ] := 
	DoVisualization[ZGVisualw[n, k],{{n,k},ZGHelp},opts]

ZGHelp[n_,k_]:= DoHelpMessage[windowtitle -> "Help for the group Z[n, k]", help ->
	StringJoin["Think of the elements of Z[", ToString[n], 
		"] as the numbers on a (modified) clock, where we identify 12 (noon or midnight) with the first element in the group, 0, and the rest of the elements are 1, 2, and so on. In this particular group, Z[",
		ToString[n], "], we also view 0 the same as  ",
		ToString[n],
		", the modulus used for this group. Addition of two numbers is just like adding hours on the clock except afterwards we reduce the sum using the modulus ",
		ToString[n],
		" (i.e., subtracting any multiples of this modulus). In this case, however, we only consider the ",
		ToString[n/k],
		" blue elements (given as multiples of ",
		ToString[k]<>"), ignoring the red ones."]]
		
ZGVisualw[n_Integer?Positive,k_Integer?Positive] := 
	Module[{rng = Range[0,n-1], blue},
	Show[{modCircle[n,k],
		LabelingNgon[rng, blue=Range[0,n-1,k], insideLabelFactor, 
		InputForm]}]]

ZGTextual[n_, opts___?OptionQ] := Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	text = StringJoin["This groupoid consists of the elements ",
		ToString[Range[0,n-1]],
		" with the operation being addition mod ",ToString[n],". The sum of two elements x and y is given by (x + y) (mod ",ToString[n],"), which results in the remainder of (x + y) upon division by ",ToString[n],
		". For example, (7 + 8) (mod 12) = 3 (mod 12) in the same way that 8 hours after 7:00 is 3:00."];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
	]

ZGTextual[n_,k_, opts___?OptionQ] := 
Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	text = StringJoin["This groupoid consists of the elements ",
ToString[Range[0,n-1,k]],
" with the operation of addition mod ",ToString[n],". The sum of two elements x and y is given by (x + y) (mod ",ToString[n],"), which means the remainder of (x + y) upon division by ",ToString[n],
". For example, (7 + 8) (mod 12) = 3 (mod 12) in the same way that 8 hours after 7:00 is 3:00."];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
	]

Protect[Z];


(* ::Subsection:: *)
(*17.3 - Zx - integers mod n under multiplication*)


Unprotect[Zx];

Options[Zx] = {Mode -> Computational};

Zx[n_Integer?Positive, k_Integer?Positive, opts___?OptionQ] :=
		Module[{mymode,G,st,sc},
	mymode = Mode/.Flatten[{opts, Options[Zx]}];
	st = Structure/.Flatten[{opts, Options[Zx]}];
	If[Mod[n, k]==0,
			G = FormGroupoid[Range[0,n-1,k], Mod[#1 #2,n]&,"*",
				FormatOperator->False,
				Generators -> {k},
				GroupoidDescription -> "subset of integers mod n under multiplication",
				GroupoidInputString ->StringJoin["Zx[",ToString[n],",",ToString[k],"]"],
				GroupoidName ->StringJoin["Zx[",ToString[n],",",ToString[k],"]"]],
		Message[Groupoid::modd,k,n]; $Failed]]

Zx[n_Integer?Positive,opts___?OptionQ] := Module[{mymode,G, sc},
	mymode = Mode/.Flatten[{opts, Options[Zx]}];
	If[mymode===Textual,Return[ZxTextual[n,opts]]];
	If[mymode===Visual,Return[ZxVisual[n,opts]]];
	If[mymode===All,Return[ZxAll[n,opts]]];
	G = FormGroupoid[Range[0,n-1], Mod[#1 #2,n]&,
		GroupoidDescription -> "Integers mod n under multiplication",
		FormatOperator->False,
		GroupoidInputString ->StringJoin["Zx[",ToString[n],"]"],
		GroupoidName ->StringJoin["Zx[",ToString[n],"]"]]
	]

ZxAll[n_Integer?Positive,opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> Zx[n],
	"Explanation" -> Zx[n, Mode->Textual, opts, ConvertMode -> "All"],
	"Visualization" -> Zx[n, Mode->Visual, opts, ShowConvert -> False]}, 
	ImageSize->Automatic],"The group Zx["<>ToString[n]<>"]", Top]

ZxTextual[n_,opts___?OptionQ] :=Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	text = StringJoin["This groupoid consists of the elements ",
			ToString[Range[0,n-1]],
			" with the operation of multiplication mod ",
			ToString[n],
			". The product of two elements x and y is given by (x*y) (mod ",
			ToString[n],"), which means the remainder of (x*y) upon division by ",
			ToString[n],
			". For example, (7*2) (mod 12) = 2 (mod 12) just as 2 shifts of 7 hours would be 14 hours, or 2 hours more than a full clock cycle."];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]
		
ZxVisual[n_,opts___?OptionQ] := 
	DoVisualization[MakeCircle[n,Range[0,n-1], Blue, 
		OutStdForm],{{n},ZxHelp},opts]

ZxHelp[n_]:= DoHelpMessage[windowtitle -> "Help for the group Zx["<>ToString[n]<>"]", help ->
	StringJoin["Think of the elements as the numbers on a (modified) clock. One main difference, however, is that we will view 0 as being equivalent to 12. Multiplication of two numbers is similar to \"multiplying\" hours on the clock: multiply the values together and then reduce mod "<>ToString[n]<>"."]
]

Zx[many:{_Integer?Positive..}, Mode -> mode_,opts___?OptionQ] :=
	Column[Map[Zx[#,Mode->mode, opts]&, many]]
		
Zx[many:{_Integer?Positive..}] :=
	Map[Zx[#]&, many]

(*Zx[n_, opts___] := (Message[Zx::intpm,"Zx["<>ToString[n]<>"]",1];$Failed)*)

Zx[n_Integer?Positive, I] := GaussianIntegersMultiplicative[n]	

Protect[Zx];


(* ::Subsection:: *)
(*17.4 - U - integers mod n relatively prime to n under multiplication*)


Unprotect[U];

Options[U]={Mode -> Computational};

U[n_Integer?Positive] := (Unprotect[U]; U[n] = 
	FormGroupoid[Range[0,n-1]//Select[#,(GCD[#,n]==1)&]&,
    	Mod[#1 #2,n]&,
    	FormatOperator->False,IsAGroup -> True,
    	GroupoidDescription -> "Integers less than n and relatively prime to n, under multiplication",
		GroupoidInputString -> StringJoin["U[",ToString[n],"]"],
		GroupoidName -> StringJoin["U[",ToString[n],"]"]]; 
		Protect[U]; U[n])

Unprotect[U];

U[n_Integer?Positive, Mode -> Computational]:= U[n]

U[n_Integer?Positive, Mode -> Textual, opts___?OptionQ]:= UTextual[n, Elements[U[n]],opts]

U[n_Integer?Positive, Mode -> Visual, opts___?OptionQ]:= UVisual[n, Elements[U[n]],opts]

Options[UInteractive]={Min -> 2, Max -> 100};

U[n_Integer?Positive, Mode -> Interactive, InteractiveMode->mode_, opts___?OptionQ]:=
	Module[{min, max, showhelp, cm},
	min = Min/.Flatten[{opts, Options[UInteractive]}];
	max = Max/.Flatten[{opts, Options[UInteractive]}];
	showhelp = ShowHelp/.Flatten[{opts, Options[HelpMessages]}];
	If[mode===Visual || mode===Textual,
		Manipulate[U[k, Mode -> mode, ShowHelp->showhelp, ShowConvert -> False, opts],{{k, n, "n"}, min, max, 1,
	Appearance->"Open"}],
		Manipulate[U[k, Mode -> mode],{{k, n, "n"}, min, max, 1,
	Appearance->"Open"}]]
]

U[n_Integer?Positive, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		U[n,Mode->Interactive, InteractiveMode -> Computational, opts],
	"Explanation" -> U[n,Mode->Interactive, InteractiveMode -> Textual, opts],
	"Visualization" -> U[n, Mode->Interactive, InteractiveMode -> Visual, opts]}, 
	ImageSize->Automatic],"Interacting with U[n]", Top]

U[n_Integer?Positive, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> U[n],
	"Explanation" -> U[n, Mode->Textual,opts, ConvertMode -> "All"],
	"Visualization" -> U[n, Mode->Visual,opts, ConvertMode -> "All"],
	"Interactive"-> U[n, Mode->Interactive,opts, ShowConvert -> False]}, 
	ImageSize->Automatic],"The group U["<>ToString[n]<>"]", Top]

UTextual[n_,els_, opts___?OptionQ] :=  Module[{text, showconvert, mode, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	text = StringJoin["This groupoid consists of the elements ",
			ToString[els],
			" with the operation being multiplication mod ",ToString[n],". The product of two elements x and y is given by (x*y) (mod ",ToString[n],"), which means the remainder of (x*y) upon division by ",ToString[n],". For example, (7*2) (mod 12) = 2 (mod 12) just as 2 shifts of 7 hours would be 14 hours, or 2 hours more than a full clock cycle. Note that not all of the elements from 0 to ",ToString[n-1]," are included. In fact, careful examination will reveal that all the elements in the list are those which are relatively prime to ",ToString[n],
			" (i.e., the GCD between the two elements is 1)."];
If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
	]
				
UVisualwk[n_,els_] := Module[{g1,g2},
	g1 = {modCircle[n, Red, 0.040],
	LabelingNgon[Range[0, n-1],els, 
		insideLabelFactor, InputForm]};
	g2 = Map[modPoint[#,n,Blue, 0.055]&,els];
	Show[{g1,g2},FormatType -> StandardForm,
			Ticks -> Automatic]]

UVisual[n_,els_, opts___?OptionQ] := 
	DoVisualization[UVisualwk[n,els],{{n},UHelp},opts]

UHelp[n_]:= DoHelpMessage[windowtitle -> "Help for the group U["<>ToString[n]<>"]", 
	help ->StringJoin["Think of the elements in U[",
	ToString[n]<>"] as certain numbers in the range 1 to ",
	ToString[n]," on a (modified) clock. One main difference, however, is that we will view the last element, ", ToString[n],", as being equivalent to zero (or noon or midnight, on a normal clock). Multiplication of two numbers is just like \"multiplying\" hours on the clock: multiply the values together and then reduce mod "<>ToString[n]<>". Note: only the blue dots represent elements of the group (since these values are relatively prime to the modulus "<>ToString[n]<>"."]
		]
	
U[many:{_Integer?Positive..}, Mode -> mode_,opts___?OptionQ] :=
	Column[Map[U[#, Mode -> mode, opts]&, many]]
		
U[many:{_Integer?Positive..}] :=
	Map[U, many]

(* U[n_, opts___?OptionQ] := (Message[U::intpm,"U["<>ToString[n]<>"]",1];$Failed)*)

Protect[U];


(* ::Subsection:: *)
(*17.5 - S - Symmetric group on n letters*)


Unprotect[Symmetric];

Symmetric::usage = "Symmetric[n,opts] returns the group of permutations on the set {1,2,..n} under composition. There are two options for this function, ProductOrder and IndexLimit. Since the elements of this group are permutations, one can specify the order that the product is taken by using ProductOrder; see ProductOrder for more information, including the values which can be used. IndexLimit defaults to 6 and indicates the upper limit for the value of the index n.\nIn addition, Symmetric is a System function, where Symmetric[{s1,...,sn }] represents the symmetry of a tensor that is symmetric in the slots si";

Options[Symmetric]={Mode -> Computational,
	ProductOrder -> RightToLeft, IndexLimit -> 6};

Symmetric[n_Integer?Positive] := Module[{G},Unprotect[Symmetric];Symmetric[n] = 
		Module[{mymode, po,sc,il},
	po = ProductOrder/.Flatten[{Options[Symmetric]}];
	il = IndexLimit/.Flatten[{Options[Symmetric]}];
DefaultOrder = If[po===RightToLeft,RightToLeft,LeftToRight];
If[n > il, Message[Group::size,StringJoin["S[",ToString[n],"]"],
		ToString[n!],il]; $Failed,
	G = FormGroupoid[Permutations[Range[1,n]],
  	MultiplyPermutations[#1,#2,
		ProductOrder -> DefaultOrder]&, 
		 FormatOperator->True, IsAGroup -> True,
		If[n>4,FormatElements->True,FormatElements->False],
    	GroupoidDescription -> "Symmetric group on n letters",
		GroupoidInputString ->StringJoin["S[",ToString[n],"]"],
		GroupoidName ->StringJoin["S[",ToString[n],"]"]];
	GroupIdentity[G] = Range[1,n];
	HasIdentityQ[G] = True;
	inverseFunction[G] = PermutationInverse;
	If[n>3,WideElementsQ[G] = True];
	G]];Protect[Symmetric];G]

Symmetric[n_Integer?Positive,opts___?OptionQ] := 
		Module[{mymode, G, po,sc,il},
	mymode = Mode/.Flatten[{opts, Options[Symmetric]}];
	po = ProductOrder/.Flatten[{opts, Options[Symmetric]}];
	il = IndexLimit/.Flatten[{opts, Options[Symmetric]}];
	DefaultOrder = If[po===RightToLeft,RightToLeft,LeftToRight];
	If[mymode===Textual,Return[SymmetricTextual[n, Elements[Symmetric[n]],opts]]];
If[n > il, Message[Group::size,StringJoin["S[",ToString[n],"]"],
		ToString[n!],il]; $Failed,
	Unprotect[Symmetric];Symmetric[n,opts] = FormGroupoid[Permutations[Range[1,n]],
  	MultiplyPermutations[#1,#2,
		ProductOrder -> DefaultOrder]&,
		  FormatOperator->True,IsAGroup -> True,
		FormatElements -> If[n>4, True,False], WideElements -> If[n>3, True,False],
    	GroupoidDescription -> "Symmetric group on n letters",
		GroupoidInputString ->StringJoin["S[",ToString[n],"]"],
		GroupoidName ->StringJoin["S[",ToString[n],"]"]];
	G = Symmetric[n,opts];
	GroupIdentity[G] = Range[1,n];
	HasIdentityQ[G] = True;
	inverseFunction[G] = PermutationInverse;Protect[Symmetric];
	If[Head[G[[1,1]]]=!=List,symmetric[n,opts]=.];
	G]]

(*		Removed due to System`Symmetric added in V9
Symmetric[many:{_Integer?Positive..}] :=
	Map[Symmetric,many]
*)
		
SymmetricTextual[n_,els_,opts___?OptionQ] := Module[{text, showconvert},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	text = Column[{"This groupoid consists of the elements that are permutations (rearragnements) of "<>ToString[n]<>" objects:",
	els,
	"For these elements, the operation is permutation multiplication (which amounts to function composition)."}];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
	]

Symmetric[n_Integer, opts___] := Message[Index::posint,Symmetric,n]

Protect[Symmetric]

Unprotect[S];

S[arg_Integer?Positive] := Symmetric[arg]

Protect[S];

SymmetricGroupAA[arg_Integer?Positive] := Symmetric[arg]

PermutationGroupAA[arg_Integer?Positive] := Symmetric[arg]

Options[SymmetricGroupAA] = {Mode -> Computational,
	ProductOrder -> RightToLeft};

SymmetricGroupAA[list_List,opts___?OptionQ] := 
		Module[{mymode, G, po, n = Length[list]},
	mymode = Mode/.Flatten[{opts, Options[Symmetric]}];
	po = ProductOrder/.Flatten[{opts, Options[Symmetric]}];
	DefaultOrder = If[po===RightToLeft,RightToLeft,LeftToRight];
	If[untestedQ[symmetricgroup[list,opts]],
		symmetricgroup[list,opts] = 
			FormGroupoid[Permutations[list],
  	MultiplyGeneralPermutations[list,#1,#2,
		ProductOrder -> DefaultOrder]&,
		 FormatOperator->True,IsAGroup -> True,
		FormatElements -> If[n>4, True,False], WideElements -> If[n>3, True,False],
    	GroupoidDescription -> "Permutation group of given list"]];
	G = symmetricgroup[list,opts];
	(* If[n>2,WideElementsQ[G] = True];*)
	If[MemberQ[textualModes,mymode], 
		out = SymmetricTextual[n]];
	G]/; Length[list]<= 6

PermutationGroupAA[list_List, opts___?OptionQ] := 
	SymmetricGroupAA[list,opts]

MultiplyGeneralPermutations[base_,g_,h_,opts___?OptionQ] :=
	Module[{rules,revrules,p,q,prod},
rules = MapThread[Rule,{base,Range[1,Length[base]]}];
revrules =Transpose[rules/.Rule->List]//Reverse//
	Transpose//Apply[Rule,#,1]&;
{p,q} = {g,h}/.rules;
prod = MultiplyPermutations[p,q,opts]/.revrules
]


(* ::Subsection:: *)
(*17.6 - A - Alternating group on n letters*)


Options[Alternating]={Mode -> Computational,
	ProductOrder -> RightToLeft, IndexLimit -> 6};

Alternating[n_Integer?Positive,opts___?OptionQ] := Alternating[n, opts] =
		Module[{mymode, G, po,sc,il},
	mymode = Mode/.Flatten[{opts, Options[Alternating]}];
	po = ProductOrder/.Flatten[{opts, Options[Alternating]}];
	DefaultOrder = If[po===RightToLeft,RightToLeft,LeftToRight];
	il = IndexLimit/.Flatten[{opts, Options[Alternating]}];
If[n > il, Message[Group::size,StringJoin["A[",ToString[n],"]"],
		ToString[n!/2],il]; $Failed,
	If[untestedQ[alternating[n,opts]],
		alternating[n,opts] = 
			FormGroupoid[Select[Permutations[Range[1,n]],
        	(Parity[#]==1)&],
  	MultiplyPermutations[#1,#2,
		ProductOrder -> DefaultOrder]&, 
		FormatOperator->True,IsAGroup -> True,
		FormatElements -> If[n>4, True,False], WideElements -> If[n>3, True,False],
    	GroupoidDescription -> "Alternating group on n letters",
		GroupoidInputString ->StringJoin["A[",ToString[n],"]"],
		GroupoidName ->StringJoin["A[",ToString[n],"]"]]];
	G = alternating[n,opts];
	If[mymode===Textual,Return[AlternatingTextual[n, Elements[G],opts]]];
	GroupIdentity[G] = Range[1,n];
	HasIdentityQ[G] = True;
	inverseFunction[G] = PermutationInverse;
	G]]

Clear[A]; (* added 9/12/08 *)
A[args__] := Alternating[args]

AlternatingGroupAA[args__] := Alternating[args]

Alternating[many:{_Integer?Positive..}, Mode -> mode_,opts___?OptionQ] :=
	Column[Map[Alternating[#,Mode->mode,opts]&,many]]
		
Alternating[many:{_Integer?Positive..}] :=
	Map[Alternating,many]

Alternating[n_, opts___] := Message[Index::posint,Alternating,n]
		
AlternatingTextual[n_,els_,opts___?OptionQ] := Module[{text, showconvert},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	text = Column[{"This groupoid consists of the even permutations",
	els,
	"The operation is permutation multiplication (composition), just as in the symmetric group."}];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
	]


(* ::Subsection:: *)
(*17.7 - D - Dihedral group of order 2n*)


Unprotect[D];

D[n_Integer?Positive, opts___?OptionQ] := Dihedral[n,opts]

Protect[D];

Options[Dihedral]={Mode -> Computational,
	Form -> RotRef,
	RotSym -> Rot,
	RefSym -> Ref};

Dihedral[n_Integer?Positive, opts___?OptionQ]:= 
	Module[{G,k, mymode, myform(*,myRotSym,myrefsymb*), sc, F},
	mymode = Mode/.Flatten[{opts, Options[Dihedral]}];
	myform = Form/.Flatten[{opts, Options[Dihedral]}];
	curDform = myform;
	therotsymb = RotSym/.Flatten[{opts, Options[Dihedral]}];
	therefsymb = RefSym/.Flatten[{opts, Options[Dihedral]}];
	If[mymode===Textual,Return[DihedralTextual[n, opts]]];
	If[mymode===Visual,Return[DihedralVisual[n,opts]]];
	If[mymode===Interactive,Return[DihedralInt[n,opts]]];
	If[mymode===All,Return[DihedralAll[n,opts]]];
	If[myform === Permutations,
		If[n == 1, G = FormGroupoid[{{1,2,3,4},{3,4,1,2}},
				PermutationComposition,
				GroupoidDescription -> "Dihedral group - rotations of a 'Z'",
				GroupoidInputString ->"Dihedral[1]", 
				GroupoidName ->"D[1]"],
			If[n == 2, G = FormGroupoid[{{1,2,3,4},{3,4,1,2},{4,3,2,1},
				{2,1,4,3}},
					PermutationComposition,
					GroupoidDescription -> "Dihedral group - rotations and reflections of a rectangle", 
					GroupoidName ->"D[2]",
					GroupoidInputString ->"Dihedral[2]"],
			G = GenerateGroupoid[Table[k,{k,1,n}]//{RotateLeft[#],
				Reverse[#]}&, PermutationComposition,SizeLimit->2 n,
				IsAGroup -> True,
				GroupoidDescription -> "Dihedral group - reflections and rotations of a regular n-gon", 
				WideElements -> True,
				GroupoidInputString ->StringJoin["Dihedral[",ToString[n],"]"],
				GroupoidName ->StringJoin["D[",ToString[n],"]"]]]]];
	If[myform === RotRef,
		If[n==1,G = FormGroupoid[{1,Ref}, DnOperation[#1,#2,1,therotsymb,therefsymb]&,
				GroupoidName->"D[1]"],
			G = GenerateGroupoid[{therotsymb,therefsymb}, 
				DnOperation[#1,#2,n,therotsymb,therefsymb]&,SizeLimit->2 n];
			F = Elements[G];
			G = FormGroupoid[Join[{F[[1]], F[[Range[3,n+1]]],F[[2]],Drop[F,n+1]}//Flatten], 
				DnOperation[#1,#2,n,therotsymb,therefsymb]&,
				GroupoidDescription -> "Dihedral group - reflections and
				rotations of a regular n-gon", Generators -> GeneratingSet[G],
				IsAGroup -> True, WideElements -> If[n>4, True,False],
				GroupoidInputString ->StringJoin["Dihedral[",ToString[n],"]"],
				GroupoidName ->StringJoin["D[",ToString[n],"]"]]]];
	(* If[n > 3, WideElementsQ[G] = True];*)
	G]

DihedralGroupAA[args___] := Dihedral[args]

Dihedral[many:{_Integer?Positive..}, Mode -> mode_, opts___?OptionQ] :=
	Column[Map[Dihedral[#, Mode -> mode, opts]&,many]]
		
Dihedral[many:{_Integer?Positive..}] :=
	Map[Dihedral,many]
	
Dihedral[n_Integer?Positive, Mode->Computational]:= Dihedral[n]

Options[DihedralInteractive]={Min -> 2, Max -> 20};

DihedralInt[n_Integer?Positive, Mode -> Interactive, InteractiveMode->mode_, opts___?OptionQ]:=
	Module[{min, max,showhelp},
	min = Min/.Flatten[{opts, Options[DihedralInteractive]}];
	max = Max/.Flatten[{opts, Options[DihedralInteractive]}];
	showhelp = ShowHelp/.Flatten[{opts, Options[HelpMessages]}];
	If[mode===Visual || mode===Textual,
		Manipulate[Dihedral[k, Mode -> mode, ShowHelp->showhelp, opts],{{k, n, "n"}, min, max, 1,
	Appearance->"Open"}],
		Manipulate[Dihedral[k, Mode -> mode],{{k, n, "n"}, min, max, 1,
	Appearance->"Open"}]]
]

DihedralInt[n_Integer?Positive, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		DihedralInt[n,Mode->Interactive, InteractiveMode -> Computational, opts],
	"Explanation" -> DihedralInt[n,Mode->Interactive, InteractiveMode -> Textual, ShowConvert -> False, opts],
	"Visualization" -> DihedralInt[n, Mode->Interactive, InteractiveMode -> Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with Dihedral[n]", Top]


DihedralAll[n_Integer?Positive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> Dihedral[n],
	"Explanation" -> Dihedral[n, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> Dihedral[n, Mode->Visual, ConvertMode -> "All",opts],
	"Interactive"-> Dihedral[n, Mode->Interactive, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"The dihedral group D["<>ToString[n]<>"]", Top]


RulesForDn[n_,R_,L_] := {L**R -> (R^(n-1))**L, 
L**(R^a_)-> (R^(n-a))**L,
(R^(a_:1)) ** (R^(b_:1)) -> R^(Mod[a+b,n]), 
R^n -> 1, L**L->1,a_**1->a,1**a_->a};

DnOperation[p_,q_,n_,rot_,ref_] :=
	(p)**(q) //. RulesForDn[n,rot,ref]



DihedralTextual[n_, opts___?OptionQ] :=Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	text = StringJoin["One way of thinking of the Dihedral group with index ",
ToString[n]," is to consider the regular ",ToString[n],"-gon. The collection of symmetries for this figure makes up this group, with the elements being represented ",
If[curDform =!= RotRef,"by the permutations of the vertices.", "(symbolically) as the elements generated by the smallest rotation and any reflection."]];
If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
	]

DihedralTextual[2, opts___?OptionQ] := Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	text = StringJoin["One way of thinking of the Dihedral group D[2] is to consider the rectangle. The collection of symmetries for this figure makes up this group, with the elements being represented ",
If[curDform =!= RotRef,"by the permutations of the vertices.", "(symbolically) as the elements generated by the smallest rotation and any reflection."]];
If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
	]

DihedralTextual[1, opts___?OptionQ] := Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	text = StringJoin["One way of thinking of the Dihedral group D[1] is to consider the 'Z'. The collection of symmetries for this figure makes up this group: The rotation of 180 degrees is called 1 and the identity is called 0."];
If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
	]

DihedralHelp[2]:= DoHelpMessage[windowtitle -> "Help for the group Dihedral[2]", 
	help ->StringJoin["The dihedral group D[2] consists of all the symmetries of the rectangle shown. Included in the group are the 2 reflections (horizontally and vertically through the center), as well as the 1 rotation of 180 degrees (and the identity - no motion). ",
If[curDform =!= RotRef,
	"The elements are considered as permutations of the vertices.",
	StringJoin["The elements are considered as follows: The rotation of 180 degrees is called ",
		ToString[therotsymb]," and any one of the reflections is called ", 
		ToString[therefsymb],". The elements are then seen as powers of ",
		ToString[therotsymb]," and products of these powers and the reflection ",
		ToString[therefsymb],"."]]]]
			
DihedralVisual[n_, opts___?OptionQ] :=
	DoVisualization[DihedralVisualWk[n],{{n},DihedralHelp},opts]

DihedralVisualWk[2] := makeFigure[2,Range[4],"D"]

DihedralHelp[1]:= DoHelpMessage[windowtitle -> "Help for the group Dihedral[1]", 
	help ->StringJoin["The dihedral group D[1] consists of all the symmetries of the 'Z' shown below. Included in the group is the 1 rotation of 180 degrees (and the identity). ",
	If[curDform =!= RotRef,
		"The elements are considered as permutations of the vertices.",
		StringJoin["The elements are considered as follows: The rotation of 180 degrees is called 1 and the identity is called 0."]]]
]

DihedralVisualWk[1] := makeFigure[2,Range[4],"Z"] 

DihedralHelp[(n_)?EvenQ]:= DoHelpMessage[windowtitle -> "Help for the group Dihedral["<>ToString[n]<>"]", 
	help ->StringJoin["The dihedral group D[", ToString[n], "] consists of all the symmetries of the ", ToString[n],"-sided regular polygon shown. Included in the group are the ",ToString[n]," reflections through the lines connecting the vertices diametrically opposite and through the lines connecting the midpoints of opposite sides, as well as the ",ToString[n]," rotations through angles consisting of multiples of ",
	If[IntegerQ[360/n],ToString[360/n],ToString[N[360/n]]]," degrees (360 divided by the index). ",
	If[curDform =!= RotRef,
		"The elements are considered as permutations of the vertices.",
		StringJoin["The elements are considered as follows: The rotation of ",
			If[IntegerQ[360/n],ToString[360/n],ToString[N[360/n]]]," degrees is called ",
			ToString[therotsymb]," and any one of the reflections is called ", 
			ToString[therefsymb],". The elements are then seen as powers of ",
			ToString[therotsymb]," and products of these powers and the reflection ",
			ToString[therefsymb],"."]]]]/;n>2

DihedralVisualWk[n_] := makeFigure[n,Range[n]]/;n>2

DihedralHelp[(n_)?OddQ]:= DoHelpMessage[windowtitle -> "Help for the group Dihedral["<>ToString[n]<>"]", 
	help ->StringJoin["The dihedral group D[",ToString[n],
	"] consists of all the symmetries of the ",
	ToString[n],"-sided regular polygon shown below. Included in the group are the ",ToString[n],
	" reflections through the lines connecting the vertices to the midpoints of opposite sides, as well as the ",
	ToString[n]," rotations through angles consisting of multiples of ",
	If[IntegerQ[360/n],ToString[360/n],ToString[N[360/n]]]," degrees (360 divided by the index). ",
	If[curDform =!= RotRef,
		"The elements are considered as permutations of the vertices.",
		StringJoin["The elements are considered as follows: The rotation of ",
			If[IntegerQ[360/n],ToString[360/n],ToString[N[360/n]]]," degrees is called ",
			ToString[therotsymb]," and any one of the reflections is called ", 
			ToString[therefsymb],". The elements are then seen as powers of ",
			ToString[therotsymb]," and products of these powers and the reflection ",
			ToString[therefsymb],"."]]]]/;n>2

Unprotect[D];
D[many:{_Integer..},opts___?OptionQ] := Dihedral[many,opts]
Protect[D];


(* ::Subsection:: *)
(*17.8 - MaxTaker*)


Options[MaxTaker]={Mode -> Computational};

MaxTaker[n_Integer?Positive,opts___?OptionQ] := 
	Module[{mymode,G,sc},
	mymode = Mode/.Flatten[{opts, Options[MaxTaker]}];
	G = FormGroupoid[Table[k,{k,1,n}],Max,"*",
		FormatOperator -> False,
		GroupoidDescription -> "Takes the maximum of two inputs.",
		GroupoidInputString ->StringJoin["MaxTaker[",ToString[n],"]"],
		GroupoidName ->StringJoin["MaxTaker[",ToString[n],"]"]];
	mymode = Mode/.Flatten[{opts, Options[Dihedral]}];
	If[mymode===Textual,Return[MaxTakerTextual[Elements[G]]]];
	G
	]

MaxTakerTextual[els_] := 
	Column[{"This groupoid consists of the following elements:",
	els,
	"The operation consists of taking the largest of the two inputs."}]

MaxTaker[many:{_Integer?Positive..}, Mode -> mode_] :=
	Column[Map[MaxTaker[#, Mode -> mode]&, many]]
		
MaxTaker[many:{_Integer?Positive..}] :=
	Map[MaxTaker,many]

MaxTaker[n_] := (Message[MaxTaker::intpm,"MaxTaker["<>ToString[n]<>"]",1];$Failed)

MaxTaker[n_, Mode -> mode_] := 
	(Message[MaxTaker::intpm,"MaxTaker["<>ToString[n]<>"]",1];$Failed)

MaxTaker[m_Integer,n_Integer,opts___?OptionQ] := 
	Module[{mymode,G,sc},
	mymode = Mode/.Flatten[{opts, Options[MaxTaker]}];
	G = FormGroupoid[Table[k,{k,m,n}],Max,"*",
		FormatOperator -> False,
		GroupoidDescription -> "Takes the maximum of two inputs.",
		GroupoidInputString ->StringJoin["MaxTaker[",ToString[n],"]"],
		GroupoidName ->StringJoin["MaxTaker[",ToString[n],"]"]];
		If[mymode===Textual,Return[MaxTakerTextual[Elements[G]]]];
	G]


(* ::Subsection:: *)
(*17.9 - MinTaker*)


Options[MinTaker]={Mode -> Computational};

MinTaker[n_Integer?Positive,opts___?OptionQ] := Module[{mymode,G,sc},
	mymode = Mode/.Flatten[{opts, Options[MinTaker]}];
	G = FormGroupoid[Table[k,{k,1,n}],Min,"*",
		FormatOperator -> False,
		GroupoidDescription -> "Takes the minimum of two inputs.",
		GroupoidInputString ->StringJoin["MinTaker[",ToString[n],"]"],
		GroupoidName ->StringJoin["MinTaker[",ToString[n],"]"]];
		If[mymode===Textual,Return[MinTakerTextual[Elements[G]]]];
	G]

MinTakerTextual[els_] := 
	Column[{"This groupoid consists of the following elements:",
	els,
	"The operation consists of taking the smallest of the two inputs."}]

MinTaker[many:{_Integer?Positive..}, Mode -> mode_] :=
	Column[Map[MinTaker[#, Mode -> mode]&, many]]
		
MinTaker[many:{_Integer?Positive..}] :=
	Map[MinTaker,many]

MinTaker[n_] := (Message[MinTaker::intpm,"MinTaker["<>ToString[n]<>"]",1];$Failed)

MinTaker[n_, Mode -> mode_] := 
	(Message[MinTaker::intpm,"MinTaker["<>ToString[n]<>"]",1];$Failed)

MinTaker[m_Integer,n_Integer,opts___?OptionQ] := 
	Module[{mymode,G,sc},
	mymode = Mode/.Flatten[{opts, Options[MinTaker]}];
	G = FormGroupoid[Table[k,{k,m,n}],Min,"*",
		FormatOperator -> False,
		GroupoidDescription -> "Takes the minimum of two inputs.",
		GroupoidInputString ->StringJoin["MinTaker[",ToString[n],"]"],
		GroupoidName ->StringJoin["MinTaker[",ToString[n],"]"]];
		If[mymode===Textual,Return[MinTakerTextual[Elements[G]]]];
	G]


(* ::Subsection:: *)
(*17.10 - RootsOfUnity*)


Options[RootsOfUnity]={Mode -> Computational};

RootsOfUnity[n_Integer?Positive] := Module[{G,sc},
	G = FormGroupoid[Table[Exp[k (2 Pi I)/n],{k,0,n-1}],
    	Exp[I (Arg[#1] + Arg[#2])]&(*Times*), "*", 
    	FormatOperator -> False, IsAGroup -> True,
    	GroupoidDescription -> "Roots of unity - solutions of x^n == 1",
		GroupoidInputString ->StringJoin["RootsOfUnity[",ToString[n],"]"],
		GroupoidName ->StringJoin["RootsOfUnity[",ToString[n],"]"]];
	If[n>4,WideElementsQ[G] = True];
	G]

RootsOfUnity[n_Integer?Positive,Mode->Textual, opts___?OptionQ] := 
	RootsOfUnityTextual[n,opts]

RootsOfUnity[n_Integer?Positive, Mode -> Visual, opts___?OptionQ] := Module[{G,sc},
	G = FormGroupoid[Table[Exp[k (2 Pi I)/n],{k,0,n-1}],
    	Exp[I (Arg[#1] + Arg[#2])]&(*Times*), "*", 
    	FormatOperator -> False, IsAGroup -> True,
    	GroupoidDescription -> "Roots of unity - solutions of x^n == 1",
		GroupoidInputString ->StringJoin["RootsOfUnity[",ToString[n],"]"],
		GroupoidName ->StringJoin["RootsOfUnity[",ToString[n],"]"]];
	If[n>4,WideElementsQ[G] = True];
	RootsOfUnityVisual[n,Elements[G],opts]
	]

Options[RootsOfUnityInteractive]={Min -> 2, Max -> 20};

RootsOfUnity[n_Integer?Positive, Mode -> Computational] := RootsOfUnity[n]

RootsOfUnity[n_Integer?Positive, Mode -> Interactive, InteractiveMode->mode_, opts___?OptionQ]:=
	Module[{min, max,showhelp},
	min = Min/.Flatten[{opts, Options[RootsOfUnityInteractive]}];
	max = Max/.Flatten[{opts, Options[RootsOfUnityInteractive]}];
	showhelp = ShowHelp/.Flatten[{opts, Options[HelpMessages]}];
	If[mode===Visual || mode===Textual,
		Manipulate[RootsOfUnity[k, Mode -> mode, ShowHelp->showhelp, opts],{{k, n, "n"}, min, max, 1,
	Appearance->"Open"}],
		Manipulate[RootsOfUnity[k, Mode -> mode],{{k, n, "n"}, min, max, 1,
	Appearance->"Open"}]]
]

RootsOfUnity[n_Integer?Positive, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		RootsOfUnity[n,Mode->Interactive, InteractiveMode -> Computational, opts],
	"Explanation" -> RootsOfUnity[n,Mode->Interactive, InteractiveMode -> Textual, ShowConvert -> False, opts],
	"Visualization" -> RootsOfUnity[n, Mode->Interactive, InteractiveMode -> Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with RootsOfUnity[n]", Top]

RootsOfUnity[n_Integer?Positive, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> RootsOfUnity[n],
	"Explanation" -> RootsOfUnity[n, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> RootsOfUnity[n, Mode->Visual, ConvertMode -> "All",opts],
	"Interactive"-> RootsOfUnity[n, Mode->Interactive,opts]}, 
	ImageSize->Automatic],"The "<>ToString[n]<>If[n==1,"st",If[n==2,"nd",If[n==3,"rd","th"]]]<>" roots of Unity ", Top]
	
RootsOfUnityVisual[n_,els_, opts___?OptionQ] := 
	DoVisualization[RootsOfUnityVisualWork[n,els],{{n},RootsOfUnityHelp},opts]

RootsOfUnityHelp[n_]:= DoHelpMessage[windowtitle -> "Help for the group RootsOfUnity[n]", 
	help ->List["The elements in the group are the solutions to the equation ",
		Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{
     SuperscriptBox["x", ToString[n]], "-", "1"}], "=", "0"}], 
   TraditionalForm]],
  FormatType->"TraditionalForm"],
	 ". The operation is ordinary (complex) multiplication, which in this case simplifies to adding the arguments of any element (the angles relative to the positive x-axis). Note also how the points are uniformly distributed around the circle."]
]

RootsOfUnityVisualWork[n_,els_] := RootsOfUnityVisualWork[n,els] = 
		Module[{pts,txt},
	pts = Map[{Re[#],Im[#]}&,els]//N;
	txt = Table[Text[ToString[els[[i]],TraditionalForm], 1.3 pts[[i]]],{i,n}];
	Show[Graphics[{Circle[{0, 0}, 1],Blue,PointSize[0.055],
		Map[Point,pts],Black,txt}],PlotRange -> {{-1.5,1.5},{-1.5,1.5}},
		Axes -> True, Ticks -> {Table[i,{i,-1,1,.5}],
		Table[i,{i,-1,1,.5}]}]
	]
	
RootsOfUnityTextual[n_, opts___?OptionQ] := Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	text = StringJoin[
		"These are the (complex) numbers that are solutions to the equation ",
		ToString[Superscript["x",n],TraditionalForm],
		" - 1 = 0. The operation is ordinary (complex) multiplication, which in this case simplifies to adding the arguments (angles relative to the positive x-axis) of the two inputs."];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
	]

RootsOfUnity[many:{_Integer?Positive..}, Mode -> mode_, opts___?OptionQ] :=
	Column[Map[RootsOfUnity[#,Mode->mode, opts]&, many]]
		
RootsOfUnity[many:{_Integer?Positive..}] :=
	Map[RootsOfUnity,many]

RootsOfUnity[n_, opts___] := 
	(Message[RootsOfUnity::intpm,"RootsOfUnity["<>ToString[n]<>"]",1];$Failed)


(* ::Subsection:: *)
(*17.15 - MeetDivisors*)


Options[MeetDivisors]={Mode -> Computational};

MeetDivisors[n_Integer?Positive,opts___?OptionQ]:= Module[{mymode, G, sc},
	mymode = Mode/.Flatten[{opts, Options[MeetDivisors]}];
	G = FormGroupoid[Divisors[n],GCD,"GCD", FormatOperator -> False,
		GroupoidDescription -> "Divisors of n, under GCD",
		GroupoidInputString ->StringJoin["MeetDiv[",ToString[n],"]"],
		GroupoidName ->StringJoin["MeetDiv[",ToString[n],"]"]];
	G]
			
MeetDivisors[many:{_Integer?Positive..}] :=
	Map[MeetDivisors,many]

MeetDivisors[n_, opts___] := 
	(Message[MeetDivisors::intpm,"MeetDivisors["<>ToString[n]<>"]",1];$Failed)


(* ::Subsection:: *)
(*17.16 - JoinDivisors*)


Options[JoinDivisors]={Mode -> Computational};

JoinDivisors[n_Integer?Positive,opts___?OptionQ]:= Module[{mymode, G, sc},
	mymode = Mode/.Flatten[{opts, Options[JoinDivisors]}];
	G = FormGroupoid[Divisors[n],LCM, "LCM", FormatOperator -> False,
		GroupoidDescription -> "Divisors of n, under LCM",
		GroupoidInputString ->StringJoin["JoinDiv[",ToString[n],"]"],
		GroupoidName ->StringJoin["JoinDiv[",ToString[n],"]"]]]

		
JoinDivisors[many:{_Integer?Positive..}] :=
	Map[JoinDivisors,many]

JoinDivisors[n_, opts___] := 
	(Message[JoinDivisors::intpm,"JoinDivisors["<>ToString[n]<>"]",1];$Failed)


(* ::Subsection:: *)
(*17.17 - MixedDivisors*)


Options[MixedDivisors]={Mode -> Computational};

MixedDivisors[n_Integer?Positive,opts___?OptionQ]:= Module[{mymode, G, sc},
	mymode = Mode/.Flatten[{opts, Options[MixedDivisors]}];
	G = FormGroupoid[Divisors[n],(LCM[#1,#2]/GCD[#1,#2])&,"mixed", 
		FormatOperator -> False,
    	GroupoidDescription -> "Divisors of n, under LCM/GCD",
		GroupoidInputString ->StringJoin["MixedDiv[",ToString[n],"]"],
		GroupoidName ->StringJoin["MixedDiv[",ToString[n],"]"]]]

MixedDivisors[many:{_Integer?Positive..}] :=
	Map[MixedDivisors,many]

MixedDivisors[n_, opts___] := 
		(Message[MixedDivisors::intpm,"MixedDivisors["<>ToString[n]<>"]",1];$Failed)


(* ::Subsection:: *)
(*17.18 - FirstTaker*)


Options[FirstTaker]={Mode -> Computational};

FirstTaker[n_Integer?Positive,opts___?OptionQ]:= Module[{mymode, G, sc},
	mymode = Mode/.Flatten[{opts, Options[FirstTaker]}];
	G = FormGroupoid[Range[n],First[{#}]&,"*", FormatOperator -> False,
		GroupoidDescription -> "Integers less than n with the operation of 'first come, first served'- i.e., left operand is the output.",
		GroupoidInputString ->StringJoin["FirstTaker[",ToString[n],"]"],
		GroupoidName ->StringJoin["FirstTaker[",ToString[n],"]"]]]

FirstTaker[many:{_Integer?Positive..}] :=
	Map[FirstTaker,many]

FirstTaker[n_, opts___] := 
	(Message[FirstTaker::intpm,"FirstTaker["<>ToString[n]<>"]",1];$Failed)


(* ::Subsection:: *)
(*17.19 - TwistedZ*)


TwistedZ[n_Integer?Positive] := TwistedZ[n] = 
	FormGroupoid[Range[0, n-2], Mod[#1 + #2 + #1 #2, n]&, "*",
		GroupoidName -> "TwistedZ["<>ToString[n]<>"]",
		GroupoidInputString -> "TwistedZ["<>ToString[n]<>"]"]


(* ::Subsection:: *)
(*17.20 - GaussianIntegers*)


gaussianintegersmodn[n_] := Module[{els = Elements[Z[n]]},
	CartesianProduct[els,els]/.{a_,b_} -> a + b*I]
	
GaussianAddition[x_, y_,n_Integer?Positive] :=
	Complex[Mod[Re[x]+Re[y],n],Mod[Im[x]+Im[y],n]]

GaussianMultiplication[x_, y_,n_Integer?Positive] :=
	Complex[Mod[Re[x] Re[y] - Im[x] Im[y],n],
		Mod[Re[x] Im[y]+Re[y] Im[x],n]]
		
GaussianIntegersAdditive[n_Integer?Positive] := 
	FormGroupoid[gaussianintegersmodn[n],
		GaussianAddition[#1,#2,n]&(*Mod[#1+#2,n]&*),"+",
		FormatOperator -> True, WideElements -> If[n>2, True, False],
		GroupoidInputString -> "Z["<>ToString[n]<>", I]",
		GroupoidName -> "Z["<>ToString[n]<>", I]"]
		
GaussianIntegersMultiplicative[n_Integer?Positive] := 
	FormGroupoid[gaussianintegersmodn[n],
		GaussianMultiplication[#1,#2,n]&(*Mod[#1 #2,n]&*),"*",
		FormatOperator -> True, WideElements -> If[n>2, True, False],
		GroupoidInputString -> "Zx["<>ToString[n]<>", I]",
		GroupoidName -> "Zx["<>ToString[n]<>", I]"]		
		
Unprotect[Z];

Z[n_Integer?Positive, I] := If[DefaultStructure === Group,
	GaussianIntegersAdditive[n], GaussianIntegers[n]]

Z[n_Integer?Positive, I, Structure -> Group] := 
	GaussianIntegersAdditive[n]
	
Unprotect[GaussianIntegers];

GaussianIntegers[n_Integer?Positive] :=
	FormRingoid[gaussianintegersmodn[n],
	GaussianAddition[#1,#2,n]&, 
	GaussianMultiplication[#1,#2,n]&,
	WideElements -> If[n>2, True, False],
	RingoidName -> 
	"Z["<>ToString[n]<>", I]", FormatOperator -> True,
	WideElements -> If[n > 2, True, False]]
	
Protect[GaussianIntegers];

Z[n_Integer?Positive, I, Structure -> Ring] := 
	GaussianIntegers[n]
	
Z[Power[n_, Rational[1,2]]] := If[squareFreeQ[n],ZSq[n],$Failed]

(* Z[n_, opts___] := If[NumberQ[n] && n =!= I,
	Message[Z::intpm,"Z["<>ToString[n]<>"]",1];$Failed]*)

Protect[Z];
		


(* ::Subsection:: *)
(* 17.25 Other groupoids*)


Options[QuaternionGroup] = {Form -> AsMatrices};

QuaternionGroup[opts___?OptionQ] := Module[{as},
	as = Form/.Flatten[{opts, Options[QuaternionGroup]}];
	Switch[as, AsMatrices, QuaternionGroupAsMatrices,
		AsIJK, QuaternionGroupAsIJK,
		AsSymbols, QuaternionGroupAsSymbols]]

QuaternionGroupAsMatrices:= GenerateGroupoid[{{{0,1},{-1,0}},{{0,I},{I,0}}}, 
	Dot,WideElements->True,
	GroupoidName -> "QuaternionGroup",
	CayleyForm->MatrixForm,
	GroupoidInputString -> "QuaternionGroup[Form->AsMatrices]"]
	
MessageCount[QuaternionGroup,JJKK] = 0;

QuaternionGroupAsIJK := 
	(If[MessageCount[QuaternionGroup,JJKK]++ < 4, Message[QuaternionGroup::JJKK]];
	FormGroupoid[{1,-1, I, -I, Global`JJ, -Global`JJ, 
		Global`KK, -Global`KK}, 
		QuatGroupOp[#1, #2]&, "*",
		GroupoidInputString -> "QuaternionGroup[Form->AsIJK]",
		GroupoidName -> "QuaternionGroup"])
	
QuatGroupRules = {1**x_:>x, (-1)**x_:>-x, x_**1:>x, x_**(-1):>-x,
  (-x_)**(x_):>1, (x_)**(-x_) :> 1, (x_)**(x_) :> -1,
  (-x_)**(y_):>-(x**y), (x_)**(-y_):>-(x**y),
	(Global`KK) ** I -> Global`JJ,
  (Global`JJ) ** (Global`KK) -> I,
	I **(Global`JJ) -> (Global`KK),
	(Global`JJ)** I -> -(Global`KK),
	(Global`KK) ** (Global`JJ) -> -I,
	I ** (Global`KK) -> -(Global`JJ),
	(-I)**x_:>-(I**x), (x_)**(-I):>-(x**I) };

QuatGroupOp[x_,y_] := (x**y) //. QuatGroupRules

QuaternionGroupAsSymbols := 
	FormGroupoidByTable[{"e", "a", "\!\(\*SuperscriptBox[\"a\", \"2\"]\)", "\!\(\*SuperscriptBox[\"a\", \"3\"]\)", "b", "ba", "\!\(\*SuperscriptBox[\"ba\", \"2\"]\)", "\!\(\*SuperscriptBox[\"ba\", \"3\"]\)"},
		{{"e", "a", "\!\(\*SuperscriptBox[\"a\", \"2\"]\)", "\!\(\*SuperscriptBox[\"a\", \"3\"]\)", "b", "ba", "\!\(\*SuperscriptBox[\"ba\", \"2\"]\)", "\!\(\*SuperscriptBox[\"ba\", \"3\"]\)"},
		 {"a", "\!\(\*SuperscriptBox[\"a\", \"2\"]\)", "\!\(\*SuperscriptBox[\"a\", \"3\"]\)", "e", "\!\(\*SuperscriptBox[\"ba\", \"3\"]\)", "b", "ba", "\!\(\*SuperscriptBox[\"ba\", \"2\"]\)"},
		 {"\!\(\*SuperscriptBox[\"a\", \"2\"]\)", "\!\(\*SuperscriptBox[\"a\", \"3\"]\)", "e", "a", "\!\(\*SuperscriptBox[\"ba\", \"2\"]\)", "\!\(\*SuperscriptBox[\"ba\", \"3\"]\)", "b", "ba"},
		 {"\!\(\*SuperscriptBox[\"a\", \"3\"]\)", "e", "a", "\!\(\*SuperscriptBox[\"a\", \"2\"]\)", "ba", "\!\(\*SuperscriptBox[\"ba\", \"2\"]\)", "\!\(\*SuperscriptBox[\"ba\", \"3\"]\)", "b"},
		 {"b", "ba", "\!\(\*SuperscriptBox[\"ba\", \"2\"]\)", "\!\(\*SuperscriptBox[\"ba\", \"3\"]\)", "\!\(\*SuperscriptBox[\"a\", \"2\"]\)", "\!\(\*SuperscriptBox[\"a\", \"3\"]\)", "e", "a"},
		 {"ba", "\!\(\*SuperscriptBox[\"ba\", \"2\"]\)", "\!\(\*SuperscriptBox[\"ba\", \"3\"]\)", "b", "a", "\!\(\*SuperscriptBox[\"a\", \"2\"]\)", "\!\(\*SuperscriptBox[\"a\", \"3\"]\)", "e"},
		 {"\!\(\*SuperscriptBox[\"ba\", \"2\"]\)", "\!\(\*SuperscriptBox[\"ba\", \"3\"]\)", "b", "ba", "e", "a", "\!\(\*SuperscriptBox[\"a\", \"2\"]\)", "\!\(\*SuperscriptBox[\"a\", \"3\"]\)"},
		 {"\!\(\*SuperscriptBox[\"ba\", \"3\"]\)", "b", "ba", "\!\(\*SuperscriptBox[\"ba\", \"2\"]\)", "\!\(\*SuperscriptBox[\"a\", \"3\"]\)", "e", "a", "\!\(\*SuperscriptBox[\"a\", \"2\"]\)"}}, 
		 "*",
			GroupoidInputString -> "QuaternionGroup[Form->AsSymbols]",
			GroupoidName -> "QuaternionGroup"]

trivProd[a_,a_] := a;

Trivial := Trivial = 
	FormGroupoid[{"u"},"u"&, "*", GroupoidInputString -> "Trivial",
		GroupoidName ->"trivial"];

MessageCount[Klein,warning] = 0;

Klein4 := (If[MessageCount[Klein,warning]++ < 4, Message[Klein4::warning]];
	FormGroupoidByTable[{"e","a","b","c"},
	{{"e","a","b","c"},
    {"a","e","c","b"},
    {"b","c","e","a"},
   	{"c","b","a","e"}},
		GroupoidInputString -> "Klein4",
   	GroupoidName -> "Klein4"])

IntegerUnits:= IntegerUnits = FormGroupoid[{1,-1}, Times,
	GroupoidName -> "IntegerUnits", GroupoidInputString -> "IntegerUnits",
	GroupoidDescription -> "the units in Z",
	FormatOperator -> False];

GaussianUnits:= GaussianUnits = FormGroupoid[{1,-1,I,-I},Times,
	GroupoidName -> "GaussianUnits", 
	GroupoidInputString -> "GaussianUnits",
	GroupoidDescription -> "the units in Z[I]",
	FormatOperator -> False];


(* ::Subsection:: *)
(* 17.30 ESG groupoids - names from Exploring Small Groups*)


ESG[0301] := Z[3];
ESG[0401] := Z[4];
ESG[0402] := Dihedral[2];
ESG[0501] := Z[5];
ESG[0601] := Z[6];
ESG[0602] := S[3];
ESG[0701] := Z[7];
ESG[0801] := Z[8];
ESG[0802] := DirectSum[Z[4],Z[2]];
ESG[0803] := DirectSum[Z[2],Z[2],Z[2]];
ESG[0804] := Dihedral[4];
ESG[0805] := QuaternionGroup[Form -> AsIJK];
ESG[0901] := Z[9];
ESG[0902] := DirectSum[Z[3],Z[3]];
ESG[1001] := Z[10];
ESG[1002] := Dihedral[5];
ESG[1101] := Z[11];
ESG[1201] := Z[12];
ESG[1202] := DirectSum[Z[6],Z[2]];
ESG[1203] := Dihedral[6];
ESG[1204] := A[4];
(* ESG[1205] := Q6 Dicyclic *)
ESG[1301] := Z[13];
ESG[1401] := Z[14];
ESG[1402] := Dihedral[7];
ESG[1501] := Z[15];
ESG[1601] := Z[16];
ESG[1602] := DirectSum[Z[8],Z[2]];
ESG[1603] := DirectSum[Z[4],Z[4]];
ESG[1604] := DirectSum[Z[4],Z[2],Z[2]];
ESG[1605] := DirectSum[Z[2],Z[2],Z[2],Z[2]];
ESG[1606] := DirectSum[D[4],Z[2]];
ESG[1607] := DirectSum[QuaternionGroup[Form -> AsIJK],Z[2]];
(*ESG[1608] := Z[16];*)
(*ESG[1609] := Z[16];*)
(*ESG[1610] := Z[16];*)
(*ESG[1611] := Z[16];*)
ESG[1612] := Dihedral[8];
(*ESG[1613] := Z[16];*)
(*ESG[1614] := Z[16];*)


(* ::Section:: *)
(* 19. Direct product*)


DSargs[G_,rest__]:=
	Apply[StringJoin, Transpose[{Map[GroupoidInputString,{G,rest}],
		Table[", ",{Length[{G,rest}]}]}]//Flatten//Most]

DirectSum[R_?GroupoidQ, Rs__]:= DirectSumProductWork[R, Rs, "+"]

DirectProduct[R_?GroupoidQ, Rs__]:=DirectSumProductWork[R, Rs, "x"]

DirectSumProductWork[R_?GroupoidQ, Rs__, op_] :=
Module[{factorsAreGroups,numgrps = Length[{R,Rs}]},
  If[Apply[And,Map[GroupoidQ,{R, Rs}]],
  	factorsAreGroups = Apply[And,Map[GroupQ,{R, Rs}]];
    FormGroupoid[Distribute[Elements/@{R,Rs},List],
    	MapThread[(#1[#2,#3])&, {Operation/@{R,Rs},#1,#2}]&,
    	GroupoidName -> Apply[StringJoin,Transpose[{Map[StructureName,{R,Rs}],
		Table[" "<>op<>" ",{numgrps}]}]//Flatten//Drop[#,-1]&],
    	MaxElementsToList -> 25,
		GroupoidInputString -> "DirectSum["<>DSargs[R, Rs]<>"]",
    	WideElements -> True, IsAGroup -> If[factorsAreGroups, True, False]],
  Message[DirectProduct::ArgErr]]]


(* ::Section:: *)
(* 21. Working with elements*)


(* ::Subsection:: *)
(*21.1 Random element(s)*)


randElement[Dom_List]:=
       Dom[[Random[Integer,{1,Length[Dom]}]]]
              
Options[RandomElement]={SelectFrom -> NonIdentity};

RandomElement[G_?GroupoidQ, opts___?OptionQ]:= 
	Module[{P,sel,els=Elements[G]},
	sel=SelectFrom/.Flatten[{opts, Options[RandomElement]}];
    If[sel===NonIdentity,
    	If[(P=Complement[els,{If[HasIdentityQ[G],
    			GroupIdentity[G],{}]}])!={},
            randElement[P],Message[RandomElement::gfail,sel];
            $Failed],randElement[els]]]
     
Options[RandomElements]={SelectFrom -> Any,
	Replacement -> True};
	
RandomElements[G_?GroupoidQ,0,opts___?OptionQ]:= {}

RandomElements[G_?GroupoidQ,n_Integer?Positive,opts___?OptionQ]:= 
	Module[{sel, rep, els=Elements[G], list={}, possible, id, p,s},
	sel=SelectFrom/.Flatten[{opts, Options[RandomElements]}];
	rep=Replacement/.Flatten[{opts, Options[RandomElements]}];
	s = Length[els];
	possible = (n <= s && sel =!= NonIdentity) || rep || 
		(n < s && sel === NonIdentity);
	If[possible,
    	If[rep,
    		(* just find some random elements, replacement ok *)
    		list = Table[RandomElement[G,SelectFrom->sel],{n}],
    		(* replacement not ok *)
    		p = RandomPermutationAA[s];
    		p = Map[els[[#]]&,p];
				If[n <= s && sel =!= NonIdentity,list = Take[p, n]];
				If[n < s && sel === NonIdentity,
					p = Take[p, n+1];
					id = If[HasIdentityQ[G],
    				GroupIdentity[G],{}];
    			p = DeleteCases[p,id];
    			If[Length[p] == n, list = p, list = Drop[p,1]]
					]
    		]
    	];
    If[!rep,
  		If[n > s, Message[RandomElements::toomany,n,s]];
   		If[n == s && sel === NonIdentity,
   				Message[RandomElements::toomanyni,n,s]]];
    list
    ]
  
RandomElements[G_?GroupoidQ,k_,opts___?OptionQ] := 
(Message[RandomElements::intpm,"RandomElements["<>StructureName[G]<>
", "<>ToString[k]<>"]",2];$Failed)

RandomElement[Dom_List] := randElement[Dom]

RandomElements[Dom_List,n_Integer?Positive] := 
	Table[randElement[Dom],{n}]

RandomElements[Dom_List,0] := {}

RandomElements[Dom_List,k_] := 
(Message[RandomElements::intpm,"RandomElements["<>ToString[Dom]<>
", "<>ToString[k]<>"]",2];$Failed)



(* ::Subsection::Closed:: *)
(*21.2 ElementQ*)


ElementQ[g_, G_?StructuredSetQ] := MemberQ[Elements[G],g]

ElementsQ[l_, G_?StructuredSetQ] := Apply[And,Map[ElementQ[#, G]&,l]]



(* ::Subsection:: *)
(*21.3 element to a power (multiple)*)


ElementToPower[G_?GroupoidQ, g_, n_Integer, Mode->Computational] := 
	ElementToPower[G, g, n]

ElementToPower[G_?GroupoidQ, g_, n_Integer?Positive] := 
	ElementToPower[G, g, n] =
	If[ElementQ[g,G],
		Fold[Operation[G], g, Evaluate[Table[g,{n-1}]]],
		Message[MemberQ::elmnt, g, StructureName[G]]; $Failed]

ElementToPower[G_?GroupoidQ, g_, 0] := ElementToPower[G, g, 0] =
	If[ElementQ[g,G],
		GroupIdentity[G],
		Message[MemberQ::elmnt, g, StructureName[G]]; $Failed]

ElementToPower[G_?GroupoidQ, g_, n_Integer?Negative] := 
	ElementToPower[G, g, n] =
	If[ElementQ[g,G],
		Module[{ginv},
			If[InvertibleQ[G, g],
				ginv = GroupInverse[G,g];
				Fold[Operation[G], ginv, Evaluate[Table[ginv,{Abs[n]-1}]]],
				Message[Inverse::fail,g,StructureName[G]]; $Failed]],
		Message[MemberQ::elmnt, g, StructureName[G]]; $Failed]

ElementToPower[G_?GroupoidQ, g_, n_Integer, Mode -> Textual, opts___?OptionQ] :=
	Module[{txt, tab, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
If[ElementQ[g,G],
txt = "To find the nth power of an element, when n is positive, we simply use the group operation on n copies of the element g. When n is negative, we perform the group operation on n copies of the element's inverse. When n is 0, we obtain the identity.\n";
If[n == 0,
	txt = txt <> "In this case, we simply have the identity.",
	txt = txt <> "In this case, the following table illustrates the accumulation of powers."];
tab = Grid[Transpose[Prepend[Table[{i, InputForm[ElementToPower[G, g, i]]}, 
	{i, If[n > 0, 1, -1], n, If[n > 0, 1, -1]}],
	{Item["n",Background-> Yellow], Item["g^n",Background-> Yellow]}]], Frame -> All,
	ItemStyle-> {Automatic,Automatic, {{1,1}-> Directive[Larger,Blue], {2,1}-> Directive[Larger,Blue]}}];
	If[showconvert,Column[{txt, tab,MakeComputationalButton[cm]},Center],Column[{txt,tab}]],
Message[MemberQ::elmnt, g, StructureName[G]]; $Failed]]
	
ElementToPower[G_?GroupoidQ, g_, n_Integer?Negative, Mode -> Visual,opts___?OptionQ] := 
	ElementToPower[G, GroupInverse[G,g], n, Mode -> Visual, opts] 

ElementToPower[G_?GroupoidQ, g_, n_Integer?Positive, Mode -> Visual,opts___?OptionQ] := 
	If[ElementQ[g,G],
Module[{list,
		temp = Length[Elements[G]],gr1,gr2,
		f,h,m,seccords, rules},
	list =FoldList[Operation[G], g, Evaluate[Table[g,{n-1}]]];
	list = Transpose[{Range[n],list}];
	f[h_,{m_}] := h -> m;
	rules = MapIndexed[f, Elements[G]];
	seccords = list//Transpose//Last;
	seccords = seccords/.rules;
	If[WideElementsQ[G],printOtherKey[Elements[G]]];
	list = Transpose[{list//Transpose//First,seccords}];
	gr1 = ListPlot[list,Joined -> True];
	gr2 = ListPlot[list,PlotStyle -> {RGBColor[0,0,1],
		PointSize[0.03]}];
	DoVisualization[Show[{gr2,gr1},  
		AxesLabel -> {"power","element"}, Ticks -> 
		If[WideElementsQ[G],
		{Table[i,{i,n}],Table[i,{i,temp}]},{Table[i,{i,n}],
		Table[{i,ToString[Elements[G][[i]], TraditionalForm]},{i,1,temp}]}],
		PlotRange -> {{0,n+1},{0,temp+1}}, AxesOrigin -> {0,0}],{{G,g,n},ElementToPowerHelp},opts]
],
Message[MemberQ::elmnt, g, StructureName[G]]; $Failed]

ElementToPowerHelp[G_,g_,n_]:= DoHelpMessage[windowtitle -> "Help for ElementToPower["<>GroupoidName[G]<>","<>ToString[g]<>","<>ToString[n]<>"]", 
	help ->
	List["In the groupoid ",
		Cell[BoxData[
 FormBox[
  RowBox[{"G", "=", 
   GroupoidName[G]}], TraditionalForm]],
 FormatType->"TraditionalForm"], 
		", this plot shows all the powers of ",
	Cell[BoxData[
 FormBox[
  RowBox[{"g", "=", ToBoxes[g,TraditionalForm]}], TraditionalForm]],
 FormatType->"TraditionalForm"],
		" up to and including the ",
		ToString[n],
		"th power. The horizontal axis is the powers of ",
	Cell[BoxData[
 FormBox["g", TraditionalForm]],
 FormatType->"TraditionalForm"],
" while the vertical axis consists of the elements in ",
	Cell[BoxData[
 FormBox["G", TraditionalForm]],
 FormatType->"TraditionalForm"],"."]]

ElementToPower[G_?GroupoidQ, g_, n_Integer, Mode -> All,opts___?OptionQ]:=
Labeled[TabView[{"Computation" -> ElementToPower[G, g, n],
	"Explanation" -> ElementToPower[G, g, n, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> ElementToPower[G, g, n, Mode->Visual, ConvertMode -> "All",opts],
	"Interactive" -> ElementToPower[G, g, n, Mode->Interactive, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"The "<>ToString[n]<>If[n==1,"st",If[n==2,"nd","th"]]<>" power of "<>ToString[g]<>" in "<>GroupoidName[G], Top]


Options[ElementToPowerInteractive]={Min -> 2, Max -> 100};

ElementToPower[G_?GroupoidQ, g_, n_Integer, Mode -> Interactive, InteractiveMode->mode_, opts___?OptionQ]:=
	Module[{min, max,showhelp, h, els = Elements[G]},
	min = Min/.Flatten[{opts, Options[ElementToPowerInteractive]}];
	max = Max/.Flatten[{opts, Options[ElementToPowerInteractive]}];
	showhelp = ShowHelp/.Flatten[{opts, Options[HelpMessages]}];
	If[mode===Visual || mode===Textual,
		Manipulate[ElementToPower[G,h,k, Mode -> mode, ShowHelp->showhelp, ShowConvert -> False, opts],{{k, n, "n"}, min, max, 1,
	Appearance->"Open"},{{h, g, "g \[Element] G"}, els,ControlType->RadioButtonBar}],
		Manipulate[ElementToPower[G,h,k, Mode -> mode],{{k, n, "n"}, min, max, 1,
	Appearance->"Open"},{{h, g, "g \[Element] G"}, els,ControlType->RadioButtonBar}]]
]

ElementToPower[G_?GroupoidQ, g_, n_Integer, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		ElementToPower[G,g,n,Mode->Interactive, InteractiveMode -> Computational, opts],
	"Explanation" -> ElementToPower[G,g,n,Mode->Interactive, InteractiveMode -> Textual, opts],
	"Visualization" -> ElementToPower[G,g,n, Mode->Interactive, InteractiveMode -> Visual, opts]}, 
	ImageSize->Automatic],"Interacting with ElementToPower[G,g,n]", Top]


(* ::Subsection:: *)
(*21.4 random stuff*)


(* squareFreeQ[n_]:= MoebiusMu[n] != 0  from Examples`OneLiners *)

squareFreeQ[d_]:= 
      If[d < 10^5, MoebiusMu[d] != 0, Print["TOO LARGE under radical"];False];

rightkindQ[n_] := IntegerQ[n] && Positive[n] && squareFreeQ[n]

(* ZSq[n_] := re[n] modified below on 7/26/04

ZSq[n_] := RandomElement[re[n],100] *)

RandomElement[re[n_], max_:100] :=
If[squareFreeQ[n],
	Random[Integer,{-max,max}] + 
		Random[Integer,{-max,max}] Sqrt[n], $Failed]

(* RandomElement[Z[Power[n_, Rational[1,2]]],max_:100] := 
	RandomElement[Z[Sqrt[n]], max] modified here and below 7/26/04 *)
	
	
RandomElement[groupoid[l_List,
	Function[Mod[__]],___], k_Integer] := (Message[RandomElement::sqrfree];
	$Failed)

(* RandomElement[Z[Sqrt[n_Integer?Positive]],max_:100] := 
	If[squareFreeQ[n],
	Random[Integer,{-max,max}] + 
		Random[Integer,{-max,max}] Sqrt[n], $Failed] *)

RandomElement[ZSq[n_],max_:100] := 
	If[squareFreeQ[n],
	Random[Integer,{-max,max}] + 
		Random[Integer,{-max,max}] Sqrt[n], $Failed]
	
RandomElement[Z[Sqrt[-1]],max_:100] := 
	Random[Integer,{-max,max}] + 
		Random[Integer,{-max,max}] I
	
RandomElement[Z[I],max_:100] := 
	Random[Integer,{-max,max}] + 
		Random[Integer,{-max,max}] I
		
RandomElements[groupoid[l_List,
	Function[Mod[__]],___], k_Integer, n_Integer] := (Message[RandomElement::sqrfree];
	$Failed)

(* RandomElements[Z[Sqrt[n_Integer?Positive]],max_:100, 
	num_Integer?Positive] := 
	If[squareFreeQ[n],
		Table[RandomElement[Z[Sqrt[n]],max], {num}], $Failed] *)

RandomElements[ZSq[n_],max_:100, 
	num_Integer?Positive] := 
	If[squareFreeQ[n],
		Table[RandomElement[Z[Sqrt[n]],max], {num}], $Failed]

RandomElements[Z[Sqrt[-1]], max_:100, num_Integer?Positive] := 
	Table[RandomElement[Z[-1], max], {num}]
	
(* added terminal s to RandomElement above 7/26/04 *)

RandomElements[Z[I], max_:100, num_Integer?Positive] :=
	Table[RandomElement[Z[I], max], {num}]


(* ::Subsection:: *)
(*21.5 GroupExponent of a group*)


Options[GroupExponent] = {Mode -> Computational};

GroupExponent[G_?GroupoidQ, Mode -> Computational, opts___?OptionQ]:= GroupExponent[G]

GroupExponent[G_?GroupoidQ] := 
		Module[{id,tocheck = Elements[G],n,max=1,maxord=1,
		pow,tmp,powers = {1},mymode,sc,exp},
	id = GroupIdentity[G];
	maxord = 1;
	max = Length[tmp=tocheck];
	tocheck = Complement[tocheck,{id}];
	n = Length[tocheck];
	While[max > maxord && n > 0, 
		pow = 2;
		While[ElementToPower[G,First[tocheck],pow] =!= id,
			pow ++];
		maxord = Max[maxord, pow];
		AppendTo[powers, pow];
		tocheck = Rest[tocheck];
		n --;
	];
	maxord = Apply[LCM,Union[powers]];
	If[{id} === Union[Table[ElementToPower[G,tmp[[i]],maxord],
		{i,Length[tmp]}]],exp = maxord,Print["HELP"]];
	exp
]

GroupExponent[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ]:=
	GroupExponentTextual[G,GroupExponent[G], opts]

GroupExponent[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ]:=
	DoVisualization[GroupExponentVisual[G,GroupExponent[G]],{{G, GroupExponent[G]},GroupExponentHelp},opts]

GroupExponentHelp[G_,exp_]:= DoHelpMessage[windowtitle -> "Help for GroupExpnonent[G]", 
	help -> List["Given the group G = ", GroupoidName[G], 
	", we are interested in knowing the value ",
	Cell[BoxData[
 FormBox["n", TraditionalForm]],
 FormatType->"TraditionalForm"],
	" such that ",Cell[BoxData[
 FormBox[
  RowBox[{
   SuperscriptBox["g", "n"], "=", "e"}], TraditionalForm]],
 FormatType->"TraditionalForm"],
	" (",
Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{"n", "\[CenterDot]", "g"}], "=", "0"}], 
  TraditionalForm]],
 FormatType->"TraditionalForm"],", if additive) for all elements ",
	Cell[BoxData[
 FormBox["g", TraditionalForm]],
 FormatType->"TraditionalForm"],
	". Here, the elements are listed in the first column, the squares (doubles) are listed in the second column, the cubes (triples) in the third column, and so on. One a row reaches the identity, no further powers (multiples) are calculated. The exponent, then, is the number of columns required. In this case, ",
		ToString[exp]," were required. Note that holding the mouse over any element in the table also shows the power/multiple."]
		]

GroupExponent[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> GroupExponent[G],
	"Explanation" -> GroupExponent[G, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> GroupExponent[G, Mode->Visual, ConvertMode -> "All", opts]}, 
	ImageSize->Automatic],"Exponent of "<>GroupoidName[G], Top]


GroupExponentTextual[G_,exp_, opts___?OptionQ]:=
	Module[{k,powers, els=Elements[G],showconvert, cm},
	powers = Table[Map[ElementToPower[G,#,k]&,els],{k,exp}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	text = StringJoin["The exponent of a finite group is the smallest positive integer n such that ",
		If[OperatorSymbol[G]==="+","n\[CenterDot]g","\!\(\*SuperscriptBox[\"g\", \"n\"]\)"], 
		" = identity for all group elements g.\nIn our case, the first power of all the elements are the elements themselves, ",
		If[exp>2,"the squares consists of "<>ToString[powers[[2]]]<>", ",""],
		If[exp>3,"the cubes consists of "<>ToString[powers[[3]]]<>", ",""],
		"and so on, while all the elements raised to the power "<>ToString[exp],
		" (or multiples, if additive) yield the identity "<>ToString[powers[[exp,1]]],
		" for every element. Thus, the exponent of this group is "<>ToString[exp]<>"."];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]



Options[GroupExponentVisual]={DisplayFunction -> $DisplayFunction};
			

GroupExponentVisual[G_, exp_, opts___] := 
	Module[{n,ords,colors,subgroups, els = Elements[G], bottomRow, grid},
	els = Elements[G];
	bottomRow = Prepend[Table[Item[If[OperatorSymbol[G]==="+",ToString[k]<>"\[CenterDot]x",Superscript["x",ToString[k]]],Background-> GrayLevel[0.7]],{k,2, exp}],
		Item["x",Background -> GrayLevel[0.7]]];
	n = Length[els];
	subgroups = Map[Elements[SubgroupGenerated[G,#]]&,els];
	ords = Map[Length,subgroups];
	grid = Table[Item[Tooltip[el=subgroups[[j,k]], 
		If[OperatorSymbol[G]==="+",ToString[k]<>"\[CenterDot]"<>ToString[subgroups[[j,1]],TraditionalForm],Superscript["("<>ToString[subgroups[[j,1]],TraditionalForm]<>")",ToString[k]]]], 
		Background-> BackgroundColors[[pos=Position[els,el,1]//Flatten//First]]],{j,1,n},{k,1,ords[[j]]}];
	grid = Insert[grid,bottomRow,-1];
	Panel[Grid[grid, Dividers->All, ItemSize->All, Spacings-> Offset[1]], 
		{"elements\nin\nfirst\ncolumn",If[OperatorSymbol[G]==="+","multiples","powers"]},{Left,Bottom}]
]

(* Added new version of GroupExponentVisual 7/17/08

Part of tooltip was
ToString[CayleyForm[G][subgroups[[j,1]]]^k] 

ToString[Superscript[subgroups[[j,1]],ToString[k]],TraditionalForm] *)


(* ::Section:: *)
(* 22. Cayley Table*)


widthNeeded[Els_List] := 
	(.33333 + Length[Els]*.60385)/25 * 
	Max[Map[Length[Characters[ToString[InputForm[#]]]]&,Els]];
	
deleteSpacesInStrings[s_String] := 
	s//Characters//DeleteCases[#," "]&//StringJoin
	
basicCayley[G_,els_,opts___] := 
	Module[{len, g,gs,widetab,lowLeftPts,i,j, dummy,missing,
		rects, textGraphics, toptext,tableText,oldLL={},
		linesGraphics, widetrans={}, altEls, StrEls,altRls,
		lines = {}, showOp,showName,showBodyText,showKey,varToUse,
		opsym,siderects, toprects, pts,sidetext, tn,
		RuleList,gn,showSidesText,Els=els,cform,
		extracols, wideQ=False,partpos,tab,cayleyForm,keyForm},
	(* first test to make sure Els and Elements[G] are the
	same set, not counting order *)
If[Not[untestedQ[WideElementsQ[G]]],wideQ=WideElementsQ[G],
		If[widthNeeded[Els]>.95,wideQ=True]];
	(* do we know the elements are wide? If not, go find out. *)
varToUse = VarToUse/.Flatten[{opts, Options[CayleyTable]}];
If[(*untestedQ[basiccayley[G,Els,opts]]*) 2 > 1 (* force through for now *),
	showOp = ShowOperator/.Flatten[{opts, Options[CayleyTable]}]; 
		(* show operation symbol? *)
	showName = ShowName/.Flatten[{opts, Options[CayleyTable]}];
	showBodyText = ShowBodyText/.Flatten[{opts, Options[CayleyTable]}];
	showSidesText = ShowSidesText/.Flatten[{opts, Options[CayleyTable]}];
	showKey = ShowKey/.Flatten[{opts, Options[CayleyTable]}];
	tn = TableName/.Flatten[{opts, Options[CayleyTablePrivate]}];
	cform = CayleyForm/.Flatten[{opts, CayleyForm -> CayleyForm[G],
		Options[CayleyTable]}];
	cayleyForm = If[cform === CayleyForm, CayleyForm[G], cform];
	len = Length[Els];
	gn = If[tn === Default, StructureName[G], tn];
	(* do we know the name of this groupoid? *)
	opsym = If[showOp,If[untestedQ[OperatorSymbol[G]],"*", 
		OperatorSymbol[G]],""];
	(* what is the symbol to denote the operation? *)
	If[wideQ, (* if wide, we have some work to do *)
		gs[i_] := StringJoin[ToString[varToUse],ToString[i]]; 
			(* define substitute symbols *)
		altEls = Table[gs[k],{k,len}];
		RuleList = MapThread[Rule,{Map[dummy,Els,1],altEls}]];
		(* rules for converting the other way - used as Rules below *)
	lowLeftPts=Flatten[Table[{i,j},{j,len-1,0,-1},{i,0,len-1}],1];
	(* get lower-left pts of rectangles for tables *)
	rects = Partition[Map[Rectangle[#,#+1]&,lowLeftPts],len];
	(* matrix of rectangles *)
	pts = Table[{-1,j},{j,0,len}]; (* to make rectangles & text *)
	siderects = Map[Rectangle[#,#+1]&,pts];(* for first operands *)
	sidetext = Map[Text[#[[2]],#[[1]]+.5,{0,0}]&,
		Transpose[{Drop[pts,-1]//Reverse, If[wideQ,Map[cayleyForm,altEls],
		Map[cayleyForm,Els]]}]];
	pts = Table[{j,len},{j,0,len-1}];
	toprects = Map[Rectangle[#,#+1]&,pts];
	toptext = Map[Text[#[[2]],#[[1]]+.5,{0,0}]&,
		Transpose[{pts,If[wideQ,Map[cayleyForm,altEls],Map[cayleyForm,
			Els]]}]];
	tab = makeTable[G,Els]; (* returns matrix of table *)
	If[wideQ, tab = Map[dummy, tab, {2}];
		tab = tab/.RuleList];
	missing = If[Position[tab, dummy[_]] =!= {},True, False];
	(* If[$VersionNumber < 2.5, Print[" "]];*)
	If[missing, tab = tab /. dummy[_] -> "MIA";
		Print["MIA indicates that an element is not in the domain, so it cannot
be keyed; see output for actual values."]];
	tableText = Map[Text[#[[2]],#[[1]]+.5,{0,0}]&,
		Transpose[{lowLeftPts,Map[cayleyForm,Flatten[tab,1]]}]];
	textGraphics = Show[Graphics[{If[showBodyText,tableText], 
		If[showSidesText,sidetext],If[showSidesText,toptext],
		{If[showName,Text[gn, {-1,len+1.5},
			{-1,0}]]},
		If[showOp,Text[StandardForm["  "<>opsym<>"  "], {len,len+1.5},
			{1,0}]],
		Text[" ",{-.66,len+.33},{0,0}],
		Text[" ",{-.25,len+.7},{0,0}]}//DeleteCases[#,Null]&//
			DeleteCases[#,{Null}]&],
		DisplayFunction -> Identity];
	lines = Union[Table[Line[{{i,0},{i,len + 1}}],{i,-1,len}],
		Table[Line[{{-1,i},{len,i}}],{i,0,len+1}]]//Flatten;
	linesGraphics = Show[Graphics[{
		{AbsoluteThickness[1],lines, Line[{{-1,len+1},{0,len}}]},
		{AbsoluteThickness[2.6],Line[{{0,0},{0,len+1}}],
			Line[{{-1,len},{len,len}}]}}],
		DisplayFunction -> Identity];
	basiccayley[G,Els,opts]={linesGraphics,textGraphics,rects}];
	(*If[wideQ,PrintCayleyKey[Els,varToUse]];*)
	basiccayley[G,Els,opts]
	]



(* ::Text:: *)
(*FourPartsToMatrix can be used to build a matrix of entries of a Cayley table given the upper-left corner (to show the op symbol), the top and left sides are the same, and finally, the main core part of the table. Once those 3 (or 4) pieces are built, use this to piece them together. Note that MatrixToFourParts is the inverse function in some sense.*)


FourPartsToMatrix[UppLft_, sides_,core_]:=Module[{temp, top},
top=Join[{UppLft},sides];
temp=Prepend[Transpose[core],sides]//Transpose;
Prepend[temp,top]
]

MatrixToFourParts[mat_List]:=Module[{ul, sides, core,temp},
temp=First[mat];
ul=First[temp];
sides=Rest[temp];
core=Rest[mat]//Transpose//Rest//Transpose;
{ul,sides,core}
]

WhiteCayleyGrid[G_]:= Module[{Els = Elements[G],basictab,itemtab},
	basictab = makeTable[G, Els];
	itemtab = Map[Item[CayleyForm[G][#], Background-> White]&, 
		FourPartsToMatrix[OperatorSymbol[G], Els, basictab],{2}];
	{basictab, itemtab}
]

WhiteCayleyGrid[G_, Els_]:= Module[{basictab,itemtab},
	basictab = makeTable[G, Els];
	itemtab = Map[Item[CayleyForm[G][#], Background-> White]&, 
		FourPartsToMatrix[OperatorSymbol[G], Els, basictab],{2}];
	{basictab, itemtab}
]
(* WhiteCayleyGrid added 7/11/08
second version useful if there is a different arrangement *)

GribasicCayley[G_,els_,opts___?OptionQ]:=
	Module[{len,g,gs,widetab,lowLeftPts,i,j,k,missing,toptext,tableText, 
		altEls,showOp,showName, keyForm, kForm,Els=els, elslen, direct,
		showBodyText,showKey,varToUse,opsym,siderects,sidetext,tn,RuleList,gn,showSidesText,cform, 
		extracols,wideQ=False,partpos,tab,cayleyForm, usekey, colorRules, bodyColored,
		headingsColored,parts, labels={{},{}}, tooltip,showInformation},
keyForm = KeyForm/.Flatten[{opts}];
kForm = If[keyForm === KeyForm, KeyForm[G], keyForm];
varToUse=VarToUse/.Flatten[{opts,Options[CayleyTable]}];
tooltip=TooltipInfo/.Flatten[{opts,Options[CayleyTable]}];
showOp=ShowOperator/.Flatten[{opts,Options[CayleyTable]}];
showName=ShowName/.Flatten[{opts,Options[CayleyTable]}];
showInformation=ShowExtraCayleyInformation/.Flatten[{opts,Options[CayleyTable]}];
showBodyText=ShowBodyText/.Flatten[{opts,Options[CayleyTable]}];
showSidesText=ShowSidesText/.Flatten[{opts,Options[CayleyTable]}];
bodyColored=BodyColored/.Flatten[{opts,Options[CayleyTable]}];
headingsColored=HeadingsColored/.Flatten[{opts,Options[CayleyTable]}];
showKey=ShowKey/.Flatten[{opts,Options[CayleyTable]}];
usekey=UseKey/.Flatten[{opts,Options[CayleyTable]}];
tn=TableName/.Flatten[{opts,Options[CayleyTablePrivate]}];
cform=CayleyForm/.Flatten[{opts,CayleyForm->CayleyForm[G],Options[CayleyTable]}];
cayleyForm=If[cform===CayleyForm,CayleyForm[G],cform];
cayleyForm=cform; (* see if this fixes some issues *)
len=Length[Els];
direct={"Panel",cform}; (* what is "Panel" doing? *)
direct={cform};
direct={};
colorRules=Table[Rule[Item[Els[[k]]],Item[Els[[k]],Background->BackgroundColors[[k]]]],{k,len}];
If[usekey===Automatic, elslen=Length[Characters[ToString[Els]]];
	If[elslen<81, usekey=False,If[elslen<141,usekey=False; 
		direct={Small,cform},usekey=True; direct={StandardForm}]]];
If[usekey===Automatic, elslen=Length[Characters[ToString[Els]]];
	If[elslen<81, usekey=False,If[elslen<141,usekey=False; 
		direct={Small},usekey=True; direct={}]]]; 
If[usekey, gs[i_]:=StringJoin[ToString[varToUse],ToString[i]];
	altEls=Table[gs[k],{k,len}];
	RuleList=Table[Rule[Item[Els[[k]],Background->x_],Item[altEls[[k]],Background->x]],
		{k,len}]];
gn=If[tn===Default,StructureName[G],tn];
opsym=If[showOp,If[untestedQ[OperatorSymbol[G]],"*",OperatorSymbol[G]]," "];
tab=makeTable[G,Els];
tab=FourPartsToMatrix["op",Els,tab];
tab=Map[Item,tab,{2}]/.colorRules;
If[!bodyColored && !headingsColored,
	tab=tab/.(Background->x_)->(Background->White),
	If[!bodyColored || !headingsColored, parts=MatrixToFourParts[tab];
		If[!bodyColored,
			tab=FourPartsToMatrix[First[parts],parts[[2]], 
				parts[[3]]/.(Background->x_)->(Background->White)],
			tab=FourPartsToMatrix[First[parts],parts[[2]]/.(Background->x_)->(Background->White), 
				parts[[3]]]]]];
If[usekey, tab=tab/.RuleList];
If[!showBodyText && !showSidesText,
	tab=tab/.(Item[el_,rl___])->(Item[Annotation[" ",el],rl]),
	If[!showBodyText || !showSidesText, parts=MatrixToFourParts[tab];
		If[!showBodyText,
			tab=FourPartsToMatrix[First[parts],parts[[2]], 
				parts[[3]]/.(Item[el_,rl___])->(Item[Annotation[" ",el],rl])],
			tab=FourPartsToMatrix[First[parts],parts[[2]]/.(Item[el_,rl___])->(Item[Annotation[" ",el],rl]), 
				parts[[3]]]]]];
tab=tab/.Item["op"]->Item[ToString[opsym]];
(*Return[{tab[[2,3,1]],Head[tab[[2,3,1]]]}];*)
If[showName,labels[[1]]={gn};labels[[2]]={Top}];
If[showKey && usekey,labels[[1]]=Join[labels[[1]],{Style[CayleyKeyString[Els,StructureName[G],G, kForm, 
		varToUse],Small]}]; labels[[2]]=Join[labels[[2]],{Bottom}]];
Off[Identity::lfail];
Off[Identity::rfail];
Off[Identity::fail];
Off[Group::fail];
Off[Inverse::noId];
Off[MemberQ::"elsbst"];
If[tooltip==Automatic && showBodyText,
tab = tab/.Item[x_,r___]:>Item[Tooltip[cayleyForm[x],MakeCayleyOrdInvTooltip[G,x,tooltip,usekey]],r]];
(*Tooltip[Item[cayleyForm[x],r],MakeCayleyOrdInvTooltip[G,x,tooltip,usekey]]
*)
On[Identity::lfail];
On[Identity::rfail];
On[Identity::fail];
On[Group::fail];
On[Inverse::noId];
On[MemberQ::"elsbst"];
If[showInformation,CellPrint[Row[{
	Button["Group properties",GroupInformationWork[G]],
	Button["Element properties",ElementInformationWork[G]],
	Button["Group Calculator",pushedGroup=G; pushedGroupName=GroupoidName[G];GroupCalculator]}]]];
(*Print[Directive[Sequence@@direct]];*)
If[showName,
	Column[{Labeled[Panel[Grid[tab,Dividers->{{1,2->Thickness[4]},{1,2->Thickness[4]}}, ItemSize->Full,
		Spacings -> Offset[1], ItemStyle->Directive[Sequence@@direct]],{" "," "},
{Left,Top}],(Sequence@@labels)]}],
	Panel[Grid[tab,Dividers->{{1,2->Thickness[6]},{1,2->Thickness[6]}},ItemSize -> All,
		Spacings -> Offset[1], ItemStyle->Directive[Sequence@@direct]],{" "," "},
{Left,Top}]]
]

DoMagnify[factor]:=Module[{nb},
nb=ButtonNotebook[];
SelectionMove[nb,Previous,Cell,2];
SelectionMove[nb,Before, CellContents];
NotebookWrite[nb,"Magnify["];
SelectionMove[nb,After, CellContents];
NotebookWrite[nb,","<>ToString[factor]<>"]"];
SelectionMove[nb,All, Cell];
SelectionEvaluate[nb,After]]

CayleyKeyString[Els_List,name_,G_,form_,lab_String:"g"] := 
	Module[{rules, nform},
	nform = If[Head[form] === KeyForm, Identity, form];nform=StandardForm;
	rules = MakeSubstitutionRules[G,Map[nform,Els], lab];
	StringJoin["KEY for "<>ToString[name]<>": label used \[Rule]"<>" element: "<>
		StringReplace[ToString[rules,nform],"->"->"\[Rule]"]]]

TempCount = 0;

MakeCayleyOrdInvTooltip[G_,el_,tipinfo_,UseKey_]:=
	Module[{oper,temp,show={}, acceptable, apply, funcs, g=el, cm=ComputationalMouseovers, rules},
acceptable={"order","inverse"};
oper = If[el===OperatorSymbol[G]||el===" ",True,False];
If[Not[oper],
rules={"element"->Style["g",Blue, 24], "order"->Style["|g|",Blue, 24], "inverse"->Style[
"\*SuperscriptBox[g, -1]",Blue,24]}; (*removed '\*' before SuperscriptBox*)
ComputationalMouseovers=False;
Off[MemberQ::elmnt];
funcs["order"]:=OrderOfElement[G,g,Mode->Computational];
funcs["inverse"]:=GroupInverse[G,g];
If[tipinfo===Automatic, apply={"order","inverse"},
apply=Intersection[acceptable,tipinfo]];
If[apply==={}, apply={"order","inverse"}];
If[UseKey, g=KeyToElement[G,el]; If[Head[g]===InputForm||Head[g]===StandardForm||Head[g]===OutputForm,g=First[g]],g=el];
If[Head[g]===Annotation, g= g[[2]]];
TempCount++;
(*If[TempCount<4,Print[{g, Head[g],OrderOfElement[G,g,Mode->Computational]}]];*)
show={{"element",Style[ToString[g,StandardForm],Blue, 24]}};
show=If[Head[el]===String && First[Characters[el]]=="x", {{}},
	Join[show,Map[{#, Style[ToString[funcs[#],StandardForm],Blue,24]}&,apply]]];
ComputationalMouseovers=cm;
On[MemberQ::elmnt];
(*AppendTo[show,{"head", ToString[Head[g]]}];*)
show=show/.rules;
]; (* above is done if not the operator symbol 
Print[{el,Head[el],show,oper}];*)
If[show==={} || oper, "operator symbol", Grid[Transpose[show],Dividers->All]]
]


Options[CayleyTablePrivate]={TableName->Default};

Options[CayleyTable]={CayleyForm->StandardForm,HeadingsColored->True,BodyColored->True,
	KeyForm->StandardForm,Mode->Visual,ShowBodyText->True,ShowKey->True,ShowName->True,
ShowOperator->True,ShowSidesText->True,TheSet->{},VarToUse->"g", UseKey->Automatic,
Version->6, TooltipInfo->Automatic, EnlargeFactor->1.5,
ShowExtraCayleyInformation->True};


GriCayleyTable[G_?GroupoidQ,opts___?OptionQ] := 
	Module[{Els=Elements[G],table,mymode,sc,ElementsToUse, tab},
	mymode=Mode/.Flatten[{Options[CayleyTable]}];
	ElementsToUse=TheSet/.Flatten[{opts,Options[CayleyTable]}];
	If[ElementsToUse=!={}&&!SameSetQ[Els,ElementsToUse],Message[TheSet::"error",ElementsToUse]];
	If[ElementsToUse==={}||!SameSetQ[Els,ElementsToUse],ElementsToUse=Els];
	Off[Inverse::fail];
	tab = GribasicCayley[G,ElementsToUse, opts];
	On[Inverse::fail];
	tab
]


CayleyTable[G_?GroupoidQ, Mode->Computational, TheSet->els_List] :=  Module[{Els = Elements[G], ElementsToUse},
	ElementsToUse = els;
	If[ElementsToUse =!= {} && Not[SameSetQ[Els,ElementsToUse]], 
		Message[TheSet::error, ElementsToUse]];
	If[ElementsToUse === {} || Not[SameSetQ[Els,ElementsToUse]], 
		ElementsToUse = Els];
	makeTable[G, ElementsToUse]
]

CayleyTable[G_?GroupoidQ, Mode->Computational] :=  
	makeTable[G, Elements[G]]

CayleyTable[G_?GroupoidQ, Mode->Textual, TheSet->els_List] := Module[{tab, Els = Elements[G], ElementsToUse},
	ElementsToUse = els;
	If[ElementsToUse =!= {} && Not[SameSetQ[Els,ElementsToUse]], 
		Message[TheSet::error, ElementsToUse]];
	If[ElementsToUse === {} || Not[SameSetQ[Els,ElementsToUse]], 
		ElementsToUse = Els];
	tab = makeTable[G,ElementsToUse];
	StringJoin["The Cayley table for a Groupoid is formed by taking all the elements of the set (in this case, ",
		ToString[ElementsToUse,StandardForm], 
		") and forming a 'multiplication' table. The entry of the table in position (i,j) is obtained by using the group operation on the ith element in the left column and the jth element in the top row. This results in the following table.\n\n",
(*ToString[Grid[tab],StandardForm],*) ToString[TextCayley[G,ElementsToUse],StandardForm]]
] 

CayleyTable[G_?GroupoidQ, Mode->Textual] :=  
	CayleyTable[G,  Mode->Textual, TheSet->Elements[G]]

CayleyTable[G_?GroupoidQ, Mode->Visual, opts___?OptionQ] :=  Module[{version},
	version = Version/.Flatten[{opts, Options[CayleyTable]}];
	Switch[version,
		6, GriCayleyTable[G, opts],
		5, GraCayleyTable[G, opts],
		_, Message[CayleyTable::version, version]]
	]

CayleyTable[G_?GroupoidQ, opts___?OptionQ] :=  
	Module[{mode, theset},
	mode = Mode/.Flatten[{opts, Options[CayleyTable]}];
	theset = TheSet/.Flatten[{opts, Options[CayleyTable]}];
	Switch[mode,
		Computational, CayleyTable[G, Mode->Computational, TheSet->theset],
		Textual, CayleyTable[G, Mode->Textual, TheSet->theset],
		Visual, CayleyTable[G, Mode->Visual, opts]
	]
]

GraCayleyTable[G_?GroupoidQ, opts___?OptionQ] :=  
	Module[{Els = Elements[G], table, mymode,sc,ElementsToUse},
	mymode = Mode/.Flatten[{opts, Options[CayleyTable]}];
	ElementsToUse = TheSet/.Flatten[{opts, Options[CayleyTable]}];
	If[ElementsToUse =!= {} && Not[SameSetQ[Els,ElementsToUse]], 
		Message[TheSet::error, ElementsToUse]];
	If[ElementsToUse === {} || Not[SameSetQ[Els,ElementsToUse]], 
		ElementsToUse = Els];
	If[untestedQ[cayleyTable[G,ElementsToUse, opts]],
		cayleyTable[G,ElementsToUse, opts] = makeTable[G,ElementsToUse]];
	table = cayleyTable[G,ElementsToUse, opts];
	If[mode===Textual,
		CaylayTableTextual[G,ElementsToUse],
		If[mode===Visual,
			CaylayTableVisual[G,ElementsToUse, opts], table]]
	]

CayleyTable[many:{_?GroupoidQ..}] :=
	Row[Map[CayleyTable[#, Mode -> (Mode/.Options[CayleyTable])]&, many]]
(* if no Mode is specified, go determine default and specify it 
so that the next function can properly be called. *)
	
CayleyTable[many:{_?GroupoidQ..}, Mode -> Computational, opts___?OptionQ] := 
		Map[CayleyTable[#, Mode -> Computational, opts]&, many]
		
CayleyTable[many:{_?GroupoidQ..}, Mode -> Textual, opts___?OptionQ] := 
		Map[CayleyTable[#, Mode -> Textual, opts]&, many]//StringJoin
		
CayleyTable[many:{_?GroupoidQ..}, Mode -> Visual, opts___?OptionQ] := 
		Row[Map[CayleyTable[#, Mode -> Visual, opts]&, many]]
		
CayleyTable[{{G1_?GroupoidQ, opts1___?OptionQ},
	{G2_?GroupoidQ, opts2___?OptionQ}}, Mode -> Visual, opts3___?OptionQ] := 
		Row[{CayleyTable[G1, Mode -> Visual, opts1, opts3],
		CayleyTable[G2, Mode -> Visual, opts2, opts3]}]

CayleyTable[{{G1_?GroupoidQ, opts1___?OptionQ},
	{G2_?GroupoidQ, opts2___?OptionQ}, {G3_?GroupoidQ, opts3___?OptionQ}}, Mode -> Visual] := 
		Row[{CayleyTable[G1, Mode -> Visual, opts1],
		CayleyTable[G2, Mode -> Visual, opts2],
		CayleyTable[G3, Mode -> Visual, opts3]}]
		
CayleyTable[many:{_?GroupoidQ..}, opts__?OptionQ] := 
	Row[Map[CayleyTable[#, opts]&, many]]
(* if there are options to be applied to each groupoid, and no 
	mode is specified, take this path *)

(* CayleyTable[many:{_?GroupoidQ..},opts:{_?VectorQ..}] := 
	CayleyTable[many, opts, 
			Mode -> (Mode/.Options[CayleyTable])]
 if we have a list of groupoids and a list of options, but
no mode specified, take this path *)

CayleyTable[many:{_?GroupoidQ..},opts:{_?MatrixQ..}, Mode -> mode_] := 
	Map[CayleyTable[Sequence[#]]&,Map[Flatten,MapThread[List,{many,opts}]]]

CayleyTable[many:{_?GroupoidQ..},opts:{_?MatrixQ..}] := 
	Map[CayleyTable[Sequence[#]]&,Map[Flatten,MapThread[List,{many,opts}]]]
(* if we have a list of groupoids and a list of options, and
the mode is specified, take this path *)


GetMode[lists_List] := Module[{opts, modes},
	opts = Map[Select[#, OptionQ]&, lists];
	modes = Map[Mode/.#&, opts];
	If[MemberQ[modes, Visual], Visual, 
		If[MemberQ[modes, Textual], Textual, Computational]]]

CayleyTable[G_,anything___] := Message[Groupoid::fail,StructureName[G]]

FindSingleton[els_,g_] :=
	Select[Position[els, g],Length[#]==1&]//Flatten
	
ColorTableSquares[G_, els_, pairs_, colors_List] := 
		Module[{poslist,rows,cols,rects,selrects},
	rows = Map[FindSingleton[els,#]&,Transpose[pairs]//First]//Flatten;
	cols = Map[FindSingleton[els,#]&,Transpose[pairs]//Last]//Flatten;
	poslist = Transpose[{rows,cols}];
	rects = basicCayley[G,els][[3]];
	selrects = Map[Part[rects,Apply[Sequence,#]]&,poslist];
	Transpose[{colors,selrects}]]

ColorTableSquares[G_, els_, pairs_, color_RGBColor] := 
	ColorTableSquares[G, els, pairs, Table[color,{Length[pairs]}]]

ColorRowSquares[G_, els_, g_, vals_, colors_List] := 
	ColorTableSquares[G, els, Map[{g,#}&,vals],colors]

ColorRowSquares[G_, els_, g_, vals_, color_RGBColor] :=
	ColorRowSquares[G,els,g,vals,Table[color,{Length[vals]}]]
		
ColorColumnSquares[G_, els_, g_, vals_, colors_List] := 
	ColorTableSquares[G, els, Map[{#,g}&,vals],colors]

ColorColumnSquares[G_, els_, g_, vals_, color_RGBColor] :=
	ColorColumnSquares[G,els,g,vals,Table[color,{Length[vals]}]]
		
ColorTopSquares[G_, els_, vals_, colors_List] := Module[{n = 
	Length[els],pos,rects,x},
	pos = Map[FindSingleton[els,#]&,vals]//Flatten;
	rects = Table[Rectangle[x={pos[[i]]-1,n},x+1],{i, Length[pos]}];
	Transpose[{colors,rects}]]

ColorTopSquares[G_, els_, vals_, color_RGBColor] :=
	ColorTopSquares[G,els,vals,Table[color,{Length[vals]}]]
		
ColorSideSquares[G_, els_, vals_, colors_List] := Module[{n = 
	Length[els],pos,rects,x},
	pos = Map[FindSingleton[els,#]&,vals]//Flatten;
	rects = Table[Rectangle[x={-1,n-pos[[i]]},x+1],{i, Length[pos]}];
	Transpose[{colors,rects}]]

ColorSideSquares[G_, els_, vals_, color_RGBColor] :=
	ColorSideSquares[G,els,vals,Table[color,{Length[vals]}]]
				
CayleyTableVisualWork[G_,ElementsToUse_, opts___] := 
	Module[{len, rects, table, Els = ElementsToUse,
		coloredRects, gColoredRects, gText, headings,
		gLines,headingsColored,bodyColored},
	headingsColored = HeadingsColored/.Flatten[{opts, 
		Options[CayleyTable]}];
	bodyColored = BodyColored/.Flatten[{opts,
  Options[CayleyTable]}];
	If[showVisTextQ[CayleyTable],
		Print[StringJoin["For each element, a different color is used.
The entries in the table corresponding to the
elements are then colored and labeled accordingly."]]];
	table = makeTable[G,Els];
	len = Length[Els];
	{gLines, gText, rects} = basicCayley[G,Els,opts]; 
		(* get basic info *)
	coloredRects = Table[{Part[BackgroundColors,i],
		Map[rects[[#[[1]],#[[2]]]]&, Select[Position[table,
		Part[Els,i]],(Length[#]==2)&]]},{i, len}];
	If[Not[bodyColored], coloredRects = coloredRects/. RGBColor[x_,y_,z_] -> RGBColor[1,1,1]];
		(* change made 10/29/99 *)
(* color the rectangles containing the same element with
the same color *)
	If[headingsColored,
		headings = Join[ColorTopSquares[G,Els,Els,
			Take[BackgroundColors,len]],
			ColorSideSquares[G,Els,Els, Take[BackgroundColors,len]]],
		headings={White,Point[{-.01,-0.01}]}];
	gColoredRects = Show[Graphics[{coloredRects, headings},
		DisplayFunction -> Identity]];
	{gColoredRects,gLines, gText}
	]

Options[CayleyTableVisual]={DisplayFunction -> $DisplayFunction};

CayleyTableVisual[G_,ElementsToUse_, opts___] :=
	Module[{showopts = FilterRules[{opts},Options[Graphics]],
		df = DisplayFunction/.Flatten[{opts, Options[CayleyTableVisual]}],
		showKey = ShowKey/.Flatten[{opts, Options[CayleyTable]}],
		vartouse = VarToUse/.Flatten[{opts, Options[CayleyTable]}],
		keyForm = KeyForm/.Flatten[{opts}], kform},
	kform = If[keyForm === KeyForm, KeyForm[G], keyForm];
	If[WideElementsQ[G] && showKey,
		PrintCayleyKey[ElementsToUse,StructureName[G],G, kform, 
		vartouse]];
	Show[CayleyTableVisualWork[G,ElementsToUse,opts],showopts,
		DisplayFunction -> df]]

CayleyTableTextual[G_,ElementsToUse_] := Module[{tab},
	tab = makeTable[G,ElementsToUse];
	Print[StringJoin["The Cayley table for a Groupoid is formed
by taking all the elements of the set (in this case, ",
ToString[InputForm[ElementsToUse]],") and forming a 'multiplication'
table. The entry of the table in position
(i,j) is obtained by using the group operation on the ith
element in the left column and the jth element in the top
row.\n"]];
]

TextCayley[G_?GroupoidQ]:=Module[{table, Els = Elements[G],len},
	len = Length[Els];
	table=makeTable[G,Els];
    table//
       Prepend[#,Table["-",{len}]]&//
       Prepend[#,Els]&//Transpose//
       Prepend[#,Table["|",{2+len}]]&//
       Prepend[#,Join[{" ","-"},Els]]&//
       Transpose//TableForm[#,TableSpacing->{1,1,0,1,0,1},TableAlignments->{Center,Center}]&
     ]

TextCayley[G_?GroupoidQ,Els_]:=Module[{table=makeTable[G,Els],len},
	len = Length[Els];
    table//
       Prepend[#,Table["-",{len}]]&//
       Prepend[#,Els]&//Transpose//
       Prepend[#,Table["|",{2+len}]]&//
       Prepend[#,Join[{" ","-"},Els]]&//
       Transpose//TableForm[#,TableSpacing->{1,1,0,1,0,1},TableAlignments->{Center,Center}]&
     ]



makeTable[G_,Els_List]:=Module[{fake},If[SubsetQAA[Els,Elements[G]],Partition[Distribute[fake[Els,Els],List],Length[Els]]/.fake->Operation[G]]]


(* ::Section:: *)
(* 23. Tests for Group properties*)


(* ::Subsection:: *)
(*23.1 closure*)


Options[ClosedQ]={Structure -> Group};

ClosedQ[G_?GroupoidQ] := ClosedQ[G] = 
		Module[{Els = Elements[G], op = Operation[G],
			contained = True, i},
	For[i = 1, i <= Length[Els], i++,
		contained = SubsetQAA[Map[(op[Els[[i]],#])&,Els],Els];
		If[Not[contained],Break[]]];
	AddGroupInfo[G, contained, "the set is closed under the operation", 
		"the set is not closed under the operation"];
	contained]

ClosedQ[G_?GroupoidQ, Mode -> Computational]:= ClosedQ[G]

ClosedQ[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ]:= 
	ClosedQTextual[G, Group, OperatorSymbol[G],opts]

ClosedQ[G_?GroupoidQ, Structure->Ring, Mode -> Textual]:= 
	ClosedQTextual[G, Ring, OperatorSymbol[G]]

ClosedQ[G_?GroupoidQ, Mode -> Textual, Structure->Ring]:= 
	ClosedQTextual[G, Ring, OperatorSymbol[G]]

ClosedQ[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ]:= 
	DoVisualization[SubgroupQVisual5[G, Elements[G], opts],{{G},ClosedQHelp},opts]

ClosedQHelp[G_]:= DoHelpMessage[windowtitle -> "Help for the closure of "<>GroupoidName[G], 
	help -> List["All the elements with a green background are the original elements from ",
	GroupoidName[G],
	":\n ",
Cell[BoxData[
 ToBoxes[Elements[G],TraditionalForm]]],
"\nThose elements with a red background, if any, are from outside this set. The presence of red elements, therefore, indicates that the set is not closed under the operation. Thus, if all the elements are green, the set is closed under the given operation."
	]]

ClosedQ[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ, Version -> 5]:= 
	ClosedQVisual5[G, ClosedQ[G], opts]

ClosedQ[G_?GroupoidQ, Mode -> Visual, Version -> 5, opts___?OptionQ]:= 
	ClosedQVisual5[G, ClosedQ[G], opts]

(* TODO fix this older version 5 *)

ClosedQ[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> ClosedQ[G],
	"Explanation" -> ClosedQ[G, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> ClosedQ[G, Mode->Visual, ConvertMode -> "All", opts]}, 
	ImageSize->Automatic],"Closure of "<>GroupoidName[G], Top]


ClosedQTextual[G_, st_,symb_, opts___?OptionQ] := Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	If[Not[multipleQ], text = StringJoin[ClosedQTextualGD[G], 
		ClosedQTextualLI[G,st,symb]],
		If[firstPassQ, 
			firstPassQ = False;
			text = StringJoin[ClosedQTextualGD[G], ClosedQTextualLI[G,st,symb]],
			text = ClosedQTextualLI[G,st,symb]]];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]

ClosedQTextualGD[_] :=
	"We say that a set S is closed under an operation op if whenever we have x and y in S, we also have op[x,y] (or x~op~y) in S.\n";	
	
ClosedQTextualLI[G_, strct_,symb_] := Module[{tab,pos,a,b,prod},
	If[Not[ClosedQ[G]],tab = makeTable[G,Elements[G]];
		pos = First[Position[tab,First[Complement[
			Union[Flatten[tab,1]],Elements[G]]]]];
		prod = tab[[Apply[Sequence,pos]]];
		a = Elements[G][[pos[[1]]]];
		b = Elements[G][[pos[[2]]]]];
	StringJoin["In this case, the ",
	If[strct===Group,"Groupoid ","Ringoid "],
	GroupoidName[G]," is ",
	ToString[If[ClosedQ[G],"indeed closed.",
	"NOT closed."]],If[Not[ClosedQ[G]],
	StringJoin[" For example, since ",
	ToString[a]," ",symb," ",ToString[b]," = ",
	ToString[prod]," (which is not in the set), it is clear that it is not closed."],""]]]


ClosedQVisual5[G_,closed_,opts___] := 
	Module[{showopts = FilterRules[{opts},Options[Graphics]],
		df = DisplayFunction/.Flatten[{opts, Options[ClosedQVisual]}]},
	SubgroupQVisual4[G, Elements[G], showopts];
	closed]

(* added closed at end 7/21/08 *)

ClosedQ[many:{_?GroupoidQ..}] := Map[ClosedQ, many]
		
ClosedQ[many:{_?GroupoidQ..}, Mode -> mode_,opts___?OptionQ] :=
	Map[ClosedQ[#, Mode-> mode, opts]&, many]//Column

ClosedQ[G_?GroupoidQ, H_List, Mode -> Visual, opts___?OptionQ]:=
	If[ElementsQ[H,G], 
		DoVisualization[SubgroupQVisual5[G, H, opts],{{G,H},ClosedQHHelp},opts],
		Message[MemberQ::elmnts, H, StructureName[G]]; $Failed]

ClosedQHHelp[G_, H_]:= DoHelpMessage[windowtitle -> "Help for the closure of "<>ToString[H]<>" in "<>GroupoidName[G], 
		help -> List["All the elements with a green background are the original elements from H = \n",
	Cell[BoxData[
 ToBoxes[H,TraditionalForm]],
 FormatType->"TraditionalForm"],
	"\nThose elements with a red background, if any, are from outside this set H. The presence of red elements, therefore, indicates that the set H is not closed under the operation. Thus, if all the elements are green, the set H is closed under the given operation."]
]
	
ClosedQ[G_?GroupoidQ,H_List,opts___?OptionQ]/;ElementsQ[H,G]:=
	ClosedQ[FormGroupoid[H, Operation[G],OperatorSymbol[G]],opts]
	
ClosedQ[G_?GroupoidQ,H_List,opts___?OptionQ]/;Not[ElementsQ[H,G]]:=
	(Message[MemberQ::elmnts,H,StructureName[G]]; $Failed)


(* ::Subsection:: *)
(*23.2 identity*)


HasLeftIdentityQ[G_?GroupoidQ] := HasLeftIdentityQ[G] =
		Module[{ok,id},
	{ok,id} = LeftIdentityWork[G];
	ok]
	
HasLeftIdentityQ[G_?GroupoidQ, Mode -> Computational, opts___?OptionQ] := HasLeftIdentityQ[G]

HasLeftIdentityQ[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ] := 
	DoVisualization[IdentityQVisualWork[G,LeftIdentity[G],leftid, opts],{{G},HasLeftIdentityQHelp},opts]

HasLeftIdentityQHelp[G_]:= DoHelpMessage[windowtitle -> "Help for the left identity of "<>GroupoidName[G], 
	help -> List["Note that the element with a gray background in the first column (",
Cell[BoxData[
 ToBoxes[LeftIdentity[G],TraditionalForm]],
 FormatType->"TraditionalForm"],") when multiplied by (added to) the elements in the top row produces a copy in its row. Thus, this element is a left identity."]
]

HasLeftIdentityQ[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ] := 
	Module[{text, showconvert,ok, id, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	{ok,id} = LeftIdentityWork[G];
	text = StringJoin["A group(oid) G has a left identity e if for all elements g \[Element] G we have e*g = g (e on the left). In this case, ",
		GroupoidName[G], 
		If[ok,
			" has a left identity, namely "<>ToString[id]<>".",
			" does not have a left identity."]];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
	]

HasLeftIdentityQ[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> HasLeftIdentityQ[G],
	"Explanation" -> HasLeftIdentityQ[G, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> HasLeftIdentityQ[G, Mode->Visual, ConvertMode -> "All", opts]}, 
	ImageSize->Automatic],"Does "<>GroupoidName[G]<>" have a left identity?", Top]

LeftIdentity[G_?GroupoidQ] := LeftIdentity[G] =
		Module[{ok,id},
	{ok,id} = LeftIdentityWork[G];
	If[ok, id, $Failed]]

LeftIdentity[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ] := 
	DoVisualization[IdentityQVisualWork[G,LeftIdentity[G],leftid],{{G},HasLeftIdentityQHelp},opts]
	
LeftIdentity[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ] := 
	HasLeftIdentityQ[G,Mode->Textual,opts]

LeftIdentity[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> LeftIdentity[G],
	"Explanation" -> LeftIdentity[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> LeftIdentity[G, Mode->Visual, ConvertMode -> "All",opts]}, 
	ImageSize->Automatic],"Left identity of "<>GroupoidName[G], Top]

LeftIdentity[G_?GroupoidQ, Mode -> Computational] := LeftIdentity[G]

LeftIdentityWork[G_] := LeftIdentityWork[G] = Module[{els = 
	Elements[G],index,ok,len},
	If[untestedQ[leftidentity[G]] || untestedQ[leftidentityq[G]],
		index = Position[makeTable[G,els],els]//Flatten;
		ok = (len = Length[index])>=1;
		If[len > 1, Message[Identity::lmultiple,
			StructureName[G],index]];
		{leftidentityq[G], leftidentity[G]} = If[ok, 
			{ok,els[[First[index]]]},
			{ok,Null}];
		If[Not[ok], Message[Identity::lfail,StructureName[G]]];
		AddGroupInfo[G, ok, StringJoin["the left identity is ", 
			ToString[leftidentity[G]]], "there is no left identity"];
	];
	{leftidentityq[G], leftidentity[G]}
]

HasRightIdentityQ[G_?GroupoidQ] := HasRightIdentityQ[G] =
		Module[{ok,id},
	{ok,id} = RightIdentityWork[G];
	ok]

HasRightIdentityQ[G_?GroupoidQ, Mode -> Computational] := HasRightIdentityQ[G]

HasRightIdentityQ[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ] := 
	DoVisualization[IdentityQVisualWork[G,RightIdentity[G],rightid],{{G},HasRightIdentityQHelp},opts]

HasRightIdentityQHelp[G_]:= DoHelpMessage[windowtitle -> "Help for the right identity of "<>GroupoidName[G], 
	help -> List["Note that the element with a gray background in the first row (",
Cell[BoxData[
 ToBoxes[RightIdentity[G],TraditionalForm]],
 FormatType->"TraditionalForm"],") when multiplied by (added to) the elements in the first column produces a copy in its column. Thus, this element is a right identity."]
]


HasRightIdentityQ[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ] := 
	Module[{text, showconvert,ok, id, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	{ok,id} = RightIdentityWork[G];
	text = StringJoin["A group(oid) G has a right identity e if for all elements g \[Element] G we have g*e = g (e on the right). In this case, ",
		GroupoidName[G], 
		If[ok,
			" has a right identity, namely "<>ToString[id]<>".",
			" does not have a right identity."]];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
	]

HasRightIdentityQ[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> HasRightIdentityQ[G],
	"Explanation" -> HasRightIdentityQ[G, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> HasRightIdentityQ[G, Mode->Visual, ConvertMode -> "All", opts]}, 
	ImageSize->Automatic],"Right identity of "<>GroupoidName[G], Top]

RightIdentity[G_?GroupoidQ, Mode -> Computational] := RightIdentity[G]

RightIdentity[G_?GroupoidQ] := RightIdentity[G] =
		Module[{ok,id},
	{ok,id} = RightIdentityWork[G];
	If[ok, id, $Failed]]
	
RightIdentity[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ] := 
	DoVisualization[IdentityQVisualWork[G,RightIdentity[G],rightid, opts],{{G},HasRightIdentityQHelp},opts]

RightIdentity[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ] := 
	HasRightIdentityQ[G, Mode->Textual,opts]

RightIdentity[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> RightIdentity[G],
	"Explanation" -> RightIdentity[G, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> RightIdentity[G, Mode->Visual, ConvertMode -> "All", opts]}, 
	ImageSize->Automatic],"Right identity of "<>GroupoidName[G], Top]

RightIdentityWork[G_] := RightIdentityWork[G] = Module[{els = 
		Elements[G],index,ok,len},
	If[untestedQ[rightidentity[G]] || untestedQ[rightidentityq[G]],
		index = Position[Transpose[makeTable[G,els]],els]//Flatten;
		ok = (len = Length[index])>=1;
		If[len > 1, Message[Identity::rmultiple,StructureName[G],index]];
		{rightidentityq[G], rightidentity[G]} = 
			If[ok, {ok,els[[First[index]]]}, {ok,Null}];
		If[Not[ok], Message[Identity::rfail,StructureName[G]]];
		AddGroupInfo[G, ok, StringJoin["the right identity is ", 
			ToString[rightidentity[G]]], "there is no right identity"];
	];
	{rightidentityq[G], rightidentity[G]}]

IdentityWork[G_] :=  IdentityWork[G] = Module[{leftok,rightok,
		leftid,rightid},
	{leftok,leftid} = LeftIdentityWork[G];
	{rightok,rightid} = RightIdentityWork[G];
	If[Not[leftok] && Not[rightok], Message[Identity::fail,
		StructureName[G]]];
	{leftok && rightok, If[leftid===rightid,leftid,Null]}
	]

Options[HasIdentityQ]={Mode -> Computational, Structure -> Group};

HasIdentityQ[G_?GroupoidQ] := HasIdentityQ[G] = 
		Module[{ok, id},
	{ok,id} = IdentityWork[G];
	If[ok, GroupIdentity[G] = id];
	AddGroupInfo[G, ok, StringJoin["the identity is ", 
			ToString[id]], "there is no identity"];
	ok]

HasIdentityQ[G_?GroupoidQ, Mode -> Computational] := HasIdentityQ[G]

HasIdentityQ[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ] := 
	HasIdentityQTextual[G, HasIdentityQ[G], Group,OperatorSymbol[G], opts]

HasIdentityQ[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ] := 
	HasIdentityQVisual[G, GroupIdentity[G],opts]

HasIdentityQ[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> HasIdentityQ[G],
	"Explanation" -> HasIdentityQ[G, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> HasIdentityQ[G, Mode->Visual, ConvertMode -> "All",opts]}, 
	ImageSize->Automatic],"Identity of "<>GroupoidName[G], Top]

HasIdentityQ[many:{_?GroupoidQ..}] := Map[HasIdentityQ, many]

HasIdentityQ[many:{_?GroupoidQ..}, Mode -> mode_, opts___?OptionQ] := 
	Map[HasIdentityQ[#, Mode -> mode, opts]&, many] //Column
		
HasIdentityQTextual[G_,ok_,st_,symb_,opts___?OptionQ] := Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	If[Not[multipleQ], text = StringJoin[IdentityQTextualGD[st,symb], IdentityQTextualLI[G,ok,st]],
		If[firstPassQ, 
			firstPassQ = False;
			text = StringJoin[IdentityQTextualGD[st,symb], IdentityQTextualLI[G,ok,st]],
			text = IdentityQTextualLI[G,ok,st]]];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]

IdentityQTextualGD[Group,"+"] := 
	"We say a Groupoid G has an identity e if for all other elements g in G we have e + g = g + e = g (where + indicates the operation). "

IdentityQTextualGD[Group,_] := 
	"We say a Groupoid G has an identity e if for all other elements g in G we have e * g = g * e = g (where * indicates the operation). "

IdentityQTextualGD[Ring,"+"] := 
	"We say a Ringoid R has an additive identity called 0 if for all other elements r in R we have 0 + r = r + 0 = r (where + indicates the operation). "

IdentityQTextualGD[Ring,"*"] := 
	"We say a Ringoid R has an multiplicative identity called 1 if for all other elements r in R we have 1 * r = r * 1 = r (where * indicates the operation). "

IdentityQTextualGD[_,_] := 
	"We say a structured set S (such as a Groupoid or Ringoid) has an identity e if for all other elements g in S we have e*g = g*e = g (where * indicates the operation). "

IdentityQTextualLI[G_,ok_,st_] := 
(StringJoin["\nIn this case, "<>GroupoidName[G]<>
If[ok," has the identity "<>ToString[GroupIdentity[G], TraditionalForm]<>".",
	" has no identity."]])

HasIdentityQVisual[G_,id_,opts___] := 
	If[HasIdentityQ[G],
		DoVisualization[IdentityQVisualWork[G,id,both,opts],{{G},HasIdentityQHelp},opts],
	$Failed]

HasIdentityQHelp[G_]:= DoHelpMessage[windowtitle -> "Help for HasIdentityQ[G]", 
	help -> List["Note that the element with a gray background in the first row (",
	Cell[BoxData[
 ToBoxes[RightIdentity[G],TraditionalForm]],
 FormatType->"TraditionalForm"],") when multiplied by (added to) the elements in the first column produces a copy in its column. Similarly, when the element with a gray background in the first column is multiplied by (added to) the elements in the first row, it produces a copy in its row. Thus, this element is a both a right and left identity."]
]

IdentityQVisualWorkV5[G_,id_,side_,opts___] := 
	Module[{els = Elements[G],len, rects, inter, pos,
		coloredRects = {}, gBasicRects, gColoredRects1, gText, 
		gLines, row, column,table, gr1, gr2,
		gColoredRects2,
		showopts = FilterRules[{opts},Options[Graphics]],
		df = DisplayFunction/.Flatten[{opts, 
			Options[HasIdentityQVisual]}]},
	If[HasIdentityQ[G],
	{gLines, gText, rects} = basicCayley[G,els, CayleyForm -> 
		CayleyForm[G]];
	table = makeTable[G,Elements[G]];
	len = Length[els];
	pos = Position[els,id,1]//Flatten//First;
	row = Part[rects, Position[table,els]//Flatten];
	column = Part[Transpose[rects], Position[Transpose[table],
		els]//Flatten];
	inter = Intersection[row//Flatten,column//Flatten];
	gColoredRects1 = Show[Graphics[{
		{OtherColors[[7]],column}, {Text[StandardForm["red: right ident."],{-1,-1},{-1,-1}]},
		{OtherColors[[7]],Rectangle[{-1,0},{0,len}]},
		{OtherColors[[3]],Rectangle[{pos-1,len},{pos,len+1}]},
		{OtherColors[[7]],inter}},DisplayFunction -> Identity]];
	gColoredRects2 = Show[Graphics[{{OtherColors[[1]],row},
		 {OtherColors[[1]],Rectangle[{0,len},{len,len+1}]},
		 {Text[StandardForm["red: left ident."],{-1,-1},{-1,-1}]},
		{OtherColors[[3]],Rectangle[{-1,len - pos},{0,len - pos +1}]},
		{OtherColors[[1]],inter}},DisplayFunction -> Identity]];
	gr1 = Show[{gColoredRects1, gLines, gText},
		DisplayFunction -> Identity];
	gr2 = Show[{gColoredRects2, gLines, gText},
		DisplayFunction -> Identity];
	If[WideElementsQ[G],
		PrintCayleyKey[els,StructureName[G],G, KeyForm[G]]];
	If[side === leftid, Show[gr2,showopts,
		DisplayFunction -> df],
		If[side === rightid, Show[gr1,showopts,
			DisplayFunction -> df],
			GraphicsGrid[{{Show[gr2, showopts, DisplayFunction->df],Show[gr1, showopts, DisplayFunction->df]}}]
			(* Show[GraphicsArray[{gr2,gr1}],showopts,
			DisplayFunction -> df] *)]]]]
	(* Changed 11/2/06 *)

IdentityQVisualWork[G_,id_,side_,opts___] := 
	Module[{els = Elements[G],len, rects, grid1, grid2, good, colorfn, grid, pos, 
		ltext, rtext, table, colorRules, colors, temp,showkey, panel, cayleyform, pos2},
		showkey = showkeyQ[G, opts];
		cayleyform = CayleyForm/.Flatten[{opts, Options[SubgroupQ]}];
		If[HasIdentityQ[G],
			{table,grid} =AbstractAlgebra`Master`Private`WhiteCayleyGrid[G];
			len=Length[els];
			pos = Position[els,id,1]//Flatten//First;
			colors = Table[colorfn[els[j]] = BackgroundColors[[j]],{j,Length[els]}];
			grid1 = grid2 = grid;
			temp = MapThread[Item[#1, Background-> #2]&,{grid1[[pos+1]],Prepend[colors,GrayLevel[0.7]]}];
			grid1[[pos+1]] = temp;
			temp = MapThread[Item[#1, Background-> #2]&,{grid1[[1]],Prepend[colors,GrayLevel[1]]}];
			grid1[[1]] = temp;
			If[showkey,grid1 = ConvertGridToKeyed[G,grid1]];
			If[cayleyform =!=StandardForm && MemberQ[{FullForm,MatrixForm,InputForm,TraditionalForm,OutputForm},cayleyform],
				pos2 = Flatten[Delete[Table[{i,j},{i,len+1},{j,len+1}],{1,1}],1];
				grid1 = MapAt[ChangeItemCayleyForm[#,cayleyform]&,grid1,pos2]];
			temp = MapThread[Item[#1, Background-> #2]&,{Transpose[grid2][[pos+1]],Prepend[colors,GrayLevel[0.7]]}];
			grid2[[All,pos+1]] = temp;
			temp = MapThread[Item[#1, Background-> #2]&,{grid2[[1]],Prepend[colors,GrayLevel[1]]}];
			grid2[[All,1]] = temp;
			If[showkey,grid2 = ConvertGridToKeyed[G,grid2]];
			If[cayleyform =!=StandardForm && MemberQ[{FullForm,MatrixForm,InputForm,TraditionalForm,OutputForm},cayleyform],
				grid2 = MapAt[ChangeItemCayleyForm[#,cayleyform]&,grid2,pos2]];
			grid1 =Panel[Grid[grid1,Dividers->{{1,2->Thickness[4]},{1,2->Thickness[4]}},
				ItemSize->All,Spacings->Offset[1]],{" "," "}, {Left,Top}];
			If[showkey, grid1 = Column[{grid1,TextCayleyKey[els,GroupoidName[G],G,StandardForm]}]];
			grid2 =Panel[Grid[grid2,Dividers->{{1,2->Thickness[4]},{1,2->Thickness[4]}},
				ItemSize->All,Spacings->Offset[1]],{" "," "}, {Left,Top}];
			If[showkey, grid2 = Column[{grid2,TextCayleyKey[els,GroupoidName[G],G,StandardForm]}]];

			If[side=== leftid, grid1,
				If[side === rightid, grid2, Row[{grid1, grid2}]]],
			Message[Identity::fail,StructureName[G]]
		]
]

Options[GroupIdentity]={Mode -> Computational, Structure -> Group};

GroupIdentity[G_?GroupoidQ] :=  GroupIdentity[G] =
		Module[{ok, id},
	{ok,id} = IdentityWork[G];
	HasIdentityQ[G] = ok;
	AddGroupInfo[G, ok, StringJoin["the identity is ", 
			ToString[id]], "there is no identity"];
	If[ok, id, $Failed]
	]

GroupIdentity[G_?GroupoidQ, Mode -> Computational] := GroupIdentity[G]

GroupIdentity[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ] := 
	GroupIdentityTextual[G, HasIdentityQ[G], Group,OperatorSymbol[G],opts]

GroupIdentity[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ] := 
	GroupIdentityVisual[G, GroupIdentity[G],opts]

GroupIdentity[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> GroupIdentity[G],
	"Explanation" -> GroupIdentity[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> GroupIdentity[G, Mode->Visual, ConvertMode -> "All",opts]}, 
	ImageSize->Automatic],"Identity of "<>GroupoidName[G], Top]

GroupIdentity[many:{_?GroupoidQ..}, Mode -> mode_, opts___?OptionQ] := 
	Map[GroupIdentity[#, Mode -> mode, opts]&, many] //Column

GroupIdentityTextual[args___] := HasIdentityQTextual[args]

GroupIdentityVisual[args___] := HasIdentityQVisual[args]

GroupIdentity[many:{_?GroupoidQ..}] := Map[GroupIdentity, many]
			
Unprotect[Identity];

groupoid /: Identity[G_groupoid,opts___?OptionQ] := 
	GroupIdentity[G,opts];

Identity[many:{_?GroupoidQ..},opts___?OptionQ] := 
	GroupIdentity[many,opts];

Protect[Identity];


(* ::Subsection:: *)
(*23.3 inverses*)


LeftInverseWork[G_,g_] := Module[{pos,els=Elements[G],ok,
		op = Operation[G]},
	If[HasIdentityQ[G],
		pos = Flatten[Position[Map[op[#,g]&,els],GroupIdentity[G],1]];
		ok = If[pos === {}, False,True];
		{ok,If[ok,First[els[[pos]]],$Failed]},
		Message[Inverse::noId,StructureName[G]];{False,$Failed}]]

LeftInvertibleQ[G_?GroupoidQ,many_List] :=
	Map[LeftInvertibleQ[G,#]&, many]/; SubsetQAA[many,Elements[G]]

LeftInvertibleQ[G_?GroupoidQ,g_] := LeftInvertibleQ[G,g] = 
		If[ElementQ[g,G],
		Module[{ok,inv},
	{ok,inv} = LeftInverseWork[G,g];
	LeftInverse[G,g] = inv;
	ok],
	Message[MemberQ::elmnt, g, StructureName[G]]; False]

LeftInvertibleQ[G_?GroupoidQ,g_, Mode -> Computational] := LeftInvertibleQ[G,g]

LeftInvertibleQ[G_?GroupoidQ,g_, Mode -> mode_] := 
	(Message[Mode::notavail, LeftInvertibleQ, mode]; $Failed)

LeftInverse[G_?GroupoidQ,many_List] :=
	Map[LeftInverse[G,#]&, many] /; SubsetQAA[many,Elements[G]]

LeftInverse[G_?GroupoidQ,g_] := LeftInverse[G, g] =
		If[ElementQ[g,G],
		Module[{ok,inv},	
	{ok,inv} = LeftInverseWork[G,g];
	LeftInvertibleQ[G,g] = ok;
	If[Not[LeftInvertibleQ[G,g]],Message[Inverse::fail,g,
		StructureName[G]];
		$Failed, inv]],
	Message[MemberQ::elmnt, g, StructureName[G]]; $Failed]

LeftInverse[G_?GroupoidQ,g_, Mode -> Computational] := LeftInverse[G,g]

LeftInverse[G_?GroupoidQ,g_, Mode -> mode_] := 
	(Message[Mode::notavail, LeftInverse, mode]; $Failed)

RightInverseWork[G_,g_] := Module[{pos,els=Elements[G],ok,
		op = Operation[G]},
	If[HasIdentityQ[G],
		pos = Flatten[Position[Map[op[g,#]&,els],GroupIdentity[G],1]];
		ok = If[pos === {}, False,True];
		{ok,If[ok,First[els[[pos]]],$Failed]},
		Message[Inverse::noId,StructureName[G]];{False,$Failed}]]

RightInvertibleQ[G_?GroupoidQ, many_List] :=
	Map[RightInvertibleQ[G,#]&, many] /; SubsetQAA[many,Elements[G]]
	
RightInvertibleQ[G_?GroupoidQ,g_] := RightInvertibleQ[G,g] =
	If[ElementQ[g,G],
		Module[{ok,inv},
			{ok,inv} = RightInverseWork[G,g];
			RightInverse[G,g] = inv;
			ok],
	Message[MemberQ::elmnt, g, StructureName[G]]; False]

RightInvertibleQ[G_?GroupoidQ,g_, Mode -> Computational] := RightInvertibleQ[G,g]

RightInvertibleQ[G_?GroupoidQ,g_, Mode -> mode_] := 
	(Message[Mode::notavail, RightInvertibleQ, mode]; $Failed)

RightInverse[G_?GroupoidQ,many_List] :=
	Map[RightInverse[G,#]&, many]/; SubsetQAA[many,Elements[G]]
		
RightInverse[G_?GroupoidQ,g_] := RightInverse[G, g] =
	If[ElementQ[g,G], 
		Module[{ok,inv},
	{ok,inv} = RightInverseWork[G,g];
	RightInvertibleQ[G,g] = ok;
	If[!RightInvertibleQ[G,g],Message[Inverse::fail,g,
		StructureName[G]]; 
	$Failed, inv]],
	Message[MemberQ::elmnt, g, StructureName[G]]; $Failed]

RightInverse[G_?GroupoidQ,g_, Mode -> Computational] := RightInverse[G,g]

RightInverse[G_?GroupoidQ,g_, Mode -> mode_] := 
	(Message[Mode::notavail, RightInverse, mode]; $Failed)

InverseWork[G_,g_] :=  
	Module[{leftok,rightok,leftinv,rightinv},
	{leftok,leftinv} = LeftInverseWork[G,g];
	If[leftok,
		{rightok,rightinv} = RightInverseWork[G,g],
		{rightok, rightinv} = {False, NULL}];
	{leftok && rightok, If[leftinv===rightinv,rightinv,$Failed]}
	]

Options[InvertibleQ] = {Mode -> Computational, Structure -> Group};

InvertibleQ[G_?GroupoidQ,many_List] :=
	Map[InvertibleQ[G,#]&,many]/; SubsetQAA[many,Elements[G]]
	
InvertibleQ[G_?GroupoidQ, many_List, Mode -> mode_, opts___?OptionQ] := 
	Column[Map[InvertibleQ[G, #, Mode -> mode, opts]&, many]] /; SubsetQAA[many,Elements[G]]
	
InvertibleQ[G_?GroupoidQ,g_] :=  InvertibleQ[G, g] =
		If[ElementQ[g,G], Module[{ok, inv},
	{ok,inv} = InverseWork[G,g];
	GroupInverse[G,g] = inv;
	AddGroupInfo[G, ok, StringJoin["the inverse of ",ToString[g],
		" is ",ToString[inv]], 
		StringJoin["there is no inverse for ",ToString[g]]];
	ok],
	Message[MemberQ::elmnt, g, StructureName[G]]; False]

InvertibleQ[G_?GroupoidQ, g_, Mode -> Computational, opts___?OptionQ] := InvertibleQ[G, g]

InvertibleQ[G_?GroupoidQ, g_, Mode -> Textual, opts___?OptionQ] := 
	InvertibleQTextual[G, g, InvertibleQ[G,g], Group, OperatorSymbol[G],opts]

InvertibleQ[G_?GroupoidQ, g_, Mode -> Visual, opts___?OptionQ] := 
	If[InvertibleQ[G,g],
		DoVisualization[InvertibleQVisual[G, g, GroupInverse[G,g], InvertibleQ[G,g],opts],{{G, g},InvertibleQHelp},opts],
		$Failed]

InvertibleQHelp[G_,g_]:=  DoHelpMessage[windowtitle -> "Help for the invertibility of g in "<>GroupoidName[G], 
	help -> List["Note that row headed by the element ", 
		Cell[BoxData[FormBox[ RowBox[{"g", "=", ToBoxes[g,TraditionalForm]}], TraditionalForm]],
  FormatType->"TraditionalForm"],
		" with a gray background intersects the column headed by the element ",
		Cell[BoxData[FormBox[ RowBox[{"h", "=", ToBoxes[GroupInverse[G,g],TraditionalForm]}], TraditionalForm]],
  FormatType->"TraditionalForm"],
		" with a gray background, and that the element at the intersection is ",
		Cell[BoxData[
 ToBoxes[GroupIdentity[G],TraditionalForm]],
 FormatType->"TraditionalForm"],
		", which is the identity for "<>GroupoidName[G]<>
		". Thus, these two elements, ",
		Cell[BoxData[FormBox[ RowBox[{"g", "=", ToBoxes[g,TraditionalForm]}], TraditionalForm]],
  FormatType->"TraditionalForm"], " and ", 
Cell[BoxData[FormBox[ RowBox[{"h", "=", ToBoxes[GroupInverse[G,g],TraditionalForm]}], TraditionalForm]],
  FormatType->"TraditionalForm"], " are inverses."]
]

InvertibleQ[many:{_?GroupoidQ..}, Mode -> mode_, opts___?OptionQ] := 
	Map[InvertibleQ[#, Mode -> mode, opts]&, many] //Column

InvertibleQ[G_?GroupoidQ, g_, Mode -> Computational, opts___?OptionQ] := InvertibleQ[G, g]

InvertibleQ[G_?GroupoidQ, g_, Mode -> Interactive, InteractiveMode->mode_, opts___?OptionQ]:=
	Module[{min, max, els=Elements[G], pos,h},
	min = 1;
	max = Length[els];
	pos = Position[els,g,1]//Flatten//First;
	Manipulate[InvertibleQ[G, h, Mode -> mode, ShowConvert -> False, opts],{{h, g, "g \[Element] G"}, els},
		ControlType -> RadioButtonBar]
]

InvertibleQ[G_?GroupoidQ, g_, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		InvertibleQ[G, g, Mode->Interactive, InteractiveMode -> Computational],
	"Explanation" -> InvertibleQ[G,g,Mode->Interactive, InteractiveMode -> Textual, ShowConvert -> False, opts],
	"Visualization" -> InvertibleQ[G,g, Mode->Interactive, InteractiveMode -> Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with InvertibleQ[G, g]", Top]

InvertibleQ2[G_?GroupoidQ, g_, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		InvertibleQ2[G, g, Mode->Interactive, InteractiveMode -> Computational, opts],
	"Explanation" -> InvertibleQ2[G,g,Mode->Interactive, InteractiveMode -> Textual, ShowConvert -> False, opts],
	"Visualization" -> InvertibleQ2[G,g, Mode->Interactive, InteractiveMode -> Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with InvertibleQ[G, g]", Top]

InvertibleQ[G_?GroupoidQ, g_, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		InvertibleQ[G, g, Mode->Interactive, InteractiveMode -> Computational, opts],
	"Explanation" -> InvertibleQ[G,g,Mode->Interactive, InteractiveMode -> Textual, ShowConvert -> False, opts],
	"Visualization" -> InvertibleQ[G,g, Mode->Interactive, InteractiveMode -> Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with InvertibleQ[G, g]", Top]


InvertibleQ[G_?GroupoidQ, g_, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> InvertibleQ[G, g],
	"Explanation" -> InvertibleQ[G, g, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> InvertibleQ[G, g, Mode->Visual, ConvertMode -> "All",opts],
	"Interactive" -> InvertibleQ[G, g, Mode->Interactive, ShowConvert -> False]}, 
	ImageSize->Automatic],"Invertibility of "<>ToString[g]<>" in " <> GroupoidName[G], Top]
	
InvertibleQTextual[args___] := InverseTextual[args]

InvertibleQVisual[args___] := InverseVisual[args]

Options[GroupInverse] = {Mode -> Computational, Structure -> Group};

GroupInverse[G_?GroupoidQ,many_List] :=
	Map[GroupInverse[G,#]&, many]/; SubsetQAA[many,Elements[G]]
	
GroupInverse[G_?GroupoidQ, many_List, Mode -> mode_, opts___?OptionQ] := 
	Column[Map[GroupInverse[G, #, Mode -> mode, opts]&, many]] /; SubsetQAA[many,Elements[G]]

GroupInverse[G_?GroupoidQ,g_] := GroupInverse[G,g] = 
		If[ElementQ[g,G], Module[{ok, inv, temp},
	If[ElementQ[temp = inverseFunction[G][g],G],
		{ok,inv} = {True, temp},
		{ok,inv} = InverseWork[G,g]];
	InvertibleQ[G,g] = ok;
	AddGroupInfo[G, ok, StringJoin["the inverse of ",ToString[g],
		" is ",ToString[inv]], 
		StringJoin["there is no inverse for ",ToString[g]]];
	If[!InvertibleQ[G,g], Message[Inverse::fail,g,StructureName[G]];
		$Failed, inv]],
	Message[MemberQ::elmnt, g, StructureName[G]]; $Failed]

GroupInverse[G_?GroupoidQ, g_, Mode -> Computational, opts___?OptionQ] := GroupInverse[G, g]

GroupInverse[G_?GroupoidQ, g_, Mode -> Textual, opts___?OptionQ] := 
	GroupInverseTextual[G, g, InvertibleQ[G,g], Group, OperatorSymbol[G], opts]

GroupInverse[G_?GroupoidQ, g_, Mode -> Visual, opts___?OptionQ] := 
	If[InvertibleQ[G,g],
		DoVisualization[InvertibleQVisual[G, g, GroupInverse[G,g], InvertibleQ[G,g],opts],{{G, g},InvertibleQHelp},opts],
		$Failed]

GroupInverse[many:{_?GroupoidQ..}, Mode -> Visual, opts___?OptionQ] := 
	Map[GroupInverse[#, Mode -> Visual, opts]&, many] //Column

GroupInverse[many:{_?GroupoidQ..}, Mode -> Textual, opts___?OptionQ] := 
	Map[GroupInverse[#, Mode -> Textual, opts]&, many] //Column

GroupInverse[G_?GroupoidQ, g_, Mode -> Computational] := GroupInverse[G, g]

GroupInverse[G_?GroupoidQ, g_, Mode -> Interactive, InteractiveMode->mode_, opts___?OptionQ]:=
	Module[{min, max, els=Elements[G], pos,h},
	min = 1;
	max = Length[els];
	pos = Position[els,g,1]//Flatten//First;
	Manipulate[GroupInverse[G, h, Mode -> mode, opts],{{h, g, "g \[Element] G"}, els},
		ControlType -> RadioButtonBar]
]

GroupInverse[G_?GroupoidQ, g_, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		GroupInverse[G, g, Mode->Interactive, InteractiveMode -> Computational, opts],
	"Explanation" -> GroupInverse[G,g,Mode->Interactive, InteractiveMode -> Textual, ShowConvert -> False, opts],
	"Visualization" -> GroupInverse[G,g, Mode->Interactive, InteractiveMode -> Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with GroupInverse[G, g]", Top]

GroupInverse[G_?GroupoidQ, g_, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> GroupInverse[G, g],
	"Explanation" -> GroupInverse[G, g, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> GroupInverse[G, g, Mode->Visual, ConvertMode -> "All", opts],
	"Interactive" -> GroupInverse[G, g, Mode->Interactive, ShowConvert -> False]}, 
	ImageSize->Automatic],"Inverse of "<>ToString[g]<>" in " <>GroupoidName[G], Top]

GroupInverseTextual[args___] := InverseTextual[args]

GroupInverseVisual[args___] := InverseVisual[args]

InverseTextual[G_,g_,ok_,st_,symb_, opts___?OptionQ] := 
	Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	If[!multipleQ, text = InverseTextualGD[st,symb]<>InverseTextualLI[G,g,ok],
		If[firstPassQ, 
			firstPassQ = False;
			text = InverseTextualGD[st,symb] <> InverseTextualLI[G,g,ok],
			text = InverseTextualLI[G,g,ok]]];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]

InverseTextualGD[Group,"+"] := 
	"Given a Groupoid G, we say an element g in G has an inverse h if G has an identity, say e, and g + h = h + g = e (where + indicates the operation)."

InverseTextualGD[Group,"*"] := 
	"Given a Groupoid G, we say an element g in G has an inverse h if G has an identity, say e, and g * h = h * g = e (where * indicates the operation)."

InverseTextualGD[Group,_] := 
	"Given a Groupoid G, we say an element g in G has an inverse h if G has an identity, say e, and g * h = h * g = e (where * indicates the operation)."

InverseTextualGD[Ring,"+"] := 
	"Given a Ringoid R, we say an element r in R has an additive inverse s if R has an additive identity 0 and r + s = s + r = 0 (where + indicates the operation)."

InverseTextualGD[Ring,"*"] := 
	"Given a Ringoid R, we say an element r in R has an multiplicative inverse s if R has an multiplicative identity 1 and r * s = s * r = 1 (where * indicates the operation)."

InverseTextualGD[_,_] := 
	"Given a StructuredSet S (Groupoid or Ringoid), we say an element g in S has an inverse h if S has an identity e and g*h = h*g = e (where * indicates the operation)."

InverseTextualLI[G_,g_,ok_] := (
	" In this case, in "<>GroupoidName[G]<>", "<>ToString[g,TraditionalForm]<>
If[ok," has "<>ToString[GroupInverse[G,g],TraditionalForm]<>" as the inverse.",
	" does not have an inverse."])

Options[InverseVisual]={DisplayFunction -> $DisplayFunction};
		
InverseVisualV5[G_,g_,ginv_,ok_,opts___] := 
	Module[{els = Elements[G],len, rects,inter,
		table = makeTable[G,Elements[G]],
		coloredRects = {}, gColoredRects, gText, 
		gLines, row, column,pos,posinv,
		showopts = FilterRules[{opts},Options[Graphics]],
		df = DisplayFunction/.Flatten[{opts, Options[InverseVisual]}]},
	If[ok,{gLines,gText,  rects} = basicCayley[G,els, CayleyForm -> 
		CayleyForm[G]];
	len = Length[els];
	pos = Position[els,g]//Flatten//First;
	posinv = Position[els,ginv]//Flatten//First;
	row = Part[rects, pos];
	column = Part[Transpose[rects], posinv];
	inter = Intersection[row//Flatten,column//Flatten];
	gColoredRects = Show[Graphics[{{OtherColors[[7]],row},{OtherColors[[1]],column}, 
		{OtherColors[[8]],inter},
		{GrayLevel[0.7],Rectangle[{-1,len-pos},{0,len-pos+1}]},
		{GrayLevel[0.7],Rectangle[{posinv-1,len},{posinv,len+1}]}
		},DisplayFunction -> Identity]];
	If[WideElementsQ[G],
		PrintCayleyKey[els,StructureName[G],G, KeyForm[G]]];
	Show[{gColoredRects, gLines,gText},showopts,
		DisplayFunction -> df], ErrorSpace]
	]

InverseVisual[G_,g_,ginv_,ok_, opts___?OptionQ] := 
	Module[{els = Elements[G],len, rects, posinv, inter, good, grid, pos, ltext, table, showkey, cayleyform},
		If[ok,
			{table,grid} =WhiteCayleyGrid[G];
			showkey = showkeyQ[G, opts];
			cayleyform = CayleyForm/.Flatten[{opts, Options[SubgroupQ]}];
			len=Length[els];
			pos = Position[els,g,1]//Flatten//First;
			posinv = Position[els,ginv]//Flatten//First;
			good ={{pos+1, 1},{1,posinv+1}};
			grid = MapAt[ChangeItemBackground[#,GrayLevel[0.7]]&,grid,good];
			good = Table[{pos + 1,k},{k,2,len + 1}];
			grid = MapAt[ChangeItemBackground[#,Yellow]&,grid,good];
			good = Table[{k, posinv + 1},{k,2,len + 1}];
			grid = MapAt[ChangeItemBackground[#, Cyan]&,grid, good];
			grid = MapAt[ChangeItemBackground[#, Green]&, grid,{{pos + 1, posinv + 1}}];
			If[showkey,grid = ConvertGridToKeyed[G,grid]];
			If[cayleyform =!=StandardForm && MemberQ[{FullForm,MatrixForm,InputForm,TraditionalForm,OutputForm},cayleyform],
				pos = Flatten[Delete[Table[{i,j},{i,len+1},{j,len+1}],{1,1}],1];
				grid = MapAt[ChangeItemCayleyForm[#,cayleyform]&,grid,pos]];
			grid =Panel[Grid[grid,Dividers->{{1,2->Thickness[4]},{1,2->Thickness[4]}},
				ItemSize->All,Spacings->Offset[1]],{" "," "}, {Left,Top}];
			If[showkey,grid = Column[{grid,TextCayleyKey[els,GroupoidName[G],G,StandardForm]}]];
			grid
		]
]

Unprotect[Inverse];

groupoid /: Inverse[G_groupoid, args___] := GroupInverse[G,args]

Protect[Inverse];

inverseList[G_] := inverseList[G] = Module[{els = Elements[G], 
 id, idok, done = False, remaining,g,h,list={},
		op = Operation[G], ok = False, pos},
	id = GroupIdentity[G];
	remaining = els;
	idok = If[id === Null, False, True];
	If[!idok,Message[Inverse::noId,StructureName[G]]];
	While[Not[done] && idok,
		g = First[remaining];
		pos = Flatten[Position[Map[op[#,g]&,remaining],id,1],1];
		ok = If[pos == {}, False,True];
		h = Part[remaining,If[Length[pos]>0,First[pos],
			pos]];
		If[h ==={}, h = "no inverse"];
		AppendTo[list,{g,h,ok}];
		remaining = Complement[remaining,{g,h}];
		done = remaining =={};
	];
	list]

Options[HasInversesQ] = {Mode -> Computational, Structure -> Group};
	
HasInversesQ[G_?GroupoidQ] := HasInversesQ[G] =
		Module[{ok,invlist},
	invlist = inverseList[G];
	If[invlist === {}, ok = False; Inverses[G] = {},
		Inverses[G] = Transpose[Take[Transpose[invlist],2]];
		ok = Apply[And,Transpose[invlist][[3]]]];
	AddGroupInfo[G, ok, "every element has an inverse",
		"there are elements without inverses"];
	ok]
		
HasInversesQ[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> HasInversesQ[G],
	"Explanation" -> HasInversesQ[G, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization 1" -> HasInversesQ[G, Mode->Visual, ConvertMode -> "All", opts],
	"Visualization 2" -> HasInversesQ[G, Mode->Visual2, ConvertMode -> "All", opts]}, 
	ImageSize->Automatic],"Invertibility of all elements in "<>GroupoidName[G], Top]

HasInversesQ[G_?GroupoidQ, Mode -> Computational, opts___?OptionQ] := HasInversesQ[G]

HasInversesQ[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ] := 
	HasInversesQTextual[G, HasInversesQ[G], Group, OperatorSymbol[G], opts]

HasInversesQ[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ] := 
	If[HasIdentityQ[G],
		DoVisualization[HasInversesQVisual[G,opts],{{G},HasInversesQHelp},opts],
			$Failed]

HasInversesQ[G_?GroupoidQ, Mode -> Visual2, opts___?OptionQ] := 
		If[HasIdentityQ[G],
			DoVisualization[HasInversesQVisual2[G,inverseList[G],opts],{{G},HasInversesQ2Help},opts],
			$Failed]

HasInversesQTextual[args___] := InversesTextual[args]

HasInversesQVisual[args___] := InversesVisual[args]

HasInversesQHelp[G_]:=  DoHelpMessage[windowtitle -> "Inverses in "<>GroupoidName[G], 
	help -> List["Note that the elements of "<>GroupoidName[G]<> 
		" are distributed around the circle. If two distinct elements are inverses of each other, there is a line segment connecting them. If an element is its own inverse, there is a loop there."]
]

HasInversesQ2Help[G_]:=  DoHelpMessage[windowtitle -> "Inverses in "<>GroupoidName[G], 
	help -> List["Note that the elements of ",GroupoidName[G], 
		" are on both the horizontal axis (identified with the element ",
	Cell[BoxData[FormBox["g", TraditionalForm]], FormatType->"TraditionalForm"],
") and vertical axis (identified with the inverse of ",
Cell[BoxData[FormBox["g", TraditionalForm]], FormatType->"TraditionalForm"],
"). (If the element names are add to read, it may be fruitful to enlarge the graphic by stretching from one corner.) There is a blue dot at the lattice point ",
Cell[BoxData[
 FormBox[Cell[TextData[Cell[BoxData[
   FormBox[
    RowBox[{"(", 
     RowBox[{"g", ",", 
      SuperscriptBox["g", 
       RowBox[{"-", "1"}]]}], ")"}], TraditionalForm]],
   FormatType->"TraditionalForm"]]], TraditionalForm]],
 FormatType->"TraditionalForm"],
" if ",
Cell[BoxData[FormBox["g", TraditionalForm]], FormatType->"TraditionalForm"],
" has an inverse."]
]

HasInversesQVisual2[args___] := InversesVisual2[args]

InversesTextual[G_,ok_,st_,symb_, opts___?OptionQ] := Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	If[!multipleQ, text = Join[{InverseTextualGD[st,symb]},InversesTextualLI[G,ok,st]],
		If[firstPassQ, 
			firstPassQ = False;
			text = Join[{InverseTextualGD[st,symb]},InversesTextualLI[G,ok,st]],			
			text = InversesTextualLI[G,ok,st]]];
	If[showconvert,Column[{StringJoin[text],MakeComputationalButton[cm]},Center],StringJoin[text]]
]

InversesTextualLI[G_,ok_,st_] := Module[{invlist,txt={}},
	invlist = inverseList[G];
	invlist = If[invlist =!= {}, invlist//Transpose//Take[#,2]&//
		Transpose, invlist];
	If[invlist =!= {},
		AppendTo[txt," The "<>If[st===Group,"Groupoid ","Ringoid "]<>
		theGroupName[G]<>" "];
		If[!ok,
			AppendTo[txt,"contains some elements without inverses. For example, "<>
			ToString[Select[invlist,(#[[2]]==="no inverse")&][[1,1]]]<>
			" does NOT have an inverse."],
			AppendTo[txt,"has an inverse for every element. Here they are:\n"];
			AppendTo[txt,headingsGrid[invlist,{"x",Superscript["x",-1]}]//ToString[#,TraditionalForm]&]],
		txt = {"Since there is no identity, inverses are not possible."}]]
(*Table added 11/27/06
modified for string output 7/24/08 
(Prepend[invlist,{"x",Superscript["x",-1]}]//Grid[#,Frame->All]&//ToString[#,TraditionalForm]&)

*)

Options[InversesVisual]={};
		
InversesVisual[G_,opts___] := 
	Module[{els = Elements[G],len, inter, coords, lines, gr,
		gLines, invlist, pairs,positionInS, bad, loops, regular, wide,
		showopts = FilterRules[{opts},Options[Graphics]], ok, els2, showkey},
ok = HasIdentityQ[G];
If[ok,
	wide=WideElementsQ[G];
	(*If[wide,
		PrintCayleyKey[els,StructureName[G],G, KeyForm[G], "g"]];*)
	invlist = inverseList[G]//Transpose//Take[#,2]&//Transpose;
	showkey = showkeyQ[G, opts];
	If[!wide && showkey, wide = True];
	bad = Select[invlist,(#[[2]]==="no inverse")&];
	loops = Select[invlist,(#[[1]] === #[[2]])&];
	regular = Complement[invlist,bad];
	positionInS = Flatten[Map[Position[els,#,1]&,Flatten[regular,
		1],1],2]//Partition[#,2]&;
	len = Length[els];
	coords = Map[Part[ngonCoordsC[len],#]&,positionInS];
	lines = Map[Line[{#[[1]],#[[2]]}]&,coords]/.
		Line[{pr_,pr_}] :> Circle[pr*0.90,.075];
	els2 = If[wide, Map[ElementToKey[G, #]&, els], els];
	Off[Graphics::optx];
	gr = Show[{Graphics[{White,If[wide,Rectangle[{-1.6,-1},{1.6,1}],
		Point[{0,0}]]}], modCircle[len],
		LabelingNgon[els2, els2, 1.25, If[wide, SequenceForm, 
			OutStdForm]],
		Graphics[{AbsoluteThickness[1.6],OtherColors[[4]],lines}]},
		showopts,  BaseStyle -> defaultFont, 
		If[$VersionNumber > 2.5, FormatType -> StandardForm,
			Ticks -> Automatic (* dummy statement *)]]; On[Graphics::optx]; 
	If[showkey,Column[{gr,TextCayleyKey[els,GroupoidName[G],G,StandardForm]}, Center], gr],
	Message[Inverse::noId, StructureName[G]]
	]]
	
	(* Changed DefaultFont to BaseStyle - 11/3/06 *)
		
InversesVisual2[G_,invl_List,opts___] := Module[{
		invlist = invl,f,rules,temp,t2,gr, showkey, els=Elements[G], len, wide,
		showopts = FilterRules[{opts},Options[Graphics]]},
	invlist=invlist/.{{a_,_,False} -> {{a,Null},{Null,a}},
		{a_,b_,True} -> {{a,b},{b,a}}}//Flatten[#,1]&//
		Union;
	f[g_,{n_}] := g -> n;
	rules = MapIndexed[f, els];
	len = Length[els];
	wide = WideElementsQ[G];
	showkey = showkeyQ[G, opts];
	If[!wide && showkey, wide = True];
	invlist = invlist /. rules /. Null -> 0;
	(* If[WideElementsQ[G],Print[ToString[Join[{"KEY:: group element"->
		"labeled as:"},rules/.Rule[x_,y_]:> Rule[InputForm[x],y]]]]];*)
	gr = ListPlot[invlist,AxesOrigin -> {0,0},
		AspectRatio -> Automatic,
		PlotRange -> {{0,(temp = len)+1},
		{0,temp+1}},PlotStyle -> {RGBColor[0,0,1],
		PointSize[0.02]}, Ticks -> If[wide,
		{t2=Table[{i,"g"<>ToString[i]},{i,0,temp}],t2},{t2 = Join[{{0," "}},
		Table[{i,ToString[els[[i]],TraditionalForm]},{i,1,temp}]],t2}],
		 AxesLabel -> {"g","\!\(\*SuperscriptBox[\"g\", 
RowBox[{\"-\", \"1\"}]]\)"}, PlotRange->{{0,len+1},{0,len+1}}, showopts];
	If[showkey,Column[{gr,TextCayleyKey[els,GroupoidName[G],G,StandardForm]}, Center], gr]
](* the idea for this came from Dennis Kletzing 
some minor tweaks 9/1/08, including removing X on axis and adding PlotRange->All
*)

HasInversesQ[many:{_?GroupoidQ..}] :=
	Map[HasInversesQ, many]
		
HasInversesQ[many:{_?GroupoidQ..}, Mode -> mode_, opts___?OptionQ] :=
	Map[HasInversesQ[#, Mode->mode, opts]&, many]//Column
				
Options[Inverses] = {Mode -> Computational, Structure -> Group};
		
Inverses[G_?GroupoidQ] := Inverses[G] =
		Module[{ok, invlist, out},
	invlist = inverseList[G];
	If[invlist === {}, ok = False; out = {},
		out = Transpose[Take[Transpose[invlist],2]];
		ok = Apply[And,Transpose[invlist][[3]]]];
	HasInversesQ[G] = ok;
	AddGroupInfo[G, ok, "every element has an inverse",
		"there are elements without inverses"];
	out]
	
Inverses[G_?GroupoidQ, Mode -> Computational, opts___?OptionQ]:= Inverses[G]
	
Inverses[G_?GroupoidQ, Mode->Textual, opts___?OptionQ]:= HasInversesQ[G,Mode->Textual, opts]

Inverses[G_?GroupoidQ, Mode->Visual, opts___?OptionQ]:= HasInversesQ[G,Mode->Visual,opts]

Inverses[G_?GroupoidQ, Mode->Visual2, opts___?OptionQ]:= HasInversesQ[G,Mode->Visual2, opts]

Inverses[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> Inverses[G],
	"Explanation" -> Inverses[G, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization 1" -> Inverses[G, Mode->Visual, ConvertMode -> "All", opts],
	"Visualization 2" -> Inverses[G, Mode->Visual2, ConvertMode -> "All", opts]}, 
	ImageSize->Automatic],"Inverses of all elements in "<>GroupoidName[G], Top]



Inverses[many:{_?GroupoidQ..}] :=	Map[Inverses, many]
		
Inverses[many:{_?GroupoidQ..}, Mode -> mode_,opts___?OptionQ] :=
	Column[Map[Inverses[#, Mode->mode, opts]&, many]]


(* ::Subsection:: *)
(*23.4 associative*)


Options[AssociativeQ] = {Mode -> Computational, Structure -> Group,
Output -> Computational};

AssociativeQ[G_?GroupoidQ] := AssociativeQ[G] = 
	Module[{els = Elements[G], op = Operation[G], ok = True, i,j,k, 
		len = Length[G[[1]]], mymode,bad},
	(*Off[Part::partd];*)
	Do[bad = {i,j,k};
		ok = op[els[[i]],op[els[[j]],els[[k]]]] === 
		op[op[els[[i]],els[[j]]],els[[k]]];
		If[!ok,Break[]], {i,1,len},{j,1,len},{k,1,len}];
	(*On[Part::partd];*)
		AddGroupInfo[G, ok, "the operation is associative with these
	elements","the operation is not associative with these elements"];
	ok]
		
AssociativeQ[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ] := Module[{ok = True, len = Length[G[[1]]], 
		els = Elements[G], op = Operation[G], bad={1,1,1}},
	ok = AssociativeQ[G];
	If[Not[ok],
		Do[bad = {i,j,k};
		ok = op[els[[i]],op[els[[j]],els[[k]]]] === 
		op[op[els[[i]],els[[j]]],els[[k]]];
		If[!ok,Break[]], {i,1,len},{j,1,len},{k,1,len}]];
	AssociativeQTextual[G, bad, ok, opts]]

AssociativeQ[G_?GroupoidQ, Mode -> Computational] := AssociativeQ[G]

AssociativeQ[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ] := 
	AssociativeQVisual[G, Computational, opts]

AssociativeQ[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> AssociativeQ[G],
	"Explanation" -> AssociativeQ[G, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> AssociativeQ[G, Mode->Visual, ConvertMode -> "All", opts]}, 
	ImageSize->Automatic],"Associativity of "<>GroupoidName[G], Top]

AssociativeQTextual[G_,bad_,ok_, opts___?OptionQ] :=  Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	If[!multipleQ, text = AssociativeQTextualGD[G]<> 
		AssociativeQTextualLI[G,bad,ok],
		If[firstPassQ, 
			firstPassQ = False;
			text = AssociativeQTextualGD[G]<> AssociativeQTextualLI[G,bad,ok],
			text = AssociativeQTextualLI[G,bad,ok]]];
		If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]

AssociativeQTextualGD[_] := 
"Given a structured set S (Groupoid or Ringoid), we say the operation * is associative if for every g, h, and k in S we have (g*h)*k = g*(h*k), where * is the group operation."

AssociativeQTextualLI[G_,bad_,ok_] := 
		Module[{d,e,f,n=Length[Elements[G]],SG = Elements[G],
			op = Operation[G],ops = OperatorSymbol[G],a,b,c, first, second},
	{a,b,c} = Map[Part[SG,#]&,bad];
	first = "\nIn this case, "<>theGroupName[G]<>
		If[ok," is associative.",
			" is NOT associative since we have ("<>
			ToString[a]<>ops<>ToString[b]<>")"<>ops<>
			ToString[c]<>" = "<>ToString[op[op[a,b],c]]<>
			", which is not equal to "<>
			ToString[op[a,op[b,c]]]<>" = "<>
			ToString[a]<>ops<>"("<>ToString[b]<>ops<>
			ToString[c]<>")!"];
	second = StringJoin[" Consider the following table illustrating "<>
	If[ok,"random triples that associate. ",
		"triples that do not associate. "]<>
	"Pay attention to the last two columns.\n"];
	StringJoin[first, second, headingsGrid[If[ok, randomTriples[G, 10],NonAssociatingWork[G]],
		{"i","j","k","(i*j)*k","i*(j*k)"}]//ToString[#,TraditionalForm]&]
]

randomTriples[G_?GroupoidQ, k_] := 
	Module[{d, e, f, op = Operation[G]},
	Table[{d = RandomElement[G],e = RandomElement[G],
		f = RandomElement[G], op[op[d,e],f],
		op[d,op[e,f]]},{k}]]

NonAssociatingWork[G_?GroupoidQ] := 
	Module[{d, e, f, op = Operation[G],
	els = Elements[G], n},
	n = Length[els];
	Select[Flatten[Table[{d = els[[i]],e=els[[j]],
		f=els[[k]],op[op[d,e],f],
		op[d,op[e,f]]},{i,n},{j,n},{k,n}],2], #[[4]]=!=#[[5]]&]]
		
NonAssociatingTriples[G_?GroupoidQ] := 
	Map[Take[#,3]&, NonAssociatingWork[G]]
		
AssociativeQVisual[G_?GroupoidQ, output_, opts___?OptionQ]:=
	Module[{diskcolor = OtherColors[[10]], gr,
		black = RGBColor[0.0, 0.0, 0.0], pr,
	  g1=RandomElement[G], g2=RandomElement[G],
	  g3=RandomElement[G], opsymb=OperatorSymbol[G],
	  ptlist1,ptlist2,ptlist3, a,b,c,g4,g5,g6,g7, d, e,f,g,
	  labellist1,labellist21,labellist22,labellist31,
	  labellist32,seglist1,seglist2,resultstrings,
	  pic1,pic21,pic22,pic31,pic32,toplabel1,toplabel2},
	a = g1; b = g2; c = g3;
	If[WideElementsQ[G], a = "g1"; b = "g2"; c= "g3"];
	toplabel1="a"<>opsymb<>"(b"<>opsymb<>"c)";
	toplabel2="(a"<>opsymb<>"b)"<>opsymb<>"c";
	ptlist1={{1,0},{3,0},{2,1},{2.5,-1},{3.5,-1},{-1,0},
		{-3,0},{-2,1},{-2.5,-1},{-3.5,-1}};
	labellist1={ToString[a,TraditionalForm],opsymb,opsymb,ToString[b,TraditionalForm],
		ToString[c,TraditionalForm],ToString[c,TraditionalForm],opsymb,opsymb,ToString[b,TraditionalForm],
		ToString[a,TraditionalForm]};
  seglist1={{1,3},{2,3},{4,2},
            {5,2},{6,8},{7,8},{9,7},{10,7}};
 	pic1={Text[toplabel1,{3,2}],Text[toplabel2,{-3,2}],
 		Map[Line[Map[ptlist1[[#]]&,#]]&,seglist1],
 		diskcolor,Map[Disk[#,0.4]&,ptlist1],
		black,Map[Text[labellist1[[#]],
			ptlist1[[#]]]&,Range[1,10]],
    Text["Elements a, b, and c\nchosen at random.",{0,-2.5}]};
  If[WideElementsQ[G],AppendTo[pic1, Text["g1 = "<>
  	ToString[TraditionalForm[g1]]<>";\ng2 = "<>ToString[TraditionalForm[g2]]<>
  	";\ng3 = "<>ToString[TraditionalForm[g3]],{0, -2.5}]]];
	ptlist2={{1,0},{3,0},{2,1},{-1,0},{-3,0},{-2,1}};
	labellist21={ToString[a, TraditionalForm],ToString[ToString[b,TraditionalForm]<>opsymb<>
		ToString[c,TraditionalForm]],opsymb,ToString[c,TraditionalForm],ToString[ToString[a,TraditionalForm]<>
		opsymb<>ToString[b,TraditionalForm]],opsymb};
	d = g4 = Operation[G][g1,g2]; e = g5 = Operation[G][g2,g3];
	If[WideElementsQ[G], d = "g4"; e = "g5"];
	labellist22={ToString[a,TraditionalForm],ToString[e,TraditionalForm],
		opsymb,ToString[c,TraditionalForm],ToString[d,TraditionalForm],opsymb};
	seglist2={{1,3},{2,3},{4,6},{5,6}};
	pic21={Text[toplabel1,{2,2}],Text[toplabel2,{-2,2}],
 		Map[Line[Map[ptlist2[[#]]&,#]]&,seglist2],
		diskcolor,Map[Disk[#,0.4]&,ptlist2],
		black,Map[Text[labellist21[[#]],
		ptlist2[[#]]]&,Range[1,6]]};
	If[WideElementsQ[G],AppendTo[pic21, Text["g1 = "<>
  	ToString[TraditionalForm[g1]]<>";\ng2 = "<>ToString[TraditionalForm[g2]]<>
  	";\ng3 = "<>ToString[TraditionalForm[g3]],{0, -2.5}]]];
 	pic22={Text[toplabel1,{2,2}],Text[toplabel2,{-2,2}],
  	Map[Line[Map[ptlist2[[#]]&,#]]&,seglist2],
		diskcolor, Map[Disk[#,0.4]&,ptlist2],black,
		Map[Text[labellist22[[#]],ptlist2[[#]]]&,Range[1,6]]};
	If[WideElementsQ[G],AppendTo[pic22, Text["g1 = "<>
  	ToString[TraditionalForm[g1]]<>";\ng3 = "<>ToString[TraditionalForm[g3]]<>
  	";\ng4 = g1*g2 = "<>ToString[TraditionalForm[g4]]<>
  	";\ng5 = g2*g3 = "<>ToString[TraditionalForm[g5]],{0, -1.5}]]];
	(* If[WideElementsQ[G],AppendTo[pic22, Text["g1 = "<>
  	ToString[InputForm[g1]]<>";\ng2 = "<>ToString[InputForm[g2]]<>
  	";\ng3 = "<>ToString[InputForm[g3]],{0, -2.5}]]];*)
	If[WideElementsQ[G], d = "g4"; e = "g5"];
	labellist31={ToString[a,TraditionalForm]<>opsymb<>ToString[e,TraditionalForm],
    ToString[d,TraditionalForm]<>opsymb<>ToString[c,TraditionalForm]};
  ptlist3={{2,1},{-2,1}};
	f = g6 = Operation[G][g4,g3]; g = g7 = Operation[G][g1,g5];
	If[WideElementsQ[G], f = "g6"; g = "g7"];
	labellist32={ToString[g,TraditionalForm],
    ToString[f,TraditionalForm]};
	resultstrings=If[Operation[G][g1,Operation[G][g2,g3]]===
    Operation[G][Operation[G][g1,g2],g3],
    {"The two results are equal.",
    " Associativity is possible."},
    {"The two results are different.",
    "Associativity is violated."}];
	pic31={Text[toplabel1,{2,2}],Text[toplabel2,{-2,2}],
		diskcolor,Map[Disk[#,0.4]&,ptlist3],black,
		Map[Text[labellist31[[#]],ptlist3[[#]]]&,Range[1,2]]};
	If[WideElementsQ[G],AppendTo[pic31, Text["g1 = "<>
  	ToString[TraditionalForm[g1]]<>";\ng3 = "<>ToString[TraditionalForm[g3]]<>
  	";\ng4 = g1*g2 = "<>ToString[TraditionalForm[g4]]<>
  	";\ng5 = g2*g3 = "<>ToString[TraditionalForm[g5]],{0, -1.5}]]];
	pic32={Text[toplabel1,{2,2}],Text[toplabel2,{-2,2}],
		diskcolor,Map[Disk[#,0.4]&,ptlist3],black,
  	Map[Text[labellist32[[#]],ptlist3[[#]]]&,Range[1,2]],Text[First[resultstrings],{0,.3}],
    Text[Last[resultstrings],{0,-.2}]};
  If[WideElementsQ[G],AppendTo[pic32, Text["g6 = "<>
  	ToString[TraditionalForm[g6]]<>";\ng7 = "<>
  	ToString[TraditionalForm[g7]],{0, -1.2}]]];
gr[1] = pic1//Graphics;
gr[2] = pic21//Graphics;
gr[3] = pic22//Graphics;
gr[4] = pic31//Graphics;
gr[5] = pic32//Graphics; (*Column[{Graphics[pic32],Apply[StringJoin,resultstrings]}];*)
pr = If[WideElementsQ[G], {{-5.5,5.5},{-4.5,2.5}}, {{-5.5,5.5},{-3.5,2.5}}];
If[output === Print, pr = Automatic];
pr = Automatic;
DoVisualization[GraphicsGrid[{{gr[1]//Show[#,PlotRange-> pr, AspectRatio -> Automatic]&},
	{gr[2]//Show[#,PlotRange-> pr, AspectRatio -> Automatic]&}, 
	{gr[3]//Show[#,PlotRange-> pr, AspectRatio -> Automatic]&},
	{gr[4]//Show[#,PlotRange-> pr, AspectRatio -> Automatic]&},
	{gr[5]}}],{{G},AssociativeQHelp},opts]
]

AssociativeQHelp[G_]:= DoHelpMessage[windowtitle -> "Help for the associativity of G", 
	help -> {"This illustrations picks a random triple of elements from ",
	Cell[BoxData[
 FormBox["G", TraditionalForm]],
 FormatType->"TraditionalForm"]" and then traces through the notion of associativity in slow motion, one step at a time. It may be useful to grab a corner of the graphic and enlarge it."}]
	
Options[RandomAssociativeQ] = {Mode -> Computational, 
	Structure -> Group};

RandomAssociativeQ[G_?GroupoidQ, n_Integer:25] := 
	Module[{els = Elements[G], op = Operation[G],
		ok, i,j,k, len = Length[G[[1]]],
		mymode,bad={1,1,1},pr1,pr2,nn},

	nn = If[IntegerQ[n] && Positive[n], n, 25];
	(*Off[Part::partd];*)
	(*If[untestedQ[randomassociativityQ[G]],*)
		Do[{i,j,k} = Table[Random[Integer,{1,len}],{3}];
			bad = {i,j,k};
			pr1 = op[els[[i]],op[els[[j]],els[[k]]]];
			pr2 = op[op[els[[i]],els[[j]]],els[[k]]];
			ok = pr1 === pr2;
			If[!ok,Break[]], {nn}];
	(*On[Part::partd];*)
		randomassociativityQ[G] = ok;
		AddGroupInfo[G, ok, "the operation is probably associative with these elements",
		"the operation is not associative with these elements"];
	ok]

RandomAssociativeQ[G_?GroupoidQ, n_Integer:25, Mode -> mode_] :=
	If[mode===Textual,
		RandomAssociativeQTextual[G,n],
		If[mode===Visual,
			RandomAssociativeQVisual[G]
		]
	]

RandomAssociativeQTextual[G_,n_] := Module[{prods={},op = 
	Operation[G],i,j,k,	els = Elements[G], len, pr1, pr2,ok,bad},
	len = Length[els];
	Do[{i,j,k} = Table[Random[Integer,{1,len}],{3}];
			bad = {i,j,k};
			pr1 = op[els[[i]],op[els[[j]],els[[k]]]];
			pr2 = op[op[els[[i]],els[[j]]],els[[k]]];
			ok = pr1 === pr2;
			AppendTo[prods, {i,j,k,pr1,pr2}];
			If[!ok,Break[]], {n}];
	Column[{AssociativeQTextualGD[G],RandomAssociativeQTextualLI[G,bad,ok,prods]}]]

RandomAssociativeQTextualLI[G_,bad_,ok_,prods_] := 
		Module[{d,e,f,n=Length[Elements[G]],op = Operation[G],
		ops = OperatorSymbol[G],a,b,c,SG=Elements[G]},
	{a,b,c} = Map[Part[SG,#]&,bad];
	StringJoin["Since this involves ",
	ToString[n^3,TraditionalForm],
	" comparisons, this function approaches associativity randomly. In this case, ",
	GroupoidName[G],
		If[ok," appears to be associative.",
			" is NOT associative since we have ("<>
			ToString[a,TraditionalForm]<>ops<>ToString[b,TraditionalForm]<>")"<>ops<>
			ToString[c,TraditionalForm]<>" = "<>ToString[op[op[a,b],c],TraditionalForm]<>
			", which is not equal to "<>
			ToString[op[a,op[b,c]],TraditionalForm]<>" = "<>
			ToString[a,TraditionalForm]<>ops<>"("<>ToString[b,TraditionalForm]<>ops<>
			ToString[c,TraditionalForm]<>")!"],
	" Consider the following table. The first column is i, the second j, the third is k, the fourth is (i*j)*k and the fifth is i*(j*k). Pay attention to the last two columns.\n",
	ToString[headingsGrid[Take[prods, 15], {"i","j","k","(i*j)*k" ,"i*(j*k)"}],TraditionalForm]]
]

RandomAssociativeQVisual[args___] := AssociativeQVisual[args]

AssociativeQ[many:{_?GroupoidQ..}] := Map[ClosedQ, many]
		
AssociativeQ[many:{_?GroupoidQ..}, Mode -> mode, opts___?OptionQ] :=
	Column[Map[AssociativeQ[#, Mode -> mode, opts]&, many]]


(* ::Subsection:: *)
(*23.5 group - all Operations*)


Options[GroupQ]={Mode -> Computational};

AddGroupInfo[G_, ok_, mess1_, mess2_, other___] := 
	(If[untestedQ[GroupInfo[G]], GroupInfo[G] = {}];
	If[ok,
		If[!MemberQ[GroupInfo[G],mess1],
			AppendTo[GroupInfo[G],mess1]],
		If[!MemberQ[GroupInfo[G],mess2],
			AppendTo[GroupInfo[G],mess2]]];)

GroupQ[G_?GroupoidQ] := GroupQ[G] = Module[{ok},
	ok = ClosedQ[G];
	If[ok, ok = HasIdentityQ[G]];
	If[ok, ok = HasInversesQ[G]];
	If[ok, ok = AssociativeQ[G]];
	If[untestedQ[GroupInfo[G]], GroupInfo[G] = {}];
	AddGroupInfo[G, ok, "this is a group", "this is NOT a group"];
	ok]

GroupQ[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ] := 
	GroupQTextual[G, opts]

GroupQ[G_?GroupoidQ, Mode -> Computational, opts___?OptionQ] := 
	GroupQ[G]

GroupQ[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ] := GroupQVisual[G, opts]

GroupQ[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> GroupQ[G],
	"Explanation" -> GroupQ[G, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> GroupQ[G, Mode->Visual, ConvertMode -> "All",opts]}, 
	ImageSize->Automatic],"Is "<>GroupoidName[G]<>" a group?", Top]

GroupQ[many:{_?GroupoidQ..}] :=
	Map[GroupQ, many]
			
GroupQ[many:{_?GroupoidQ..}, Mode -> mode_, opts___?OptionQ] :=
	Column[Map[GroupQ[#, Mode -> mode, opts]&, many]]
		
GroupQTextual[G_, opts___?OptionQ] := 
	Column[{"Given a set S and an operation *, we call the pair (S,*)
a group if S is closed under the operation *, there is an identity
element, every elemement has an inverse and the operation * is
associative.\n",
	HasIdentityQ[G, Mode -> Textual,opts], "\n",
	ClosedQ[G, Mode -> Textual,opts], "\n",
	HasInversesQ[G, Mode -> Textual,opts], "\n",
	AssociativeQ[G, Mode -> Textual,opts]}]
	
GroupQVisual[G_, opts___?OptionQ] := Column[{
	HasIdentityQ[G,Mode -> Visual,opts],
	ClosedQ[G,Mode -> Visual,opts],
	HasInversesQ[G,Mode -> Visual,opts],
	AssociativeQ[G,Mode -> Visual,opts]},Alignment-> {Center, Baseline}]

Options[ProbableGroupQ]={Mode -> Computational};

ProbableGroupQ[G_?GroupoidQ] := ProbableGroupQ[G] = Module[{ok},
	ok = ClosedQ[G];
	If[ok, ok = HasIdentityQ[G]];
	If[ok, ok = HasInversesQ[G]];
	If[ok, ok = RandomAssociativeQ[G]];
	AddGroupInfo[G, ok, "this is (probably) a group", 
	"this is NOT a group"];
	ok]
	
ProbableGroupQ[G_?GroupoidQ, Mode -> mode_] := 
	If[mode===Textual,
		ProbableGroupQTextual[G],
		If[mode===Visual,
			ProbableGroupQVisual[G]
		]
	]
	
ProbableGroupQTextual[G_, opts___?OptionQ] := 
	(ClosedQ[G, Mode -> Textual,opts];
	HasIdentityQ[G, Mode -> Textual,opts];
	HasInversesQ[G, Mode -> Textual,opts];
	AssociativeQ[G, Mode -> Textual,opts])
	
ProbableGroupQVisual[G_, opts___?OptionQ] := (
	ClosedQ[G,Mode -> Visual,opts];
	HasIdentityQ[G,Mode -> Visual,opts];
	Inverses[G,Mode -> Visual,opts];
	RandomAssociativeQ[G,Mode -> Visual,opts])


(* ::Subsection:: *)
(*23.6 similar structures*)


SemiGroupQ[G_?GroupoidQ]:= ClosedQ[G] && AssociativeQ[G]

SemiGroupQ[G_?GroupoidQ, Mode -> mode_] :=
	If[mode===Textual,
		SemiGroupQTextual[G],
		If[mode===Visual,
			SemiGroupQVisual[G]
		]
	]
					
SemiGroupQ[many:{_?GroupoidQ..}] :=
	Map[SemiGroupQ, many]

SemiGroupQ[many:{_?GroupoidQ..}, Mode -> mode_] :=
	Column@Map[SemiGroupQ[#, Mode->mode]&, many]
		
SemiGroupQTextual[G_] := 
	Column[{"Given a set S and an operation *, we call the pair (S,*)
a semigroup if S is closed under the operation * and the operation
* is associative.",
	ClosedQ[G, Mode -> Textual],
	AssociativeQ[G, Mode -> Textual]}]
	
SemiGroupQVisual[G_] := Column[{
	ClosedQ[G,Mode -> Visual],
	AssociativeQ[G,Mode -> Visual]}]

MonoidQ[G_?GroupoidQ] := MonoidQ[G] = Module[{ok},
	ok = ClosedQ[G];
	If[ok, ok = HasIdentityQ[G]];
	If[ok, ok = AssociativeQ[G]];
	If[untestedQ[GroupInfo[G]], GroupInfo[G] = {}];
	AddGroupInfo[G, ok, "this is a monoid", "this is NOT a monoid"];
	ok]
	
MonoidQ[G_?GroupoidQ, Mode -> mode_] :=
	If[mode===Textual,
		MonoidQTextual[G],
		If[mode===Visual,
			MonoidQVisual[G]
		]
	]
		
MonoidQ[many:{_?GroupoidQ..}] :=
	Map[MonoidQ, many]
			
MonoidQ[many:{_?GroupoidQ..}, Mode -> mode_] :=
	Column@Map[MonoidQ[#, Mode->mode]&, many]
	
MonoidQTextual[G_, opts___?OptionQ] := 
	Column[{"Given a set S and an operation *, we call the pair (S,*)
a group if S is closed under the operation *, there is an identity
element, and the operation * is associative.",
	ClosedQ[G, Mode -> Textual, opts],
	HasIdentityQ[G, Mode -> Textual, opts],
	AssociativeQ[G, Mode -> Textual, opts]}]
	
MonoidQVisual[G_, opts___?OptionQ] := Column[{
	ClosedQ[G,Mode -> Visual, opts],
	HasIdentityQ[G,Mode -> Visual, opts],
	AssociativeQ[G,Mode -> Visual, opts]}]


(* ::Section:: *)
(* 30. Subgroup stuff*)


(* ::Subsection:: *)
(* 30.1 Subgroupoid*)


Options[Subgroupoid]={Mode -> Computational};

Subgroupoid[G_?GroupoidQ, H_List] := 
	If[SubsetQAA[H, Elements[G]],
		If[ProperSubsetQAA[H,Elements[G]],
		Module[{mymode,sub,Hoid,sc},
	sub = SubgroupQ[H,G];(* Not sure why this line was commented out but it is need for
		for visual2 so uncommented 11/4/06 *)
	Hoid = FormGroupoid[H, Operation[G],OperatorSymbol[G],
		GatherSubGroupoidOptions[G]]], G],
	Message[MemberQ::elmnts, H, StructureName[G]]; $Failed] 
	
Subgroupoid[G_?GroupoidQ, H_List, Mode -> Computational, opts___?OptionQ] := Subgroupoid[G, H]

Subgroupoid[G_?GroupoidQ, H_List, Mode -> Textual, opts___?OptionQ] := 
	SubgroupQ[H, G, Mode -> Textual, opts]

Subgroupoid[G_?GroupoidQ, H_List, Mode -> Visual, opts___?OptionQ] := 
	SubgroupQ[H, G, Mode -> Visual, opts]

Subgroupoid[G_?GroupoidQ, H_List, Mode -> Visual2, opts___?OptionQ] := 
	SubgroupQ[H, G, Mode -> Visual2, opts]

Subgroupoid[G_?GroupoidQ, many:{_List..}] :=
	Map[Subgroupoid[G,#]&,many] /; Apply[And,Map[SubsetQAA[#,Elements[G]]&,many]]
	
Subgroupoid[G_?GroupoidQ, many:{_List..}, Mode -> mode_] :=
	Column[Map[Subgroupoid[G,#, Mode->mode]&,many]] /; Apply[And,Map[SubsetQAA[#,Elements[G]]&,many]]


(* ::Subsection:: *)
(* 30.2 SubgroupQ*)


Options[SubgroupQ]={Mode -> Computational, CayleyForm->StandardForm};
	
SubgroupVisualTextCount = 0;

SubgroupQ[many:{_List..}, G_?GroupoidQ] := Map[SubgroupQ[#,G]&, 
	many]/; Apply[And,Map[SubsetQAA[#, Elements[G]]&,many]]

SubgroupQ[many:{_List..}, G_?GroupoidQ, Mode ->  mode_] := 
	Column[Map[SubgroupQ[#, G, Mode-> mode]&, many]] /; Apply[And,Map[SubsetQAA[#,Elements[G]]&,many]]

SubgroupQ[many:{_?GroupoidQ..}, G_?GroupoidQ] := 
	Map[SubgroupQ[#,G]&, many]

SubgroupQ[many:{_?GroupoidQ..}, G_?GroupoidQ, Mode ->  mode_] := 
	Column[Map[SubgroupQ[#, G, Mode-> mode]&, many]] /; Apply[And,Map[SubsetQAA[#,Elements[G]]&,Map[Elements,many]]]


SubgroupQ[many:{_?GroupoidQ..}, G_?GroupoidQ, Mode -> mode_] := 
		Map[SubgroupQ[#,G, Mode-> mode]&, many]//Column

SubgroupQ[many:{_List..}] :=
	Map[SubgroupQ[Apply[Sequence,#]]&,many]

SubgroupQ[many:{_List..},Mode->mode_, opts___?OptionQ] :=
	Column[Map[SubgroupQ[Apply[Sequence,#],Mode-> mode, opts]&,many],Center]
		
SubgroupQ[H_List, G_?GroupoidQ, Mode -> Computational, opts___?OptionQ]:=SubgroupQ[H, G]

SubgroupQ[H_List, G_?GroupoidQ] := SubgroupQ[H,G] =
	If[GroupQ[G],SubgroupQWork[G,H],
		Message[Group::fail,StructureName[G]];$Failed]
				
SubgroupQ[H_?GroupoidQ, G_?GroupoidQ] := SubgroupQ[H,G] =
	If[Operation[G] === Operation[H],
		If[GroupQ[G],SubgroupQWork[G,Elements[H]],
			Message[Group::fail,StructureName[G]]; False],
		Message[Operation::fail]; False]

SubgroupQ[H_List, G_?GroupoidQ, Mode -> Textual, opts___?OptionQ] := Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	If[GroupQ[G],text = SubgroupQTextual[G,H],
		Message[Group::fail,StructureName[G]];text = "Parent set is not a group"];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]

SubgroupQ[H_?GroupoidQ, G_?GroupoidQ, Mode -> Textual, opts___?OptionQ] := 
	If[Operation[G] === Operation[H],
		SubgroupQ[Elements[H], G, Mode->Textual, opts],
		Message[Operation::fail]; $Failed]

SubgroupQ[H_?GroupoidQ, G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> SubgroupQ[H, G],
	"Explanation" -> SubgroupQ[H, G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization 1" -> SubgroupQ[H, G, Mode->Visual, ConvertMode -> "All",opts],
	"Visualization 2" -> SubgroupQ[H, G, Mode->Visual2, ConvertMode -> "All",opts]}, 
	ImageSize->Automatic],"Is "<>ToString[Elements[H], TraditionalForm]<>" a subgroup of "<>GroupoidName[G]<>"?", Top]

SubgroupQ[H_?GroupoidQ, G_?GroupoidQ, Mode -> Most, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> SubgroupQ[H, G],
	"Explanation" -> SubgroupQ[H, G, Mode->Textual, ConvertMode -> "Most", opts],
	"Visualization" -> SubgroupQ[H, G, Mode->Visual, ConvertMode -> "Most",opts]}, 
	ImageSize->Automatic],"Is "<>ToString[Elements[H], TraditionalForm]<>" a subgroup of "<>GroupoidName[G]<>"?", Top]

SubgroupQ[H_List, G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> SubgroupQ[H, G],
	"Explanation" -> SubgroupQ[H, G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization 1" -> SubgroupQ[H, G, Mode->Visual, ConvertMode -> "All",opts],
	"Visualization 2" -> SubgroupQ[H, G, Mode->Visual2, ConvertMode -> "All",opts]}, 
	ImageSize->Automatic],"Is "<>ToString[H, TraditionalForm]<>" a subgroup of "<>GroupoidName[G]<>"?", Top]

SubgroupQ[H_List, G_?GroupoidQ, Mode -> Most, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> SubgroupQ[H, G],
	"Explanation" -> SubgroupQ[H, G, Mode->Textual, ConvertMode -> "Most",opts],
	"Visualization" -> SubgroupQ[H, G, Mode->Visual, ConvertMode -> "Most",opts]}, 
	ImageSize->Automatic],"Is "<>ToString[H, TraditionalForm]<>" a subgroup of "<>GroupoidName[G]<>"?", Top]

SubgroupQ[H_List, G_?GroupoidQ, Mode->Visual, Version->5] := 
	If[GroupQ[G],SubgroupQVisual[G,H],
		Message[Group::fail,StructureName[G]];$Failed]
				
SubgroupQ[H_List, G_?GroupoidQ, Mode -> Visual, opts___?OptionQ] := 
	If[GroupQ[G],DoVisualization[
			SubgroupQVisual5[G,H,opts],{{H,G},SubgroupQHelp},opts],
		Message[Group::fail,StructureName[G]];$Failed]

SubgroupQ[H_?GroupoidQ, G_?GroupoidQ, Mode -> Visual, opts___?OptionQ] := 
	If[Operation[G] === Operation[H],
		If[GroupQ[G],DoVisualization[
			SubgroupQVisual5[G,Elements[H],opts],{{H,G},SubgroupQHelp},opts],
			Message[Group::fail,StructureName[G]]; $Failed],
		Message[Operation::fail]; $Failed]

SubgroupQHelp[H_,G_]:=  DoHelpMessage[windowtitle -> "Help for whether H is a subgroup of G", 
		help -> List["The elements from ", 
		Cell[BoxData[
 ToBoxes[H,TraditionalForm]],
 FormatType->"TraditionalForm"],
		" are colored in green while those colored in red are not in this list but are in the group ",
		GroupoidName[G]<>". If there are no red elements, then the set ",
		Cell[BoxData[
 ToBoxes[H,TraditionalForm]],
 FormatType->"TraditionalForm"],
		" is closed in "<>GroupoidName[G]<>
		"and thus it is a subgroup. In contrast, if there are red ones, then the set is not a subgroup."]
]

SubgroupQ[H_List, G_?GroupoidQ, Mode -> Visual2, opts___] := 
	If[GroupQ[G],If[SubgroupQ[H,G],
		DoVisualization[SubgroupQVisual6[G,H,SubgroupVisualText/.Flatten[{opts,Options[SubgroupQ]}]],
				{{H,G},SubgroupQ2Help},opts],
			Message[SubgroupQ::notsbgp,H];$Failed],
			Message[Group::fail,StructureName[G]]; $Failed]

SubgroupQ::notsbgp="This mode of SubgroupQ requires a subgroup for the illustration but `1` is not.";

SubgroupQ[H_?GroupoidQ, G_?GroupoidQ, Mode -> Visual2, opts___] := 
	If[Operation[G] === Operation[H],
		If[GroupQ[G],If[SubgroupQ[H,G],
			DoVisualization[SubgroupQVisual6[G,Elements[H],SubgroupVisualText/.Flatten[{opts,Options[SubgroupQ]}]],
				{{Elements[H],G},SubgroupQ2Help},opts],
			Message[SubgroupQ::notsbgp,H];$Failed],
			Message[Group::fail,StructureName[G]]; $Failed],
		Message[Operation::fail]; $Failed]
		
SubgroupQ2Help[H_,G_]:= DoHelpMessage[windowtitle -> "Help for whether H is a subgroup of G ", 
	help ->Join[{"Here we are wondering if the set ",
		Cell[BoxData[FormBox["H", TraditionalForm]], FormatType->"TraditionalForm"],
	" = ", 
		Cell[BoxData[
 ToBoxes[H,TraditionalForm]],
 FormatType->"TraditionalForm"],
		" is a subgroup of "<>GroupoidName[G]<>". "},
		If[SubgroupQ[H,G],
			{"Since ",
			Cell[BoxData[FormBox["H", TraditionalForm]], FormatType->"TraditionalForm"],
	" is a subgroup, note that all the elements in ",
	Cell[BoxData[FormBox["H", TraditionalForm]], FormatType->"TraditionalForm"],
	" are colored yellow while all the other elements are colored according to the left cosets of ",
	Cell[BoxData[FormBox["H", TraditionalForm]], FormatType->"TraditionalForm"],
		" in the group "<>GroupoidName[G]<>"."},
			{"Since ",
	Cell[BoxData[FormBox["H", TraditionalForm]], FormatType->"TraditionalForm"],
	" is not a subgroup of "<>GroupoidName[G]<>", the coloration in this context may not meaningful."}]]
]
		
SubgroupQWork[G_, H_, opts___?OptionQ] := Module[{mymode, ok, GG},
	mymode = Mode/.Flatten[{opts, Options[SubgroupQ]}];
	GG = FormGroupoid[H, Operation[G], OperatorSymbol[G]];
	If[Not[untestedQ[inverseFunction[G]]], inverseFunction[GG] =
		inverseFunction[G]];
	ok = Length[H] > 0 && SubsetQAA[H,Elements[G]] &&
		ClosedQ[GG]]
		
exNotClosed[H_,G_] := Module[{i=1,j=1,done = False,
	len = Length[H],el1,el2,prod},
	While[Not[done],
		el1 = H[[i]];
		el2 = H[[j]];
		prod = Operation[G][el1,el2];
		If[Not[MemberQ[H,prod]],
			done = True,
			i++;
			If[i>len,i=1;j++]
		];
	];
	{el1,el2,prod}]
	(* finds an example to  show not closed *)

SubgroupQTextual[G_,H_] := 
	If[!multipleQ, SubgroupQTextualGD[G] <> SubgroupQTextualLI[G,H],
		If[firstPassQ, 
			firstPassQ = False;
			SubgroupQTextualGD[G] <> SubgroupQTextualLI[G,H],
			SubgroupQTextualLI[G,H]]]

SubgroupQTextualGD[_] := "By definition, we say a set H is a subgroup of the group G if H is a subset of G and it is itself a group under the operation inherited from G. For finite groups, as is the case here, one only needs to show the closure of H under the operation of G (assuming, of course, that H is nonempty).\n"

SubgroupQTextualLI[G_,H_] := Module[{trip},
If[SubgroupQ[H,G],
		StringJoin["Since ",ToString[H,TraditionalForm]," is closed under the operation of ",
			theGroupName[G],", then indeed this is a subgroup."],
		If[Length[H]>0,
			trip = exNotClosed[H,G];
			StringJoin["Since ",ToString[H,TraditionalForm],
				" is NOT closed (for example, the elements ",ToString[trip[[1]]], " and ",
ToString[trip[[2]]], " have a product (sum) of ",ToString[trip[[3]]],
", which is not in ",ToString[H],"), this is not a subgroup of ",
theGroupName[G],"."],
			"Since the set H is empty, it cannot be a subgroup."]
	]]

Options[SubgroupQVisual]={DisplayFunction -> $DisplayFunction};

SubgroupQVisual[G_,H_,opts___?OptionQ] := 
	Module[{els = Elements[G],len, rects, gColoredRects, gText,
		gLines, pos, good, in, out,op = Operation[G], morein,
		moreinpos, showopts = FilterRules[{opts},Options[Graphics]],
		df = DisplayFunction/.Flatten[{opts, Options[SubgroupQVisual]}]},
	len = Length[els];
	els = Join[H,Complement[els,H]];
	(* if this new els is ok, what is below can be simplified *)
	pos = Flatten[Map[Position[els,#,1]&,H]];
	moreinpos =  pos;
	pos = Flatten[Outer[List, pos, pos],1];
	morein = {OtherColors[[1]],Join[Map[Rectangle[{#-1,len},{#, len+1}]&,
		moreinpos],
		Map[Rectangle[{-1,len-#},{0, len+1-#}]&,moreinpos]]};
	{gLines, gText,rects} = basicCayley[G,els, CayleyForm -> 
		CayleyForm[G]];
	good = Select[pos, MemberQ[H,Part[els,#[[1]]]~op~Part[els,
		#[[2]]]]&];
	in = {OtherColors[[1]], Map[Part[rects,#[[1]],#[[2]]]&,good]};
	out = {OtherColors[[3]], Map[Part[rects,#[[1]],#[[2]]]&,Complement[pos,good]]};
	in = {OtherColors[[1]],Join[in[[2]],morein[[2]]]};
	gColoredRects = Show[Graphics[{in, out},
		DisplayFunction -> Identity]];
	If[showVisTextQ[SubgroupQ1],
Print[StringJoin["All the elements marked with yellow are original elements in the set. Those in red are from outside."]]];
If[WideElementsQ[G],
		PrintCayleyKey[els,StructureName[G],G, KeyForm[G]]];
Show[{gColoredRects, gLines,gText},
		showopts]]
(* removed ,DisplayFunction -> df 7/21/08 *)

SubgroupQVisual5[G_,H_, opts___?OptionQ] := 
	Module[{els = Elements[G],len, pos, good, in, out, op = Operation[G],
		morein,morein2,grid,labels = {1,2},displayTextQ, showkey, panel, cayleyform},
	showkey = showkeyQ[G, opts];
	cayleyform = CayleyForm/.Flatten[{opts, Options[SubgroupQ]}];
	len = Length[els];
	els = Join[H,Complement[els,H]];
	pos = Flatten[Map[Position[els,#,1]&,H]];
	morein= pos + 1;
(* adjust for borders that have headers *)
	morein=Map[{1,#}&,morein];
	morein2=Map[RotateRight,morein];
	morein=Union[morein2,morein];
	pos = Flatten[Outer[List, pos, pos],1];
	in = Select[pos, MemberQ[H,Part[els,#[[1]]]~op~Part[els,
		#[[2]]]]&];
	good = in+1; 
	good=Union[good,morein];
	grid =WhiteCayleyGrid[G,els]//Last;
	grid = MapAt[ChangeItemBackground[#,GoodElementsColor]&,grid,good];
	out = Complement[pos,in]+1;
	grid = MapAt[ChangeItemBackground[#,BadElementsColor]&,grid,out];
	If[showkey,grid = ConvertGridToKeyed[G,grid]];
	If[cayleyform =!=StandardForm && MemberQ[{FullForm,MatrixForm,InputForm,TraditionalForm,OutputForm},cayleyform],
		pos = Flatten[Delete[Table[{i,j},{i,len+1},{j,len+1}],{1,1}],1];
		grid = MapAt[ChangeItemCayleyForm[#,cayleyform]&,grid,pos]];
	panel = Panel[Grid[grid,Dividers->{{1,2->Thickness[4]},{1,2->Thickness[4]}},
		ItemSize->Full, Spacings->Offset[1]],{" "," "},{Left,Top}];
	If[showkey,panel = Column[{panel,TextCayleyKey[els,GroupoidName[G],G,StandardForm]}]];
	panel
	]

(* SubgroupQVisual5 version added 7/15/08 
code below are great utilities
*)

SubgroupQVisual6[G_,H_, dispTxtQ_] := 
	Module[{els = Elements[G],len, grid, labels = {1,2}, cosets,
		newlist, colorfn, Hset, displayTextQ},
	len = Length[els];
	Hset = If[Head[H]===List, H, Elements[H]];
	cosets = Cosets[G,H,left];
	newlist = Flatten[cosets,1];
	grid = WhiteCayleyGrid[G,newlist]//Last;
	Do[colorfn[cosets[[1,i]]//StandardForm] = OtherColors[[1]],{i, Length[H]}];
	Do[colorfn[cosets[[i,j]]//StandardForm] = BackgroundColors[[i]],
		{i, 2, Length[cosets]},{j,Length[H]}];
	grid = Map[ChangeItemBackgroundElement[#,colorfn]&,grid,{2}];
	grid = MapAt[ChangeItemBackground[#,White]&,grid,{{1,1}}];
	labels[[1]]={"All the elements marked with yellow are elements in the subgroup " <> ToString[H] <> ". The others are colored according to the various left cosets of this subgroup in the group " <>StructureName[G]<>"."};
	If[! displayTextQ,labels[[1]]={""}];
	labels[[2]]={Top};
	(*Column[{Labeled[Panel[Grid[grid,Dividers->{{1,2->Thickness[4]},{1,2->Thickness[4]}},
		ItemSize->Full, Spacings-> Offset[1]],{"x","y"},
{Left,Top}],(Sequence@@labels)]},Center]*)
	Panel[Grid[grid,Dividers->{{1,2->Thickness[4]},{1,2->Thickness[4]}},
		ItemSize->Full, Spacings-> Offset[1]],{" "," "},
{Left,Top}]
	]

(* SubgroupQVisual6 added 7/16/08 *)

Cosets[G_?GroupoidQ,H_List,side_] := Module[{op = Operation[G],
	findcoset},
	findcoset[{els_,cosetlist_,mside_}] := 
			Module[{temp,g,cs = cosetlist},
		temp = Fold[DeleteCases[#1, #2]&,els,Last[cs]];
		If[temp=!={}, g = First[temp];
			AppendTo[cs,Map[If[mside===left,op[g,#]&,
				op[#,g]&],H]]];
		{temp,cs,side}];
	FixedPoint[findcoset,{Elements[G],{H},side}][[2]]
]

Options[SubgroupQVisual2]={DisplayFunction -> $DisplayFunction};

SubgroupQVisual2[G_,H_,sub_,opts___?OptionQ] := 
	Module[{S = Elements[G],len, rects, coloredRects, gText, 
		colorfn,i,j,colors, gLines,cosets,newlist,headings,
		op = Operation[G],
		showopts = FilterRules[{opts},Options[Graphics]],
		df = DisplayFunction/.Flatten[{opts, Options[SubgroupQVisual2]}]},
If[!sub, Message[MemberQ::sbgrp,H,StructureName[G]],
	len = Length[S];
	cosets = Cosets[G,H,left];
	newlist = Flatten[cosets,1];
	{gLines, gText,rects} = 
		basicCayley[G,newlist, CayleyForm -> CayleyForm[G]];
	Do[colorfn[cosets[[1,i]]] = OtherColors[[1]],{i, Length[H]}];
	Do[colorfn[cosets[[i,j]]] = BackgroundColors[[i]],
		{i, 2, Length[cosets]},{j,Length[H]}];
	colors = Map[colorfn,makeTable[G,newlist],{2}];
	headings = Transpose[{Map[colorfn,newlist],
		Table[Rectangle[{i-1, len}, {i, len+1}],{i,len}]}];
	headings = Join[headings,Transpose[{Map[colorfn,newlist],
		Table[Rectangle[{-1, len-i}, {0, len-i+1}],{i,len}]}]];
	coloredRects = Transpose[{Flatten[colors],Flatten[rects]}];
	If[showVisTextQ[SubgroupQ2],
Print[StringJoin["All the elements marked with yellow are elements in the subgroup. The others are colored according to the various left cosets of the subgroup in the group."]]];
	Show[{Graphics[{headings, coloredRects}], gLines, gText},
		showopts,DisplayFunction -> df]
		]]
			
SubgroupQVisual4[G_,H_,opts___] := 
	Module[{S = Elements[G],Gp},
	S = Join[H,Complement[S,H]];
	Gp = FormGroupoid[S, Operation[G], GatherGroupoidOptions[G]];
	SubgroupQVisual[Gp, H, opts]//Print
	(*SubgroupQ[H,Gp, Mode -> Visual,Output -> Graphics,opts]*)]
	(* added Print 11/3/06 
removed DisplayFunction -> Identity 7/21/08 *)


(* ::Subsection:: *)
(* 30.3 Subgroup intersection*)


(* add Textual and Visual - for the latter consider two calls
to SubgroupQVisual (each subgroup) and then one for the 
intersection also *)

SubgroupIntersection[G_?GroupoidQ, H_?GroupoidQ, K_?GroupoidQ] :=
	If[Operation[G] === Operation[H] === Operation[K],
		SubgroupIntersection[G, Elements[H], Elements[K]],
		Message[Operation::fail]; $Failed]

SubgroupIntersection[G_?GroupoidQ, H_List, K_List] := 
		Module[{op = Operation[G], ok = True, els = Elements[G], new =
			Intersection[H, K]},
	If[SubsetQAA[H,els], ok = True, 
		ok = False;
		Message[MemberQ::elmnts, H, StructureName[G]]];
	If[SubsetQAA[K,els], ok = ok && True, 
		ok = ok && False;
		Message[MemberQ::elmnts, K, StructureName[G]]];
	If[SubgroupQ[H,G], ok = ok && True, 
		ok = ok && False;
		Message[MemberQ::sbgrp, H, StructureName[G]]];
	If[SubgroupQ[K,G], ok = ok && True, 
		ok = ok && False;
		Message[MemberQ::sbgrp, K, StructureName[G]]];
	If[ok,
		If[ProperSubsetQAA[new,els],
			FormGroupoid[new, op, OperatorSymbol[G], 
				GatherSubGroupoidOptions[G]],
			G], $Failed]];



(* ::Subsection:: *)
(* 30.4 Subgroup union*)


SubgroupUnion[G_?GroupoidQ, H_?GroupoidQ, K_?GroupoidQ] :=
	If[Operation[G] === Operation[H] === Operation[K],
		SubgroupUnion[G, Elements[H], Elements[K]],
		Message[Operation::fail]; $Failed]
		
SubgroupUnion[G_?GroupoidQ, H_List, K_List] := 
		Module[{op = Operation[G], ok = True, els = Elements[G], new = Union[H,K]},
	If[SubsetQAA[H,els], ok = True, 
		ok = False;
		Message[MemberQ::elmnts, H, StructureName[G]]];
	If[SubsetQAA[K,els], ok = ok && True, 
		ok = ok && False;
		Message[MemberQ::elmnts, K, StructureName[G]]];
	If[SubgroupQ[H,G], ok = ok && True, 
		ok = ok && False;
		Message[MemberQ::sbgrp, H, StructureName[G]]];
	If[SubgroupQ[K,G], ok = ok && True, 
		ok = ok && False;
		Message[MemberQ::sbgrp, K, StructureName[G]]];
	If[ok,
		If[ProperSubsetQAA[new,els],
			FormGroupoid[new, op, OperatorSymbol[G], 
				GatherSubGroupoidOptions[G]],
			G], $Failed]];



(* ::Subsection:: *)
(* 30.5 Subgroup product*)


SubgroupProduct[G_?GroupoidQ, H_?GroupoidQ, K_?GroupoidQ] :=
	If[Operation[G] === Operation[H] === Operation[K],
		SubgroupProduct[G, Elements[H], Elements[K]],
		Message[Operation::fail]; $Failed]

SubgroupProduct[G_?GroupoidQ, H_List, K_List] := 
		Module[{op = Operation[G], ok = True, els = Elements[G], new},
	new = Union[CloseSets[H,K,op]];
	If[SubsetQAA[H,els], ok = True, 
		ok = False;
		Message[MemberQ::elmnts, H, StructureName[G]]];
	If[SubsetQAA[K,els], ok = ok && True, 
		ok = ok && False;
		Message[MemberQ::elmnts, K, StructureName[G]]];
	If[SubgroupQ[H,G], ok = ok && True, 
		ok = ok && False;
		Message[MemberQ::sbgrp, H, StructureName[G]]];
	If[SubgroupQ[K,G], ok = ok && True, 
		ok = ok && False;
		Message[MemberQ::sbgrp, K, StructureName[G]]];
	If[ok,
		If[ProperSubsetQAA[new,els],
			FormGroupoid[new, op, OperatorSymbol[G], 
				GatherSubGroupoidOptions[G]],
			G], $Failed]];
		


(* ::Subsection:: *)
(* 30.6 Subgroup closure*)


Options[Closure] = {Mode -> Computational, ReportIterations ->
	False, Staged -> False, Sort -> False, Output -> Computational};

Closure[G_?GroupoidQ, H_?GroupoidQ, opts___?OptionQ] := 
	If[Operation[G] === Operation[H],
		Closure[G, Elements[H], opts],
		Message[Operation::fail]; $Failed]
		
Closure[G_?GroupoidQ, H_List] := Closure[G, H] = 
	Module[{elem, iterations},
If[SubsetQAA[H,Elements[G]],
	{elem, iterations} = ClosureWk[G, H];
	If[ProperSubsetQAA[elem,Elements[G]],
		FormGroupoid[elem, Operation[G], OperatorSymbol[G],
			GatherSubGroupoidOptions[G]],
		ReorderGroupoid[G, elem]],
Message[MemberQ::elmnts,H,StructureName[G]]; $Failed]]

Closure[G_?GroupoidQ, H_List, Sort->sort_] := Closure[G, H] = 
	Module[{elem, iterations},
If[SubsetQAA[H,Elements[G]],
	{elem, iterations} = ClosureWk[G, H];
	If[sort===True,elem = Sort[elem]];
	If[ProperSubsetQAA[elem,Elements[G]],
		FormGroupoid[elem, Operation[G], OperatorSymbol[G],
			GatherSubGroupoidOptions[G]],
		ReorderGroupoid[G, elem]],
Message[MemberQ::elmnts,H,StructureName[G]]; $Failed]]

Closure[G_?GroupoidQ, H_List, ReportIterations -> repIt_] := Closure[G, H] = 
	Module[{elem, iterations},
If[SubsetQAA[H,Elements[G]],
	{elem, iterations} = ClosureWk[G, H];
	If[ProperSubsetQAA[elem,Elements[G]],
		If[repIt===True,{FormGroupoid[elem, Operation[G], OperatorSymbol[G],
			GatherSubGroupoidOptions[G]],Length[iterations],iterations},FormGroupoid[elem, Operation[G], OperatorSymbol[G],
			GatherSubGroupoidOptions[G]]],
		If[repIt===True,
			{ReorderGroupoid[G, elem],Length[iterations],iterations},
			ReorderGroupoid[G, elem]]],
Message[MemberQ::elmnts,H,StructureName[G]]; $Failed]]

Closure[G_?GroupoidQ, H_List, Mode -> Textual, opts___?OptionQ] := 
	Module[{elem, iterations, text, showconvert, cm},
	{elem, iterations} = ClosureWk[G, H];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	text = ClosureTextual[G, Length[iterations], Last[iterations]];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]

Closure[G_?GroupoidQ, H_List, Mode -> Visual, opts___?OptionQ] := Module[{elem, iterations},
	{elem, iterations} = ClosureWk[G, H];
	ClosureVisual[G, iterations, opts]]

Closure[G_?GroupoidQ, H_, Mode -> Computational, opts___?OptionQ] := Closure[G, H]

Closure[G_?GroupoidQ, H_, Mode -> Interactive, InteractiveMode->Visual, opts___?OptionQ]:=
	Module[{x={}},
	Panel[Column[{CheckboxBar[Dynamic[x],Complement[Elements[G],H]],
		Dynamic[SubgroupQVisual5[G,Join[H,x],Mode->Visual, opts]]}], 
		TraditionalForm["Closure of "<>ToString[H]<>" in "<>GroupoidName[G]]]]

Closure[G_?GroupoidQ, H_, Mode -> Interactive, InteractiveMode->Textual, opts___?OptionQ]:=
	Module[{x={}},
		Panel[Column[{CheckboxBar[Dynamic[x],Complement[Elements[G],H]],
		Dynamic[Closure[G,Join[H,x],Mode->Textual, opts]]}], 
		TraditionalForm["Closure of "<>ToString[H]<>" in "<>GroupoidName[G]]]]

Closure[G_?GroupoidQ, H_, Mode -> Interactive, InteractiveMode->Computational]:=
	Module[{x={}},
		Panel[Column[{CheckboxBar[Dynamic[x],Complement[Elements[G],H]],
		Dynamic[Closure[G,Join[H,x]]]}], 
		TraditionalForm["Closure of "<>ToString[H]<>" in "<>GroupoidName[G]]]]

Closure[G_?GroupoidQ, H_, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		Closure[G, H, Mode->Interactive, InteractiveMode -> Computational],
	"Explanation" -> Closure[G,H,Mode->Interactive, InteractiveMode -> Textual, ShowConvert -> False, opts],
	"Visualization" -> Closure[G,H, Mode->Interactive, InteractiveMode -> Visual,ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with Closure[G, H]", Top]

Closure[G_?GroupoidQ, H_List, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> Closure[G, H],
	"Explanation" -> Closure[G, H, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> Closure[G, H, Mode->Visual, ConvertMode -> "All",opts],
	"Interactive" -> Closure[G, H, Mode->Interactive, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],TraditionalForm["Closure of "<>ToString[H]<>" in "<>GroupoidName[G]], Top]

ClosureWk[G_, H_] := Module[{op = Operation[G], elem = H,
	optable, done = False, level = 1, els,n, max = 
		Length[Elements[G]]},
	els[1]=H;
	While[(Length[elem]<=max) && Not[done],
		optable=CloseSets[elem,elem,op];
		If[Sort[Union[elem,optable]]===Sort[elem],
			done=True,
			(*else*)
			elem=UnionNoSort[Join[elem,optable]];
			level++;
			els[level] = elem]];(*end of While *)
	{elem, Table[els[k], {k, 1, level}]}]
	
ClosureTextual[G_,n_,clos_] := TraditionalForm["Given a subset S of a groupoid G, the closure of the set S is the smallest subset of G containing S that is closed under the operation of G. In this case, it took "<>ToString[n]<>" iterations to arrive at the closure:\n"<>ToString[clos]]

ClosureVisual2[G_,lst_,opts___] := ClosureVisualStaged[G,lst,opts]

ClosureVisualStaged[G_,lst_,opts___] := Module[{i},
	firstPassQ = True;
	Do[If[i > 1, PrintCayleyKeyQ = False];ClosureVisualStagedSlide[i] = 
		SubgroupQVisual4[G,lst[[i]], DisplayFunction -> 
		Identity,opts];
		firstPassQ = False,{i,Length[lst]}];
	firstPassQ = True;
	TotalStages[Closure] = Length[lst];
	CurrentStage[Closure] = 1;
	Show[ClosureVisualStagedSlide[1],
		DisplayFunction -> $DisplayFunction]
]

NextStage[Closure] := (CurrentStage[Closure]++;
	If[CurrentStage[Closure] <= TotalStages[Closure],
		Show[ClosureVisualStagedSlide[CurrentStage[Closure]],
			DisplayFunction -> $DisplayFunction],
		CurrentStage[Closure]=1;
		Show[ClosureVisualStagedSlide[1],
			DisplayFunction -> $DisplayFunction]])

NextStage[Closure]:= Message[Closure::stage]

NextStage[Closure,k_Integer] := 
(CurrentStage[Closure] = Mod[CurrentStage[Closure] + k,
			TotalStages[Closure]];
	If[CurrentStage[Closure] > 0,
		Show[ClosureVisualStagedSlide[CurrentStage[Closure]],
			DisplayFunction -> $DisplayFunction],
		Show[ClosureVisualStagedSlide[TotalStages[Closure]],
			DisplayFunction -> $DisplayFunction]])

NextStage[Closure,k_Integer]:= Message[Closure::stage]
			
PreviousStage[Closure] := (CurrentStage[Closure]--;
	If[CurrentStage[Closure] > 0,
		Show[ClosureVisualStagedSlide[CurrentStage[Closure]],
			DisplayFunction -> $DisplayFunction],
		CurrentStage[Closure]=TotalStages[Closure];
		Show[ClosureVisualStagedSlide[TotalStages[Closure]],
			DisplayFunction -> $DisplayFunction]];)

PreviousStage[Closure]:= Message[Closure::stage]

PreviousStage[Closure,k_Integer] := 
	(CurrentStage[Closure] = Mod[CurrentStage[Closure] - k,
			TotalStages[Closure]];
	If[CurrentStage[Closure] > 0,
		Show[ClosureVisualStagedSlide[CurrentStage[Closure]],
			DisplayFunction -> $DisplayFunction],
		Show[ClosureVisualStagedSlide[TotalStages[Closure]],
			DisplayFunction -> $DisplayFunction]];)

PreviousStage[Closure,k_Integer]:= Message[Closure::stage]

PreviousStage[SubgroupClosure] := PreviousStage[Closure]

NextStage[SubgroupClosure] := NextStage[Closure]

ClosureVisualV5[G_,lst_,opts___] := Module[{i},
	Do[If[i > 1, PrintCayleyKeyQ = False];
	SubgroupQVisual4[G,lst[[i]],opts, DisplayFunction -> 
		$DisplayFunction];, {i,Length[lst]}]]

ClosureVisual[G_,lst_, opts___?OptionQ] := Module[{i},
	DoVisualization[Manipulate[If[i > 1, PrintCayleyKeyQ = False];
	SubgroupQVisual5[G,lst[[i]],opts], 
	{{i, 1,"iteration"}, 1, Length[lst], 1, Appearance->"Open"}],{{G,lst//First},ClosureHelp},opts]]
(* formerly this used version 4 of SubgroupQVisual *)

ClosureHelp[G_,H_]:= DoHelpMessage[windowtitle -> "Help for the closure of H in "<>GroupoidName[G], 
	help -> List["Consider the set ",
		Cell[BoxData[
 FormBox["H", TraditionalForm]],
 FormatType->"TraditionalForm"],
	" = ", 
		Cell[BoxData[ToBoxes[H,TraditionalForm]], FormatType->"TraditionalForm"],
		" in the group ",
	Cell[BoxData[
 FormBox["G", TraditionalForm]],
 FormatType->"TraditionalForm"],
	" = ",
		GroupoidName[G],
		". We want to know if this set is closed. The elements with a green background come from ",
	Cell[BoxData[
 FormBox["H", TraditionalForm]],
 FormatType->"TraditionalForm"],
	" while the elements with a red background are in the group ",
	Cell[BoxData[
 FormBox["G", TraditionalForm]],
 FormatType->"TraditionalForm"],
	" but outside ",
	Cell[BoxData[
 FormBox["H", TraditionalForm]],
 FormatType->"TraditionalForm"],
	". If there are red-colored elements, we need to add these to the set ",
	Cell[BoxData[
 FormBox["H", TraditionalForm]],
 FormatType->"TraditionalForm"],
	" and check again. This device allows the user to do so on an ongoing basis until the set is closed. To use this, either move the slider bar, click on the black triangle, or click on the - or + symbols."]

]

SubgroupClosure[G_?GroupoidQ, H_List, opts___?OptionQ] := 
	Closure[G, H, opts]


(* ::Subsection:: *)
(* 30.7 Subgroup join*)


SubgroupJoin[G_?GroupoidQ, H_?GroupoidQ, K_?GroupoidQ] :=
	If[Operation[G] === Operation[H] === Operation[K],
		SubgroupJoin[G, Elements[H], Elements[K]],
		Message[Operation::fail]; $Failed]

SubgroupJoin[G_?GroupoidQ, H_List, K_List] := 
		Module[{op = Operation[G], ok = True, els = Elements[G], new, 
			old = GatherGroupoidOptions[G]},
	If[SubsetQAA[H,els], ok = True, 
		ok = False;
		Message[MemberQ::elmnts, H, StructureName[G]]];
	If[SubsetQAA[K,els], ok = ok && True, 
		ok = ok && False;
		Message[MemberQ::elmnts, K, StructureName[G]]];
	If[SubgroupQ[H,G], ok = ok && True, 
		ok = ok && False;
		Message[MemberQ::sbgrp, H, StructureName[G]]];
	If[SubgroupQ[K,G], ok = ok && True, 
		ok = ok && False;
		Message[MemberQ::sbgrp, K, StructureName[G]]];
	If[ok,
		new = GenerateGroupoid[Join[H, K],Operation[G]];
		If[ProperSubsetQAA[Elements[new],els],
			FormGroupoid[Elements[new], op, OperatorSymbol[G], 
				GatherSubGroupoidOptions[G]],
			FormGroupoid[Elements[new], op, OperatorSymbol[G], old]], $Failed]]


(* ::Subsection:: *)
(* 30.8 Subgroups*)


Subgroups[G_?CyclicQ] := Module[{n = Size[G], orders, g, subs},
	orders = Complement[Divisors[n], {1,n}];
	g = First[CyclicGenerators[G]];
	subs = Map[FormGroupoid[#, Operation[G], OperatorSymbol[G], 
		GatherSubGroupoidOptions[G]]&,
		Map[Sort, Prepend[Map[Elements@SubgroupGenerated[G,
			ElementToPower[G, g, #]]&,
		orders], {GroupIdentity[G]}]]];
	Append[subs, G]]
	
Subgroups[G_?GroupoidQ] := 
		Module[{els=Elements[G],Hsets,subgroups,divs,id,lengths,n},
	id = GroupIdentity[G];
	els = Complement[els,{id}];
	n = Length[els] + 1;
	lengths = Complement[Divisors[n],{1,n}]-1; (* account for missing identity *)
	Hsets = Flatten[Table[KSubsets[els,lengths[[i]]],{i,Length[lengths]}],1];
	Hsets = Map[Join[#,{id}]&,Hsets];
	subgroups = Select[Hsets,SubgroupQ[#,G]&];
	subgroups = Select[subgroups,Length[#] < Size[G]&];
	Append[Map[FormGroupoid[#, Operation[G], OperatorSymbol[G], 
		GatherSubGroupoidOptions[G]]&,
		Prepend[Map[Sort,subgroups],{id}]], G]]


(* ::Section:: *)
(* 31. Subgroup Generated by an Element*)


ClosedQAndIdentityQ[G_?GroupoidQ] :=
	If[HasIdentityQ[G],
		If[ClosedQ[G], True,
			Message[Group::fail, StructureName[G]]; False],
		Message[Group::fail, StructureName[G]]; False]

SubgroupGeneratedWork[g_,G_] := SubgroupGeneratedWork[g,G]= Module[{id},
	If[Not[ElementQ[g,G]],
		Message[MemberQ::elmnt, g, StructureName[G]];$Failed,
		If[ClosedQAndIdentityQ[G],
			id = GroupIdentity[G];
			If[g===id,
				{g},
				FixedPointList[Operation[G][g,#]&,g, Length[Elements[G]],
				SameTest ->(#2===id&)]//If[Last[#]=!=id, Message[Group::noord,
					g, StructureName[G]]; $Failed,#]&], $Failed]]]

Options[SubgroupGenerated]={Mode -> Computational, Output -> Computational};

SubgroupGenerated[G_?GroupoidQ, g_] :=  Module[{sg},
	sg = SubgroupGeneratedWork[g,G];
	If[sg =!= $Failed,
		If[ProperSubsetQAA[sg, Elements[G]],
			FormGroupoid[sg, Operation[G], OperatorSymbol[G],
				GatherSubGroupoidOptions[G]],
			FormGroupoid[sg, Operation[G], OperatorSymbol[G],
				GatherGroupoidOptions[G]]], $Failed]]
		
SubgroupGenerated[G_?GroupoidQ,g_, Mode -> Computational, opts___?OptionQ]:=SubgroupGenerated[G, g]

SubgroupGenerated[G_?GroupoidQ,g_, Mode -> Textual, opts___?OptionQ] := Module[{sg},
	sg = SubgroupGeneratedWork[g,G];
	If[sg =!=$Failed,
		SubgroupGeneratedTextual[g, G, sg, opts],
		$Failed]]

SubgroupGenerated[G_?GroupoidQ,g_, Mode -> Visual, opts___?OptionQ] := Module[{sg},
	sg = SubgroupGeneratedWork[g,G];
	If[sg =!=$Failed,
		DoVisualization[SubgroupGeneratedVisual[g,G,sg, opts],{{G,g},SubgroupGeneratedHelp},opts],
		$Failed]]

SubgroupGeneratedHelp[G_,g_]:= DoHelpMessage[windowtitle -> "Help for the subgroup generated by g in G", 
		help -> {"This tool helps illustrate the subgroup generated by ",
		Cell[BoxData[FormBox["g", TraditionalForm]], FormatType->"TraditionalForm"],
	" = ", 
		Cell[BoxData[ToBoxes[g,TraditionalForm]], FormatType->"TraditionalForm"],
		" in the group "<>GroupoidName[G]<>". To see this subgroup, either mover the slider bar to the right or click on the black triangle. This will then trace through the powers/multiples of ",
	Cell[BoxData[FormBox["g", TraditionalForm]], FormatType->"TraditionalForm"],
	" until the subgroup is generated."}
]

SubgroupGenerated[G_?GroupoidQ,g_, Mode -> Visual2, opts___?OptionQ] := Module[{sg},
	sg = SubgroupGeneratedWork[g,G];
	If[sg =!=$Failed,
		DoVisualization[SubgroupGeneratedVisual5[G,g, opts],{{G,g},SubgroupGenerated2Help},opts],
		$Failed]]

SubgroupGenerated2Help[G_,g_]:= DoHelpMessage[windowtitle -> "Help for the subgroup generated by g in G", 
		help ->{"This table helps illustrate the subgroup generated by ",
		Cell[BoxData[FormBox["g", TraditionalForm]], FormatType->"TraditionalForm"],
	" = ", 
		Cell[BoxData[ToBoxes[g,TraditionalForm]], FormatType->"TraditionalForm"],
		" in the group "<>GroupoidName[G]<>". Note that in the table, the row headed by ",
		Cell[BoxData[ToBoxes[g,TraditionalForm]], FormatType->"TraditionalForm"],
		" illustrates all the powers/multiples of ",
	Cell[BoxData[FormBox["g", TraditionalForm]], FormatType->"TraditionalForm"],
	" until the subgroup is generated. The key at the bottom indicates the order in which they are generated until the identity is reached. This can also be found by holding the mouse over any colored element in the body of the table."}
]

SubgroupGenerated[G_?GroupoidQ, g_, Mode -> Computational, opts___?OptionQ] := 
	SubgroupGenerated[G, g]

SubgroupGenerated[G_?GroupoidQ, g_, Mode -> Interactive, InteractiveMode->mode_, opts___?OptionQ]:=
	Module[{min, max, els=Elements[G], pos,h},
	min = 1;
	max = Length[els];
	pos = Position[els,g,1]//Flatten//First;
	Manipulate[SubgroupGenerated[G, h, Mode -> mode, opts],{{h, g, "g \[Element] G"}, els},
		ControlType -> RadioButtonBar]
]

SubgroupGenerated[G_?GroupoidQ, g_, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		SubgroupGenerated[G, g, Mode->Interactive, InteractiveMode -> Computational, opts],
	"Explanation" -> SubgroupGenerated[G,g,Mode->Interactive, InteractiveMode -> Textual, ShowConvert -> False, opts],
	"Visualization 1" -> SubgroupGenerated[G,g, Mode->Interactive, InteractiveMode -> Visual, ShowConvert -> False, opts],
	"Visualization 2" -> SubgroupGenerated[G,g, Mode->Interactive, InteractiveMode -> Visual2, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with SubgroupGenerated[G, g]", Top]

SubgroupGenerated[G_?GroupoidQ, g_, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> SubgroupGenerated[G, g],
	"Explanation" -> SubgroupGenerated[G, g, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization 1" -> SubgroupGenerated[G, g, Mode->Visual, ConvertMode -> "All", opts],
	"Visualization 2" -> SubgroupGenerated[G, g, Mode->Visual2, ConvertMode -> "All", opts],
	"Interactive" -> SubgroupGenerated[G, g, Mode->Interactive, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Subgroup generated by "<>ToString[g]<>" in "<>GroupoidName[G], Top]

SubgroupGenerated[G_?GroupoidQ, H_List] :=
	Map[SubgroupGenerated[G,#]&, H]/;SubsetQAA[H,Elements[G]]

SubgroupGenerated[G_?GroupoidQ, H_List, Mode -> mode_, opts___?OptionQ] :=
	Column[Map[SubgroupGenerated[G,#, Mode->mode, opts]&, H]]/;SubsetQAA[H,Elements[G]]

(* The above doesn't work. Why? *)

SubgroupGeneratedTextual[g_,G_,list_, opts___?OptionQ] := 
	Module[{opsy = OperatorSymbol[G], inlen,nS,len,heldlist,
		nlist,S=Elements[G],op= Operation[G], text, tab, more, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	If[list =!=$Failed,
	text = StringJoin["Given a group G and an element g \[Element] G, the subgroup generated by g, denoted <g>, is the set of all powers (multiples when expressed additively) of g in G. The group ",StructureName[G], " has the subgroup <",ToString[g, TraditionalForm],"> given as:\n"];
	len = Length[list];
	heldlist = makeHeldList[g,G,len];
	nlist = Map[KeyForm[G], NestList[(op[g,#])&,g,len-1]];
	tab = Grid[Prepend[Transpose[{Range[len],heldlist,nlist}],{Item["index",Background -> GrayLevel[0.8]],Switch[opsy,
			"+",Item["multiples",Background -> GrayLevel[0.8]],_,Item["powers",Background -> GrayLevel[0.8]]],
			Item["simplified",Background -> GrayLevel[0.8]]}],Frame->All];
	tab = headingsGrid[Transpose[{Range[len],heldlist,nlist}],{"index",Switch[opsy,
			"+","multiples",_,"powers"], "simplified"}];
	more = Grid[{Prepend[UnionNoSort[list],Item["as generated:",Background -> GrayLevel[0.8]]],
		Prepend[Union[list],Item["sorted:",Background -> GrayLevel[0.8]]]},Frame->All];
	more = headingsGrid[{UnionNoSort[list],Union[list]},{"as generated:","sorted:"},Left];
	If[showconvert,Column[{text,tab,more, MakeComputationalButton[cm]},Center],Column[{text,tab,more}]],$Failed]]

SubgroupGeneratedVisual[g_,G_,genlist_, opts___] := 
	Module[{i,n,m,pos,ds,allpos,newcrds,thelines,orderlist,
		growPtsGr = {},growLblGr = {},nwlist,genpos, wide, els2,
		op = Operation[G],S = Elements[G],heldlist, gr, key="", output,showkey},
	output = Output/.Flatten[{opts}];
	wide=WideElementsQ[G];
	showkey = showkeyQ[G, opts];
If[genlist=!=$Failed,
	If[wide, 
		key = TextCayleyKey[S,
			StructureName[G],G, KeyForm[G], "g"], key= " "];
	m = Length[genlist];
	heldlist = makeHeldList[g,G,m];
	n = Length[S];
	genpos = Map[Position[S,#,1]&,genlist]//Flatten;
	ds = .05/m;
	newcrds = Part[ngonCoordsC[n],genpos];
	thelines = {};
	allpos ={};
	orderlist = {genlist,Take[heldlist,Length[genlist]]}//
		Transpose//Sort//Transpose//Last;
	If[wide, els2 = Map[ElementToKey[G,#]&,S];
		heldlist = Table["("<>ElementToKey[G,g]<>")^"<>ToString[k],
			{k,1,Length[heldlist]}], els2 = S];
	nwlist = heldlist;
	pos = First[genpos];
	AppendTo[growPtsGr, ngonDot[pos,n,OtherColors[[3]],.03]];
	AppendTo[growLblGr, ptLabeling[newcrds[[1]],
		nwlist[[1]]//OutStdForm]];
	gr[1] = Show[{modCircle[n],
			LabelingNgon[els2, els2,
			insideLabelFactor, If[wide,SequenceForm,
				KeyForm[G]]],
			growPtsGr, growLblGr}, PlotRange->{{-1.5,1.5},{-1.5,1.5}}, DisplayFunction -> Identity];
	Do[If[i>1,AppendTo[thelines,
		Line[{newcrds[[i]],newcrds[[i-1]]}]]];
		If[i==m,AppendTo[thelines,
		Line[{newcrds[[1]],newcrds[[m]]}]]];
		pos = genpos[[i]];
		AppendTo[growPtsGr,ngonDot[pos,
			n,OtherColors[[3]],.03 +(i-1)ds]];
		AppendTo[growLblGr, ptLabeling[newcrds[[i]],
			nwlist[[i]]//OutStdForm]];
		gr[i] = Show[{modCircle[n],
			LabelingNgon[els2, els2,
			insideLabelFactor, If[wide,SequenceForm,
				KeyForm[G]]],
			If[i>1,Graphics[{OtherColors[[4]],thelines}]],
			growPtsGr,growLblGr},PlotRange->{{-1.5,1.5},{-1.5,1.5}}]
		,{i,2,m}];
		Manipulate[Labeled[Show[gr[i]],Style[key,Smaller],Bottom], 
				{{i, 1,"power (multiple) of element"}, 1, m, 1, Appearance->"Open"}]
		(* removed semicolon; changed Do to Manipulate and tweaked labeling 7/10/08
		m (upper bound) was changed to Length[S], i.e., size of group
		 *)
	]]

makeHeldList[g_,G_,n_] := Module[{opsy = OperatorSymbol[G]},
	Switch[opsy,"+",
		Map[StringJoin[ToString[#],"*",ToString[g]]&,Range[n]],
			_,
		Map[StringJoin["(",ToString[KeyForm[G][g]],")","^",ToString[#]]&,Range[n]]]
	]



SubgroupGeneratedVisual2[G_, g_, opts___?OptionQ] :=SubgroupGeneratedVisual5[G,g,opts]

ChangeGeneratedRow[G_, g_,{otab_,itemTable_},pos_,list_,lenlist_]:= 
	Module[{Els=Elements[G], poslist, 
		k, changedRow, itemTab},
	poslist = Map[Select[Position[otab[[pos]],#],Length[#]==2&]&,list]/.{{1,x_}}:>x;
	changedRow = itemTable[[pos + 1]]//Flatten;
	Do[changedRow[[poslist[[k]] + 1]]=
		(changedRow[[poslist[[k]] + 1]]/.Item[val_,Rule[Background,x_]]
		-> Item[Tooltip[CayleyForm[G][val], 
		If[OperatorSymbol[G]==="+",Style[ToString[k]<>"\[CenterDot]"<>ToString[g],Blue, 25],Style[ToString[g]^k,Blue, 24]]],Rule[Background,Hue[(k-1)/lenlist]]]),{k,1 ,Length[list]}];
	changedRow[[1]]=
		(changedRow[[1]]/.Rule[Background,x_]:>Rule[Background,GrayLevel[0.7]]);
	itemTab = itemTable;
	itemTab[[First[pos]+1]]= changedRow;
	itemTab
]
(* ChangeGeneratedRow added 7/11/08  and modified 7/14/08
 *)

SubgroupGeneratedVisual5[G_, g_,opts___?OptionQ] :=
	Module[{els = Elements[G], newtab, labels = {1,2},
		pos, powersRow, labeledRow, list, lenlist, key, fullkey="", showkey, cayleyform, wide},
	showkey = showkeyQ[G, opts];
	cayleyform = CayleyForm/.Flatten[{opts, Options[SubgroupQ]}];
	wide = WideElementsQ[G];
	If[!wide && showkey, wide = True];
	If[wide && showkey,
		fullkey = TextCayleyKey[els,StructureName[G],G, KeyForm[G]]];
	pos = Select[Position[els,g],Length[#]==1&]//Flatten;
	list = SubgroupGeneratedWork[g,G];
	lenlist = Length[list];
	newtab=ChangeGeneratedRow[G, g,WhiteCayleyGrid[G],pos, list, lenlist];
	If[wide,newtab = ConvertGridToKeyed[G,newtab]];
	If[cayleyform =!=StandardForm && MemberQ[{FullForm,MatrixForm,InputForm,TraditionalForm,OutputForm},cayleyform],
		pos = Flatten[Delete[Table[{i,j},{i,len+1},{j,len+1}],{1,1}],1];
		newtab = MapAt[ChangeItemCayleyForm[#,cayleyform]&,newtab,pos]];
	labeledRow = Prepend[Table[Item[k,Background->White],{k,1,lenlist}],"n"];
	powersRow = Prepend[Table[Item[Tooltip[CayleyForm[G][list[[k]]],
		If[OperatorSymbol[G]==="+",Style[ToString[k]<>"\[CenterDot]"<>ToString[g],Blue, 25],Style[ToString[g,TraditionalForm]^k,Blue, 24]]],
		Background->Hue[(k-1)/lenlist] ],{k,1,lenlist}],If[OperatorSymbol[G]==="+","n\[CenterDot]"<>ToString[g],Superscript[ToString[g,TraditionalForm],"n"]]];
	If[wide,labeledRow = ConvertGridToKeyed[G,labeledRow]];
	If[wide,powersRow = ConvertGridToKeyed[G,powersRow]];
	key = Panel@Column[{Grid[{labeledRow,powersRow},ItemSize->All, BaseStyle->Small],fullkey}];
	Column[{Panel[Grid[newtab,Dividers->{{1,2->Thickness[4]},{1,2->Thickness[4]}},ItemSize->All],{" "," "},
{Left,Top}],key},Center]
		]

(* phase out the one below *)
SubgroupGeneratedVisual5[G_, g_, heading_List] :=
	Module[{els = Elements[G], newtab, labels = {1,2},
		pos, powersRow, labeledRow, list, lenlist, key, fullkey=""},
	If[WideElementsQ[G],
		fullkey = TextCayleyKey[els,StructureName[G],G, KeyForm[G]]];
	pos = Select[Position[els,g],Length[#]==1&]//Flatten;
	list = SubgroupGeneratedWork[g,G];
	lenlist = Length[list];
	newtab=ChangeGeneratedRow[G, g,WhiteCayleyGrid[G],pos, list, lenlist];
	labeledRow = Prepend[Table[Item[k,Background->White],{k,1,lenlist}],"n"];
	powersRow = Prepend[Table[Item[Tooltip[CayleyForm[G][list[[k]]],
		If[OperatorSymbol[G]==="+",Style[ToString[k]<>"\[CenterDot]"<>ToString[g],Blue, 25],Style[ToString[g]^k,Blue, 24]]],
		Background->Hue[(k-1)/lenlist] ],{k,1,lenlist}],If[OperatorSymbol[G]==="+","n\[CenterDot]"<>ToString[g],Superscript[ToString[g],"n"]]];
	key = Column[{Grid[{labeledRow,powersRow},ItemSize->All,BaseStyle->Small],fullkey}];
	labels[[1]]=heading;
	labels[[2]]={Top};
	Column[{Labeled[Panel[Grid[newtab,Dividers->{{1,2->Thickness[4]},{1,2->Thickness[4]}},ItemSize->All],{" "," "},
{Left,Top}],(Sequence@@labels)], key},Center]
		]

coloredSquares[g_,G_,list_,n_] := Module[{pos, x, coloredRects={},
		S = Elements[G],poslist,i,lenlist, 
		tab = makeTable[G, Elements[G]]},
	pos = Select[Position[S,g],Length[#]==1&]//Flatten;
	lenlist = Length[list];
	poslist = Map[Select[Position[tab[[pos]],#],Length[#]==2&]&,list]/.
		{{1,x_}}:>x;
	row = Flatten[basicCayley[G,S][[3]][[pos]],1];
	Do[AppendTo[coloredRects, {Hue[(i-1)/n],
		row[[poslist[[i]]]]}],{i, lenlist}];
	Flatten[coloredRects]]




(* ::Section:: *)
(* 32. Order*)


(* ::Subsection::Closed:: *)
(* 32.1 General*)


Size[G_?StructuredSetQ]:=Size[G]=Length[Elements[G]]

Size[G_?StructuredSetQ,Mode->mode_]:=Size[G]=(Message[Mode::"notavail",Size,mode];Length[Elements[G]])

Unprotect[Order];

groupoid/:Order[G_groupoid]:=Size[G];

ringoid/:Order[G_ringoid]:=Size[G];

groupoid/:Order[G_groupoid,Mode->mode_]:=Size[G,Mode->mode];

ringoid/:Order[G_ringoid,Mode->mode_]:=Size[G,Mode->mode];

Order[many:{_groupoid..}]:=Size/@many

Order[many:{_ringoid..}]:=Size/@many

Protect[Order];

Size[many:{_?StructuredSetQ..}]:=Size/@many


(* ::Subsection:: *)
(* 32.2 Order of an Element*)


Options[OrderOfElement]={Mode->Computational};

OrderOfElement[G_?GroupoidQ, g_, Mode->Computational, opts___?OptionQ]:=
	If[MemberQ[Elements[G],g],OrderOfElementWork[G,g],
		If[SubsetQAA[g,Elements[G]],Map[OrderOfElementWork[G,#]&,g],
		Message[MemberQ::elsbst,g,G];$Failed]]
	
OrderOfElement[G_?GroupoidQ,g_]:=
	If[MemberQ[Elements[G],g],OrderOfElementWork[G,g],
		If[SubsetQAA[g,Elements[G]],Map[OrderOfElementWork[G,#]&,g],
		Message[MemberQ::elsbst,g,G];$Failed]]

OrderOfElementWork[G_?GroupoidQ,g_]:=
Module[{id,ord=$Failed,len},
If[ClosedQAndIdentityQ[G],
	id=GroupIdentity[G];
	len=Length[Elements[G]];
	ord=If[g===id,1,
		Length[FixedPointList[Operation[G][g,#]&,g,len,SameTest->((#2===id)&)]]//If[#==len+1,$Failed,#]&],$Failed];
ord]


OrderOfElement[G_?GroupoidQ, g_, Mode->Textual, opts___?OptionQ]:=  Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	If[MemberQ[Elements[G],g],text=OrderOfElementTextualGD[G]<>OrderOfElementTextualLI[G,g];
		If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text],
		If[SubsetQAA[g,Elements[G]],Column[Map[OrderOfElement[G,#,Mode->Textual, opts]&,g]],
		Message[MemberQ::elsbst,g,G];$Failed]]]

OrderOfElementTextualGD[_]:="Given an element g in a Groupoid G, the order of the element is the minimum (positive) integer n such that \!\(\*SuperscriptBox[\"g\", \"n\"]\) (n\[ThinSpace]g for an additive group) is the identity element.\n"

OrderOfElementTextualLI[G_,g_]:=
	Module[{temp},
	StringJoin["In ",GroupoidName[G],", the order of ",ToString[g],
	" is ",ToString[temp=OrderOfElementWork[G,g],StandardForm],
". The table below shows the increasing "<>If[OperatorSymbol[G]==="+","multiples","powers"]<>" until the identity is reached.\n",
ToString[headingsGrid[{Range[1,temp],AbstractAlgebra`Master`Private`SubgroupGeneratedWork[g,G]},
	{"n", If[OperatorSymbol[G]==="+","n\[CenterDot]g","\!\(\*SuperscriptBox[\"g\", \"n\"]\)"]}, Left],
TraditionalForm]]]

OrderOfElement[G_?GroupoidQ, g_, Mode->Visual, opts___?OptionQ]:=
	If[MemberQ[Elements[G],g],
		DoVisualization[SubgroupGeneratedVisual5[G,g, opts], {{G,g,OrderOfElementWork[G,g]},OrderOfElementHelp},opts],
		If[SubsetQAA[g,Elements[G]],Column[Map[OrderOfElement[G,#,Mode->Visual]&,g]],
		Message[MemberQ::elsbst,g,G];$Failed]]

OrderOfElementHelp[G_,g_,ord_]:= DoHelpMessage[windowtitle -> "Help for the order of an element in "<>GroupoidName[G], 
	help -> List["This table shows all the "<>
		If[OperatorSymbol[G]==="+","multiples","powers"]<>
		" of ",
		Cell[BoxData[ToBoxes[g,TraditionalForm]], FormatType->"TraditionalForm"],
		" in "<>GroupoidName[G]<>
		". Use the key at the bottom to determine the color and value of the nth power. Note that the last "<>If[OperatorSymbol[G]==="+","multiple","power"]<>" (exponent of "<>ToString[ord]<>") returns the identity of the group. Thus, the order of the element in this group is then "<>ToString[ord]<>"."]
]

OrderOfElement[G_?GroupoidQ, g_, Mode -> Interactive, InteractiveMode->mode_, opts___?OptionQ]:=
	Manipulate[OrderOfElement[G, h, Mode -> mode, opts],{{h, g, "g \[Element] G"}, Elements[G]},
		ControlType -> RadioButtonBar]

OrderOfElement[G_?GroupoidQ, g_, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		OrderOfElement[G, g, Mode->Interactive, InteractiveMode -> Computational, opts],
	"Explanation" -> OrderOfElement[G,g,Mode->Interactive, InteractiveMode -> Textual,ShowConvert -> False,opts],
	"Visualization" -> OrderOfElement[G,g, Mode->Interactive, InteractiveMode -> Visual,ShowConvert -> False,opts]}, 
	ImageSize->Automatic],"Interacting with OrderOfElement[G, g]", Top]

OrderOfElement[G_?GroupoidQ, g_, Mode->All, opts___?OptionQ]:=
	If[MemberQ[Elements[G],g],OrderOfElementAll[G,g,Mode->All],
		If[SubsetQAA[g,Elements[G]],Column[Map[OrderOfElementAll[G,#,Mode->All, opts]&,g]],
		Message[MemberQ::elsbst,g,G];$Failed]]

OrderOfElementAll[G_?GroupoidQ, g_, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> OrderOfElement[G, g],
	"Explanation" -> OrderOfElement[G, g, Mode->Textual, ConvertMode -> "All" ,opts],
	"Visualization" -> OrderOfElement[G, g, Mode->Visual, ConvertMode -> "All" ,opts],
	"Interactive" -> OrderOfElement[G, g,Mode->Interactive, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Order of "<>ToString[g]<>" in "<>GroupoidName[G], Top]


OrderOfElement[G_?GroupoidQ, many_List, Mode->mode_, opts___?OptionQ]:=
	Column[Map[OrderOfElement[G,#,Mode->mode, opts]&,many]]/;SubsetQAA[many,Elements[G]]

GoodPairsGroupsElements[lst_List]:= Apply[And,Map[MemberQ[Elements[First[#]],Last[#]]&,lst]]

OrderOfElement[many:{_List..}]:=
	Map[OrderOfElement[First[#],Last[#]]&,many]/;GoodPairsGroupsElements[many]

OrderOfElement[many:{_List..}, Mode->mode_, opts___?OptionQ]:=
	Column[Map[OrderOfElement[First[#],Last[#],Mode->mode,opts]&,many]]/;GoodPairsGroupsElements[many]

OrderOfElement[G_?GroupoidQ,g_,opts___?OptionQ]/;!MemberQ[Elements[G],g]:=(Message[MemberQ::elmnt,g,StructureName[G]];$Failed)

OrderOfElement[many:{_List..},Mode->mode_]/;!GoodPairsGroupsElements[many]:=
Message[OrderOfElement::badpairs]

OrderOfElement[G_,g_,opts___?OptionQ]:=(Message[Groupoid::fail,StructureName[G]];$Failed)



Unprotect[Order];

groupoid/:Order[G_groupoid,g_,opts___?OptionQ]:=OrderOfElement[G,g,opts];

Order[many_?MatrixQ,opts___?OptionQ]:=OrderOfElement[many,opts];

Protect[Order];


(* ::Subsection:: *)
(* 32.3 Order of all Elements*)


Orders[G_?GroupoidQ, opts___?OptionQ] := OrderOfAllElements[G, opts]

Orders[many:{_?GroupoidQ..}, opts___?OptionQ] :=
	OrderOfAllElements[many, opts]

Orders[G_?GroupoidQ, many_, opts___?OptionQ] :=
	If[SubsetQAA[many,Elements[G]], 
		Transpose[{many, OrderOfElement[G, many, opts]}],
		If[ElementQ[many, G], 
			{many, OrderOfElement[G, many, opts]},
			$Failed]]
			
Orders[many:{_List..}] :=
	Map[Orders, many]
		
Orders[many:{_List..},Mode -> mode_, opts___?OptionQ] :=
	Column@Map[Orders[#,Mode -> mode, opts]&, many]

Options[OrderOfAllElements]={Mode -> Computational};

OrderOfAllElements[G_?GroupoidQ] := OrderOfAllElements[G] = 
	Transpose[{Elements[G],
		Map[Length[SubgroupGeneratedWork[#,G]]&,
			Elements[G]]}]

OrderOfAllElements[G_?GroupoidQ, Mode->Computational, opts___?OptionQ]:= OrderOfAllElements[G]

OrderOfAllElements[G_?GroupoidQ, Mode->Textual, opts___?OptionQ]:=
	OrderOfAllElementsTextual[G,OrderOfAllElements[G], opts]

OrderOfAllElements[G_?GroupoidQ, Mode->Visual, opts___?OptionQ]:=
	OrderOfAllElementsVisual[G, opts]

OrderOfAllElements[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	If[InteractiveThroughGroups[OrderOfAllElements, G, InteractiveMode->Computational, opts]===$Failed,
		Labeled[TabView[{"Computation" -> OrderOfAllElements[G],
	"Explanation" -> OrderOfAllElements[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> OrderOfAllElements[G, Mode->Visual, ConvertMode -> "All",opts]}, 
	ImageSize->Automatic],"Order of all elements in "<>GroupoidName[G], Top],
		Labeled[TabView[{"Computation" -> OrderOfAllElements[G],
	"Explanation" -> OrderOfAllElements[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> OrderOfAllElements[G, Mode->Visual, ConvertMode -> "All",opts],
	"Interactive" -> OrderOfAllElements[G, Mode->Interactive, ShowConvert -> False,opts]}, 
	ImageSize->Automatic],"Order of all elements in "<>GroupoidName[G], Top]
]	

OrderOfAllElements[G_?GroupoidQ, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		InteractiveThroughGroups[OrderOfAllElements, G, InteractiveMode->Computational, opts],
	"Explanation" -> InteractiveThroughGroups[OrderOfAllElements, G, InteractiveMode->Textual, ShowConvert -> False, opts],
	"Visualization" -> InteractiveThroughGroups[OrderOfAllElements, G, InteractiveMode->Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with OrderOfAllElements[G]", Top]

OrderOfAllElements[many:{_?GroupoidQ..}] :=
	Map[OrderOfAllElements, many]
	
OrderOfAllElements[many:{_?GroupoidQ..}, Mode -> mode_, opts___?OptionQ] :=
	Column@Map[OrderOfAllElements[#, Mode -> mode, opts]&, many]

OrderOfAllElementsComputational[G_] := (
	Transpose[{Elements[G],
		Map[Length[SubgroupGeneratedWork[#,G]]&,
			Elements[G]]}])

OrderOfAllElementsTextual[G_,orders_, opts___?OptionQ] := 
		Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	If[showconvert,
		Column[{OrderOfAllElementsTextualGD[G],OrderOfAllElementsTextualLI[G,orders],MakeComputationalButton[cm]},Center],
		Column[{OrderOfAllElementsTextualGD[G],OrderOfAllElementsTextualLI[G,orders]},Center]] 
		]

OrderOfAllElementsTextualGD[_] := "Given a Groupoid G, we can consider the order of all the elements in the group. See \"OrderOfElement\" for details about this. The table below illustrates each element and its order."

OrderOfAllElementsTextualLI[G_,orders_] := 
	headingsGrid[orders,{"element","order"}]

OrderOfAllElementsVisual[G_, opts___?OptionQ] := 
	DoVisualization[CyclicSubgroupsVisualGrid[G,CyclicSubgroupsWork[G],opts],{{G},OrderOfAllElementsHelp},opts]

OrderOfAllElementsHelp[G_]:= DoHelpMessage[windowtitle -> "Help for the order of all elements in "<>GroupoidName[G], 
	help ->List["This table shows all the "<>
		If[OperatorSymbol[G]==="+","multiples","powers"]<>
		" of each element in "
		<>GroupoidName[G]<>
		". Use the key at the bottom to determine the color and value of the nth power. Note that the count of the colored elements in a given row (the subgroup generated by the element in the first column) is the order of this element. Also, note that by holding the mouse over a colored element in the Cayley table, one can view the ",
		If[OperatorSymbol[G]==="+"," multiple ("," power ("],
		If[OperatorSymbol[G]==="+", Cell[BoxData[
 FormBox[
  RowBox[{"n", "\[CenterDot]", "g"}], TraditionalForm]],
 FormatType->"TraditionalForm"],Cell[BoxData[
 FormBox[
  SuperscriptBox["g", "n"], TraditionalForm]],
 FormatType->"TraditionalForm"]],
		") of the generating element ",
		Cell[BoxData[
 FormBox["g", TraditionalForm]],
 FormatType->"TraditionalForm"]," in that row."]]

Options[OrderOfAllElementsVisual2]={DisplayFunction -> $DisplayFunction};

OrderOfAllElementsVisual2[G_,opts___] := Module[{len,gr,
		i, ga,El = Elements[G],
		showopts = FilterRules[{opts},Options[Graphics]],
		df = DisplayFunction/.Flatten[{opts, Options[OrderOfAllElementsVisual2]}]},
	len = Length[El];
	Do[gr[i] = OrderOfElement[G,El[[i]],Mode -> Visual],{i,len}];
	ga = Partition[Array[gr,len],3];
	If[Mod[len,3]==1,AppendTo[ga,{gr[len],
		Graphics[{White,Point[{0,0}]}],
		Graphics[{White,Point[{0,0}]}]}]];
	If[Mod[len,3]==2,AppendTo[ga,{gr[len-1],gr[len],
		Graphics[{White,Point[{0,0}]}]}]];
	Show[GraphicsArray[ga],showopts,DisplayFunction -> df]]


(* ::Section:: *)
(* 34. Commutators*)


abelianQ[G_?GroupoidQ] := abelianQ[G] = Module[{
		t = makeTable[G,Elements[G]]},
	t === Transpose[t]]
	
Options[Commutator]={Mode -> Computational};

Commutator[G_?abelianQ, x_, y_]/; SubsetQAA[{x,y},Elements[G]] := GroupIdentity[G]

(* Commutator[G_?GroupoidQ, x_, y_]/; SubsetQAA[{x,y},Elements[G]] := 
	Operation[G][Operation[G][x,y],LeftInverse[G,Operation[G][y,x]]]*)

Commutator[G_?GroupoidQ, x_, y_] := 
	CommutatorComputational[G,x,y]/; SubsetQAA[{x,y},Elements[G]]

CommutatorComputational[G_,x_,y_] := Module[{op = 
		Operation[G]},
	op[LeftInverse[G,op[y,x]],op[x,y]]]

Commutator[G_?GroupoidQ, x_, y_]/; !SubsetQAA[{x,y},Elements[G]] :=
(Message[MemberQ::elmnts,{x,y},StructureName[G]]; $Failed)

Options[Commutators] = {Mode -> Computational};

Commutators[G_?abelianQ] := {GroupIdentity[G]}

Commutators[G_?GroupoidQ] := CommutatorsComputational[G]

Commutators[G_?GroupoidQ, Mode->Visual, opts___?OptionQ] := 
	DoVisualization[NewCommutatorsVisual[G, opts],{{G,Length[CommutatorsComputational[G]]},CommutatorsHelp},opts]

Commutators[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	If[InteractiveThroughGroups[Commutators, G, InteractiveMode->Computational, opts]===$Failed,
		Labeled[TabView[{"Computation" -> Commutators[G],
	"Explanation" -> Commutators[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> Commutators[G, Mode->Visual, ConvertMode -> "All",opts]}, 
	ImageSize->Automatic],"Commutators of "<>GroupoidName[G], Top],
		Labeled[TabView[{"Computation" -> Commutators[G],
	"Explanation" -> Commutators[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> Commutators[G, Mode->Visual, ConvertMode -> "All",opts],
	"Interactive" -> Commutators[G, Mode->Interactive, ShowConvert -> False,opts]}, 
	ImageSize->Automatic],"Commutators of "<>GroupoidName[G], Top]
]	

Commutators[G_?GroupoidQ, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		InteractiveThroughGroups[Commutators, G, InteractiveMode->Computational, opts],
	"Explanation" -> InteractiveThroughGroups[Commutators, G, InteractiveMode->Textual, ShowConvert -> False, opts],
	"Visualization" -> InteractiveThroughGroups[Commutators, G, InteractiveMode->Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with Commutators[G]", Top]

Commutators[G_?GroupoidQ, Mode -> Visual, Version -> 5] := CommutatorsVisual[G]

Commutators[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ] := CommutatorsTextual[G, opts]

Commutators[G_?GroupoidQ, Mode -> Computational, opts___?OptionQ] := CommutatorsComputational[G]

CommutatorsComputational[G_] := Module[{els=Elements[G],x,y,n},
	n = Length[els];
	Flatten[Table[CommutatorComputational[G,els[[x]],
		els[[y]]], {x,1,n},{y,1,n}],1]//Union];

CommutatorsTextual[G_, opts___?OptionQ]:=  Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	text = "Given a Groupoid G, the set of commutators of G is the set of all elements of the form x y \!\(\*SuperscriptBox[\"x\", 
RowBox[{\"-\", \"1\"}]]\) \!\(\*SuperscriptBox[\"y\", 
RowBox[{\"-\", \"1\"}]]\) for all x and y in G. In our case, "<>GroupoidName[G]<>" has the following set of commutators:\n"<>ToString[CommutatorsComputational[G],TraditionalForm];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]

Options[CommutatorsVisual] = {DisplayFunction -> $DisplayFunction};

CommutatorsVisual[G_,opts___?OptionQ] := 
	Module[{els = Elements[G], rects,keyRects, crects,
		gColoredRects, gText, gLines, comms,n,reducedcomms,
		moretext,lev,rulelist, tab,
		showopts = FilterRules[{opts},Options[Graphics]]},
	n = Length[els];
	tab = Flatten[Table[{Commutator[G,els[[i]], els[[j]]],{els[[i]], els[[j]]}},{i,n},
		{j,n}],1];
	reducedcomms = Union[First[Transpose[tab]]];
	lev = Length[reducedcomms];
	rulelist = Table[Rule[reducedcomms[[i]],
		myColorList[[i]]],{i,lev}];
	keyRects = Join[Table[{myColorList[[i]],
		Rectangle[{0, -i}, {1, -i+1}]},{i,lev}],
		Transpose[{Table[myColorList[[i]],{i,lev}],
			headingsRectanglesForSublist[els,reducedcomms]}]];
	moretext = Table[Text[ToString[reducedcomms[[i]]//KeyForm[G]],
		{1.5,-i+.5},{-1,0}],{i,lev}];
	If[WideElementsQ[G],
		moretext = Join[moretext, Table[Text[genericSublist[els, 
		reducedcomms][[i]],{-0.4,-i+.5}],{i,lev}]]];
	{gLines, gText,rects} = basicCayley[G,els,
		ShowBodyText -> False, CayleyForm -> CayleyForm[G]];
	crects = ColorTableSquares[G,els,
		Last[Transpose[tab]], First[Transpose[tab]]/.rulelist];
	gColoredRects = Show[Graphics[{crects,keyRects,moretext},
		DisplayFunction -> Identity]];
	If[WideElementsQ[G],
		PrintCayleyKey[els,StructureName[G],G, KeyForm[G]]];
	Show[{gColoredRects, gLines, gText},showopts,
		DisplayFunction -> df]
	]

NewCommutatorsVisual[G_, opts___?OptionQ]:= Module[{origTab, itemTab, els = Elements[G],
	powersRow, labeledRow,key, labels = {1,2},len,tab, n, j, i,reducedcomms,
	lev, rulelist, temp, temphead, firstrow, firstcolumn, rest, showkey, grid, wide},
	{origTab,itemTab} = WhiteCayleyGrid[G];
	n = Length[els];
	showkey = showkeyQ[G, opts];
	wide = WideElementsQ[G];
	If[!wide && showkey, wide=True];
	tab = Table[Commutator[G,els[[i]], els[[j]]],{i,n}, {j,n}];
	firstrow =itemTab[[1]];
	firstcolumn = Transpose[itemTab]//First//Rest;
	rest = Take[itemTab,{2,n+1},{2,n+1}];
	temp=MapThread[temphead,{rest,tab},2];
	reducedcomms = Union[Flatten[tab,1]];
	lev = Length[reducedcomms];
	rulelist = Table[Rule[reducedcomms[[i]],Item[" ",Background-> myColorList[[i]]]],{i,lev}];
	itemTab = tab/.rulelist;
	rulelist = Table[Rule[Item[StandardForm[reducedcomms[[i]]],Background->a_],Item[StandardForm[reducedcomms[[i]]],Background-> AbstractAlgebra`Master`Private`myColorList[[i]]]],{i,lev}];
	key = Grid[{Rest[firstrow]}/.rulelist,Frame->All,ItemSize->All,BaseStyle->Small];
	If[showkey||wide,firstrow = ConvertGridToKeyed[G,firstrow]];
	If[showkey||wide,firstcolumn = ConvertGridToKeyed[G,firstcolumn]];
	itemTab = Prepend[Transpose[itemTab],firstcolumn]//Transpose;
	itemTab = Prepend[itemTab,firstrow];
	grid = Panel[Grid[itemTab,Dividers->{{1,2->Thickness[4]},{1,2->Thickness[4]}},
		ItemSize->All],{"x","y"},{Left,Top}];
	If[showkey||wide,key = ConvertGridToKeyed[G,key]];
	If[showkey,Column[{grid, key,TextCayleyKey[els,GroupoidName[G],G,StandardForm]}, Center], 
		Column[{grid, key}, Center]]
]

CommutatorsHelp[G_,numcomm_]:= DoHelpMessage[windowtitle -> "Help for the commutators of "<>GroupoidName[G], 
	help -> List["This table shows all the commutators in "<>GroupoidName[G]<>
		". Use the key at the bottom: each element in the group that is colored is one of the "<>
		ToString[numcomm]<>" commutators."<>
		" By considering elements ",
	Cell[BoxData[FormBox["g", TraditionalForm]], FormatType->"TraditionalForm"],
" and ",
Cell[BoxData[FormBox["h", TraditionalForm]], FormatType->"TraditionalForm"],
" in the group, with ",
	Cell[BoxData[FormBox["g", TraditionalForm]], FormatType->"TraditionalForm"],
" heading row ",
Cell[BoxData[FormBox["r", TraditionalForm]], FormatType->"TraditionalForm"],
" and ",
Cell[BoxData[FormBox["h", TraditionalForm]], FormatType->"TraditionalForm"],
" heading column ",
Cell[BoxData[FormBox["c", TraditionalForm]], FormatType->"TraditionalForm"],
", the commutator of ",
Cell[BoxData[FormBox["g", TraditionalForm]], FormatType->"TraditionalForm"],
" and ",
Cell[BoxData[FormBox["h", TraditionalForm]], FormatType->"TraditionalForm"],
" is indicated by observing the color where row ",
Cell[BoxData[FormBox["r", TraditionalForm]], FormatType->"TraditionalForm"],
" and column ",
Cell[BoxData[FormBox["c", TraditionalForm]], FormatType->"TraditionalForm"],
" intersect and comparing to the key below."]
]

Options[CommutatorSubgroup]={Mode -> Computational};

CommutatorSubgroup[G_?GroupoidQ] := 
	CommutatorSubgroupComputational[G]

CommutatorSubgroup[G_?GroupoidQ, Mode -> Computational, opts___?OptionQ] := 
	CommutatorSubgroupComputational[G]
	
CommutatorSubgroup[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ] := 
	CommutatorSubgroupVisual[G, Elements[CommutatorSubgroupComputational[G]], opts]

CommutatorSubgroup[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ] := 
	CommutatorSubgroupTextual[G, opts]

CommutatorSubgroup[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	If[InteractiveThroughGroups[CommutatorSubgroup, G, InteractiveMode->Computational, opts]===$Failed,
		Labeled[TabView[{"Computation" -> CommutatorSubgroup[G],
	"Explanation" -> CommutatorSubgroup[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> CommutatorSubgroup[G, Mode->Visual, ConvertMode -> "All",opts]}, 
	ImageSize->Automatic],"Commutator subgroup of "<>GroupoidName[G], Top],
		Labeled[TabView[{"Computation" -> CommutatorSubgroup[G],
	"Explanation" -> CommutatorSubgroup[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> CommutatorSubgroup[G, Mode->Visual, ConvertMode -> "All",opts],
	"Interactive" -> CommutatorSubgroup[G, Mode->Interactive, ShowConvert -> False,opts]}, 
	ImageSize->Automatic],"Commutator subgroup of "<>GroupoidName[G], Top]
]	

CommutatorSubgroup[G_?GroupoidQ, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		InteractiveThroughGroups[CommutatorSubgroup, G, InteractiveMode->Computational, opts],
	"Explanation" -> InteractiveThroughGroups[CommutatorSubgroup, G, InteractiveMode->Textual, ShowConvert -> False, opts],
	"Visualization" -> InteractiveThroughGroups[CommutatorSubgroup, G, InteractiveMode->Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with CommutatorSubgroup[G]", Top]

CommutatorSubgroupComputational[G_]:= Module[{sub},
	sub = GenerateGroupoid[CommutatorsComputational[G],Operation[G]];
	If[ProperSubsetQAA[sub = Elements[sub], Elements[G]],
			FormGroupoid[sub, Operation[G], OperatorSymbol[G],
				GatherSubGroupoidOptions[G]],
			G]]

CommutatorSubgroupTextual[G_, opts___?OptionQ]:=  Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	text = "Given a Groupoid G, the commutator subgroup is the subgroup generated by the set of commutators of G, the set of all elements of the form x y \!\(\*SuperscriptBox[\"x\", 
RowBox[{\"-\", \"1\"}]]\) \!\(\*SuperscriptBox[\"y\", 
RowBox[{\"-\", \"1\"}]]\) for all x and y in G. In our case, "<>GroupoidName[G]<>" has the following commutator subgroup:\n"<>ToString[CommutatorSubgroupComputational[G],TraditionalForm];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]

CommutatorSubgroupVisual[G_,sub_,opts___?OptionQ]:= 
	DoVisualization[SubgroupQVisual5[G, sub, opts],{{G},CommutatorSubgroupHelp},opts]

CommutatorSubgroupHelp[G_]:= DoHelpMessage[windowtitle -> "Help for the commutator subgroup of "<>GroupoidName[G], 
	help -> List["This Cayley table shows the commutator subgroup in "<>GroupoidName[G]<>". The elements colored green are in the commutator subgroup. This is the subgroup that is generated by all the commutators in G."]
]


(* ::Section:: *)
(* 35. AbelianQ*)


CommutativeQ[G_?GroupoidQ] := AbelianQ[G]

CommutativeQ[G_?GroupoidQ,opts__?OptionQ] := AbelianQ[G, opts]

CommutativeQ[many:{_?GroupoidQ..}] := Map[AbelianQ, many]

AbelianQ[many:{_?GroupoidQ..}] := Map[AbelianQ, many]

CommutativeQ[many:{_?GroupoidQ..}, Mode -> mode_, opts___?OptionQ] :=
	Map[AbelianQ[#, Mode->mode, opts]&, many]
	
AbelianQ[many:{_?GroupoidQ..}, Mode -> mode_, opts___?OptionQ] :=
	Map[AbelianQ[#, Mode->mode, opts]&, many]
	
Options[AbelianQ]={Mode -> Computational};
		
AbelianQ[G_?GroupoidQ] := AbelianQ[G] = Module[{
		t = makeTable[G,Elements[G]]},
	t === Transpose[t]]

AbelianQ[G_?GroupoidQ, Mode -> Computational, opts___?OptionQ]:= AbelianQ[G]

AbelianQ[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ]:= AbelianQTextual[G, opts]

AbelianQ[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ]:= 
	DoVisualization[AbelianQVisual[G, opts],{{G},AbelianQHelp},opts]

AbelianQ[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	If[InteractiveThroughGroups[AbelianQ, G, InteractiveMode->Computational, opts]===$Failed,
		Labeled[TabView[{"Computation" -> AbelianQ[G],
	"Explanation" -> AbelianQ[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> AbelianQ[G, Mode->Visual, ConvertMode -> "All",opts]}, 
	ImageSize->Automatic],"Is "<>GroupoidName[G]<>" Abelian?", Top],
		Labeled[TabView[{"Computation" -> AbelianQ[G],
	"Explanation" -> AbelianQ[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> AbelianQ[G, Mode->Visual, ConvertMode -> "All",opts],
	"Interactive" -> AbelianQ[G, Mode->Interactive, ShowConvert -> False,opts]}, 
	ImageSize->Automatic],"Is "<>GroupoidName[G]<>" Abelian?", Top]
]	

AbelianQ[G_?GroupoidQ, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		InteractiveThroughGroups[AbelianQ, G, InteractiveMode->Computational, opts],
	"Explanation" -> InteractiveThroughGroups[AbelianQ, G, InteractiveMode->Textual, ShowConvert -> False, opts],
	"Visualization" -> InteractiveThroughGroups[AbelianQ, G, InteractiveMode->Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with AbelianQ[G]", Top]


Options[AbelianQInteractive]={Min -> 2, Max -> 50};


(* AbelianQ[G_, Mode -> Interactive, InteractiveMode->mode_, opts___?OptionQ]:=
	Module[{min, max,showhelp,nm, index="Al", info},
	info = GroupoidNameToInfo[GroupoidName[G]];
	If[Length[info]===2,{nm,index}=info,nm=info];
If[Head[index] === Integer && index > 0,
	min = Min/.Flatten[{opts, Options[AbelianQInteractive]}];
	max = Max/.Flatten[{opts, Options[AbelianQInteractive]}];
	showhelp = ShowHelp/.Flatten[{opts, Options[HelpMessages]}];
	If[mode===Visual || mode===Textual,
		Manipulate[AbelianQ[ToExpression[nm<>"["<>ToString[k]<>"]"], Mode -> mode, ShowHelp->showhelp, opts],{{k, index, "n"}, min, max, 1,
	Appearance->"Open"}],
		Manipulate[AbelianQ[ToExpression[nm<>"["<>ToString[k]<>"]"], Mode -> mode],{{k, index, "n"}, min, max, 1,
	Appearance->"Open"}]],
$Failed]
] *)

AbelianQHelp[G_]:=  DoHelpMessage[windowtitle -> "Help for the commutativity of "<>GroupoidName[G], 
	help -> List["A group is Abelian if ",
Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"g", "\[InvisibleSpace]", "h"}], "=", 
    RowBox[{"h", "\[InvisibleSpace]", "g"}]}], TraditionalForm]],
  FormatType->"TraditionalForm"],
 " (or, if additve, ",
Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"g", " ", "+", " ", "h"}], " ", "=", " ", 
    RowBox[{"h", " ", "+", " ", "g"}]}], TraditionalForm]],
  FormatType->"TraditionalForm"],
") for all elements. This will be indicated in the Cayley table by considerng symmetry across the NW to SE diagonal. If there is symmetry across this line, the group is Abelian. In the table, elements with a white background commute while those with a red background do not commute."]
]

AbelianQVisual[G_,opts___?OptionQ] := Module[{g1,g2,g3,nc,
	showopts = FilterRules[{opts},Options[Graphics]],showkey, wide, gr},
	{g1,g2,g3} = basicCayley[G,Elements[G], CayleyForm -> CayleyForm[G]];
	nc = NonCommutingPairs[G];
	showkey = showkeyQ[G, opts];
	wide = WideElementsQ[G];
	nc = Join[nc, Map[Reverse,nc]]//Union;
	(*Print["White elements commute while red ones do not."];Added 061116*)
	 gr=Show[{Graphics[{{White,g3},MakeAbelianQLines[G],If[nc =!= {}, 
		ColorTableSquares[G,Elements[G],
			nc,RGBColor[1,0,0]], Point[{0,0}]]}],g2,g1},
		showopts];
	If[showkey,Column[{gr,TextCayleyKey[Elements[G],GroupoidName[G],G,StandardForm]}, Center], gr]
]

MakeAbelianQLines[G_] := Module[{n = Length[Elements[G]],lines},
	lines = {OtherColors[[1]],AbsoluteThickness[3], Line[{{0,n},{n,0}}]};
	Join[lines,Table[Line[{{0,i},{n-i,n}}], {i,n-2,0,-1}],
Table[Line[{{i,0},{n,n-i}}], {i,n-2}]]
]

NonCommutingPairs[G_?GroupoidQ] := Module[{els = Elements[G], n, i,j, 
		op = Operation[G],a,b},
	n = Length[els];
	Select[Flatten[Table[{x = els[[i]], y = els[[j]], op[x,y] === op[y,x]},
		{i, 1, n}, {j, i, n}], 1],#[[3]]===False&]/.{a_,b_,False} -> {a,b}]

(* changed x = S[[i]] to x = S[[i,1]] and y = S[[j]] to y = S[[i,2]] 
also changed {i, Length[S]}, {j,i,Length[S]} to simply {i, Length[S]}
Finally, removed Flatten. *)

AbelianQTextual[G_, opts___?OptionQ] := Module[{S = NonCommutingPairs[G],x, text, showconvert,
	y,i,j,	op = Operation[G], first, second = "", cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	first = "We say that a group(oid) G is Abelian (or commutative) if for all g and h in G we have g*h = h*g (with the operation *). "<>If[S==={}, "In this case, all the elements commute.",
		"In this case, the following pairs do NOT commute:\n"];
	second = headingsGrid[Table[x = S[[i,1]]; y = S[[i,2]];
		{x, y, op[x,y], op[y,x], op[x,y] === op[y,x]},
		{i, Length[S]}],{"x","y","x y", "y x","commute?"}];
	If[S==={},
		If[showconvert,Column[{first,MakeComputationalButton[cm]},Center],first],
		If[showconvert,Column[{first,second, MakeComputationalButton[cm]},Center],
			Column[{first,second}]]
]
		]


(* ::Section:: *)
(* 36. Cyclicity of a group*)


Options[CyclicQ]={Mode -> Computational};

CyclicQ[G_?GroupoidQ] := CyclicQ[G] = Module[{done = False, sub,
		els = Elements[G], len,cyc, i=1},
	len = Length[els];
	While[Not[done],
		sub = SubgroupGeneratedWork[els[[i]],G];
		If[sub===$Failed, done = True; cyc = $Failed,
			cyc = (Union[sub] === Union[els]);
			done = (i == len) || cyc;
			i++]];
	{cyclicQ[G], generator[G]} = {cyc,els[[i-1]]};
	cyc]

CyclicQ[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ]:=
	Module[{done = False, sub,
		els = Elements[G], len,cyc, i,mymode,sc},
	len = Length[els];
	i = 1;
	While[Not[done],
		sub = SubgroupGeneratedWork[els[[i]],G];
		cyc = Union[sub] === Union[els];
		done = (i == len) || cyc;
		i++];
	{cyclicQ[G], generator[G]} = {cyc,els[[i-1]]};
	CyclicQTextual[G,generator[G],opts]
	]

CyclicQ[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ]:=
	CyclicQVisual[G, opts]

CyclicQ[G_?GroupoidQ, Mode -> Computational]:=
	CyclicQ[G]

CyclicQ[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	If[InteractiveThroughGroups[CyclicQ, G, InteractiveMode->Computational, opts]===$Failed,
		Labeled[TabView[{"Computation" -> CyclicQ[G],
	"Explanation" -> CyclicQ[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> CyclicQ[G, Mode->Visual, ConvertMode -> "All",opts]}, 
	ImageSize->Automatic],"Is "<>GroupoidName[G]<>" cyclic?", Top],
		Labeled[TabView[{"Computation" -> CyclicQ[G],
	"Explanation" -> CyclicQ[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> CyclicQ[G, Mode->Visual, ConvertMode -> "All",opts],
	"Interactive" -> CyclicQ[G, Mode->Interactive, ShowConvert -> False,opts]}, 
	ImageSize->Automatic],"Is "<>GroupoidName[G]<>" cyclic?", Top]
]	

CyclicQ[G_?GroupoidQ, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		InteractiveThroughGroups[CyclicQ, G, InteractiveMode->Computational, opts],
	"Explanation" -> InteractiveThroughGroups[CyclicQ, G, InteractiveMode->Textual, ShowConvert -> False, opts],
	"Visualization" -> InteractiveThroughGroups[CyclicQ, G, InteractiveMode->Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with CyclicQ[G]", Top]


CyclicQ[many:{_?GroupoidQ..}, Mode -> mode_, opts___?OptionQ] :=
	Column[Map[CyclicQ[#,Mode->mode, opts]&, many]]
		
CyclicQ[many:{_?GroupoidQ..}] :=
	Map[CyclicQ,many]
		
CyclicQTextual[G_,gen_, opts___?OptionQ] := Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	If[!multipleQ, text= Text[Row@{CyclicQTextualGD[G], CyclicQTextualLI[G,gen]}],
		If[firstPassQ, 
			firstPassQ = False;
			text= Text[Row@{CyclicQTextualGD[G], CyclicQTextualLI[G,gen]}],
			text= Text[CyclicQTextualLI[G,gen]]]];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]

CyclicQTextualGD[_] := Row[{"A Groupoid ",
	Style["G",Italic], " is said to be cyclic if there exists an element ",
	Style["g",Italic], " in ", Style["G",Italic], " such that for all ",
	Style["h",Italic],
	" in ", Style["G",Italic], " there exists an integer ",
	Style["n",Italic], " such that ", Style["h = \!\(\*SuperscriptBox[\"g\", \"n\"]\)",Italic],". "}]

CyclicQTextualLI[G_,gen_] := 
	Row[{"In this case, ",
		GroupoidName[G],If[cyclicQ[G],
		" is indeed cyclic, being generated by "<>ToString[gen, TraditionalForm]<>"."," is NOT cyclic."]}]

CyclicQVisual[G_,opts___] :=
	Module[{g},
	If[CyclicQ[G],g=generator[G];
		DoVisualization[SubgroupGeneratedVisual5[G,g,opts],{{G,True,g},CyclicQHelp},opts],
		DoVisualization[CyclicSubgroupsVisualGrid[G,
			CyclicSubgroupsWork[G],opts],{{G,False,g},CyclicQHelp},opts]]]

CyclicQHelp[G_,True,g_]:=  DoHelpMessage[windowtitle -> "Help for whether G is cyclic or not", 
	help -> List["In this case, the group "<>
		GroupoidName[G]<>" is cyclic. This can be seen since the element "<>ToString[g]<>
		" generates the whole group. Use the key at the bottom to determine the color and value of the nth power/multiple of "<>ToString[g]<>
			" and note that since its row is filled up, it generates all of "<>GroupoidName[G]<>". Thus, this group is cyclic."]
]

CyclicQHelp[G_,False,g_]:=  DoHelpMessage[windowtitle -> "Help for whether G is cyclic or not", 
	help -> List["Each row of the table, corresponding to the element g in the first column, shows the subgroup generated by the element g in the group "<>
		GroupoidName[G]<>". Use the key at the bottom to determine the color and value of the nth power to determine the order that the subgroup is generated. Since there is NOT at least one row whose subgroup generated by the element in the first column fills out the whole (covers the whole group), then this group is NOT cyclic."]
]

showAllGenerations[G_] :=
	Module[{els = Elements[G],op= Operation[G],opsy=OperatorSymbol[G],
		len,inlen,heldlist,i,nS,g,rects, x,pos,n,poslist,
		coloredRects, max = -1,gColoredRects={}, gText, 
		gLines,huerects={},huetext={},list,ggColoredRects},
	{ gLines, gText,rects} = basicCayley[G,els, CayleyForm -> CayleyForm[G]];
	n = Length[els];
	Do[
		g = els[[i]];
		list = SubgroupGeneratedWork[g,G];
		inlen = Length[list];
		max = Max[max,inlen];
		pos = Position[els,g,1]//Flatten;
		coloredRects=coloredSquares[g,G,list,inlen];
		If[max == inlen,Do[AppendTo[huerects, {Hue[(i-1)/inlen],
			Rectangle[{i-1,-2},{i,-1}]}],{i, inlen}]];
		AppendTo[gColoredRects, {coloredRects}], {i,n}];
		AppendTo[gColoredRects, {huerects}];
	ggColoredRects = Show[Graphics[gColoredRects,DisplayFunction->Identity]];
	Show[{ ggColoredRects, gLines,gText},
		DisplayFunction -> Identity(*,PlotRange -> All*)]
		]


(* ::Section:: *)
(* 37. Cyclic subgroups of a group*)


CyclicSubgroupsWork[G_] := 
	Map[SubgroupGeneratedWork[#,G]&,Elements[G]]

Options[CyclicSubgroups]={Mode -> Computational};

CyclicSubgroups[G_?GroupoidQ] := 
	Module[{out, subs, temp},
	subs = Union[Map[Union,temp = CyclicSubgroupsWork[G]]];
	subs = If[CyclicQ[G], Drop[subs, -1], subs];
	out = Map[FormGroupoid[#, Operation[G], OperatorSymbol[G], 
		GatherSubGroupoidOptions[G]]&,
		subs];
	If[CyclicQ[G], AppendTo[out, G]];
	out]

CyclicSubgroups[G_?GroupoidQ, Mode->Computational, opts___?OptionQ] :=CyclicSubgroups[G]

CyclicSubgroups[G_?GroupoidQ, Mode->Textual, opts___?OptionQ] := 
	Module[{temp},
	temp = CyclicSubgroupsWork[G];
	CyclicSubgroupsTextual[G,temp, opts]]

CyclicSubgroups[G_?GroupoidQ, Mode->Visual, opts___?OptionQ] := 
	Module[{temp},
	temp = CyclicSubgroupsWork[G];
	DoVisualization[CyclicSubgroupsVisualGrid[G,temp, opts],{{G},CyclicSubgroupsHelp},opts]]

CyclicSubgroupsVisualMessage[G_]:=Module[{show},
	show = Show/.Options[HelpMessages];
{If[show,Button["Click for explanation", CyclicSubgroupsHelp[G],
		Background->Yellow, BaseStyle -> Small, ImageSize->Automatic],""]}
]

CyclicSubgroupsHelp[G_]:=  DoHelpMessage[windowtitle -> "Help for the cyclic subgroups of "<>GroupoidName[G], 
	help -> List["Each row of the table, corresponding to the element g in the first column, shows the subgroup generated by the element g in the group "<>
		GroupoidName[G]<>". Use the key at the bottom to determine the color and value of the nth power to determine the order that the subgroup is generated."]
]

CyclicSubgroups[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	If[InteractiveThroughGroups[CyclicSubgroups, G, InteractiveMode->Computational, opts]===$Failed,
		Labeled[TabView[{"Computation" -> CyclicSubgroups[G],
	"Explanation" -> CyclicSubgroups[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> CyclicSubgroups[G, Mode->Visual, ConvertMode -> "All",opts]}, 
	ImageSize->Automatic],"Cyclic subgroups of "<>GroupoidName[G]<>" cyclic?", Top],
		Labeled[TabView[{"Computation" -> CyclicSubgroups[G],
	"Explanation" -> CyclicSubgroups[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> CyclicSubgroups[G, Mode->Visual, ConvertMode -> "All",opts],
	"Interactive" -> CyclicSubgroups[G, Mode->Interactive, ShowConvert -> False,opts]}, 
	ImageSize->Automatic],"Cyclic subgroups of "<>GroupoidName[G]<>" cyclic?", Top]
]	

CyclicSubgroups[G_?GroupoidQ, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		InteractiveThroughGroups[CyclicSubgroups, G, InteractiveMode->Computational, opts],
	"Explanation" -> InteractiveThroughGroups[CyclicSubgroups, G, InteractiveMode->Textual, ShowConvert -> False, opts],
	"Visualization" -> InteractiveThroughGroups[CyclicSubgroups, G, InteractiveMode->Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with CyclicSubgroups[G]", Top]

CyclicSubgroupsTextual[G_,sg_,opts___?OptionQ] := Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	text = Column[{CyclicSubgroupsTextualGD[G],CyclicSubgroupsTextualLI[G,sg]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]]

CyclicSubgroupsTextualGD[_] := 
"Given a group G, we can find all the cyclic subgroups by taking all the elements g in G and determining <g>. Below is the list of the cyclic subgroups determined by calculating <g> for each element serially. The first column of the output gives the list of subgroups as they are generated and the second column reflects the first column sorted.\n"

CyclicSubgroupsTextualLI[G_,sg_] := Module[{temp1, 
	temp2,diff},
	temp = Map[Sort,sg];
	headingsGrid[Transpose[{sg,temp}],{"generated","sorted"}]]

Options[CyclicSubgroupsVisual]={DisplayFunction -> $DisplayFunction};

CyclicSubgroupsVisual[G_,sg_,opts___]:= CyclicSubgroupsVisualGrid[G,sg,""]

CyclicSubgroupsVisualGrid[G_,subgroups_, opts___?OptionQ]:= Module[{origTab, itemTab, ord, k,
		powersRow, labeledRow,key, labels = {1,2},len, len2, showkey, cayleyform, wide, grid, pos},
	{origTab,itemTab} = WhiteCayleyGrid[G];
	ord = Length[subgroups];
	wide = WideElementsQ[G];
	showkey = showkeyQ[G, opts];
	len2 = Length[Elements[G]];
	cayleyform = CayleyForm/.Flatten[{opts, Options[SubgroupQ]}];
	len=OrderOfAllElements[G]//Transpose//Last//Max;
	Do[itemTab = ChangeGeneratedRow[G, subgroups[[k,1]],{origTab,itemTab},{k}, 
		subgroups[[k]],len],{k,1,ord}];
	If[showkey || wide,itemTab = ConvertGridToKeyed[G,itemTab]];
	If[cayleyform =!=StandardForm && MemberQ[{FullForm,MatrixForm,InputForm,TraditionalForm,OutputForm},cayleyform],
		pos = Flatten[Delete[Table[{i,j},{i,len2+1},{j,len2+1}],{1,1}],1];
		itemTab = MapAt[ChangeItemCayleyForm[#,cayleyform]&,itemTab,pos]];
	labeledRow = Prepend[Table[Item[k,Background->White],{k,1,len}],"n"];
	powersRow = Prepend[Table[Item[If[OperatorSymbol[G]==="+",ToString[k]<>"\[CenterDot]g","g"^k],
		Background->Hue[(k-1)/len] ],{k,1,len}],If[OperatorSymbol[G]==="+","n\[CenterDot]g","g"^"n"]];
	key = Grid[{labeledRow,powersRow},ItemSize->All,BaseStyle->Small];
	grid =Panel[Grid[itemTab,Dividers->{{1,2->Thickness[4]},{1,2->Thickness[4]}},ItemSize->All],{"x","y"},
{Left,Top}];
	If[showkey,Column[{grid,key,TextCayleyKey[Elements[G],GroupoidName[G],G,StandardForm]}, Center], 
		Column[{grid,key}, Center]]
]

(* Added 7/14/08 *)
	
CyclicSubgroups[many:{_?GroupoidQ..}, Mode -> mode_] :=
	Column[Map[CyclicSubgroups[#, Mode->mode]&,many]]
		
CyclicSubgroups[many:{_?GroupoidQ..}] :=
	Map[CyclicSubgroups,many]


(* ::Section:: *)
(* 38. Cyclic Generators of a Group*)


Options[CyclicGenerators]={Mode -> Computational};

CyclicGenerators[G_?GroupoidQ] := 
	Module[{mymode, 	els = Elements[G],list,temp},
	temp = CyclicSubgroupsWork[G];
	list = Map[First,Select[temp,
		(Length[els]==Length[#])&]];
	If[list ==={}, Message[Group::notcyclic,
		StructureName[G]]];
	list]

CyclicGenerators[G_?GroupoidQ, Mode -> Computational, opts___?OptionQ] := CyclicGenerators[G]

CyclicGenerators[G_?GroupoidQ, Mode -> Textual, opts___?OptionQ] :=
	CyclicGeneratorsTextual[G,CyclicSubgroupsWork[G], opts]

CyclicGenerators[G_?GroupoidQ, Mode -> Visual, opts___?OptionQ] :=
	DoVisualization[CyclicGeneratorsVisual[G,CyclicSubgroupsWork[G], opts],
		{{G},CyclicGeneratorsHelp},opts]

CyclicGeneratorsTextual[G_,sg_, opts___?OptionQ] := Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	text = Column[{CyclicGeneratorsTextualGD[G],Elements[G], CyclicSubgroupsTextualLI[G,sg]}];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]]

CyclicGeneratorsTextualGD[_] := 
"Given a group G, we can find all the generators of the group by taking all the elements g in G and determining <g> and determine when <g> = G. Below is the list of the cyclic subgroups determined by calculating <g> for each element in sequence. The elements are of G are:"

Options[CyclicGeneratorsVisual]={DisplayFunction -> $DisplayFunction};

CyclicGeneratorsVisual[G_,sg_, opts___?OptionQ] :=
	CyclicSubgroupsVisualGrid[G,sg,opts]

CyclicGeneratorsHelp[G_]:= DoHelpMessage[windowtitle -> "Help for cyclic generators of "<>GroupoidName[G], 
	help -> List["Each row of the table, corresponding to the element ",
	Cell[BoxData[FormBox["g", TraditionalForm]],FormatType->"TraditionalForm"],
	" in the first column, shows the subgroup generated by the element ",
	Cell[BoxData[FormBox["g", TraditionalForm]],FormatType->"TraditionalForm"],
	" in the group "<>
		GroupoidName[G]<>". Use the key at the bottom to determine the color and value of the nth power. Those elements whose row is fully colored is a cyclic generator for this group."]
]
	
CyclicGenerators[many:{_?GroupoidQ..}] :=
	Map[CyclicGenerators, many]

CyclicGenerators[many:{_?GroupoidQ..}, Mode -> mode_, opts___?OptionQ] :=
	Map[CyclicGenerators[#, Mode -> mode, opts]&, many]//Column

CyclicGenerators[G_?GroupoidQ, Mode -> All, opts___?OptionQ]:=
	If[InteractiveThroughGroups[CyclicGenerators, G, InteractiveMode->Computational, opts]===$Failed,
		Labeled[TabView[{"Computation" -> CyclicGenerators[G],
	"Explanation" -> CyclicGenerators[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> CyclicGenerators[G, Mode->Visual, ConvertMode -> "All",opts]}, 
	ImageSize->Automatic],"Cyclic generators of "<>GroupoidName[G]<>" cyclic?", Top],
		Labeled[TabView[{"Computation" -> CyclicGenerators[G],
	"Explanation" -> CyclicGenerators[G, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> CyclicGenerators[G, Mode->Visual, ConvertMode -> "All",opts],
	"Interactive" -> CyclicGenerators[G, Mode->Interactive, ShowConvert -> False,opts]}, 
	ImageSize->Automatic],"Cyclic generators of "<>GroupoidName[G]<>" cyclic?", Top]
]	

CyclicGenerators[G_?GroupoidQ, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		InteractiveThroughGroups[CyclicGenerators, G, InteractiveMode->Computational, opts],
	"Explanation" -> InteractiveThroughGroups[CyclicGenerators, G, InteractiveMode->Textual, ShowConvert -> False, opts],
	"Visualization" -> InteractiveThroughGroups[CyclicGenerators, G, InteractiveMode->Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with CyclicGenerators[G]", Top]


(* ::Section:: *)
(* 39. Centralizer of an Element of a Group*)


Options[Centralizer]={Mode -> Computational};

ElementsCommuteQ[op_,x_,y_]:=op[x,y]===op[y,x]

ElementCommutesWithListQ[op_,x_,H_List]:=Apply[And,Map[ElementsCommuteQ[op,x,#]&,H]]

CommuteQ[G_?GroupoidQ, x_, y_]:= Operation[G][x,y]===Operation[G][y,x]/;ElementQ[x,G]&&ElementQ[y,G]

CommuteQ[G_?GroupoidQ, x_, y_, Mode -> Computational, opts___?OptionQ]:= CommuteQ[G, x, y]

CommuteQ[G_?GroupoidQ, x_, y_, Mode -> Textual, opts___?OptionQ]:= Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	text = StringJoin["Two elements x and y in a group or ring commute if x*y=y*x where * is the group (ring) operation. In this case, the two elements do ",
		If[CommuteQ[G,x,y],"commute.", "NOT commute."]];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]/;ElementQ[x,G]&&ElementQ[y,G]

CommuteQVisual[G_?GroupoidQ, x_, y_, opts___?OptionQ]:= Module[{els = Elements[G], table, grid, xpos,
	ypos, len, colors, showkey, cayleyform, temp, commuteq, op= Operation[G], newcolor, pos2},
	{table,grid} = WhiteCayleyGrid[G];
	len=Length[els];
	xpos = Position[els,x,1]//Flatten//First;
	ypos = Position[els,y,1]//Flatten//First;
	showkey = showkeyQ[G, opts];
	cayleyform = CayleyForm/.Flatten[{opts, Options[SubgroupQ]}];
	grid[[xpos+1,1]]=grid[[xpos+1,1]] /.Rule[Background,_]-> Rule[Background,GrayLevel[0.7]];
	grid[[1,ypos+1]]=grid[[ypos+1,1]] /.Rule[Background,_]-> Rule[Background,GrayLevel[0.7]];
	grid[[1,xpos+1]]=grid[[1,xpos+1]] /.Rule[Background,_]-> Rule[Background,Blend[{GrayLevel[0.7],Blue},.25]];
	grid[[ypos+1,1]]=grid[[ypos+1,1]] /.Rule[Background,_]-> Rule[Background,Blend[{GrayLevel[0.7],Blue},.25]];
	commuteq =op[x,y]===op[y,x];
	If[commuteq,
		newcolor=GoodElementsColor,
		newcolor=BadElementsColor];
	grid[[xpos+1,ypos+1]]=grid[[xpos+1,ypos+1]] /.Rule[Background,_]-> Rule[Background,newcolor];
	grid[[ypos+1,xpos+1]]=grid[[ypos+1,xpos+1]] /.Rule[Background,_]-> Rule[Background,newcolor];
	If[showkey,grid = ConvertGridToKeyed[G,grid]];
	If[cayleyform =!=StandardForm && MemberQ[{FullForm,MatrixForm,InputForm,TraditionalForm,OutputForm},cayleyform],
				pos2 = Flatten[Delete[Table[{i,j},{i,len+1},{j,len+1}],{1,1}],1];
				grid = MapAt[ChangeItemCayleyForm[#,cayleyform]&,grid,pos2]];
	grid =Panel[Grid[grid,Dividers->{{1,2->Thickness[4]},{1,2->Thickness[4]}},
				ItemSize->All,Spacings->Offset[1]],{"x","y"}, {Left,Top}]
]

CommuteQ[G_?GroupoidQ, x_, y_, Mode -> Visual, opts___?OptionQ]:= 
	DoVisualization[CommuteQVisual[G, x,y, opts],{{G, x,y},CommuteQHelp},opts]/;ElementQ[x,G]&&ElementQ[y,G]

CommuteQHelp[G_?GroupoidQ, x_, y_]:= DoHelpMessage[windowtitle -> "Help for considering whether x and y commute in G", 
	help -> List["In the Cayley table, note that the two elements in question, ",
	Cell[BoxData[FormBox["x", TraditionalForm]], FormatType->"TraditionalForm"],
	" = ",
	Cell[BoxData[ToBoxes[x,TraditionalForm]], FormatType->"TraditionalForm"],
	" and ",
	Cell[BoxData[FormBox["y", TraditionalForm]], FormatType->"TraditionalForm"],
	" = ",
	Cell[BoxData[ToBoxes[y,TraditionalForm]], FormatType->"TraditionalForm"],
	" are colored either light blue or gray in both the first column and first row. The product of the two gray ones and the two blue ones represent the products ",
	Cell[BoxData[FormBox["x y", TraditionalForm]], FormatType->"TraditionalForm"],
	" and ",
	Cell[BoxData[FormBox["y x", TraditionalForm]], FormatType->"TraditionalForm"],
	", respectively. If these two values are the same, these products are colored green but reddish if not. Thus, green indicates that the elements commute while reddish indicates that they do not."
]]

CommuteQ[G_?GroupoidQ, x_, y_, Mode -> Interactive, InteractiveMode->mode_, opts___?OptionQ]:=
	Manipulate[CommuteQ[G, g, h, Mode -> mode, opts],{{g, x, "x \[Element] G"}, Elements[G],ControlType -> RadioButtonBar},
		{{h, y, "y \[Element] G"}, Elements[G],ControlType -> RadioButtonBar}
		]

CommuteQ[G_?GroupoidQ, x_, y_, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		CommuteQ[G, x, y,Mode->Interactive, InteractiveMode -> Computational, opts],
	"Explanation" -> CommuteQ[G, x, y,Mode->Interactive, InteractiveMode -> Textual, ShowConvert->False, opts],
	"Visualization" -> CommuteQ[G, x, y, Mode->Interactive, InteractiveMode -> Visual, ShowConvert->False, opts]}, 
	ImageSize->Automatic],"Interacting with CommuteQ[G,x,y]", Top]

CommuteQ[G_?GroupoidQ, x_, y_, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> CommuteQ[G, x, y],
	"Explanation" -> CommuteQ[G, x, y, Mode->Textual, ConvertMode->"All"],
	"Visualization" -> CommuteQ[G, x, y, Mode->Visual, ConvertMode->"All",opts],
	"Interactive" -> CommuteQ[G, x, y, Mode->Interactive, ShowConvert->False,opts]}, 
	ImageSize->Automatic],"The x and y commute in G", Top]

CommuteQ[G_?GroupoidQ, x_, H_List]:= Apply[And,Map[Operation[G][x,#]===Operation[G][#,x]&,H]]/;ElementQ[x,G]&&ElementsQ[H,G]

CommuteQ[G_?GroupoidQ, x_, H_?GroupoidQ]:= CommuteQ[G, x, Elements[H]]/;SubgroupQ[H,G]

CommuteQ[G_?GroupoidQ, x_, H_List, Mode -> Textual, opts___?OptionQ]:= Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	text = StringJoin["An element x commutes with a subset H of a group or ring if for all y \[Element] H we have x*y=y*x, where * is the group (ring) operation. In this case, the element x and set H do ",
		If[CommuteQ[G,x,H],"commute.", "NOT commute."]];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]/;ElementQ[x,G]&&ElementsQ[H,G]

CommuteQ[G_?GroupoidQ, x_, H_, Mode -> Visual, opts___?OptionQ]:= 
	DoVisualization[CommuteQVisual[G, x,H, opts],{{G, x,y},CommuteQHelp},opts]/;ElementQ[x,G]&&ElementsQ[H,G]


CommuteQVisual[G_?GroupoidQ, x_, H_List, opts___?OptionQ]:= Module[{els = Elements[G], table, grid, xpos,
	Hpos, len, colors, showkey, cayleyform, temp, commuteq, k, op= Operation[G], newcolor, pos2},
	{table,grid} = WhiteCayleyGrid[G];
	len=Length[H];
	xpos = Position[els,x,1]//Flatten//First;
	Do[Hpos[k] = Position[els,H[[k]],1]//Flatten//First, {k,1,len}];
	showkey = showkeyQ[G, opts];
	cayleyform = CayleyForm/.Flatten[{opts, Options[SubgroupQ]}];
	grid[[xpos+1,1]]=grid[[xpos+1,1]] /.Rule[Background,_]-> Rule[Background,GrayLevel[0.7]];
	grid[[1,xpos+1]]=grid[[1,xpos+1]] /.Rule[Background,_]-> Rule[Background,GrayLevel[0.7]];
	Do[grid[[1,Hpos[k]+1]]=grid[[1,Hpos[k]+1]] /.Rule[Background,_]-> Rule[Background,Blend[{GrayLevel[0.7],Blue},k/len]];
	grid[[Hpos[k]+1,1]]=grid[[Hpos[k]+1,1]] /.Rule[Background,_]-> Rule[Background,Blend[{GrayLevel[0.7],Blue},k/len]],{k, 1, len}];
	Do[commuteq =op[x,H[[k]]]===op[H[[k]],x];
		If[commuteq,
			newcolor=GoodElementsColor,
			newcolor=Blend[{GrayLevel[0.7],BadElementsColor},k/len]];
		grid[[xpos+1,Hpos[k]+1]]=grid[[xpos+1,Hpos[k]+1]] /.Rule[Background,_]-> Rule[Background,newcolor];
		grid[[Hpos[k]+1,xpos+1]]=grid[[Hpos[k]+1,xpos+1]] /.Rule[Background,_]-> Rule[Background,newcolor];,
		{k,1, len}];
	If[showkey,grid = ConvertGridToKeyed[G,grid]];
	If[cayleyform =!=StandardForm && MemberQ[{FullForm,MatrixForm,InputForm,TraditionalForm,OutputForm},cayleyform],
				pos2 = Flatten[Delete[Table[{i,j},{i,len+1},{j,len+1}],{1,1}],1];
				grid = MapAt[ChangeItemCayleyForm[#,cayleyform]&,grid,pos2]];
	grid =Panel[Grid[grid,Dividers->{{1,2->Thickness[4]},{1,2->Thickness[4]}},
				ItemSize->All,Spacings->Offset[1]],{"x","y"}, {Left,Top}]
]



Centralizer[G_?GroupoidQ, g_] := 
	Module[{mymode, els = Elements[G],cent, centels, op = Operation[G]},
	If[ElementQ[g,G],
	(* centels = Select[els, op[#,g]===op[g,#]&];*)
	centels = Select[els, ElementsCommuteQ[op,#,g]&];
	cent = If[ProperSubsetQAA[centels, els],
			FormGroupoid[centels, Operation[G], OperatorSymbol[G],
				GatherSubGroupoidOptions[G]],
			G], CentralizerSub[G,g]]]

Centralizer[G_?GroupoidQ, g_, Mode->Computational, opts___?OptionQ] := Centralizer[G, g]

Centralizer[G_?GroupoidQ, x_, Mode -> Interactive, InteractiveMode->mode_, opts___?OptionQ]:=
	Manipulate[Centralizer[G, g, Mode -> mode, opts],{{g, x, "g \[Element] G"}, Elements[G],ControlType -> RadioButtonBar}
		]

Centralizer[G_?GroupoidQ, x_, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		Centralizer[G, x, Mode->Interactive, InteractiveMode -> Computational, opts],
	"Explanation" -> Centralizer[G, x, Mode->Interactive, InteractiveMode -> Textual, ShowConvert->False, opts],
	"Visualization" -> Centralizer[G, x, Mode->Interactive, InteractiveMode -> Visual, ShowConvert->False, opts]}, 
	ImageSize->Automatic],"Interacting with Centralizer[G,g]", Top]

Centralizer[G_?GroupoidQ, g_, Mode->Textual, opts___?OptionQ] :=
	CentralizerTextual[G, g, Centralizer[G,g], opts]

CentralizerTextual[G_,g_,cent_, opts___?OptionQ] := Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	text= StringJoin["Given an element g in a group G, we define the centralizer of g in G as the set of all elements in G which commute with g. In other words, it is the set {h in G | g h = h g}. In this case, the centralizer of ",
	ToString[g], " in ", GroupoidName[G], " is the set \n", ToString[cent]];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]]

Centralizer[G_?GroupoidQ, g_, Mode -> Visual, opts___?OptionQ]:= 
	Manipulate[
	DoVisualization[CommuteQVisual[G, g,h, opts],{{G, g,h},CommuteQHelp},opts],{{h,First[Elements[G]],"g \[Element] G"},Elements[G], ControlType->Slider}]

Centralizer[G_?GroupoidQ, g_, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> Centralizer[G, g],
	"Explanation" -> Centralizer[G, g, Mode->Textual, ConvertMode -> "All", opts],
	 "Visualization" -> Centralizer[G, g, Mode->Visual, ConvertMode -> "All", opts],
	"Interactive" -> Centralizer[G, g, Mode->Interactive, ConvertMode -> "All", opts]}, 
	ImageSize->Automatic],"Centralizer of "<>ToString[g]<>" in "<>GroupoidName[G], Top]

(* TODO For a visualization of Centralizer[G,g], animate through each element h in the group and only color
g and h in the headings and in the body only color g*h and h*g. *)


(* ::Section:: *)
(* 40. Center of a group*)


Unprotect[Center];

groupoid /: 
	Center[G_groupoid, opts___?OptionQ] := 
	GroupCenter[G, opts];

Protect[Center];

Options[GroupCenter] = {Mode -> Computational};
	
CommuteWithAllQ[G_?GroupoidQ, el_] := 
	(Elements[Centralizer[G,el]]//Union) === (Elements[G]//Union)
		
GroupCenter[G_?GroupoidQ, opts___?OptionQ] := Module[{mymode,
		list, els = Elements[G],ct, cent},
	mymode = Mode/.Flatten[{opts, Options[GroupCenter]}];
	ct = makeTable[G,els];
	cent = MapThread[SameQ, {ct,Transpose[ct]},2]//
  	{Apply[And,#,1],Apply[And,Transpose[#],1]}&//
    MapThread[And,#]&//
    Select[Transpose[{#,Domain[G]}],First[#]&]&//
    Transpose//Last;
  If[ProperSubsetQAA[cent,els],
			FormGroupoid[cent, Operation[G], OperatorSymbol[G],
				GatherSubGroupoidOptions[G]],
			G]]


(* ::Section:: *)
(* 41. Centralizer of a subgroup*)


commutesWithH[x_, H_List, op_] :=
	Map[op[x, #]&, H] === Map[op[#, x]&, H]

Centralizer[G_?GroupoidQ, H_List] := Module[{els = Elements[G], op =
		Operation[G], cent},
	cent = Select[els, commutesWithH[#, H, op]&]; (* old *)
	cent = Select[els, ElementCommutesWithListQ[op,#,H]&];
	If[ProperSubsetQAA[cent,els],
			FormGroupoid[cent, op, OperatorSymbol[G],
				GatherSubGroupoidOptions[G]],
			G]]/;SubsetQAA[H,Elements[G]]

CentralizerSub[G_?GroupoidQ, H_List] := Module[{els = Elements[G], op =
		Operation[G], cent},
	cent = Select[els, commutesWithH[#, H, op]&];
	cent = Select[els, ElementCommutesWithListQ[op,#,H]&];
	If[ProperSubsetQAA[cent,els],
			FormGroupoid[cent, op, OperatorSymbol[G],
				GatherSubGroupoidOptions[G]],
			G]]
			
Centralizer[G_?GroupoidQ, H_?GroupoidQ] :=
	If[Operation[G] === Operation[H],
		CentralizerSub[G, Elements[H]],
		Message[Operation::fail]; $Failed]


(* ::Section:: *)
(* 42. Conjugacy topics*)


(* ::Subsection:: *)
(*42.1 ElementConjugate*)


Unprotect[Conjugate];

Attributes[Conjugate] = {}; (* Note: removed Listable *)

groupoid /: 
	Conjugate[G_groupoid, h_, x_, opts___?OptionQ] := 
		Module[{rh, rx},
	{rh, rx} = Map[TensorRank, {h, x}];
	If[rh === rx, ElementConjugate[G, h, x, opts],
		If[rh === rx + 1, SubgroupConjugate[G, h, x, opts],
		Message[Conjugate::fail,h,x]; $Failed]]]

Protect[Conjugate];

Options[ElementConjugate]={Mode -> Computational};

ElementConjugate[G_?GroupoidQ, h_, x_, opts___?OptionQ] := 
	Module[{mymode, con, op = Operation[G]},
If[ElementQ[h,G] && ElementQ[x,G],
	con = op[op[x,h],GroupInverse[G,x]],
If[!ElementQ[h,G],Message[MemberQ::elmnt,h,StructureName[G]]];
If[!ElementQ[x,G],Message[MemberQ::elmnt,x,StructureName[G]]]; $Failed]]



(* ::Subsection:: *)
(*42.2 SubgroupConjugate*)


Options[SubgroupConjugate]={Mode -> Computational};

SubgroupConjugate[G_?GroupoidQ,H_List,x_,opts___?OptionQ] := 
	Module[{mymode,con, 
		op = Operation[G],out},
If[SubgroupQ[H,G] && ElementQ[x,G],
	con = Map[op[op[x,#],GroupInverse[G,x]]&,H];
	con = If[ProperSubsetQAA[con, Elements[G]],
			FormGroupoid[con, op, OperatorSymbol[G], 
				GatherSubGroupoidOptions[G]],
			G],
	If[!SubgroupQ[H,G],
		Message[MemberQ::sbgrp,H,StructureName[G]]];
	If[!ElementQ[x,G],Message[MemberQ::elmnt,x,StructureName[G]]]]]
	
SubgroupConjugate[G_?GroupoidQ, H_?GroupoidQ, x_, opts___?OptionQ] :=
	If[Operation[G] === Operation[H],
		SubgroupConjugate[G, Elements[H], x, opts],
		Message[Operation::fail]; $Failed]


(* ::Subsection:: *)
(*42.3 ConjugacyClass*)


Options[ConjugacyClass] = {Mode -> Computational};

ConjugacyClass[G_?GroupoidQ,h_,opts___?OptionQ] := 
	Module[{mymode, els = Elements[G],con, 
		op = Operation[G],out},
	mymode = Mode/.Flatten[{opts, Options[ConjugacyClass]}];
If[ElementQ[h,G],
	con = Map[(op[op[#,h],GroupInverse[G,#]])&,els]//Union,
If[!ElementQ[h,G],Message[MemberQ::elmnt,h,StructureName[G]]]]]


(* ::Subsection:: *)
(*42.4 Normalizer*)


Options[Normalizer]={Mode -> Computational};

Normalizer[G_?GroupoidQ, H_List, opts___?OptionQ] := 
	Module[{mymode, els = Elements[G],norm={}, 
		op = Operation[G],out},
If[SubgroupQ[H,G],
	Do[If[Subgroupoid[G,H]===SubgroupConjugate[G,H,els[[i]]],
(*changed H===to Subgroupoid[G,H]===11/27/06*)
		AppendTo[norm,els[[i]]]],{i,Length[els]}],
(* If[!ElementQ[h,G],Message[MemberQ::sbgrp,H,StructureName[G]]]]] *)
If[!ElementQ[H,G],Message[MemberQ::sbgrp,H,StructureName[G]];$Failed]]]
(*changed h in ElementQ to H-not sure why either needed;added;$Failed after message*)

Normalizer[G_?GroupoidQ, H_?GroupoidQ, opts___?OptionQ] :=
	If[Operation[G] === Operation[H],
		Normalizer[G, Elements[H], opts],
		Message[Operation::fail]; $Failed]


(* ::Section:: *)
(* 43. Stablizer and Orbit of a point*)


(* ::Subsection:: *)
(*43.1 Stabilizer of a point*)


Options[Stabilizer] = {Mode -> Computational};

Stabilizer[G_?GroupoidQ,S_,x_,opts___?OptionQ] := 
	Module[{mymode, els = Elements[G]},
	mymode = Mode/.Flatten[{opts, Options[Stabilizer]}];
If[MemberQ[S,x],
	DeleteCases[MapThread[If[FixQ[S,#2,x],els[[#1]]]&,
		{Range[Length[els]],els}],Null],
	Message[MemberQ::elmnt,x,S]]]

Stabilizer[S_,x_,opts___?OptionQ] :=
	Stabilizer[PermutationGroupAA[S],S,x]


(* ::Subsection:: *)
(*43.2 Orbit*)


Options[Orbit] = {Mode -> Computational};

Orbit[G_?GroupoidQ, S_, x_, opts___?OptionQ] := 
Module[{mymode, els = Elements[G]},
	mymode = Mode/.Flatten[{opts, Options[Orbit]}];
If[MemberQ[S,x],
	Map[PermutationImage[S,#,x]&,els]//UnionNoSort,
	Message[MemberQ::elmnt,x,S]]]
	
Orbit[S_, x_, opts___?OptionQ] :=
	Orbit[PermutationGroupAA[S],S,x]



(* ::Section:: *)
(* 44. For labs - from permutations*)


RandomColoredSquares[n_Integer?Positive, colors_List:{RGBColor[1,0,0],RGBColor[0,0,1],
 RGBColor[0,1,0],RGBColor[1,0,1],RGBColor[1,1,0],RGBColor[0,1,1],
 RGBColor[1,.5,0],RGBColor[1,.752907,.796106],
 RGBColor[.250999,.878399,.815699],
 RGBColor[0.902005,0.902005,0.980407],
 RGBColor[0.498001,1,0.831401],RGBColor[0,0,0.501999]}] := 
	Module[{cl,gr,perm, dx = 0.1},
If[n > 12, 
	Print["When a value greater than 12 is used, you need to provide (as a second
	argument) a list of colors as well."]; $Failed,
perm = RandomPermutationAA[n];
CurrentColorList = Take[colors,n][[perm]];
CurrentPermList = {Range[n],CurrentColorList};
gr=Show[Graphics[Table[{{CurrentColorList[[i]],
	Rectangle[{(i-1)+dx, 0+dx}, {i-dx, 1-dx}]}, {RGBColor[0,0,0],Text[i, 
	{(i-1) + 0.5, 0.5}]}},{i, n}]]]
]]

PermuteColoredSquares[p_] := 
	Module[{cl,gr1,gr2,perm,i,n = Length[p], dx = 0.1,q},
If[Head[p[[1]]]===Rule,perm = ToPermutation[p]//PermutationInverse,
	perm = PermutationInverse[p]];
q = PermutationInverse[perm];
If[Length[p]===Length[CurrentColorList],
gr1=Graphics[Table[{{CurrentColorList[[i]],
	Rectangle[{(i-1)+dx, 0+dx}, {i-dx, 1-dx}]}, {RGBColor[0,0,0],Text[i, 
	{(i-1) + 0.5,0.5}]}},{i,n}]];
gr2=Graphics[Table[{{CurrentColorList[[perm[[i]]]],
	Rectangle[{(i-1)+dx, -2+dx}, {i-dx, -1-dx}]},{RGBColor[0,0,0],Text[perm[[i]], 
	{(i-1) + 0.5,-1.5}]}},{i,n}]];
gr3=Graphics[{RGBColor[0,0,0],Table[Arrow[{{(i-1)+.5, 0+dx},
	{q[[i]] -.5,-1-dx}}],{i,n}]}];
Show[{gr1,gr2,gr3},DisplayFunction -> $DisplayFunction]
]]

ShowColoredPermutation[p_] := 
	Module[{q,cl,gr1,gr2,perm,i,n = Length[p], colors={RGBColor[1,0,0],RGBColor[0,0,1],
 RGBColor[0,1,0],RGBColor[1,0,1], RGBColor[1,1,0],
 RGBColor[0,1,1],RGBColor[1,.5,0],RGBColor[1,.752907,.796106],
 RGBColor[.250999,.878399,.815699],
 RGBColor[0.902005,0.902005,0.980407],RGBColor[0.498001,1,0.831401],
 RGBColor[0,0,0.501999]}, dx = 0.1},
If[Head[p[[1]]]===Rule,perm = ToPermutation[p]//PermutationInverse,
	perm = PermutationInverse[p]];
q = PermutationInverse[perm];
If[Length[p]=!=Length[CurrentColorList],
	CurrentColorList = Take[colors,n][[perm]]];
gr1=Graphics[Table[{{CurrentColorList[[i]],
	Rectangle[{(i-1)+dx, 0+dx}, {i-dx, 1-dx}]}, {RGBColor[0,0,0],Text[i, 
	{(i-1) + 0.5,0.5}]}},{i,n}]];
gr2=Graphics[Table[{{CurrentColorList[[perm[[i]]]],
	Rectangle[{(i-1)+dx, -2+dx}, {i-dx, -1-dx}]}, {RGBColor[0,0,0],Text[perm[[i]], 
	{(i-1) + 0.5,-1.5}]}},{i,n}]];
gr3=Graphics[{RGBColor[0,0,0],Table[Arrow[{{(i-1)+.5, 0+dx},
	{q[[i]] -.5,-1-dx}}],{i,n}]}];
Show[{gr1,gr2,gr3},DisplayFunction -> $DisplayFunction]
]

SideBySideMatrices[p_,q_] := MatrixForm[{Join[Range[Length[p]],
{" "},Range[Length[q]]],Join[ToPermutation[p],{" "},
ToPermutation[q]]}]


(* ::Section:: *)
(* 49. Zd Functions*)


ZdConjugate[c_Complex] := Conjugate[c]
ZdConjugate[c_Integer] := c
ZdConjugate[(a_:0) + (b_:1) Sqrt[c_]] := a - b Sqrt[c]

ZdDivide[a_, b_] := Expand[Expand[a * ZdConjugate[b]]/Expand[b * ZdConjugate[b]]]

ZdDividesQ[d_, a_, b_] := If[ZdOKdQ[d], ZdQ[ZdDivide[b,a]], $Failed]
(* this assumes that both a and b are of the form x + y Sqrt[d] *)

DividesQ[a_Integer, b_Integer] := IntegerQ[b/a]

DividesQ[a_?ZdQ, b_?ZdQ, Radical -> d_] := ZdDividesQ[d, a, b]

ZdOKdQ[d_] := If[Head[d]=!=Integer, Message[ZdNorm::int,d]; False,
	If[d==1, Message[ZdNorm::one]; False,
		If[squareFreeQ[d], True, Message[ZdNorm::sqfree, d]; False]]]

ZdNorm[y_] := Module[{a, b, d, a1, b1, d1, x = Expand[y]},
	{d, a, b} = Switch[Head[x],
		Integer, {1,x,0},
		Complex, {-1, Re[x], Im[x]},
		Times, x /. Times[b1_, Power[d1_, Rational[1,2]]] :> {d1, 0, b1},
		Plus, x /. {Plus[a1_, Times[b1_, Power[d1_, Rational[1,2]]]] :> {d1, a1, b1},
			Plus[a1_, Power[d1_, Rational[1,2]]] :> {d1, a1, 1}},
		Power, x /. Power[d1_, Rational[1,2]] :> {d1, 0, 1}];
	If[d < 0, a^2 + Abs[d] b^2, Abs[a^2 - d b^2]]]

ZdQ[x_] := IntegerQ[x] ||
	(Head[x]===Complex && Head[Re[x]]===Integer && Head[Im[x]]===Integer) ||
	(Head[x]===Power && IntegerQ[x[[1]]] && x[[2]] === Rational[1,2]) || 
	(Head[x]===Times && Head[x[[1]]]===Integer && Head[x[[2,1]]]===Integer &&
		x[[2,2]] === Rational[1,2]) ||
	(Head[x]===Times && Head[x[[1]]]===Complex && Head[Im[x[[1]]]]===Integer &&
		Head[x[[2,1]]]===Integer && x[[2,2]] === Rational[1,2]) ||
	(Head[x]===Plus && Head[x[[1]]]===Integer && Head[x[[2]]]===Power &&
		Head[x[[2,1]]]===Integer && x[[2,2]] === Rational[1,2]) ||
	(Head[x]===Plus && Head[x[[1]]]===Integer && Head[x[[2]]]===Times &&
		Head[x[[2,1]]]===Complex && Head[Im[x[[2,1]]]]===Integer &&
		Head[x[[2,2]]]===Power && Head[x[[2,2,1]]]===Integer && 
		x[[2,2,2]] === Rational[1,2]) ||
	(Head[x]===Plus && Head[x[[1]]]===Integer && Head[x[[2]]]===Times &&
		Head[x[[2,1]]]===Integer && 
		Head[x[[2,2]]]===Power && Head[x[[2,2,1]]]===Integer && 
		x[[2,2,2]] === Rational[1,2])
			
ZdToPoint[ptlst_List] := ptlst /. {Plus[a_Integer:0, Times[Complex[0,b_Integer:1],
	Power[5, Rational[1,2]]]] -> {a , b}, a_Integer -> {a,0},
	Complex[a_, b_] -> {a,b}}
(* convert a list of numbers in Zd to points in the plane 
<{{1,0}, {0,Sqrt[d]}}> *)
	
ZdDivisorCandidates[d_Integer?Negative, num_] := ZdDivisorCandidates[d, num] =
	If[ZdOKdQ[d],
		Module[{nrm = ZdNorm[num], div},
			div = Divisors[nrm];
			Flatten[Map[ValuesHavingGivenNorm[d, #]&, div]]//Union], $Failed]
(* Given d and a number num, this returns candidates for divisors of that number *)

ZdDivisorCandidates[d_Integer?Positive, num_, max_Integer:50] := 
	If[ZdOKdQ[d],
		Module[{nrm = ZdNorm[num], div},
			div = Divisors[nrm];
			Flatten[Map[ValuesHavingGivenNorm[d, #, max]&, div]]//Union], $Failed]
(* Given d and a number num, this returns candidates for divisors of that number *)
	
PositiveZdQ[d_, num_] := 
	If[IntegerQ[num], Positive[num],
		If[d == -1, N[Re[num]]>0 && N[Im[num]] >= 0,
			If[d < -1, If[N[Re[num]]==0, N[Im[num]] > 0, N[Re[num]]>0],
				Positive[First[num /. a_ + b_ Sqrt[d] :> {a, b}]]]]]
			
zdDivisors[-1, num_] := zdDivisors[-1, num] = 
	Apply[Times,CartesianProduct[Divisors[num, 
	GaussianIntegers -> True],{1,-1,I,-I}],{1}]//Sort

zdDivisors[d_?Negative, num_] := zdDivisors[d, num] = If[ZdOKdQ[d], Module[{lst},
	Off[Power::infy, Infinity::indet];
	lst = Select[Map[{#,ZdDividesQ[d, #, num]}&, 
		ZdDivisorCandidates[d, num]],#[[2]]===True&];
	lst = Transpose[lst]//First;
	Off[Power::infy, Infinity::indet];
	lst], $Failed]

CombineByNegations[lst_List] := CombineByNegations[lst] = 
Module[{temp, comb,next, done = False,
	neg, remaining, len},
temp = Sort[lst];
comb = {};
next = First[temp];
remaining = Complement[temp, {next}];
While[Not[done],
	neg = Select[remaining, # == - next &]//Flatten;
	AppendTo[comb, Flatten[{next, neg}]//Sort];
	remaining = Complement[remaining, Flatten[{next, neg}]];
	done = (len = Length[remaining]) < 2;
	If[done,
		If[len==1, AppendTo[comb, remaining]],
		next = First[remaining]];
	];
comb]

CombineByAsociates[d_, mylst_List] := CombineByAsociates[d, mylst] =
		Module[{nlst = {}, work, done = False, assq, add,lst = mylst},
	While[Not[done],
		work = First[lst];
		assq = Map[ZdAssociatesQ[d, #, work]&, Complement[lst, {work}]];
		add = If[Or@@assq === False, {work}, 
			{work,Complement[lst, {work}][[Flatten[Position[assq, 
			True]]]]}//Flatten];
		AppendTo[nlst, add//Sort];
		lst = Complement[lst, add];
		done = lst === {}];
	nlst]
	
CombineByProducts[inlst_List, num_] := CombineByProducts[inlst, num] = 
Module[{nlst = {}, work, done = False, 
	assq, add, temp, lst = inlst},
	While[Not[done],
		work = First[lst];
		assq = Map[Expand[# * work] === num&, temp=Complement[lst,{work}]];
		add = If[Or@@assq === False, If[Expand[work * work]===num, 
			{work, work}, {work}], 
			{work,temp[[First[Flatten[Position[assq, 
			True]]]]]}];
		AppendTo[nlst, add//Sort];
		lst = Complement[lst, add];
		done = lst === {}];
	nlst]

Options[ZdDivisors] = {DivisorsComplete -> False, NonTrivialOnly -> False,
	Combine -> False};

ZdDivisors[d_?Negative, num_, opts___?OptionQ] :=  If[ZdOKdQ[d], 
	Module[{lst,
		dl=DivisorsComplete/.Flatten[{opts, Options[ZdDivisors]}],
		nto=NonTrivialOnly/.Flatten[{opts, Options[ZdDivisors]}],
		comb=Combine/.Flatten[{opts, Options[ZdDivisors]}]},
	lst = zdDivisors[d, num];
	If[nto, lst = Complement[lst, If[d == -1, {1, -1,I,-I, num, -num, num I, -num I},
		{1, -1, num, -num}]]];
	If[dl === False, lst = Select[lst, PositiveZdQ[d, #]&]];
	If[lst =!= {},
		Switch[comb,
			False, lst,
			Products, CombineByProducts[lst, num],
			Associates, CombineByAsociates[d, lst],
			Negations, CombineByNegations[lst]],
		{}]], $Failed]

zdDivisors[d_?Positive, num_, max_Integer?Positive] := zdDivisors[d, num, max] =
	If[ZdOKdQ[d], Module[{lst},
	Off[Power::infy, Infinity::indet];
	lst = Select[Map[{#,ZdDividesQ[d, #, num]}&, 
		ZdDivisorCandidates[d, num, max]],#[[2]]===True&];
	lst = Transpose[lst]//First;
	Off[Power::infy, Infinity::indet];
	lst], $Failed]

ZdDivisors[d_?Positive, num_, max_Integer?Positive, opts___?OptionQ] :=  
If[ZdOKdQ[d], 
	Module[{lst,
		dl=DivisorsComplete/.Flatten[{opts, Options[ZdDivisors]}],
		nto=NonTrivialOnly/.Flatten[{opts, Options[ZdDivisors]}],
		comb=Combine/.Flatten[{opts, Options[ZdDivisors]}]},
	lst = zdDivisors[d, num, max];
	If[nto, lst = Complement[lst, {1, -1, num, -num}]];
	If[dl === False, lst = Select[lst, PositiveZdQ[d, #]&]];
	lst = Switch[comb,
		False, lst,
		Products, CombineByProducts[lst, num],
		Associates, CombineByAsociates[d, lst],
		Negations, CombineByNegations[lst]]], $Failed]

ZdUnitQ[d_?ZdOKdQ, x_] := ZdNorm[x]==1

ZdUnits[-1] := {1, -1, I, -I}

ZdUnits[d_?ZdOKdQ] := If[d < 0, {-1, 1}]

ZdAssociatesQ[d_?ZdOKdQ, a_, b_] := Module[{q},
	q = ZdDivide[a, b];
	If[ZdQ[q],
		ZdUnitQ[d, q],
		q = ZdDivide[b, a];
		If[ZdQ[q],
			ZdUnitQ[d, q],
			False]]]

NonTrivialDivisors[n_Integer?Positive] := Complement[Divisors[n], {1,n}]

ZdIrreducibleQ[d_?Negative, x_] := If[ZdOKdQ[d], Module[{nrm,nd},
	nrm = ZdNorm[x];
	If[PrimeQ[nrm], True,
		nd = NonTrivialDivisors[nrm];
		And@@Map[Not[ZdPossibleNormQ[d, #]]&, nd]]], $Failed]
	
ZdCombineAssociates[d_?ZdOKdQ, mylst_List] := CombineByAsociates[d, mylst]

Options[IntegerDivisors] = Flatten[{Options[Divisors],
	DivisorsComplete -> False, 
	NonTrivialOnly -> False, Combine -> False}];

IntegerDivisors[num_Integer, opts___?OptionQ] := 
	Module[{lst,
		dl=DivisorsComplete/.Flatten[{opts, Options[IntegerDivisors]}],
		nto=NonTrivialOnly/.Flatten[{opts, Options[IntegerDivisors]}],
		comb=Combine/.Flatten[{opts, Options[IntegerDivisors]}]},
	lst = Divisors[num];
	If[nto, lst = Complement[lst, {1, -1, num, -num}]];
	If[dl === True, lst = Join[lst, -lst]//Union];
	lst = Switch[comb,
		False, lst,
		Products, CombineByProducts[lst, num],
		Associates, CombineByNegations[lst],
		Negations, CombineByNegations[lst]]]

FirstQuadInterior[d_Integer?Negative, nrm_] := Module[{xmax, ymax, pts, a, b},
	xmax = Floor[Sqrt[nrm]//N];
	ymax = Floor[Sqrt[nrm/Abs[d]]//N];
	pts = Flatten[Table[{a,b}, {a,0,xmax}, {b, 0, ymax}],1];
	Select[pts, ZdNorm[PtToNum[d, #]] <= nrm &]]

PtsToNorm[d_Integer?Negative, pts_List] :=
	Map[First[#]^2 - d Last[#]^2 &, pts]
	
PtsToNorm[d_Integer?Positive, pts_List] :=
	Map[Abs[First[#]^2 - d Last[#]^2] &, pts]
	
PtToNum[d_Integer, pt_List] := First[pt] + Last[pt] Sqrt[d]

AllInterior[d_Integer?Negative, nrm_] := Module[{q1, q2, a, b},
	q1 = FirstQuadInterior[d, nrm];
	q2 = q1 /. {{a_Integer, b_Integer} :> {-a, b}};
	Union[q1, q2, Join[q1, q2] /. {a_Integer, b_Integer} :> {a, -b}]]
	
ZdPossibleNormsVisual[d_Integer?Negative, nrm_] := Module[{pts, nrms, nrmlist,
		n, rules, gpts, gr1, gr2, xmax, a, b},
	pts = AllInterior[d, nrm];
	nrms = PtsToNorm[d, pts];
	nrmlist = Union[nrms];
	n = Length[nrmlist];
	xmax = Floor[Sqrt[nrm]//N] + 1;
	rules = Table[Rule[nrmlist[[i]], Hue[i/n]], {i, n}];
	gpts = Transpose[{nrms /. rules, Map[Point, pts, {1}]}];
	gr1 = Show[Graphics[{PointSize[0.015], gpts}]];
	gr2 = ContourPlot[a^2 - d b^2 == nrm, {a, -xmax, xmax}, {b, -xmax, xmax}];
	Show[{gr1, gr2},  
		Axes -> True, AspectRatio -> Automatic, Frame -> True]]
	
ZdPossibleNorms[d_Integer?Negative, nrm_] := 
	PtsToNorm[d, AllInterior[d, nrm]]//Union
		
ZdPossibleNorms[d_Integer?Negative, nrm_, Mode -> Visual] :=
	ZdPossibleNormsVisual[d, nrm]
				
ZdPossibleNormQ[d_Integer?Negative, x_] := If[ZdOKdQ[d], 
	MemberQ[ZdPossibleNorms[d, x],x], $Failed]
		
InsideEllipseQ[d_Integer?Negative, nrm_, pt_List] :=
	First[pt]^2 - d Last[pt]^2 <= nrm

GetNextPoints[d_Integer?Negative, nrm_, last_List] :=
	Module[{a = First[last], b = Last[last], x, y, in = $Failed, 
		out = $Failed, done = True},
x = a - 1;
y = b + 1;
If[InsideEllipseQ[d, nrm, {x,y}], 
	in = {x,y};
	out = {x+1, y},
	done = False;
	While[Not[done],
		If[InsideEllipseQ[d, nrm, {--x,y}],
			done = True;
			in = {x, y};
			out = {x+1, y},
			done = False || x == 0]]];
{in, out}]

NearbyIntegerEllipsePoints[d_Integer?Negative, nrm_] := Module[{pts, pt, x, 
		done = False, in , out, maxy, a, b, inn, outt},
	x = Floor[N[Sqrt[nrm]]];
	pt = {x, 0};
	If[InsideEllipseQ[d, nrm, pt], pts = {pt, {x+1, 0}}, pts = {pt}];
	in = pt;
	maxy = Floor[Sqrt[nrm/Abs[d]]//N];
	done = maxy == 0;
	While[Not[done],
		{inn, outt} = GetNextPoints[d, nrm, in];
		If[inn === $Failed, done = True,
			{in, out} = {inn, outt};
			pts = Join[pts, {in, out}];
			done = maxy == Last[in]]];
	x = First[in];
	pts = Join[pts, Flatten[Table[{{i, maxy}, {i, maxy+1}}, 
		{i, x-1, 0, -1}],1]];
	pts = pts//Union;
	pts = Join[pts, pts/.{a_, b_} :> {-a, b}]//Union;
	Join[pts, pts /. {a_, b_} :> {a, -b}]//Union]

InsideHorHyperbolaQ[d_Integer?Positive, nrm_?Positive, pt_List] :=
	First[pt]^2 - d Last[pt]^2 > nrm
	
InsideVerHyperbolaQ[d_Integer?Positive, nrm_?Negative, pt_List] :=
	First[pt]^2 - d Last[pt]^2 < nrm

OnHyperbolaQ[d_Integer?Positive, nrm_, pt_List] :=
	Abs[First[pt]^2 - d Last[pt]^2] == Abs[nrm]
		
OnNextRowQ[d_Integer?Positive, nrm_Integer?Positive, pt_List] := 
		Module[{a, b, done = False},
	{a, b} = pt;
	b++;
	While[Not[done],
		a++;
		done = InsideHorHyperbolaQ[d, nrm, {a,b}]];
	a--;
	{{a,b}, OnHyperbolaQ[d, nrm, {a,b}]}]

OnNextColumnQ[d_Integer?Positive, nrm_Integer?Negative, pt_List] := 
		Module[{a, b, done = False},
	{a, b} = pt;
	a++;
	While[Not[done],
		b++;
		done = InsideVerHyperbolaQ[d, nrm, {a,b}]];
	b--;
	{{a,b}, OnHyperbolaQ[d, nrm, {a,b}]}]
	
IntegerHyperbolaPoints[d_Integer?Positive, nrm_Integer?Negative, max_Integer:50] := 
	Module[{pts, pt, x, y, done = False, nxtpt, onQ, a, b, it = 0},
	y = Floor[N[Sqrt[Abs[nrm]]]];
	x = 0;
	pt = {x, y};
	it++;
	If[OnHyperbolaQ[d, nrm, pt], pts = {pt}, pts = {}];
	While[Not[done],
		{nxtpt, onQ} = OnNextColumnQ[d, nrm, pt];
		If[onQ, AppendTo[pts, nxtpt]];
		pt = nxtpt;
		done = it++ > max];
	pts = Join[pts, pts/.{a_Integer, b_Integer} :> {-a, b}]//Union;
	Join[pts, pts /. {a_Integer, b_Integer} :> {a, -b}]//Union]
	
IntegerHyperbolaPoints[d_Integer?Positive, nrm_?Positive, max_Integer:50] := 
	Module[{pts, pt, x, y, done = False, nxtpt, onQ, a, b, it = 0},
	x = Floor[N[Sqrt[nrm]]];
	y = 0;
	pt = {x, y};
	it++;
	If[OnHyperbolaQ[d, nrm, pt], pts = {pt}, pts = {}];
	While[Not[done],
		{nxtpt, onQ} = OnNextRowQ[d, nrm, pt];
		If[onQ, AppendTo[pts, nxtpt]];
		pt = nxtpt;
		done = it++ > max];
	pts = Join[pts, pts/.{a_Integer, b_Integer} :> {-a, b}]//Union;
	Join[pts, pts /. {a_Integer, b_Integer} :> {a, -b}]//Union]
	
AllHyperbolaPoints[d_Integer?Positive, nrm_Integer, max_Integer:50] :=
	Union[IntegerHyperbolaPoints[d, nrm, max],IntegerHyperbolaPoints[d, -nrm, max]]
	
PointsWithGivenNorm[d_Integer?Negative, nrm_] := 
	Select[NearbyIntegerEllipsePoints[d, nrm], PtsToNorm[d, {#}] == {nrm}&]

PointsWithGivenNorm[d_Integer?Positive, nrm_, max_Integer:50] := 
	AllHyperbolaPoints[d, nrm, max]
	
QuadOneQ[pt_List] := First[pt] >= 0 && Last[pt] >= 0

QuadFourQ[pt_List] := First[pt] >= 0 && Last[pt] <= 0

RightHalfQ[pt_List] := QuadOneQ[pt] || QuadFourQ[pt]
	
ValuesHavingGivenNorm[d_Integer?Negative, nrm_] :=
	Map[PtToNum[d,#]&, PointsWithGivenNorm[d, nrm]]

ValuesHavingGivenNorm[d_Integer?Positive, nrm_, max_Integer:50] :=
	Map[PtToNum[d,#]&, PointsWithGivenNorm[d, nrm, max]]

ValuesHavingGivenNorm[d_Integer?Negative, nrm_, SkipNegations -> True] :=
	Map[PtToNum[d,#]&, Select[PointsWithGivenNorm[d, nrm], RightHalfQ]]
	
RandomElement[d_Integer, max_] :=
	Random[Integer, {-max, max}] + Random[Integer, {-max, max}] Sqrt[d]
	
RandomElements[d_Integer, max_, n_Integer?Positive] := 
	Table[RandomElement[d, max], {n}]


(* ::Section:: *)
(* 50. Cosets and related topics*)


(* ::Subsection:: *)
(*50.1 finding a left or right coset*)


Options[LeftCoset] = {Mode -> Computational};

Options[LeftCosetPrivate] = {LeftMeans -> ElementOnLeft};

LeftCoset[G_?GroupoidQ, H_?GroupoidQ, g_] :=
	If[Operation[G] === Operation[H],
		LeftCoset[G, Elements[H], g],
		Message[Operation::fail]; $Failed]

LeftCoset[G_?GroupoidQ, H_?GroupoidQ, g_, opts___?OptionQ] := 
	If[Operation[G] === Operation[H],
		LeftCoset[G, Elements[H], g, opts],
		Message[Operation::fail]; $Failed]

LeftCoset[G_?GroupoidQ,H_List, g_, Mode -> Computational, opts___?OptionQ] := 
	LeftCoset[G,H,g]

LeftCoset[G_?GroupoidQ,H_List, g_] := 
	If[!ElementQ[g,G] || !SubgroupQ[H,G], 
		HandleCosetErrors[LeftCoset,G,H,g],
		If[(LeftMeans/.Flatten[{Options[LeftCosetPrivate]}])===ElementOnLeft,
			Map[Operation[G][g,#]&,H],Map[Operation[G][#,g]&,H]]]
	
LeftCoset[G_?GroupoidQ,H_List, g_, LeftMeans -> lm_] := 
	If[!ElementQ[g,G] || !SubgroupQ[H,G], 
		HandleCosetErrors[LeftCoset,G,H,g],
		If[lm===ElementOnLeft,
			Map[Operation[G][g,#]&,H],Map[Operation[G][#,g]&,H]]]

LeftCoset[G_?GroupoidQ,H_List, g_, LeftMeans-> LM_, Mode -> Textual, opts___?OptionQ] :=
	LeftCoset[G, H, g,Mode -> Textual, LeftMeans->LM, opts]

LeftCoset[G_?GroupoidQ,H_List, g_, Mode -> Textual, opts___?OptionQ] := 
		Module[{mymode,sc,lc, lm, showconvert, cm},
	lm = LeftMeans/.Flatten[{opts, Options[LeftCosetPrivate]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	If[!ElementQ[g,G] || !SubgroupQ[H,G], 
		HandleCosetErrors[LeftCoset,G,H,g],
		lc = If[lm===ElementOnLeft,
			Map[Operation[G][g,#]&,H],Map[Operation[G][#,g]&,H]];
	If[showconvert,Column[{LeftCosetTextual[G,H,lc,g,lm],
		MakeComputationalButton[cm]},Center],LeftCosetTextual[G,H,lc,g,lm]]]]

LeftCoset[G_?GroupoidQ,H_List, g_, LeftMeans-> LM_, Mode -> Visual, opts___?OptionQ] :=
	LeftCoset[G, H, g,Mode -> Visual, LeftMeans->LM]

LeftCoset[G_?GroupoidQ,H_List, g_, Mode -> Visual, opts___?OptionQ] := 
		Module[{lm,mymode,sc,lc},
	lm = LeftMeans/.Flatten[{opts, Options[LeftCosetPrivate]}];
	If[!ElementQ[g,G] || !SubgroupQ[H,G], 
		HandleCosetErrors[LeftCoset,G,H,g],
		lc = If[lm===ElementOnLeft,
			Map[Operation[G][g,#]&,H],Map[Operation[G][#,g]&,H]];
		DoVisualization[LeftCosetVisual[G,H,lc,g,lm, opts], {{G, H, g}, LeftCosetHelp}, opts],
		$Failed]]

LeftCosetHelp[G_,H_,g_]:= DoHelpMessage[windowtitle -> "Help for the left coset of H in "<>GroupoidName[G], 
	help -> List["Given the element ", 
		Cell[BoxData[FormBox[RowBox[{"g", "=",  ToBoxes[g,TraditionalForm]}], TraditionalForm]],
  FormatType->"TraditionalForm"],
		" and subgroup ",
		Cell[BoxData[FormBox[RowBox[{"H", "=",  ToBoxes[H,TraditionalForm]}], TraditionalForm]],
  FormatType->"TraditionalForm"],
		" in the group ",
	Cell[BoxData[
 FormBox["H", TraditionalForm]],
 FormatType->"TraditionalForm"],
	" = "<>GroupoidName[G]<>", we are interested in the left coset of ",
	Cell[BoxData[FormBox["H", TraditionalForm]],FormatType->"TraditionalForm"],
" in ",
	Cell[BoxData[FormBox["G", TraditionalForm]],FormatType->"TraditionalForm"],
" containing ",
Cell[BoxData[FormBox["g", TraditionalForm]],FormatType->"TraditionalForm"],
". This graphic shows that when the group operation combines the element ",
Cell[BoxData[FormBox["g", TraditionalForm]],FormatType->"TraditionalForm"],
" with each element in ",
Cell[BoxData[FormBox["H", TraditionalForm]],FormatType->"TraditionalForm"],
" (Mageneta-colored), this results in the coset pointed to by the arrow (and is Cyan-colored)."]
	]

LeftCoset[G_?GroupoidQ, H_, g_, Mode -> Interactive, InteractiveMode->mode_, opts___?OptionQ]:=
	Manipulate[LeftCoset[G, H, h, Mode -> mode, opts],{{h, g, "g \[Element] G"}, Elements[G]},
		ControlType -> RadioButtonBar]

LeftCoset[G_?GroupoidQ, H_, g_, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		LeftCoset[G, H, g, Mode->Interactive, InteractiveMode -> Computational, opts],
	"Explanation" -> LeftCoset[G, H, g,Mode->Interactive, InteractiveMode -> Textual, ShowConvert -> False, opts],
	"Visualization" -> LeftCoset[G, H, g, Mode->Interactive, InteractiveMode -> Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with LeftCoset[G, H, g]", Top]

LeftCoset[G_?GroupoidQ,H_List, g_, LeftMeans-> LM_, Mode -> All, opts___?OptionQ] :=
	LeftCoset[G, H, g, Mode -> All, LeftMeans->LM, opts]

LeftCoset[G_?GroupoidQ, H_List, g_, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> LeftCoset[G, H, g],
	"Explanation" -> LeftCoset[G, H, g, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> LeftCoset[G, H, g, Mode->Visual, ConvertMode -> "All", opts],
	"Interactive" -> LeftCoset[G, H, g, Mode->Interactive, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Left coset of "<>ToString[H,TraditionalForm]<>" in "<>GroupoidName[G]<>" containing "<>ToString[g,TraditionalForm], Top]


Options[RightCoset]={Mode -> Computational};

RightCoset[G_?GroupoidQ, H_?GroupoidQ, g_] :=
	If[Operation[G] === Operation[H],
		RightCoset[G, Elements[H], g],
		Message[Operation::fail]; $Failed]

RightCoset[G_?GroupoidQ, H_?GroupoidQ, g_, opts___?OptionQ] := 
	If[Operation[G] === Operation[H],
		RightCoset[G, Elements[H], g, opts],
		Message[Operation::fail]; $Failed]

RightCoset[G_?GroupoidQ,H_List, g_, Mode -> Computational, opts___?OptionQ] := 
	RightCoset[G, H, g]

RightCoset[G_?GroupoidQ,H_List, g_] := 
	If[!ElementQ[g,G] || !SubgroupQ[H,G], 
		HandleCosetErrors[RightCoset,G,H,g],
		If[(LeftMeans/.Flatten[{Options[LeftCosetPrivate]}])===ElementOnLeft,
			Map[Operation[G][#,g]&,H],Map[Operation[G][g,#]&,H]]]

RightCoset[G_?GroupoidQ,H_List, g_, LeftMeans -> lm_] := 
	If[!ElementQ[g,G] || !SubgroupQ[H,G], 
		HandleCosetErrors[RightCoset,G,H,g],
		If[lm===ElementOnLeft,
			Map[Operation[G][#,g]&,H],Map[Operation[G][g,#]&,H]]]

RightCoset[G_?GroupoidQ,H_List, g_, LeftMeans->LM_, Mode -> Textual, opts___?OptionQ] :=
	RightCoset[G, H, g, Mode -> Textual, LeftMeans->LM, opts]

RightCoset[G_?GroupoidQ,H_List, g_, Mode -> Textual, opts___?OptionQ] := 
		Module[{lm,mymode,sc,lc, cm},
	lm = LeftMeans/.Flatten[{opts, Options[LeftCosetPrivate]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	If[!ElementQ[g,G] || !SubgroupQ[H,G], 
		HandleCosetErrors[RightCoset,G,H,g],
		lc = If[lm===ElementOnLeft,
			Map[Operation[G][g,#]&,H],Map[Operation[G][#,g]&,H]];
	If[showconvert,Column[{RightCosetTextual[G,H,lc,g,lm],
		MakeComputationalButton[cm]},Center],RightCosetTextual[G,H,lc,g,lm]]]]

RightCoset[G_?GroupoidQ,H_List, g_, LeftMeans-> LM_, Mode -> Visual, opts___?OptionQ] :=
	RightCoset[G, H, g,Mode -> Visual, LeftMeans->LM, opts]

RightCoset[G_?GroupoidQ,H_List, g_,Mode -> Visual, opts___?OptionQ] := 
		Module[{lm,mymode,sc,lc},
	lm = LeftMeans/.Flatten[{opts, Options[LeftCosetPrivate]}];
	If[!ElementQ[g,G] || !SubgroupQ[H,G], 
		HandleCosetErrors[RightCoset,G,H,g],
		lc = If[lm===ElementOnLeft,
			Map[Operation[G][g,#]&,H],Map[Operation[G][#,g]&,H]];
	DoVisualization[RightCosetVisual[G,H,lc,g,lm, opts],{{G, H, g},RightCosetHelp}, opts],
	$Failed
	]]

RightCosetHelp[G_,H_,g_]:= DoHelpMessage[windowtitle -> "Help for the left identity of "<>GroupoidName[G], 
	help -> List["Given the element ", 
		Cell[BoxData[FormBox[RowBox[{"g", "=",  ToBoxes[g,TraditionalForm]}], TraditionalForm]],
  FormatType->"TraditionalForm"],
		" and subgroup ",
		Cell[BoxData[FormBox[RowBox[{"H", "=",  ToBoxes[H,TraditionalForm]}], TraditionalForm]],
  FormatType->"TraditionalForm"],
		" in the group ",
	Cell[BoxData[
 FormBox["H", TraditionalForm]],
 FormatType->"TraditionalForm"],
	" = "<>GroupoidName[G]<>", we are interested in the left coset of ",
	Cell[BoxData[FormBox["H", TraditionalForm]],FormatType->"TraditionalForm"],
" in ",
	Cell[BoxData[FormBox["G", TraditionalForm]],FormatType->"TraditionalForm"],
" containing ",
Cell[BoxData[FormBox["g", TraditionalForm]],FormatType->"TraditionalForm"],
". This graphic shows that when the group operation combines the element ",
Cell[BoxData[FormBox["g", TraditionalForm]],FormatType->"TraditionalForm"],
" with each element in ",
Cell[BoxData[FormBox["H", TraditionalForm]],FormatType->"TraditionalForm"],
" (Mageneta-colored), this results in the coset pointed to by the arrow (and is Cyan-colored)."]
	]


RightCoset[G_?GroupoidQ, H_, g_, Mode -> Interactive, InteractiveMode->mode_, opts___?OptionQ]:=
	Manipulate[RightCoset[G, H, h, Mode -> mode, opts],{{h, g, "g \[Element] G"}, Elements[G]},
		ControlType -> RadioButtonBar]

RightCoset[G_?GroupoidQ, H_, g_, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		RightCoset[G, H, g, Mode->Interactive, InteractiveMode -> Computational],
	"Explanation" -> RightCoset[G, H, g, Mode->Interactive, InteractiveMode -> Textual, ShowConvert -> False, opts],
	"Visualization" -> RightCoset[G, H, g, Mode->Interactive, InteractiveMode -> Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with RightCoset[G, H, g]", Top]

RightCoset[G_?GroupoidQ,H_List, g_, LeftMeans-> LM_, Mode -> All] :=
	RightCoset[G, H, g,Mode -> All, LeftMeans->LM]

RightCoset[G_?GroupoidQ, H_List, g_, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> RightCoset[G, H, g],
	"Explanation" -> RightCoset[G, H, g, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> RightCoset[G, H, g, Mode->Visual, ConvertMode -> "All", opts],
	"Interactive" -> RightCoset[G, H, g, Mode->Interactive, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Right coset of "<>ToString[H, TraditionalForm]<>" in "<>GroupoidName[G]<>" containing "<>ToString[g, TraditionalForm], Top]

HandleCosetErrors[f_,G_,H_,g_] :=
(If[!SubgroupQ[H,G], Message[MemberQ::sbgrp,H,StructureName[G]]];
If[!ElementQ[g,G], Message[MemberQ::elmnt,g,StructureName[G]]];$Failed)

LeftCosetTextual[G_,H_,gH_,g_,lm_] := 
	If[!multipleQ, Column[{CosetTextualGD[G, Left, lm], 
		LeftCosetTextualLI[G,H,gH,g,lm]}],
		If[firstPassQ, 
			firstPassQ = False;
			Column[{CosetTextualGD[G, Left,lm], 
		LeftCosetTextualLI[G,H,gH,g,lm]}],
			LeftCosetTextualLI[G,H,gH,g,lm]]]

CosetTextualGD[_, side_, lm_] := 
	"Given an element g in a Groupoid G and a subgroup H of G, the "<> If[side === Left,"left", "right"]<>" coset of H in G containing g is the set of all elements "<>If[lm === ElementOnLeft, "gH = {g h | h in H}.", "Hg = {h g | h in H}."]

LeftCosetTextualLI[G_,H_,gH_,g_, lm_] := 
StringJoin["In this case, the left coset of ",
ToString[H,TraditionalForm]," in ",StructureName[G], 
" containing ",ToString[g,TraditionalForm]," is given by ",ToString[gH,TraditionalForm],
". This can be seen as follows:\n",
makeCosetTextList[G,H,g,gH,If[lm===ElementOnLeft,Left,Right]]]

RightCosetTextual[G_,H_,gH_,g_,lm_] := 
	If[!multipleQ, Column[{CosetTextualGD[G, Right,lm], 
		RightCosetTextualLI[G,H,gH,g,lm]}],
		If[firstPassQ, 
			firstPassQ = False;
			Column[{CosetTextualGD[G, Right,lm], 
		RightCosetTextualLI[G,H,gH,g,lm]}],
			RightCosetTextualLI[G,H,gH,g,lm]]]

RightCosetTextualLI[G_,H_,Hg_,g_,lm_] := 
StringJoin["In this case, the right coset of ",
ToString[H,TraditionalForm]," in ",StructureName[G],
" containing ",ToString[g,TraditionalForm]," is given by ",ToString[Hg,TraditionalForm],
". This can be seen as follows:\n",
makeCosetTextList[G,H,g,Hg,If[lm===ElementOnLeft,Right,Left]]]

makeCosetTextList[G_,H_,g_,gH_,side_] := Module[{txt},
	Switch[OperatorSymbol[G],"+",
		Switch[side,
	Left,
			txt = StringJoin[ToString[g,TraditionalForm]," + ", ToString[H,TraditionalForm], "\n"];
			txt = txt <> StringJoin["= ",
				ToString[Map[StringJoin[ToString[g,TraditionalForm]," + ",
				ToString[#,TraditionalForm]]&,H],TraditionalForm], "\n"];
			txt = txt <> StringJoin["= ",ToString[gH,TraditionalForm]],
	Right,
			txt = StringJoin[ToString[H,TraditionalForm]," + ",ToString[g,TraditionalForm], "\n"];
			txt = txt <> StringJoin["= ",
				ToString[Map[StringJoin[ToString[#,TraditionalForm]," + ",
				ToString[g,TraditionalForm]]&,H],TraditionalForm], "\n"];
			txt = txt <> StringJoin["= ",ToString[gH,TraditionalForm]]],
			_,
		Switch[side,
	Left,
			txt = StringJoin[ToString[g,TraditionalForm]," * ",ToString[H,TraditionalForm], "\n"];
			txt = txt <> StringJoin["= ",
				ToString[Map[StringJoin[ToString[g,TraditionalForm]," * ",
				ToString[#,TraditionalForm]]&,H],TraditionalForm], "\n"];
			txt = txt <> StringJoin["= ",ToString[gH,TraditionalForm]],
	Right,
			txt = StringJoin[ToString[H,TraditionalForm]," * ",ToString[g,TraditionalForm], "\n"];
			txt = txt <> StringJoin["= ",
				ToString[Map[StringJoin[ToString[#,TraditionalForm]," * ",
				ToString[g,TraditionalForm]]&,H],TraditionalForm], "\n"];
			txt = txt <> StringJoin["= ",ToString[gH,TraditionalForm]]]
		];
	txt]
		
GroupoidElementsRows[S_,w_]:=
	Module[{n = Length[S], h,rects,lines,text},
	h = n/w;
	rects = Table[Rectangle[{i-1, j-1}, {i, j}],{j,h,1,-1},{i,w}];
	lines =	Join[Table[Line[{{0,j},{w,j}}],{j,0,h}],
		Table[Line[{{i,0},{i,h}}],{i,0,w}]];
	text = MapThread[Text[#1, #2]&,
		{S,Flatten[Table[{i-.5,j-.5},{j,h,1,-1},{i,w}],1]}];
	{rects,lines,text}
]

CosetVisual[G_,H_,gH_,side_] := 
		Module[{els,w,h,n,rects,lines,text,lc,pos,crects},
	lc = If[side===Left,LeftCosets[G,H],RightCosets[G,H]];
	pos = Position[Map[Sort,lc],Sort[gH]]//Flatten//First;
	els = lc//Flatten[#,1]&;
	n = Length[els];
	w = Length[H];
	h = n/w;
	{rects,lines,text} = GroupoidElementsRows[els,w];
	crects = If[Sort[H]===Sort[gH],
		{OtherColors[[13]],rects[[1]],OtherColors[[7]],Table[Rectangle[{i-1,h-1},{i,h-.5}],{i,w}]},
		{OtherColors[[13]],rects[[1]],OtherColors[[7]],rects[[pos]]}];
	Graphics[{crects,RGBColor[1,1,1],Rectangle[{-1,h-1},{0,h}],
	Rectangle[{w,h-1},{w+1,h}],	RGBColor[0,0,0],lines,text,
		{OtherColors[[13]],Rectangle[{0, -0.5}, {1, -0.1}]},
		{OtherColors[[7]],Rectangle[{0, -1.0}, {1, -0.6}]},
		Text["subgroup",{1.1,-0.3},{-1,0}],
		Text["coset",{1.1,-0.8},{-1,0}]}]
]

Options[LeftCosetVisual]={DisplayFunction -> $DisplayFunction};

LeftCosetVisual[G_,H_,gH_,g_,lm_,opts___] := 
	Module[{h, n = Length[Elements[G]],w = Length[H],
		cv = CosetVisual[G,H,gH,If[lm===ElementOnLeft,Left,Right]],
		showopts = FilterRules[{opts},Options[Graphics]],
		pos = Position[Map[Sort,LeftCosets[G,H,LeftMeans->lm]],Sort[gH]]//Flatten//First,dy},
	h = n/w;
	dy = If[Sort[H]===Sort[gH],.3, .5];
	Show[{cv,If[lm===ElementOnLeft,leftGraphics[g,G,h,w,dy,pos],
		rightGraphics[g,G,h,w,dy,pos]]},showopts]]
(* updated Arrow to meet V6 syntax 11/3/06 - below also *)

leftGraphics[g_,G_,h_,w_,dy_,pos_]:=
((*Print[{"left", {w+.1,h-dy},{w+.5,h-dy},{w+.5,h-pos+dy},"r",{{-.5,h-pos+dy},{-.1,h-pos+dy}}}];*)
Graphics[
		{Text[StringJoin[ToString[g,TraditionalForm]," ",OperatorSymbol[G]],{-.25,h-.5},{1,0}],
		OtherColors[[5]],Line[{{w+.1,h-dy},{w+.5,h-dy},{w+.5,h-pos+dy}}],
		Arrow[{{w+.5,h-pos+dy},{w+.1,h-pos+dy}}]}])

rightGraphics[g_,G_,h_,w_,dy_,pos_]:=
((*Print[{"right", {w+.1,h-dy},{w+.5,h-dy},{w+.5,h-pos+dy}}];*)
	Graphics[{Text[StringJoin[OperatorSymbol[G]," ",ToString[g]],{w+.25,h-.5},{-1,0}],
		OtherColors[[5]],Line[{{-.1,h-dy},{-.5,h-dy},{-.5,h-pos+dy}}],
		Arrow[{{-.5,h-pos+dy},{-.1,h-pos+dy}}]}])

RightCosetVisual[G_,H_,gH_,g_,lm_,opts___] := 
	Module[{h, n = Length[Elements[G]],w = Length[H],
		cv = CosetVisual[G,H,gH,If[lm===ElementOnLeft,Right,Left]],
		showopts = FilterRules[{opts},Options[Graphics]],
		pos = Position[Map[Sort,LeftCosets[G,H]],Sort[gH]]//Flatten//First,dy},
	h = n/w;
	dy = If[Sort[H]===Sort[gH],.3, .5];
	Show[{cv,If[lm===ElementOnLeft,rightGraphics[g,G,h,w,dy,pos],
		leftGraphics[g,G,h,w,dy,pos]]},showopts]]

FindCosetPosition[cl_,co_] :=
	(Position[Flatten[cl,1],First[co]]//Flatten//First)/
		Length[co]//Ceiling 


(* ::Subsection:: *)
(*50.2 finding all left or right cosets*)


Cosets[G_?GroupoidQ,H_List,side_] := Module[{op = Operation[G],
	findcoset},
	findcoset[{els_,cosetlist_,mside_}] := 
			Module[{temp,g,cs = cosetlist},
		temp = Fold[DeleteCases[#1, #2]&,els,Last[cs]];
		If[temp=!={}, g = First[temp];
			AppendTo[cs,Map[If[mside===Left,op[g,#]&,
				op[#,g]&],H]]];
		{temp,cs,side}];
	FixedPoint[findcoset,{Elements[G],{H},side}][[2]]
]
 
Options[LeftCosets]={Mode -> Computational};

LeftCosets[G_?GroupoidQ, H_?GroupoidQ, opts___?OptionQ] :=
	If[Operation[G] === Operation[H],
		LeftCosets[G, Elements[H], opts],
		Message[Operation::fail]; $Failed]

LeftCosets[G_?GroupoidQ,H_List, Mode-> Computational, opts___?OptionQ] :=
	LeftCosets[G, H]

LeftCosets[G_?GroupoidQ, H_List] := LeftCosets[G,H] =
	If[!SubgroupQ[H,G], Message[MemberQ::sbgrp,H,StructureName[G]];$Failed,
		If[(LeftMeans/.Flatten[{Options[LeftCosetPrivate]}])===ElementOnLeft,
			Cosets[G,H,Left],Cosets[G,H,Right]]]

LeftCosets[G_?GroupoidQ, H_List, LeftMeans -> lm_] :=
	If[!SubgroupQ[H,G], Message[MemberQ::sbgrp,H,StructureName[G]];$Failed,
		If[lm===ElementOnLeft,
			Cosets[G,H,Left],Cosets[G,H,Right]]]

LeftCosets[G_?GroupoidQ,H_List, LeftMeans-> lm_, Mode->Textual, opts___?OptionQ] := 
	LeftCosets[G, H, Mode->Textual, LeftMeans -> lm, opts]

LeftCosets[G_?GroupoidQ,H_List, Mode-> Textual, opts___?OptionQ] := 
		Module[{lm,mymode,sc,lc, showconvert, cm},
	lm = LeftMeans/.Flatten[{opts, Options[LeftCosetPrivate]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	If[!SubgroupQ[H,G], Message[MemberQ::sbgrp,H,StructureName[G]],
		lc = If[lm===ElementOnLeft,Cosets[G,H,Left],Cosets[G,H,Right]];
		If[showconvert,Column[{LeftCosetsTextual[G, H, lc],
			MakeComputationalButton[cm]},Center],text]]]

LeftCosets[G_?GroupoidQ,H_List, LeftMeans-> lm_, Mode->Visual] := 
	LeftCosets[G, H, Mode->Visual, LeftMeans -> lm]

LeftCosets[G_?GroupoidQ,H_List, Mode-> Visual, opts___?OptionQ] := 
		Module[{lm,mymode,sc,lc},
	lm = LeftMeans/.Flatten[{opts, Options[LeftCosetPrivate]}];
	If[!SubgroupQ[H,G], Message[MemberQ::sbgrp,H,StructureName[G]],
		lc = If[lm===ElementOnLeft,Cosets[G,H,Left],Cosets[G,H,Right]];
		DoVisualization[LeftCosetsVisual[G, H, lc, opts],{{G,H},LeftCosetsHelp},opts]]]

LeftCosetsHelp[G_,H_]:=  DoHelpMessage[windowtitle -> "Help for the left cosets of H in G", 
	help -> List[{"Given the subgroup ",
	Cell[BoxData[FormBox["H", TraditionalForm]], FormatType->"TraditionalForm"],
" = ", 
		Cell[BoxData[ToBoxes[H,TraditionalForm]], FormatType->"TraditionalForm"],
		" in the group ",
Cell[BoxData[FormBox["G", TraditionalForm]], FormatType->"TraditionalForm"],
" = "<>GroupoidName[G]<>", we are interested in the left cosets of ",
Cell[BoxData[FormBox["H", TraditionalForm]], FormatType->"TraditionalForm"],
" in ",
Cell[BoxData[FormBox["G", TraditionalForm]], FormatType->"TraditionalForm"],
". This graphic shows how the various cosets interact with each other when \"multiplied\" together."
		}]]

LeftCosets[G_?GroupoidQ,H_List, LeftMeans-> lm_, Mode->All, opts___?OptionQ] := 
	LeftCosets[G, H, Mode->All, LeftMeans -> lm, opts]

LeftCosets[G_?GroupoidQ, H_List, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> LeftCosets[G, H, opts],
	"Explanation" -> LeftCosets[G, H, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> LeftCosets[G, H, Mode->Visual, ConvertMode -> "All", opts]}, 
	ImageSize->Automatic],"Left cosets of "<>ToString[H,TraditionalForm]<>" in "<>GroupoidName[G], Top]

LeftCosetsTextual[G_,H_,gH_] := BothCosetsTextual[G,H,gH]
		
RightCosetsTextual[G_,H_,gH_] := BothCosetsTextual[G,H,gH]
	
BothCosetsTextual[G_,H_,cl_] :=
	Column[{StringJoin["Given the group ",StructureName[G],
	" and subgroup ", ToString[H,TraditionalForm], ", the following is the list of cosets:\n"],
	TableForm[cl, TableDepth->1]}]

LeftCosetsVisual[G_,H_,gH_,opts___] :=  SubgroupQVisual6[G,H, False]
	(* BothCosetsVisual[G,H,gH,opts] convert what is below similar to SubgroupQVisual6*)
		
RightCosetsVisual[G_,H_,gH_,opts___] := SubgroupQVisual6[G,H, False]
(* BothCosetsVisual[G,H,gH,opts]*)
		
Options[BothCosetsVisual]={DisplayFunction -> $DisplayFunction};

BothCosetsVisual[G_,H_,cl_,opts___] := 
		Module[{ind = Length[cl],gLines, gText, rects, crects,table,
			els = Flatten[cl,1],headings,len,coloredRects,hsz = Length[H],
			rl,
			showopts = FilterRules[{opts},Options[Graphics]],
			df = DisplayFunction/.Flatten[{opts, Options[BothCosetsVisual]}]},
	{gLines, gText, rects} = basicCayley[G,els, CayleyForm -> CayleyForm[G]]; 
	len = Length[els];
	rl = MapThread[Rule[BackgroundColors[[#1]],BackgroundColors[[#2]]]&,
		{Range[len],Table[i,{i,ind},{hsz}]//Flatten}];
	table = makeTable[G,els];
	coloredRects = Table[{Part[BackgroundColors,i],
		Map[rects[[#[[1]],#[[2]]]]&, Select[Position[table,
		Part[els,i]],(Length[#]==2)&]]},{i, len}];
	headings = Table[{Part[BackgroundColors,i],
			Rectangle[{i-1, len}, {i, len+1}]},{i,len}];
	headings = Join[headings,Table[{Part[BackgroundColors,i],
			Rectangle[{-1, len-i}, {0, len-i+1}]},{i,len}]];
	crects = {coloredRects,headings};
	Do[crects = crects/.rl[[Range[(i-1)*hsz+1,i*hsz]]],{i,ind}];
	If[WideElementsQ[G],
		PrintCayleyKey[els,StructureName[G],G, KeyForm[G]]];
	Show[{Graphics[crects],gLines, gText},showopts,
		DisplayFunction -> df]
]

Options[RightCosets]={Mode -> Computational};

RightCosets[G_?GroupoidQ, H_?GroupoidQ, opts___?OptionQ] :=
	If[Operation[G] === Operation[H],
		RightCosets[G, Elements[H], opts],
		Message[Operation::fail]; $Failed]

RightCosets[G_?GroupoidQ,H_List, Mode -> Computational, opts___?OptionQ] :=
	RightCosets[G,H]

RightCosets[G_?GroupoidQ,H_List] := RightCosets[G, H] =
	If[!SubgroupQ[H,G], Message[MemberQ::sbgrp,H,StructureName[G]];$Failed,
		If[(LeftMeans/.Flatten[{Options[LeftCosetPrivate]}])===ElementOnLeft,
		Cosets[G,H,Right],Cosets[G,H,Left]]]

RightCosets[G_?GroupoidQ,H_List, LeftMeans -> lm_] := 
	If[!SubgroupQ[H,G], Message[MemberQ::sbgrp,H,StructureName[G]];$Failed,
		If[lm===ElementOnLeft,
		Cosets[G,H,Right],Cosets[G,H,Left]]]

RightCosets[G_?GroupoidQ,H_List, Mode -> Textual, opts___?OptionQ] := 
		Module[{mymode,sc,lc, showconvert, cm},
	lm = LeftMeans/.Flatten[{opts, Options[LeftCosetPrivate]}];
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	If[!SubgroupQ[H,G], Message[MemberQ::sbgrp,H,StructureName[G]],
		lc = If[lm===ElementOnLeft,Cosets[G,H,Right],Cosets[G,H,Left]];
	If[showconvert,Column[{RightCosetsTextual[G, H, lc],
		MakeComputationalButton[cm]},Center],text]
]]

RightCosets[G_?GroupoidQ,H_List, Mode -> Visual, opts___?OptionQ] := 
		Module[{mymode,sc,lc},
	lm = LeftMeans/.Flatten[{opts, Options[LeftCosetPrivate]}];
	If[!SubgroupQ[H,G], Message[MemberQ::sbgrp,H,StructureName[G]],
		lc = If[lm===ElementOnLeft,Cosets[G,H,Right],Cosets[G,H,Left]];
	DoVisualization[RightCosetsVisual[G, H, lc, opts],{{G, H}, RightCosetsHelp},opts]
]]

RightCosetsHelp[G_,H_]:= DoHelpMessage[windowtitle -> "Help for the right cosets of H in G", 
	help -> List[{"Given the subgroup ",
Cell[BoxData[FormBox["H", TraditionalForm]], FormatType->"TraditionalForm"],
" = ", 
		Cell[BoxData[ToBoxes[H,TraditionalForm]], FormatType->"TraditionalForm"],
		" in the group ",
Cell[BoxData[FormBox["G", TraditionalForm]], FormatType->"TraditionalForm"],
" = "<>GroupoidName[G]<>", we are interested in the right cosets of ",
Cell[BoxData[FormBox["H", TraditionalForm]], FormatType->"TraditionalForm"],
" in ",
Cell[BoxData[FormBox["G", TraditionalForm]], FormatType->"TraditionalForm"],
". This graphic shows how the various cosets interact with each other when \"multiplied'\.10\" together."
		}]
]

RightCosets[G_?GroupoidQ, H_List, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> RightCosets[G, H],
	"Explanation" -> RightCosets[G, H, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> RightCosets[G, H, Mode->Visual, ConvertMode -> "All",opts]}, 
	ImageSize->Automatic],"Right cosets of "<>ToString[H,TraditionalForm]<>" in "<>GroupoidName[G], Top]



(* ::Subsection:: *)
(*50.3 normal subgroups, factor and quotient groups*)


Options[Index]={Mode -> Computational};

Index[G_?GroupoidQ, H_?GroupoidQ, opts___?OptionQ] :=
	If[Operation[G] === Operation[H],
		Index[G, Elements[H], opts],
		Message[Operation::fail]; $Failed]

Index[G_?GroupoidQ, H_List] := 
	If[!SubgroupQ[H,G], Message[MemberQ::sbgrp,H,StructureName[G]],
		 Length[Elements[G]]/Length[H]]

Index[G_?GroupoidQ, H_List, Mode -> Computational, opts___?OptionQ] := Index[G, H]

Index[G_?GroupoidQ, H_List, Mode -> Textual, opts___?OptionQ] := 
	IndexTextual[G, H, If[!SubgroupQ[H,G], Message[MemberQ::sbgrp,H,StructureName[G]],
		 Length[Elements[G]]/Length[H]], opts]

Index[G_?GroupoidQ, H_List, Mode -> Visual, opts___?OptionQ] := 
	DoVisualization[IndexVisual[G, H],{{G,H}, IndexHelp},opts]


IndexHelp[G_,H_]:= DoHelpMessage[windowtitle -> "Help for the index of H in G", 
	help -> List[{"Given the subgroup ",
Cell[BoxData[FormBox["H", TraditionalForm]], FormatType->"TraditionalForm"],
" = ", 
		Cell[BoxData[ToBoxes[H,TraditionalForm]], FormatType->"TraditionalForm"],
		" in the group ",
Cell[BoxData[FormBox["G", TraditionalForm]], FormatType->"TraditionalForm"],
" = "<>GroupoidName[G]<>", we are interested in the count of the left/right cosets of ",
Cell[BoxData[FormBox["H", TraditionalForm]], FormatType->"TraditionalForm"],
" in ",
Cell[BoxData[FormBox["G", TraditionalForm]], FormatType->"TraditionalForm"],
", called the index. This graphic shows how the list of cosets, which can be easily counted to determine the index."
		}]]

Index[G_?GroupoidQ, H_List, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> Index[G, H],
	"Explanation" -> Index[G, H, Mode->Textual, ConvertMode -> "All",opts],
	"Visualization" -> Index[G, H, Mode->Visual, ConvertMode -> "All",opts]}, 
	ImageSize->Automatic],"Index of "<>ToString[H]<>" in "<>GroupoidName[G], Top]

IndexTextual[G_,H_,index_, opts___?OptionQ] := Module[{text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	If[showconvert,
		Column[{IndexTextualGD[G],IndexTextualLI[G,H,index],MakeComputationalButton[cm]},Center],
		Column[{IndexTextualGD[G],IndexTextualLI[G,H,index]},Center]]
	]

IndexTextualLI[G_,H_,index_] := 
	  "In this case, the index of the subgroup " <> ToString[H]<>" in "<>GroupoidName[G]<>" is "<>ToString[index]<>"."

IndexTextualGD[_] := 
	"Given a subgroup H of a group G, we say the index of the subgroup H in G is the number of left (or right) cosets of H in G."

Options[IndexVisual]={DisplayFunction -> $DisplayFunction};

IndexVisual[G_,H_,opts___] := Module[{els,w,h,n, grid, lc},
If[SubgroupQ[H,G],
	lc =LeftCosets[G,H];
	els = lc//Flatten[#,1]&;
	n = Length[els];
	w = Length[H];
	h = n/w;
	grid = Table[Item[els[[k]],Background-> Hue[Ceiling[k/w]/h]],{k,1,n}];
	grid = Partition[grid,w];
	Panel[Grid[grid,Dividers-> All,ItemSize->Full,Spacings->Offset[1]],Cosets, Top],
	$Failed]
]

(* New version of IndexVisual added 7/17/08
removed Spacings->Offset[1] from Grid options *)

NormalQ[N_?GroupoidQ, G_?GroupoidQ] := 
	If[Operation[G] === Operation[N],
		NormalQ[Elements[N], G],
		Message[Operation::fail]; False]
		
NormalQ[N_List, G_?GroupoidQ] := NormalQ[N,G] =
	If[!SubgroupQ[N,G], Message[MemberQ::sbgrp,N,StructureName[G]]; False,
		Apply[And,Map[Union[LeftCoset[G,N,#]]===
			Union[RightCoset[G,N,#]]&,Elements[G]]]]
		
NormalQ[N_,G_,  Mode -> Computational]:= NormalQ[N,G]

NormalQ[N_,G_,  Mode -> Visual]:=
	(Message[Mode::novis]; $Failed)

NormalQ[N_,G_, Mode -> Textual]:=
	(Message[Mode::notext]; $Failed)
	
(* Added 7/26/04 *)

(* for a visual - use SubgroupQVisual2 if good - not sure
if not normal *)

goodrepresentation[G_,N_,reps_,cosets_] := 
	Module[{id,ok,idcoset,cl = Length[Elements[G]]/Length[N]},
	ok = Length[reps]===cl;
	If[ok,
		idcoset = First[cosets];
		ok = Fold[DeleteCases[#1,{x___,#2,y___}]&,cosets,reps]==={};
		If[!ok,Message[QuotientGroup::badrep,reps];{ok,{999}},
		(*{ok,Intersection[idcoset,reps]}],*)
		{ok,{GroupIdentity[G]}}],
	Message[QuotientGroup::replngth,cl];	
	{ok,{999}}]
]

ElementToCoset[Q_?GroupoidQ, el_] := 
	Module[{G, type, form, cosets, reps, coset, rep,opsymb},
	G = numerator /. Q[[3,5]];
	opsymb = OperatorSymbol[G];
	If[ElementQ[el,G],
		form = formused /. Q[[3,5]];
		cosets = cosetlist /. Q[[3,5]];
		reps = cosetreps /. Q[[3,5]];
		coset = Flatten[Select[cosets, MemberQ[#, el]&],1];
		rep = First[Flatten[Select[reps,MemberQ[coset,#]&],1]];
		coset = Switch[form,
			CosetLists, coset,
			Representatives, rep,
			Cosets, If[opsymb === "+", acoset[rep,NS],
				mcoset[rep,NS]]],
		Message[MemberQ::elmnt, el, 
			StructureName[G]]; $Failed]]
	
FactorGroup[args___] := QuotientGroup[args]

Options[QuotientGroup]={Mode -> Computational, 
	Form -> Cosets, Representatives -> Canonical};
	
Options[QuotientGroupExtra]={ShowMessage -> True};

QuotientGroup[G_?GroupoidQ, N_?GroupoidQ, opts___?OptionQ] := 
	If[Operation[G] === Operation[N],
		QuotientGroup[G, Elements[N], opts],
		Message[Operation::fail]; $Failed]
	
MessageCount[QuotientGroup,NS] = 0;

QuotientGroup[G_?GroupoidQ, N_List, opts___?OptionQ] := QuotientGroup[G, N, opts] =
	Module[{cosets,reps,mymode,sc,form,repmethod,QG,els,lm,
		opsy=OperatorSymbol[G],id,ok=True,rands, sm},
If[NormalQ[N,G],
	mymode = Mode/.Flatten[{opts, Options[QuotientGroup]}];
	form = Form/.Flatten[{opts, Options[QuotientGroup]}];
	sm = ShowMessage/.Flatten[{opts, Options[QuotientGroupExtra]}] &&
		MessageCount[QuotientGroup,NS] < 5;
	repmethod = Representatives/.Flatten[{opts, Options[QuotientGroup]}];
	cosets = LeftCosets[G,Sort[N]];
	If[repmethod===Canonical,
		reps = Map[First,cosets];
		id = GroupIdentity[G], (*else *)
		If[repmethod === Random,
			rands = Table[Random[Integer,{1,Length[cosets[[1]]]}],
				{Length[cosets]}];
			reps = MapThread[Part,{cosets,rands}]; 
			id = GroupIdentity[G], (*else *)
			reps = repmethod;
			{ok,{id}} = goodrepresentation[G,N,reps,cosets]]];
If[ok,
	If[form===Cosets,
		If[opsy==="+", 
			Format[acoset[id,NS]] := HoldForm[NS];
			Format[acoset[NS,id]] := HoldForm[NS],
			Format[mcoset[id,NS]] := HoldForm[NS];
			Format[mcoset[NS,id]] := HoldForm[NS]];
		Format[acoset[a_,NS]] := HoldForm[a + NS];
		Format[acoset[NS,a_]] := HoldForm[NS + a];
		Format[mcoset[a_,NS]] := HoldForm[a * NS];
		Format[mcoset[NS,a_]] := HoldForm[NS * a]];
	If[form===Representatives,
		QG = FormGroupoid[reps, QGRepProd[G,cosets,#1,#2,reps]&,OperatorSymbol[G],
			GroupoidName -> StructureName[G]<>"/NS", IsAGroup -> True,
			ExtraInformation -> {{True},{Identity[G]},
			{},{},{cosetlist -> cosets, cosetreps -> reps, numerator -> G, formused -> form}}],
		If[form===CosetLists,
			QG = FormGroupoid[cosets, QGListProd[G,cosets,#1,#2,reps]&,OperatorSymbol[G],
				GroupoidName -> StructureName[G]<>"/NS", WideElements -> True,
				IsAGroup -> True,
				ExtraInformation -> {{True},{N},{},{},
				{cosetlist -> cosets, cosetreps -> reps, numerator -> G, formused -> form}}],
			If[opsy==="+",
				els = Map[acoset[# , NS]&,reps];
				QG = FormGroupoid[els, QGCosetSum[G,cosets,#1,#2,reps]&,OperatorSymbol[G],
					WideElements -> True,KeyForm -> OutputForm, IsAGroup -> True,
					GroupoidName -> StructureName[G]<>"/NS",
					ExtraInformation -> {{True},{N},{},{},
					{cosetlist -> cosets, cosetreps -> reps, numerator -> G, formused -> form}}],
				els = Map[mcoset[# , NS]&,reps];
				QG = FormGroupoid[els, QGCosetProd[G,cosets,#1,#2,reps]&,OperatorSymbol[G],
					WideElements -> True,KeyForm -> OutputForm,
					GroupoidName -> StructureName[G]<>"/NS", IsAGroup -> True,
					ExtraInformation -> {{True},{NS},{},{},
					{cosetlist -> cosets, cosetreps -> reps, numerator -> G, formused -> form}}]];
		If[sm,MessageCount[QuotientGroup,NS]++; Message[QuotientGroup::NS,N]]];
		];
	normalG[QG] = NS[Apply[Sequence,N]];
	QG, $Failed],
Message[Group::notnorm,N,GroupoidName[G]];$Failed]]

(* consider a visual mode with two side-by-side Cayley tables,
one using LeftCosetsVisual and the other the Cayley Table of
quotient *)

CosetToList[G_?GroupoidQ, acoset[a_, NS]] := 
	Select[cosetlist /. G[[3,5]], MemberQ[#, a]&]//First
	
CosetToList[G_?GroupoidQ, mcoset[a_, NS]] := 
	Select[cosetlist /. G[[3,5]], MemberQ[#, a]&]//First

CosetToList[G_?GroupoidQ, acoset[NS, a_]] := 
	Select[cosetlist /. G[[3,5]], MemberQ[#, a]&]//First

CosetToList[G_?GroupoidQ, mcoset[NS, a_]] := 
	Select[cosetlist /. G[[3,5]], MemberQ[#, a]&]//First

CosetToList[G_?GroupoidQ, coset_] := Module[{rep, a, opsy =
		OperatorSymbol[G], lc, ok},
	rep = Switch[Head[coset],
		Symbol, If[coset===NS, If[opsy === "+", 0, 1], Null],
		Plus, If[opsy === "+", coset /. a_ + NS :> a, Null],
		Times, If[opsy =!= "+", coset /. a_ NS :> a, Null],
		_, Null];
	lc = cosetlist /. G[[3,5]];
	ok = MemberQ[Flatten[lc, 1], rep];
	If[ok, 	Select[lc, MemberQ[#,rep]&]//First,
		Message[CosetToList::illformed, coset]; $Failed]]

QGRepProd[G_,cosets_,g_,h_,reps_] := 
		Module[{op = Operation[G],Gprod,coset,prod},
	Gprod = op[g,h];
	coset = Select[cosets, MemberQ[#,Gprod]&]//First;
	prod = Select[reps,MemberQ[coset,#]&]//First]

QGListProd[G_,cosets_, gl_List,hl_List,reps_] := Module[{pr},
	pr = QGRepProd[G, cosets, First[gl], First[hl],reps];
	Select[cosets, MemberQ[#,pr]&]//First]
	
findcosetproduct[G_,cosets_,g_,h_,reps_] := 
		Module[{coset},
coset = Select[cosets, MemberQ[#,Operation[G][g,h]]&]//First;
Select[reps,MemberQ[coset,#]&]//First]

QGCosetSum[G_,cosets_,(a_:id) + NS,(b_:id)+ NS,reps_] := 
		Module[{g,h,gi = GroupIdentity[G]},
	{g,h} = {a,b}/. id -> gi;
	acoset[findcosetproduct[G,cosets,g,h,reps], NS]]

QGCosetSum[G_,cosets_,NS + (a_:id),NS + (b_:id),reps_] := 
		Module[{g,h,gi = GroupIdentity[G]},
	{g,h} = {a,b}/. id -> gi;
	acoset[findcosetproduct[G,cosets,g,h,reps], NS]]

QGCosetSum[G_,cosets_,acoset[a_ ,NS],acoset[b_,NS],reps_] := 
		acoset[findcosetproduct[G,cosets,a,b,reps], NS]

QGCosetSum[G_,cosets_,acoset[NS,a_],acoset[NS,b_],reps_] := 
		acoset[findcosetproduct[G,cosets,a,b,reps], NS]

QGCosetProd[G_,cosets_,(a_:id) * NS,(b_:id)* NS,reps_] := 
		Module[{g,h,gi = GroupIdentity[G]},
	{g,h} = {a,b}/. id -> gi;
	mcoset[findcosetproduct[G,cosets,g,h,reps], NS]]

QGCosetProd[G_,cosets_,NS * (a_:id),NS * (b_:id),reps_] := 
		Module[{g,h,gi = GroupIdentity[G]},
	{g,h} = {a,b}/. id -> gi;
	mcoset[findcosetproduct[G,cosets,g,h,reps], NS]]

QGCosetProd[G_,cosets_,mcoset[NS,a_],mcoset[NS,b_],reps_] := 
	mcoset[findcosetproduct[G,cosets,a,b,reps], NS]
		
QGCosetProd[G_,cosets_,mcoset[a_,NS],mcoset[b_,NS],reps_] := 
	mcoset[findcosetproduct[G,cosets,a,b,reps], NS]


(* ::Section:: *)
(*53. Pascal*)


PascalRow[a_,b_,G_,0]:={a};

PascalRow[a_,b_,G_,1]:={a,b};

PascalRow[a_,b_,G_,n_]:=PascalRow[a,b,G,n]=(Prepend[#1,a]&)[(Append[#1,b]&)[((Operation[G][First[#1],Last[#1]]&)/@#1&)[(Partition[#1,2,1]&)[PascalRow[a,b,G,n-1]]]]]


Pascal[a_,b_,G_,n_]:=(PascalRow[a,b,G,#1]&)/@Range[0,n]
Pascal[a_,b_,G_,n_,Mode->Visual]:=
	Module[{comp=Pascal[a,b,G,n],rowdisplay,m,row,rules,k},
	rules=((#1->#2&)@@#1&)/@Transpose[{Elements[G],Table[BackgroundColors[[k]],{k,1,Length[Elements[G]]}]}];
	rowdisplay[m_,row_]:=(({#1/.rules,Point[{#2,-m}]}&)@@#1&)/@Transpose[{row,Range[-m/2,m/2,1]}];
	Show[Graphics[{PointSize[1.1/n],(rowdisplay[#1,comp[[#1+1]]]&)/@Range[0,n]}]]]


(* ::Section:: *)
(* 55. Morphoid Definitions*)


(* ::Subsection:: *)
(*general*)


GroupoidQ[G_] := (Head[G]===Groupoid || Head[G]===groupoid) && 
	Head[First[G]]===List

GroupoidQ[many:{_groupoid..}] := Map[GroupoidQ,many]

GroupoidQ[many:{_Groupoid..}] := Map[GroupoidQ,many]

RingoidQ[R_] := (Head[R]===Ringoid || Head[R]===ringoid) && 
	Head[First[R]]===List

RingoidQ[many:{_ringoid..}] := Map[RingoidQ,many]

RingoidQ[many:{_?RingoidQ..}] := Map[RingoidQ,many]

StructuredSetQ[S_] := GroupoidQ[S] || RingoidQ[S]

StructuredSetQ[S_List] := Map[StructuredSetQ,S]


(* ::Subsection:: *)
(*Morphoid Form & Formation*)


StringRule[rule_] := Module[{lst},
		lst = rule /. Rule[x_,y_] :> Rule[ToString[x],ToString[y]];
		If[$VersionNumber < 2.5, ToString[lst],
			lst /. Rule[x_, y_] :> x<>" -> "<>y]
]

Format[morphoid[f_,S1_?StructuredSetQ,S2_?StructuredSetQ,str_,ft_,opts___?OptionQ]] :=
	Module[{fmt=FormatFunction/.Flatten[{opts, Options[FormMorphoid]}],
		gr=First[GeneratingRule/.Flatten[{opts, Options[PrivateFormMorphoid]}]],
		ce=ConjugatingElement/.Flatten[{opts, Options[PrivateFormMorphoid]}],
		fts = If[ft===Rule, "-Rules-","-Function-"]},
	If[fmt===True,
		Morphoid[fts,"-"<>StructureName[S1]<>"-","-"<>StructureName[S2]<>"-"],
		If[fmt===Rule,
			Morphoid[StringRule[gr],"-"<>StructureName[S1]<>"-","-"<>StructureName[S2]<>"-"],
			If[fmt===Conjugation,
				Morphoid["Conjugation by "<>ToString[KeyForm[S1][ce]],"-"<>StructureName[S1]<>"-","-"<>StructureName[S2]<>"-"],
				Morphoid[f,"-"<>StructureName[S1]<>"-","-"<>StructureName[S2]<>"-"]]]]]
	
MorphoidQ[f_] :=  ValidMorphFuncQ[First[f]] &&
	StructuredSetQ[f[[2]]] && StructuredSetQ[f[[3]]]
	
ValidMorphFuncQ[f_] := (Head[f]==Symbol || Head[f]==Function ||
	(Head[f]==List && Head[f[[1]]]==Rule))
	
MorphoidRules[f_?MorphoidQ] := f[[1]] (* for external use *)

MorphoidFunction[f_?MorphoidQ] := f[[1]] (* for external use *)

Domain[f_?MorphoidQ] := f[[2]] (* for external use *)

Codomain[f_?MorphoidQ] := f[[3]] (* for external use *)

MorphoidStructure[f_?MorphoidQ] := f[[4]] (* for internal use *)

MorphoidType[f_?MorphoidQ] := f[[5]] (* for internal use *)

MorphoidOptions[f_?MorphoidQ] := Apply[List, Drop[f, 5]]
(* for internal use *)

morphoid[f_,S1_?StructuredSetQ,S2_?StructuredSetQ,_,Rule,opts__][x_]:=
		Which[ElementQ[x,S1], x/.f,
			ElementsQ[x, S1], x/.f,
			True, Message[MemberQ::elsbst, x, S1]; $Failed];
		
morphoid[f_,S1_?StructuredSetQ,S2_?StructuredSetQ,_,Function,opts__][x_]:=
		Which[ElementQ[x, S1], f[x],
			ElementsQ[x, S1], Map[f, x],
			True, Message[MemberQ::elsbst, x, S1]; $Failed];
 
Options[FormMorphoid]={Mode -> Computational, FormatFunction->False};

Options[PrivateFormMorphoid]={GeneratingRule -> {Null}, 
ConjugatingElement->Null};
	
FormMorphoid[f_Function, S1_?StructuredSetQ,S2_?StructuredSetQ,
	opts___?OptionQ] :=
	Module[{head1=Head[S1],head2=Head[S2],structure,
	 		 ff = FormatFunction/.Flatten[{opts, Options[FormMorphoid]}],
	 		 ce = ConjugatingElement/.Flatten[{opts, Options[PrivateFormMorphoid]}],
	 		 gr = GeneratingRule/.Flatten[{opts, Options[PrivateFormMorphoid]}]},
		If[head1 === head2,
			structure = Switch[head1,
					groupoid, Group,
					ringoid, Ring];	
		If[SubsetQAA[Map[f,Elements[S1]], Elements[S2]],
			morphoid[f,S1,S2,structure,Function,
												FormatFunction->ff, GeneratingRule -> gr,ConjugatingElement->ce],
			Message[Morphoid::fail,f,StructureName[S1],StructureName[S2]];$Failed],
			$Failed]]

FormMorphoid[args__, Mode -> Visual, opts___?OptionQ] := Module[{f},
	f = FormMorphoid[args, opts];
	VisualizeMorphoid[f, opts]]
	
FormMorphoid[f_Symbol, 
					S1_?StructuredSetQ,
					S2_?StructuredSetQ,
					opts___?OptionQ] :=
				FormMorphoid[f[#]&,S1,S2,opts];

FormMorphoid[rules:{_Rule..},
			 S1_?StructuredSetQ,
			 S2_?StructuredSetQ,
			 opts___?OptionQ] :=
	Module[{head1=Head[S1],head2=Head[S2],structure,sets,
	 		 ff=FormatFunction/.Flatten[{opts, Options[FormMorphoid]}], 
	 		 ce = ConjugatingElement/.Flatten[{opts, Options[PrivateFormMorphoid]}],
	 		 gr = GeneratingRule/.Flatten[{opts, Options[PrivateFormMorphoid]}]},
		If[head1===head2,structure=Switch[head1,
										groupoid,Group,
										ringoid,Ring];	
		sets = Apply[List,rules,1]//Transpose;
		If[Length[rules] > 20, ff = True];
		(* I picked 20, but this can be changed, to say that the list of
		rules should be formatted. *)
		If[Equal[Sort[Elements[S1]],Sort[First[sets]]] && 
		       SubsetQAA[Last[sets],Elements[S2]],
			morphoid[rules,S1,S2,structure, Rule,
			 										FormatFunction -> ff,
			 									 GeneratingRule -> gr,
			 									 ConjugatingElement->ce],
			If[Not[Equal[Sort[Elements[S1]],Sort[First[sets]]]],
			Message[Morphoid::domain,rules,StructureName[S1]]; $Failed,
			Message[Morphoid::range,rules,StructureName[S2]]; $Failed]],
			$Failed]]

semiop[x_,op_] := op[x,#]&

CyclicQ[R_?RingoidQ] := CyclicQ[TempGroupoid[R[[1]], R[[2]]]] 

FormMorphoid[gen_ -> im_, G_?CyclicQ, H_?StructuredSetQ, opts___?OptionQ] :=
        Module[{dom,rng, len = Length[Elements[G]], rules,s1=Head[G],s2=Head[H]},
                dom = NestList[semiop[gen,Addition[G]],gen,len-1];
                rng = NestList[semiop[im,Addition[H]],im,len-1];
                rules = Apply[Rule,Transpose[{dom,rng}],1];
	If[s1===s2, 
		id1 = GroupIdentity[If[GroupoidQ[G], G, TAGroupoid[G]]];
		id2 = GroupIdentity[If[GroupoidQ[H], H, TAGroupoid[H]]];
		rules = rules/. Rule[id1,_] :> Rule[id1, id2];
		(* to ensure that identities match up *)
		morphoid[rules, G, H, If[s1===groupoid, Group,Ring], Rule, FormatFunction -> Rule, 
                	GeneratingRule -> {Rule[gen, im]}],
               Message[FormMorphoid::badstruc]; $Failed]]

RulesByPosition[S1_List,S2_List,pos_List]:=
  Module[{n=Length[S2]},
   If[(Length[S1]=!=Length[pos])||(Union[pos,Range[1,n]]=!=Range[1,n]),"Error",
       Transpose[{S1,Map[S2[[#]]&,pos]}]//Map[Rule[First[#],Last[#]]&,#]&]]

FormMorphoid[pos:{_Integer..},
						S1_?StructuredSetQ,
						S2_?StructuredSetQ,
						opts___?OptionQ]:=
Module[{mymode=Mode/.{opts}/.Options[FormMorphoid],
		s1=Head[S1],s2=Head[S2],structure},
	If[s1===s2,structure=Which[s1===groupoid,Group,
						  s1===ringoid,Ring,
						  True,Null]];
	If[(structure===Group)||(structure===Ring),
		Which[mymode==Computational,
    		If[(Length[First[S1]]=!=Length[pos])||
   				(Union[pos,Range[1,Length[First[S2]]]]=!=Range[1,Length[First[S2]]]),
				Message[FormMorphoid::badpos];$Failed,
				FormMorphoid[RulesByPosition[S1[[1]],S2[[1]],pos],
							 S1,S2,opts]],
			True,Message[Mode::notavail,FormMorphoid,mymode]],
			Message[Morphoid::badarg,FormMorphoid];$Failed]];
				 
Options[FormMorphoidSetup]={Mode->Visual};

FormMorphoidSetup[S1_?StructuredSetQ,
						S2_?StructuredSetQ,opts___?OptionQ]:=
	Module[{m,n,mp,np,r1,r2,T1=First[S1],T2=First[S2],
			mymode=Mode/.{opts}/.Options[FormMorphoidSetup]},
			Which[mymode===Visual,
			m=Length[T1];n=Length[T2];
			mp=Quotient[m,2];np=Quotient[n,2];
			r1=Range[1,m];r2=Range[1,n];
			{Line[{{0,Min[mp-m-1,np-n-1]},{0,Max[mp+1,np+1]}}],
			(* removed the -2 and +2 in calculations of line height *)
				Text["Domain\n",{-6,mp}],Text["Codomain\n",{6,np}],
			 Map[{Text[KeyForm[S1][T1[[#]]],{-6,-#+mp}],
			     Text[#,{-1,-#+mp}]}&,r1],
			 Map[{Text[KeyForm[S2][T2[[#]]],{6,-#+np}],
			     Text[#,{1,-#+np}]}&,r2]}//Graphics//
			     Show[#,PlotRange->{{-10,10},
			                  {Min[mp-m-2,np-n-2],Max[mp+2,np+2]}}]&,
			mymode===Interactive,
				MorphoidSetupMenu[S1,S2,opts],
			      True,Message[Mode::notavail,FormMorphoidSetup,mymode]]]


(* ::Subsection:: *)
(*Automorphisms*)


(* ::Subsubsection:: *)
(*Automorphism*)


Options[Automorphism]={Mode->Computational};

(* removed Mode->Computational in the definition below
and in the second where it is called - 11/4/06  trying to solve recursion error *)

Automorphism[G_?GroupoidQ,a_->b_]:=
If[CyclicQ[G],
If[(OrderOfElement[G,a]==Size[G])&&
      (OrderOfElement[G,b]==Size[G]),
	FormMorphoid[Map[{ElementToPower[G,a,#],
						ElementToPower[G,b,#]}&,Range[1,Size[G]]]//
						Sort[#,(First[#1]<First[#2])&]&//
						Map[Apply[Rule,#]&,#]&,G,G,
           			 FormatFunction->Rule, GeneratingRule ->{Rule[a, b]}],
	Message[Automorphism::badrule,GroupoidName[G]]; $Failed],
	(Message[Automorphism::nosup];$Failed)];

Automorphism[G_?GroupoidQ,a_->b_, Mode->Computational, opts___?OptionQ] := Automorphism[G,a -> b]

Automorphism[G_?GroupoidQ,a_->b_, Mode->Textual, opts___?OptionQ] := Module[{text, showconvert, cm},
	text =AutomorphismTextual[G, a->b];
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]

Automorphism[G_?GroupoidQ,a_->b_, Mode->Visual, opts___?OptionQ] := 
	DoVisualization[VisualizeMorphoid[Automorphism[G, a->b]],{{G, a, b},AutomorphismHelp},opts]

AutomorphismHelp[G_, a_, b_]:= DoHelpMessage[windowtitle -> "Help for the automorphism generated by a \[RightArrow] b", 
	help -> List["This shows the result of the automorphism generated by the rule ",
	Cell[BoxData[
  FormBox[
   RowBox[{"a", "\[RightArrow]", "b"}], 
   TraditionalForm]],
  FormatType->"TraditionalForm"],
	" where ",
	Cell[BoxData[FormBox["a", TraditionalForm]], FormatType->"TraditionalForm"],
	" = ",
	Cell[BoxData[ToBoxes[a,TraditionalForm]], FormatType->"TraditionalForm"],
		" and ",
	Cell[BoxData[FormBox["b", TraditionalForm]], FormatType->"TraditionalForm"],
	" = ",
	Cell[BoxData[ToBoxes[b,TraditionalForm]], FormatType->"TraditionalForm"],
	". The arrows show how the map is defined on this group ", GroupoidName[G],"."]
]

Automorphism[G_?GroupoidQ,a_->b_, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> Automorphism[G, a->b],
	"Explanation" -> Automorphism[G, a->b, Mode->Textual, ConvertMode->"All", opts],
	"Visualization" -> Automorphism[G, a->b, Mode->Visual, ConvertMode->"All",opts]}, 
	ImageSize->Automatic],"An automorphism based on two generators", Top]


AutomorphismTextual[G_?GroupoidQ,a_->b_]:=
  Module[{ord=OrderOfElement[G,a],
         sumstring, txt,
         symb=ToString[OperatorSymbol[G]]},
   	sumstring=Module[{as=ToString[#1]},
	If[#2<4,Nest[(#<>symb<>as)&,as,#2-1],
		as<>symb<>as<>symb<>"<<"<>ToString[#2-3]<>">>"<>symb<>as]]&;
	Map[{#,ElementToPower[G,a,#],
			ElementToPower[G,b,#]}&,Range[2,ord]]//
	 Map[(ToString[#[[2]]]<>" = "<>
	 		sumstring[a,#[[1]]]<>" is mapped to "<>
	 		sumstring[b,#[[1]]]<>" = "<>
	 		ToString[#[[3]]])&,#]&//
	 		Map[StringJoin,#]&//Column]
 

Options[AutomorphismGroup]={Mode->Computational};

AutomorphismGroup[G_,opts___?OptionQ]:=
   Module[{gens,fg,
        	ff=FormatFunction/.Flatten[{opts, Options[MorphoidComposition]}]},
   If[CyclicQ[G],gens=CyclicGenerators[G];fg=First[gens];
       Map[Automorphism[G,fg->#,Mode -> Computational]&,gens]//
		FormGroupoid[#,MorphoidComposition[#1,#2]&,"*",
		             GroupoidName->"Aut["<>GroupoidName[G]<>"]",
		             GroupoidDescription->"Automorphism group of "<>GroupoidName[G],
		             KeyForm->OutputForm,
		             IsAGroup->True,
		             WideElements->True,
		             CayleyForm->OutputForm]&,
		Message[AutomorphismGroup::nosup];
									$Failed]];
									
Unprotect[Aut];

Aut[G_?GroupoidQ,opts___?OptionQ]:=AutomorphismGroup[G,opts];

Protect[Aut];


(* ::Subsubsection:: *)
(*Inner Automorphisms*)


Options[InnerAutomorphism]={FunctionForm->Rules};

Options[InnerAutomorphismPrivate]={FormatFunction->Conjugation};

InnerAutomorphism[G_?GroupoidQ, g_, opts___?OptionQ] :=
Module[{ff=FormatFunction/.Flatten[{opts, Options[InnerAutomorphismPrivate]}],
		funform=FunctionForm/.Flatten[{opts, Options[InnerAutomorphism]}],
		f,Sd=Sort[Elements[G]]},
    If[InvertibleQ[G, g],Which[funform===Rules,
		f=Map[Rule[#[[1]],#[[2]]]&,Transpose[{Sd,
			      Map[(Operation[G][Operation[G][GroupInverse[G, g],
			                                     #],g])&,Sd]}]],
		True,f=(Operation[G][Operation[G][GroupInverse[G, g],#],g])&];
		FormMorphoid[f,G,G,FormatFunction->ff,ConjugatingElement->g],
		Message[InnerAutomorphism::noinv, g];$Failed]]

ConjugationComposition[f_?MorphoidQ,g_?MorphoidQ,cosets_,opts___?OptionQ]:=
			Module[{cf,cg,interm,ccomp,	op=Operation[f[[2]]]},
						cf=ConjugatingElement/.Options[f];
						cg=ConjugatingElement/.Options[g];
						interm=op[cg,cf];
						ccomp=First[First[Select[cosets,MemberQ[#,interm]&]]];
						MorphoidComposition[f,g,FormatFunction->Conjugation,
																								ConjugatingElement->ccomp]]

ConjugationComposition[f_?MorphoidQ,g_?MorphoidQ,{{elem_}...},opts___?OptionQ]:=
			Module[{cf,cg,interm,ccomp,	op=Operation[f[[2]]]},
						cf=ConjugatingElement/.Options[f];
						cg=ConjugatingElement/.Options[g];
						ccomp=op[cg,cf];
						MorphoidComposition[f,g,FormatFunction->Conjugation,																		ConjugatingElement->ccomp]]

InnerAutomorphismGroup[G_?GroupoidQ]:=
	If[Not[GroupQ[G]],Message[InnerAutomorphismGroup::nogroup, G];$Failed,
	Module[{center=GroupCenter[G],cosets},
	cosets=LeftCosets[G,center];
	(reps=Map[First,LeftCosets[G,center]])//
		Map[InnerAutomorphism[G,#,FunctionForm->Rules, FormatFunction->Conjugation]&,#]&//
		FormGroupoid[#,ConjugationComposition[#1,#2,cosets, FormatFunction->Conjugation]&,
			"*",
		             GroupoidName->"Inn["<>GroupoidName[G]<>"]",
		             GroupoidDescription->"Inner automorphism group of "<>GroupoidName[G],
		             IsAGroup->True,
		             KeyForm->OutputForm, 
		             WideElements->True,
		             FormatElements -> True,
		             OperatorSymbol->"\[Degree]"]&]]

Inn[G_?GroupoidQ] := InnerAutomorphismGroup[G]


(* ::Subsection:: *)
(*Comparison of Morphoids*)


SameMorphFunctionQ[f_?MorphoidQ,g_?MorphoidQ]:=
	Module[{},
	    If[(Sort[f[[2,1]]]===Sort[g[[2,1]]]),
	    Fold[(#1&&(f[#2]===g[#2]))&,
	             f[f[[2,1,1]]]===g[f[[2,1,1]]],
	             Rest[f[[2,1]]]   ],
	    False,False]]; (* internal *)

EqualMorphoidQ[f_?MorphoidQ, g_?MorphoidQ]:=
	Module[{},(Sort[f[[2,1]]]===Sort[g[[2,1]]])&&
	          (Sort[f[[3,1]]]===Sort[g[[3,1]]])&&
	          Head[f[[2,1]]]===Head[g[[2,1]]]&&
	          Head[f[[3,1]]]===Head[g[[3,1]]]&&
	          SameMorphFunctionQ[f,g]]


(* ::Subsection:: *)
(*PreservesQ*)


Options[PreservesQ]={Mode -> Computational,
                    Structure :> DefaultStructure};

PreservesQ[rules:{_Rule..},{S1_List,op1_}, {S2_List,op2_}, {a_, b_}] := 
	PreservesGroupQ[rules,{op1,op2},{a,b}]

PreservesQ[f_Function,{S1_List,op1_}, {S2_List,op2_}, {a_, b_}] := 
	PreservesGroupQ[f,{op1,op2},{a,b},S1,S2]

PreservesQ[f_Symbol,{S1_List,op1_}, {S2_List,op2_}, {a_, b_}] := 
	PreservesGroupQ[f,{op1,op2},{a,b},S1,S2]

PreservesQ[rules:{_Rule..},{S1_List,op1_,op3_},{S2_List,op2_,op4_},{a_, b_}] := 
	PreservesGroupQ[rules,{op1,op2},{a,b}] &&
	PreservesGroupQ[rules,{op3,op4},{a,b}]
	
PreservesQ[f_Function,{S1_List,op1_,op3_},{S2_List,op2_,op4_},{a_, b_}] := 
	PreservesGroupQ[f,{op1,op2},{a,b},S1,S2] &&
	PreservesGroupQ[f,{op3,op4},{a,b},S1,S2]

PreservesQ[f_Symbol,{S1_List,op1_,op3_},{S2_List,op2_,op4_},{a_, b_}] := 
	PreservesGroupQ[f,{op1,op2},{a,b},S1,S2] &&
	PreservesGroupQ[f,{op3,op4},{a,b},S1,S2]
	
PreservesQ[args__, Mode -> Computational]:= PreservesQ[args]

PreservesQ[f_?MorphoidQ, {a_, b_}] := Module[{
		structure,mymode,p},
		structure=f[[4]];
	p= Switch[structure,
	 	 	Group,PreservesQ[First[f],{f[[2,1]],f[[2,2]]},{f[[3,1]],f[[3,2]]},	{a,b}],
			Ring,PreservesQ[First[f],{f[[2,1]],f[[2,2]],f[[2,3]]},{f[[3,1]],f[[3,2]],f[[3,3]]},	
			{a,b}]]
]

PreservesQ[f_?MorphoidQ, {a_, b_}, Mode -> Textual, opts___?OptionQ] := 
	PreservesQTextual[f,{a,b}, opts]

PreservesQTextual[f_?MorphoidQ, {a_, b_}, opts___?OptionQ] := 
	Module[{text, showconvert, cm, presq},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	presq = PreservesQ[f, {a, b}];
	text = StringJoin["A function f: G \[RightArrow] H acts as a morphism for the pair {x, y} in (G, *) we have f(x*y)=f(x)#f(y) where # is  the operation in H. When this holds for the pair, we say that the Morphoid preserves this pair. In our case, our morphoid f, given as ",
		ToString[f,TraditionalForm],
		If[presq, ", DOES preserve the pair"<>ToString[{a,b},TraditionalForm]<>".",
			", DOES NOT preserve the pair"<>ToString[{a,b},TraditionalForm]<>". Use the Visual mode to see why the pair fails."]
	];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]

PreservesQ[f_?MorphoidQ, {a_, b_}, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> PreservesQ[f, {a,b}],
	"Explanation" -> PreservesQ[f, {a,b}, Mode->Textual, ShowConvert->False],
	"Visualization" -> PreservesQ[f, {a,b}, Mode->Visual, ShowConvert->False,opts],
	"Interactive" -> PreservesQ[f, {a,b}, Mode->Interactive, ShowConvert->False,opts]}, 
	ImageSize->Automatic],"Does the Morphoid f preserve {a, b}", Top]

PreservesQ[f_?MorphoidQ, {a_, b_}, Mode->Visual, opts___?OptionQ] := 
	DoVisualization[PreservesQVisual[f,{a,b}],{{f,{a,b}},PreservesQVisualHelp}, opts]
	
PreservesQVisualHelp[f_,{a_,b_}]:= DoHelpMessage[windowtitle -> "Help for PreservesQ[f, {a,b}]", 
		help -> List["Given the Morphoid ",
Cell[BoxData[FormBox["f", TraditionalForm]], FormatType->"TraditionalForm"],
		" = " ,
	Cell[BoxData[ToBoxes[f,TraditionalForm]], FormatType->"TraditionalForm"],
	" and pair of points ",
Cell[BoxData[
  FormBox[
   RowBox[{"{", 
    RowBox[{"a", ",", "b"}], "}"}], TraditionalForm]],
  FormatType->"TraditionalForm"],
	" = ",
	Cell[BoxData[ToBoxes[{a,b},TraditionalForm]], FormatType->"TraditionalForm"],
	" in the domain of ",
Cell[BoxData[FormBox["f", TraditionalForm]], FormatType->"TraditionalForm"],
	", we are interested in whether the map ",
	Cell[BoxData[FormBox["f", TraditionalForm]], FormatType->"TraditionalForm"],
" preserves the operations in the domain and codomain for this pair. In other words, we want to know if ",
Cell[BoxData[
  FormBox[
   RowBox[{
    RowBox[{"f", "(", 
     RowBox[{"a", "*", "b"}], ")"}], "=", 
    RowBox[{
     RowBox[{"f", "(", "a", ")"}], "#", 
     RowBox[{"f", "(", "b", ")"}]}]}], TraditionalForm]],
  FormatType->"TraditionalForm"],
" where * is the operation in the domain and # is the operation in the codomain. In the graphic, the domain elements ",
Cell[BoxData[
  FormBox[
   RowBox[{"{", 
    RowBox[{"a", ",", "b"}], "}"}], TraditionalForm]],
  FormatType->"TraditionalForm"],
" are on the left, as is the product ",
Cell[BoxData[
  FormBox[
   RowBox[{"a", "*", "b"}], TraditionalForm]],
  FormatType->"TraditionalForm"],
". On the right are the images of ",
Cell[BoxData[FormBox["a", TraditionalForm]], FormatType->"TraditionalForm"],
" (namely ",
Cell[BoxData[
  FormBox[
   RowBox[{"f", "(", "a", ")"}], TraditionalForm]],
  FormatType->"TraditionalForm"],
") and ",
Cell[BoxData[FormBox["b", TraditionalForm]], FormatType->"TraditionalForm"],
" (",
Cell[BoxData[
  FormBox[
   RowBox[{"f", "(", "b", ")"}], TraditionalForm]],
  FormatType->"TraditionalForm"],") and then we multiply (using the group operation in the codomain) these two and check to see if is the same as the image of ",
Cell[BoxData[
  FormBox[
   RowBox[{"a", "*", "b"}], TraditionalForm]],
  FormatType->"TraditionalForm"],"."
		]]

PreservesQ[f_?MorphoidQ, {a_, b_}, Mode -> Interactive, InteractiveMode->mode_, opts___?OptionQ]:=
	Manipulate[PreservesQ[f, h, Mode -> mode],{{h, {a,b}, "{g, h} \[Subset] G"}, 
	CartesianProduct[Elements[Domain[f]],Elements[Domain[f]]]},
		ControlType -> RadioButtonBar]
	
PreservesQ[f_?MorphoidQ, {a_, b_}, Mode -> Interactive, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> 
		PreservesQ[f, {a,b}, Mode->Interactive, InteractiveMode -> Computational, opts],
	"Explanation" -> PreservesQ[f,{a,b}, Mode->Interactive, InteractiveMode -> Textual, ShowConvert -> False, opts],
	"Visualization" -> PreservesQ[f,{a,b}, Mode->Interactive, InteractiveMode -> Visual, ShowConvert -> False, opts]}, 
	ImageSize->Automatic],"Interacting with PreservesQ[f, {g, h}]", Top]

Options[PreservesQVisual]={nameToUse -> ""};

PreservesQVisual[rules_,{op1_,op1sym_,nm1_},{op2_,op2sym_,nm2_},
	{a_,b_}, opts___?OptionQ] := Module[{column1, column2,arrows,rects,labels,
		color2 = OtherColors[[13]],color1 = OtherColors[[8]],
		name = nameToUse/.Flatten[{opts, Options[PreservesQVisual]}]},
	column1 = {Text[ToString[op1[a,b]//InputForm], {1,1}],
		Text["a"<>op1sym<>"b", {1,1.8}], Text[ToString[a//InputForm],{-1,5}],
		Text["a",{-1,5.8}],Text[ToString[b//InputForm],{2,7}],
		Text["b",{2,7.8}],Text[nm1,{1,9}]};
	column2 = {Text["f(a"<>op1sym<>"b)", {8,.2}],
		Text[ToString[((op1[a,b])/.rules)//InputForm], {8,1}],
		Text[ToString[op2[(a/.rules),(b/.rules)]//InputForm], {8,1.8}],
		Text["f(a)"<>op2sym<>"f(b)", {8,2.6}], 
		Text[ToString[(a/.rules)//InputForm],{7,5}],
		Text["f(a)",{7,5.8}],Text[ToString[(b/.rules)//InputForm],{10,7}],
		Text["f(b)",{10,7.8}],Text[nm2,{8,9}]};
	arrows = {color2,Arrow[{{3.5,7}, {8.5,7}}],Arrow[{{0.5,5}, {5.5,5}}],
		Arrow[{{7,4.4}, {8,3.1}}],Arrow[{{10,6.4}, {8,3.1}}],
		color1,Arrow[{{2.5,1}, {6.5,1}}],Arrow[{{-1,4.5}, {1,2.5}}],
		Arrow[{{2,6.5}, {1,2.5}}]};
	rects = {OtherColors[[12]],Rectangle[{6.6,1.3},{9.4,3.0}],
		OtherColors[[14]],Rectangle[{6.6,-.2},{9.4,1.3}],
		color2,Rectangle[{8.7, 6.6}, {11.3, 7.4}],
		Rectangle[{5.7,4.6},{8.3,5.4}],Rectangle[{6.7,1.4},{9.3, 2.2}],
		color1, Rectangle[{.7, 6.6}, {3.3, 7.4}],
		Rectangle[{-2.3,4.6},{0.3,5.4}],Rectangle[{-0.3,0.6},{2.3,1.4}],
		Rectangle[{6.7,.6},{9.3,1.4}]};
	labels = {color2,Text["f",{4.5,7.25}],Text["f",{4.5,5.25}],
		color1,Text["f",{4.5,1.25}],RGBColor[0,0,0],Text[op1sym,{1.0,3.9}],
		Text[op2sym,{8.0,3.9}]};
	Show[Graphics[{{OtherColors[[3]],AbsoluteThickness[2],
		Line[{{-0.3,8.6},{2.3,8.6}}],Line[{{6.7,8.6},{9.3,8.6}}]},
		rects,arrows,labels,column1,column2, Text[name,{4.4,-0.6},{0,0}]}],PlotRange -> All]
]

PreservesQVisual[f_?MorphoidQ,{a_,b_},opts___?OptionQ] := Module[{structure,
		showopts = FilterRules[{opts},Options[Graphics]], g, S1 = f[[2]],S2=f[[3]], names,
		df = DisplayFunction/.Flatten[{opts, Options[PreservesQVisual]}],gr1,gr2,gr},
	g = If[f[[5]]=!=Rule,AAToRules[f],f];
	structure = g[[4]];
	gr = Switch[structure, Group,
		PreservesQVisual[First[g],{Operation[S1],OperatorSymbol[S1],
			StructureName[S1]},{Operation[S2],OperatorSymbol[S2],StructureName[S2]},
			{a,b},opts],
		Ring, GraphicsGrid[{{PreservesQVisual[First[g],{Addition[S1],PlusSymbol[S1],
			StructureName[S1]},{Addition[S2],PlusSymbol[S2],StructureName[S2]},
			{a,b},nameToUse -> "Addition",opts],
			 PreservesQVisual[First[g],{Multiplication[S1],TimesSymbol[S1],
			StructureName[S1]},{Multiplication[S2],TimesSymbol[S2],StructureName[S2]},
			{a,b},nameToUse -> "Multiplication",opts]}}]
			]
	
(* modified for V6 to reflect change in graphics - printed out instead (for now) 11/4/06 *)
]
(*gr1 = *)(*gr2 =*)(*Show[GraphicsArray[{gr1,gr2}],DisplayFunction -> Identity]
Show[gr,showopts,DisplayFunction-> df]*)


PreservesGroupQ[rules:{_Rule..}, {op1_,op2_},{a_,b_},dom___List] := 
	((op1[a,b])/.rules) === op2[a/.rules,b/.rules]
	
PreservesGroupQ[f_Function, {op1_,op2_},{a_,b_},dom1_,dom2___] := 
	PreservesGroupQ[AAToRules[f,dom1,dom2],{op1,op2},{a,b}]
	
PreservesGroupQ[f_Symbol, {op1_,op2_},{a_,b_},dom1_,dom2___] := 
	PreservesGroupQ[AAToRules[f,dom1,dom2],{op1,op2},{a,b}]
	
(* Textual mode? *)


(* ::Subsection:: *)
(*Formation Shortcuts*)


Options[ZMap]={Structure:>DefaultStructure, FormatFunction -> Rule};

ZMap[m_,n_,opts___?OptionQ] := 
	Module[{str=Structure/.Flatten[{{opts},{Structure:>DefaultStructure}}],
		ff = FormatFunction/.Flatten[{opts, Options[ZMap]}]},
	FormMorphoid[Mod[#, n]&,
				Z[m,Structure->str],
				Z[n,Structure->str], 
				FormatFunction -> ff, 
				GeneratingRule -> {Rule[1,1]}]]

ZMap[m_,n_, Rule[a_,b_], opts___?OptionQ] := 
	If[GCD[m,a]==1,
Module[{str=Structure/.{opts}/.{Structure:>DefaultStructure}, powers,
	exp, ff = FormatFunction/.Flatten[{opts, Options[ZMap]}]},
	powers = Table[{k,ElementToPower[Z[m,Structure->Group], a, k]}, {k, 1, m}];
	exp[y_] := First[First[Select[powers, #[[2]]==y&]]]; 
	FormMorphoid[Mod[b*exp[#],n]&, Z[m,Structure->str],Z[n,Structure->str], 
		FormatFunction -> ff, 
		GeneratingRule -> {Rule[a,b]}]],
		Message[ZMap::relpr, m, n, a, b]]

Unprotect[ToRules];

Options[ToRules] = {FormatFunction -> False};

Options[AAToRules] = {FormatFunction -> False};

ToRules[f_Function, A_List, B_List]:=AAToRules[f, A, B]

ToRules[f_Function, A_List]:=AAToRules[f, A]

ToRules[f_Function, A_?StructuredSetQ]:=AAToRules[f, A]

ToRules[morphoid[f_Function, dom_, cod_,
	str_, Function, opts___?OptionQ],tropts___?OptionQ]:=
	AAToRules[morphoid[f, dom, cod, str, Function, opts], tropts]

ToRules[morphoid[rules:{_Rule..}, dom_, cod_,
	str_, Rule, opts___?OptionQ],tropts___?OptionQ]:=
	AAToRules[morphoid[rules, dom, cod, str, Rule, opts], tropts]

AAToRules[f_Function, A_List, B_List] := 
	Module[{rules = Map[(# -> f[#])&, A], im},
		If[SubsetQAA[im = (Transpose[Apply[List, rules, 1]]//Last), B], 
			rules, 
			Message[MemberQ::elmnts, "the image elements "<>ToString[im], B];
			$Failed]]

AAToRules[f_Function, A_List] := Map[(#->f[#])&, A]

AAToRules[f_Function, A_?StructuredSetQ] := AAToRules[f, Elements[A]]

AAToRules[morphoid[f_Function, dom_, cod_,
	str_, Function, opts___?OptionQ],tropts___?OptionQ] :=
	FormMorphoid[AAToRules[f, Elements[dom]], dom, cod, 
		FormatFunction :> (FormatFunction/.Flatten[{tropts, Options[AAToRules]}]), opts]

AAToRules[morphoid[rules:{_Rule..}, dom_, cod_,
	str_, Rule, opts___?OptionQ],tropts___?OptionQ] :=
	FormMorphoid[rules, dom, cod, 
		FormatFunction :> (FormatFunction/.Flatten[{tropts, Options[AAToRules]}]),
		 opts]
		
Protect[ToRules];

ToFunction[rules:{_Rule..}, f_] := 
	(Map[(f[#[[1]]] = #[[2]])&, Apply[List,rules,1]];f)

ToFunction[rules:{_Rule..}] := Module[{f = Unique["ff"]},
	Map[(f[#[[1]]] = #[[2]])&, Apply[List,rules,1]];f
]

ToFunction[morphoid[rules:{_Rule..}, dom_, cod_,
		str_, Rule, opts___?OptionQ]] :=
	FormMorphoid[ToFunction[rules], dom, cod, GeneratingSet -> {Null}]

ToFunction[morphoid[rules:{_Rule..}, dom_, cod_,
		str_, Rule, opts___?OptionQ], g_] :=
	FormMorphoid[ToFunction[rules, g], dom, cod, GeneratingSet -> {Null}]
		
Options[MorphoidComposition]={Mode -> Computational, 
	FormatFunction->False, ConjugatingElement->Null};

MorphoidComposition[g_?MorphoidQ,
                    f_?MorphoidQ,opts___?OptionQ]:=
   Module[{mymode = Mode/.{opts}/.Options[MorphoidComposition],ng,typesok,imdomok,
								ce= ConjugatingElement/.Flatten[{opts, Options[MorphoidComposition]}],
   		   ff = FormatFunction/.{opts}/.Options[MorphoidComposition],
   		   (* mn = MorphoidName/.{opts}/.Options[FormMorphoid],*)
           fr=If[f[[5]]===Function,AAToRules[f],f],
           gr=If[g[[5]]===Function,AAToRules[g],g],
           cr},
           If[(imdomok = Sort[fr[[3,1]]]===Sort[gr[[2,1]]])&&
                 (typesok = fr[[4]]===gr[[4]]),
              cr=Map[(#[[1]]->(#[[2]]/.First[gr]))&,First[fr]];
              FormMorphoid[cr,fr[[2]],gr[[3]],
              				FormatFunction->If[(ng=NewGenerator[g,f]) === Null,ff,
              					Rule], GeneratingRule -> {ng},ConjugatingElement->ce],
             If[Not[imdomok], Message[MorphoidComposition::notdef,
             	StructureName[fr[[3]]],StructureName[gr[[2]]]]];
             If[Not[typesok], Message[MorphoidComposition::notdef2,
             	fr[[4]],gr[[4]]]]; $Failed]]
  
NewGenerator[g_?MorphoidQ, f_?MorphoidQ] := Module[{fr, gr},
		fr = First[GeneratingRule/.MorphoidOptions[f]];
	gr = First[GeneratingRule/.MorphoidOptions[g]]; (*Print[{fr, gr, First[g]}];*)
	If[fr === Null || gr === Null, Null,
		If[Head[First[g]]===List && Head[First[f]]===List, 
		Rule[First[fr],Last[fr]/.First[g]],
	Rule[First[fr],First[g][Last[fr]]]]]
	] (* private *)



(* ::Subsection:: *)
(*Other built-in Morphoids*)


InducedCanonical[f_?MorphoidQ] := Module[{K, Q, st, rules, GQ, els},
	K = Kernel[f];
	st = MorphoidStructure[f];
	Q = If[st === Group, QuotientGroup[Domain[f], K, Form -> Cosets],
		QuotientRing[Domain[f], K, Form -> Cosets]];
	GQ = If[st === Group, Q, AGroupoid[Q]];
	els = Elements[Domain[f]];
	rules = Table[Rule[els[[k]], ElementToCoset[GQ, els[[k]]]], {k,Length[els]}];
	FormMorphoid[rules, Domain[f], Q]]
	
InducedIsomorphism[f_?MorphoidQ] := Module[{K, Q, st, rules},
	K = Kernel[f];
	st = MorphoidStructure[f];
	Q = If[st === Group, QuotientGroup[Domain[f], K, Form -> Cosets],
		QuotientRing[Domain[f], K, Form -> Cosets]];
	rules = Map[Rule[#, f[CosetToList[Q,#]//First]]&, Elements[Q]];
	FormMorphoid[rules, Q, MorphoidImage[f]]]
	
Sgn[G_?GroupoidQ] := 
	FormMorphoid[Parity, G, IntegerUnits]

(* DetHomomorphism[n_, k_] := FormMorphoid[Det, GL[n, k], U[k]] 

need to change/extend def. of FormMorphoid for this to work

Also consider Projection[ListOfStructures_List, coordinate_Integer] :=
FormMorphoid[f, ListOfStructures, ListOfStructures[[coordinate]]]*)


(* ::Subsection:: *)
(*MorphismQ*)


goodSamplePairsQ[in_, n_] := SubsetQAA[Union[Flatten[in]], Range[n]]

Options[ProbableMorphismQ]={SampleSize->5, SamplePairs->False,
	PrintMessage->True};
	
ProbableMorphismQ[f_?MorphoidQ,opts___?OptionQ]:=
		Module[{pm,ss,nrr,sample,dom=f[[2,1]],sp,
										dl=Length[f[[2,1]]]},
			If[(PrintMessage/.{opts})/.Options[ProbableMorphismQ],
				Message[ProbableMorphismQ::warning]];
			ss=(SampleSize/.{opts})/.Options[ProbableMorphismQ];
			If[Not[IntegerQ[ss]] || (ss<1),ss=5];
			sp=(SamplePairs/.{opts})/.Options[ProbableMorphismQ];
			If[Head[sp]===List && goodSamplePairsQ[sp, dl],
				sample = sp,
				If[sp===Default && dl > 4,
					sample={{1,2},{2,3},{3,5},{4,1},{5,4}},
					sample=Table[{Random[Integer,{1,dl}],Random[Integer,{1,dl}]},{ss}]]];
			Fold[And[#1,PreservesQ[f,{dom[[#2[[1]]]],dom[[#2[[2]]]]}]]&,
									 PreservesQ[f,{dom[[sample[[1,1]]]],dom[[sample[[1,2]]]]}],
									 Rest[sample]]];
		
Options[MorphismQ]={Mode -> Computational,
                    Structure :> DefaultStructure};

cay[G_?GroupoidQ,opts___?OptionQ]:=
	makeTable[G, Elements[G],opts];

TempGroupoid[list_List, op_] :=
	groupoid[list, op, {{},{},{},{},{}}];
	
TAGroupoid[R_?RingoidQ] :=
	FormGroupoid[R[[1]], R[[2]], GroupoidName -> 
		"Add("<>RingoidName[R]<>")", 
		KeyForm -> 
			If[untestedQ[KeyForm[R]],
				InputForm, KeyForm[R]],
		CayleyForm -> 
			If[untestedQ[CayleyForm[R]],
				OutputForm, CayleyForm[R]], 
		ExtraInformation -> {{},{},{},{},{"AG" -> True}}]
	
TMGroupoid[R_?RingoidQ] :=
	FormGroupoid[R[[1]], R[[3]], GroupoidName -> 
		"Mult("<>RingoidName[R]<>")", 
		KeyForm -> 
			If[untestedQ[KeyForm[R]],
				InputForm, KeyForm[R]],
		CayleyForm -> 
			If[untestedQ[CayleyForm[R]],
				OutputForm, CayleyForm[R]], 
		ExtraInformation -> {{},{},{},{},{"MG" -> True}}]
		
MorphismQ[rulesorf_, G1_?GroupoidQ, G2_?GroupoidQ] := 
MorphismQ[rulesorf, G1, G2] = 
	Module[{f = If[(Head[rulesorf]===Function)||(Head[rulesorf]===Symbol),
			rulesorf[#]&, (#/.rulesorf)&], S1 = Elements[G1], op2 = Operation[G2]},
	(Map[f[#]&,cay[G1],{2}])===
     (cay[TempGroupoid[Map[f[#]&,S1],op2]])
]

MorphismQ[rulesorf_, R1_?RingoidQ, R2_?RingoidQ] :=
MorphismQ[rulesorf, R1, R2] =
	Module[{f = If[(Head[rulesorf]===Function)||(Head[rulesorf]===Symbol),
		rulesorf[#]&,(#/.rulesorf)&], S1 = Elements[R1], S3},
		S3 = Map[f[#]&, S1];
	(Map[f[#]&,cay[TempGroupoid[S1, Addition[R1]]],{2}]===
     cay[TempGroupoid[S3,Addition[R2]]])&&
 (Map[f[#]&,cay[TempGroupoid[S1,Multiplication[R1]]],{2}]===
     cay[TempGroupoid[S3, Multiplication[R2]]])
 
]

MorphismQ[rulesorf_, S1_, S2_, Mode -> Computational]:=MorphismQ[rulesorf, S1, S2]

MorphismQ[f_?MorphoidQ, Mode -> Computational]:=MorphismQ[f]

MorphismQ[f_?MorphoidQ, Mode -> Textual, opts___?OptionQ]:=MorphismQTextual[f, opts]

MorphismQ[f_?MorphoidQ] := Module[{morph},
	morph = Switch[f[[4]],
		Group, MorphismQ[First[f], f[[2]], f[[3]]],
		Ring, MorphismQ[First[f], f[[2]], f[[3]]]];
	morph
    ]

MorphismQ[f_?MorphoidQ, Mode -> Visual, opts___?OptionQ] := Module[{morph},
	morph = Switch[f[[4]],
		Group, MorphismQ[First[f], f[[2]], f[[3]]],
		Ring, MorphismQ[First[f], f[[2]], f[[3]]]];
	DoVisualization[MorphismQVisual[f],{{f},MorphismQHelp},opts]
    ]

MorphismQHelp[f_]:= DoHelpMessage[windowtitle -> "Help for determining whether a Morphoid is a morphism", 
	help -> List["For the map ",
Cell[BoxData[FormBox["f", TraditionalForm]], FormatType->"TraditionalForm"],
" used here, its domain is ",
Cell[BoxData[FormBox["G", TraditionalForm]], FormatType->"TraditionalForm"],
	" = ",
		GroupoidName[Domain[f]], " and its codomain is ", GroupoidName[Codomain[f]],
		". Consider the Cayley table of elements from the domain ",
Cell[BoxData[FormBox["G", TraditionalForm]], FormatType->"TraditionalForm"],
		" of the morphoid ",
Cell[BoxData[FormBox["f", TraditionalForm]], FormatType->"TraditionalForm"],
". This map will be a (homo)morphism if \n\n\t\t\t",
Cell[BoxData[
 FormBox[
  RowBox[{
   RowBox[{"f", "(", 
    RowBox[{"g", "*", "h"}], ")"}], "=", 
   RowBox[{
    RowBox[{"f", "(", "g", ")"}], "#", 
    RowBox[{"f", "(", "h", ")"}]}]}], 
  TraditionalForm]],
 FormatType->"TraditionalForm"],
"\n\nfor all pairs ",
Cell[BoxData[
 FormBox[
  RowBox[{"{", 
   RowBox[{"g", ",", "h"}], "}"}], TraditionalForm]],
 FormatType->"TraditionalForm"],
" coming from the domain ",
Cell[BoxData[FormBox["G", TraditionalForm]], FormatType->"TraditionalForm"],
". (Note that the operation in the domain is denoted by * while the operation in the codomain is denoted by #.) If this equation holds for a pair ",
Cell[BoxData[
 FormBox[
  RowBox[{"{", 
   RowBox[{"g", ",", "h"}], "}"}], TraditionalForm]],
 FormatType->"TraditionalForm"],
", then we say the operations are preserved for the pair.",
		" In this case, we will color the square light green where the row headed by ",
Cell[BoxData[FormBox["g", TraditionalForm]], FormatType->"TraditionalForm"],
" intersects the column headed by ",
Cell[BoxData[FormBox["h", TraditionalForm]], FormatType->"TraditionalForm"],
". If every square is colored light green, then this property holds for all elements and the function is indeed a morphism. If it fails for at leasts one square (pair of elements), then it is not. Failures are colored a light red.\n\nNOTE: holding the mouse over an element in the table reveals the visualization of PreservesQ."]
]

MorphismQTextual[f_?MorphoidQ, opts___?OptionQ] := Module[{text, showconvert, cm, morphq},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	morphq = MorphismQ[f];
	text = StringJoin["A function f: G \[RightArrow] H is a morphism if for all x and y in (G, *) we have f(x*y)=f(x)#f(y) where # is  the operation in H. In our case, our morphoid f, given as ",
		ToString[f,TraditionalForm],
		If[morphq, ", is a morphism.",
			", is NOT a morphism. Use the Visual mode to see which pairs fail and which pairs work."]
	];
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]
]

MorphismQ[f_?MorphoidQ, Mode -> All, opts___?OptionQ]:=
	Labeled[TabView[{"Computation" -> MorphismQ[f],
	"Explanation" -> MorphismQ[f, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> MorphismQ[f, Mode->Visual, ConvertMode -> "All", opts]}, 
	ImageSize->Automatic],"Is "<>ToString[f,TraditionalForm]<>" a morphism?", Top]

Options[MorphismQVisual]=
 {DisplayFunction -> $DisplayFunction,TextFormat->InputForm,prologue->True};

MorphismQTooltip[f_,{g_,h_},op_]:= PreservesQ[f,{g,h},Mode-> Visual]

AddMorphismQTooltip[tab_,pos_,f_,Gop_]:=
	tab[[Apply[Sequence,pos]]]=tab[[Apply[Sequence,pos]]]/.Item[x_,r___]:> 
		Item[Tooltip[x,MorphismQTooltip[f,pos,Gop]],r] (* not used *)

MorphismQVisual[f_?MorphoidQ,opts___?OptionQ]  := 
Switch[f[[4]],
 Group,
  Module[{els, rects, wideQ, coloredRects, gText, preserves,
  		gLines, G, color, text, gr, allPairs, fails, grid,
			mainBody, firstRow, firstcol,
  		txtform=TextFormat/.{opts}/.Options[MorphismQVisual],
  		dp =prologue/.Flatten[{opts, Options[MorphismQVisual]}]},
(*{gLines, gText, rects} = basicCayley[G,els, CayleyForm->txtform, WideElements->wideQ];
	preserves=Position[MapThread[SameQ,{Map[f[#]&,cay[G],{2}],
	    cay[TempGroupoid[Map[f[#]&,els],f[[3,2]]]]},2],True];
	color = Map[rects[[Apply[Sequence,#]]]&,preserves];
	coloredRects = Prepend[Join[Complement[Flatten[rects],color],
		{Prepend[color,OtherColors[[1]]]}],RGBColor[1,1,1]];
	If[wideQ,
		PrintCayleyKey[els,GroupoidName[G],G,KeyForm[G]]];
	gr = Show[{Graphics[coloredRects],gLines, gText}];*)
	G = f[[2]];
	wideQ=WideElementsQ[f[[2]]];
	If[wideQ,txtform=OutputForm];
	els = Elements[G];
	len = Length[els];
	allPairs = Flatten[Table[{i,j},{i,len},{j,len}],1];
	preserves=Position[MapThread[SameQ,{Map[f[#]&,cay[G],{2}],
	    cay[TempGroupoid[Map[f[#]&,els],f[[3,2]]]]},2],True];
	fails = Complement[allPairs, preserves];
	grid =WhiteCayleyGrid[G,els]//Last;
	firstRow = First[grid];
	mainBody = Take[grid,{2,len+1},{2,len+1}];
	firstCol = Take[grid,{2,len+1},{1,1}]//Flatten;
	mainBody = MapAt[ChangeItemBackground[#,
		ColorData["HTML"]["LawnGreen"]]&,mainBody,preserves];
	mainBody = MapAt[ChangeItemBackground[#,
		ColorData["HTML"]["Tomato"]]&,mainBody,fails];
	mainBody = ReplacePart[mainBody,{x_,y_}:> (mainBody[[x,y]]/.Item[z_,r___]:> 
		Item[Tooltip[z,MorphismQTooltip[f,{els[[x]],els[[y]]},Operation[G]]],r])];
	grid=Prepend[Transpose[Prepend[Transpose[mainBody],
		firstCol]],firstRow];
	grid=Panel[Grid[grid,Dividers->{{1,2->Thickness[4]},{1,2->Thickness[4]}},
		ItemSize->Full, Spacings->Offset[1]],{"x","y"},{Left,Top}];
	grid
	],
 Ring,
 Module[{ag,mg, text},
	text = "The table entry corresponding to the sum a+b (resp. product a*b) in the domain of the morphoid is colored if and only if addition (resp. multiplication) of the pair {a,b} is preserved by the morphoid; i.e., f(a+b) = f(a)+f(b) (resp.  f(a*b) = f(a)*f(b))";
	ag=MorphismQVisual[FormMorphoid[f[[1]],
                          TAGroupoid[f[[2]]],
                          TAGroupoid[f[[3]]]]];
	mg=MorphismQVisual[FormMorphoid[f[[1]], 																								TMGroupoid[f[[2]]],
 					TMGroupoid[f[[3]]]]];
	 Row[{ag, mg}]
 	(* Show[GraphicsArray[{ag,mg}]]*)]]
(* modified 11/4/06 to handle change in graphics for version 6 *)

HomomorphismQ[f_?MorphoidQ,opts___?OptionQ]:=MorphismQ[f,opts];



(* ::Subsection:: *)
(*Kernel*)


Kernel[f_?MorphoidQ] := Module[{structure=f[[4]],
	mymode,g,K,idtest,idname, els},
	{idtest,idname}=Switch[structure,Group,{HasIdentityQ,GroupIdentity},
	    Ring, {HasZeroQ, Zero}];
	els = Elements[Domain[f]];
	g = If[f[[5]]===Rule,f,AAToRules[f]];
	If[Not[idtest[g[[3]]]], Message[Kernel::noid,StructureName[g[[3]]]];$Failed,
		K=Select[Elements[g[[2]]],((#/.g[[1]])==idname[g[[3]]])&];
		If[mymode===Visual, KernelVisual[f, K]];
		Switch[structure, Group,
			If[ProperSubsetQAA[K,els],
				FormGroupoid[K,f[[2,2]],OperatorSymbol[f[[2]]], 
					GroupoidName->"Ker("<>ToString[f]<>")",
					GatherSubGroupoidOptions[f[[2]]]],
				Domain[f]], 
			Ring, 
			If[ProperSubsetQAA[K,els],
				FormRingoid[K,f[[2,2]],f[[2,3]], RingoidName->"Ker("<>ToString[f]<>")",
					GatherSubRingoidOptions[f[[2]]]],
				Domain[f]]]]
]

Kernel[f_?MorphoidQ, Mode->Visual, opts___?OptionQ] := Module[{structure=f[[4]],
	mymode,g,K,idtest,idname, els},
	{idtest,idname}=Switch[structure,Group,{HasIdentityQ,GroupIdentity},
	    Ring, {HasZeroQ, Zero}];
	els = Elements[Domain[f]];
	g = If[f[[5]]===Rule,f,AAToRules[f]];
	If[Not[idtest[g[[3]]]], Message[Kernel::noid,StructureName[g[[3]]]];$Failed,
		K=Select[Elements[g[[2]]],((#/.g[[1]])==idname[g[[3]]])&];
		DoVisualization[KernelVisual[f, K, opts],{{f,K},KernelHelp},opts]]
]

KernelHelp[f_,K_]:= 
	DoHelpMessage[windowtitle -> "Help for the kernel of a Morphoid", 
	help -> List["The kernel of a map is the set of elements in the domain that are mapped to the identity in the codomain. In this graphic, the Magenta-colored arrows indicate which domain elements are mapped to the identity in the codomain."]
]

Kernel[f_?MorphoidQ, Mode->Computational, opts___?OptionQ]:=Kernel[f]

Kernel[f_?MorphoidQ, Mode->Textual, opts___?OptionQ] := Module[{structure=f[[4]],
	mymode,g,K,idtest,idname, els, text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	{idtest,idname}=Switch[structure,Group,{HasIdentityQ,GroupIdentity},
	    Ring, {HasZeroQ, Zero}];
	els = Elements[Domain[f]];
	g = If[f[[5]]===Rule,f,AAToRules[f]];
	If[Not[idtest[g[[3]]]], Message[Kernel::noid,StructureName[g[[3]]]];$Failed,
		K=Select[Elements[g[[2]]],((#/.g[[1]])==idname[g[[3]]])&];
		text=KernelTextual[f, K, Identity[f[[3]]]]//TraditionalForm;
		If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]]
]


Kernel[f_?MorphoidQ, Mode -> All, opts___?OptionQ]:=
Labeled[TabView[{"Computation" -> Kernel[f],
	"Explanation" -> Kernel[f, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> Kernel[f, Mode->Visual, ConvertMode -> "All", opts]}, 
	ImageSize->Automatic],TraditionalForm["Kernel of "<>ToString[f,TraditionalForm]], Top]

KernelVisual[f_?MorphoidQ, k_, opts___?OptionQ] := 
	VisualizeMorphoid[f, ColorDomain -> 
		Table[{Magenta, k[[i]]},{i, Length[k]}]]

KernelTextual[f_?MorphoidQ, k_, coid_] := 
	StringJoin["Given a morphoid f, the kernel of this is the set of elements from the domain of f that are mapped to the identity of the codomain. ",
	"In our case, the morphoid is ", ToString[f, TraditionalForm],
	", the identity in the codomain is ", ToString[coid, TraditionalForm],
	", and the kernel elements are ", ToString[k, TraditionalForm], "."]


(* ::Subsection:: *)
(*Image*)


MorphoidImage[f_?MorphoidQ]:=
	Module[{structure=f[[4]],mymod,dom=Elements[f[[2]]],im,
		els = Elements[Codomain[f]]},
	im=If[f[[5]]===Rule,
		Transpose[Apply[List,First[f],1]]//Last//UnionNoSort,
		Map[First[f],dom]//UnionNoSort];
		Switch[structure, Group,
			If[ProperSubsetQAA[im,els],
				FormGroupoid[im,f[[3,2]],OperatorSymbol[f[[3]]], 
					GroupoidName->"Im("<>ToString[f]<>")",
					GatherSubGroupoidOptions[f[[3]]]],
				Codomain[f]], 
			Ring, 
			If[ProperSubsetQAA[im,els],
				FormRingoid[im,f[[3,2]],f[[3,3]], RingoidName->"Im("<>ToString[f]<>")",
					GatherSubRingoidOptions[f[[3]]]],
				Codomain[f]]]]

MorphoidImage[f_?MorphoidQ, Mode->Computational, opts___?OptionQ]:=MorphoidImage[f]

MorphoidImage[f_?MorphoidQ, Mode -> All, opts___?OptionQ]:=
Labeled[TabView[{"Computation" -> MorphoidImage[f],
	"Explanation" -> MorphoidImage[f, Mode->Textual, ConvertMode -> "All", opts],
	"Visualization" -> MorphoidImage[f, Mode->Visual, ConvertMode -> "All", opts]}, 
	ImageSize->Automatic],TraditionalForm["Image of "<>ToString[f]], Top]

MorphoidImage[f_?MorphoidQ, Mode->Visual, opts___?OptionQ] := Module[{img},
	img = MorphoidImage[f]//Elements;
	DoVisualization[ImageVisual[f, img, opts],{{f,img},ImageHelp},opts]
]

ImageHelp[f_,K_]:= 
	DoHelpMessage[windowtitle -> "Help for the image of a Morphoid", 
	help -> List["The image of a map is the set of elements in the codomain to which elements from the domain are mapped. In this graphic, the Magenta-colored arrows indicate which codomain elements are \"hit\"."]
]

MorphoidImage[f_?MorphoidQ, Mode->Textual, opts___?OptionQ] := Module[{img, text, showconvert, cm},
	showconvert = ShowConvert/.Flatten[{opts, Options[HelpMessages]}];
	cm = ConvertMode/.Flatten[{opts, ConvertMode -> "Textual"}];
	img = MorphoidImage[f, Mode->Computational]//Elements;
	text=ImageTextual[f, img]//TraditionalForm;
	If[showconvert,Column[{text,MakeComputationalButton[cm]},Center],text]]

ImageTextual[f_?MorphoidQ, img_] := 
	StringJoin["Given a morphoid f, the image of this is the set of elements from the codomain of f to which are mapped elements from the domain. ",
	"In our case, the morphoid is ", ToString[f, TraditionalForm],
	", and the image elements are ", ToString[img, TraditionalForm], "."]

ImageVisual[f_?MorphoidQ, img_, opts___?OptionQ] := 
	VisualizeMorphoid[f, ColorCodomain -> 
		Table[{Magenta, img[[i]]},{i, Length[img]}]]

MorphoidImage[f_?MorphoidQ,subgroup_List,opts___?OptionQ]:=
Module[{structure=f[[4]],mymode,dom=subgroup,im,els = Elements[Codomain[f]]},
 im=If[f[[5]]===Rule,
    Transpose[Apply[List,Select[First[f],MemberQ[dom,First[#]]&],1]]//Last//UnionNoSort,
    Map[First[f],dom]//UnionNoSort];
  Switch[structure,Group,
  	If[ProperSubsetQAA[im, els],
				FormGroupoid[im,f[[3,2]],OperatorSymbol[f[[3]]], 
					GroupoidName->"Im("<>ToString[f]<>")",
					GatherSubGroupoidOptions[f[[3]]]],
				Codomain[f]],
            Ring,If[ProperSubsetQAA[im,els],
				FormRingoid[im,f[[3,2]],f[[3,3]], RingoidName->"Im("<>ToString[f]<>")",
					GatherSubRingoidOptions[f[[3]]]],
				Codomain[f]]]];


(* ::Subsection:: *)
(*InverseImage*)


InverseImageOfEl[f_?MorphoidQ, el_]:=
	If[ElementQ[el, f[[3]]],
		Select[f[[2,1]],MemberQ[{el},f[#]]&],
		Message[MemberQ::elmnt, el, StructureName[f[[3]]]]; {}]
		
InverseImage[f_?MorphoidQ,Img_]:= 
	If[ElementQ[Img, f[[3]]], InverseImageOfEl[f, Img],
		If[Head[Img]===List,
			If[Or@@Map[ElementQ[#, f[[3]]]&, Img],
				Map[InverseImageOfEl[f, #]&, Img]//Flatten[#,1]&//UnionNoSort,
				Message[MemberQ::elsbst, Img, f[[3]]]; {}],
			Message[MemberQ::elmnt, Img, f[[3]]]; {}]]

InverseImage[f_?MorphoidQ,Img_, Mode -> Visual, opts___?OptionQ]:= 
	InverseImageVisual[f, Img, opts]

InverseImageVisual[f_?MorphoidQ, Img_, opts___?OptionQ] := Module[{els},
	els = InverseImage[f, Img];
	If[els =!= $Failed,
		VisualizeMorphoid[f, ColorCodomain -> 
			Table[{Magenta, els[[i]]},{i, Length[els]}]]]]
	
	(* added Print to the above on 11/4/06 *)
	
Fiber[args___] := InverseImage[args]

Options[InverseImages] = {Mode -> Computational, WithImages -> False};

InverseImages[f_?MorphoidQ, opts___?OptionQ] := 
		Module[{imq = WithImages/.Flatten[{opts, Options[InverseImages]}], preimages,
			mymode},
			mymode = Mode/.Flatten[{opts, Options[InverseImages]}];
			preimages = Map[{InverseImage[f,#],#}&, f[[3,1]]];
			If[mymode===Visual, InverseImagesVisual[f]//Return];
			If[imq, preimages, preimages//Transpose//First]]
	
InverseImagesVisual[f_?MorphoidQ, opts___?OptionQ] := Module[{els,n},
	els = Elements[MorphoidImage[f]];
	n = Length[els];
	VisualizeMorphoid[f, ColorCodomain -> 
			Table[{Hue[i/(n+1)], els[[i]]},{i, n}]]]



(* ::Subsection:: *)
(*SurjectiveQ*)


SurjectiveQ[f_?MorphoidQ]:=(Sort[First[MorphoidImage[f]]]===Sort[f[[3,1]]]);

OntoQ[args___] := SurjectiveQ[args];


(* ::Subsection:: *)
(*InjectiveQ*)


InjectiveQ[f_?MorphoidQ]:=(Length[f[[2,1]]]==Length[First[MorphoidImage[f]]])

OneToOneQ[args___] := InjectiveQ[args];


(* ::Subsection:: *)
(*IsomorphismQ*)


Options[IsomorphismQ] = {Cautious->False};

IsomorphismQ[g_?MorphoidQ,opts___?OptionQ] := 
	Module[{S,f=First[g],G=g[[2]],H=g[[3]],op2,iso=False,caut,gfun},
	caut=(Cautious/.{opts})/.Options[IsomorphismQ];
	S = Elements[G];
	op2 = Operation[H];
	gfun=If[g[[5]]===Rule,ToFunction[f],f];
	If[Length[S]== Length[Elements[H]],
		(*passes first test of being the same size *)
		If[Length[S] == Length[Union[Map[gfun,S]]],
			(* passes being onto *)
			If[(*Small case *) Length[S]<7 || caut, If[MorphismQ[g],
				iso = True, Message[IsomorphismQ::notHom]; $Failed],
				(*Large case*) If[ProbableMorphismQ[g]&&If[caut,MorphismQ[g],True],
				             iso = True, Message[IsomorphismQ::notHom]; $Failed]],
		Message[Morphoid::notonto]; $Failed],
	Message[Morphoid::dff,G,H]];
	iso
]


(* ::Subsection:: *)
(*VisualizingMorphoid*)


Options[VisualizeMorphoid] = {ColorDomain -> {}, ColorCodomain -> {}};

VisualizeMorphoid[f_?MorphoidQ, opts___?OptionQ] := 
Module[{sys=f[[4]], dom, cod, rules, n1, n2, domrls, codrls, dx, row1, row2, first, second,
	lines, eps = .3, elsd,elsc,x, temp, temp1, temp2, (* x added 7/26/04 *)
	pts1, pts2, t1, t2, domkey, codomkey, img, fdom, fcod, showopts,
	kd = ColorDomain/.Flatten[{opts, Options[VisualizeMorphoid]}],
	kc = ColorCodomain/.Flatten[{opts, Options[VisualizeMorphoid]}]},
    showopts = FilterRules[{opts},Options[Graphics]];
	rules  = If[MorphoidType[f] === Rule, f[[1]],
		AAToRules[f[[1]], Elements[Domain[f]]]];
	{pts1, pts2} = Transpose[Apply[List,rules,1]];
	{fdom, fcod} = {Domain[f], Codomain[f]};
	elsc = Elements[Codomain[f]];
	elsd = Elements[Domain[f]];
	If[kd===Automatic, kd = Table[{Hue[k/(Length[elsd]+1)],elsd[[k]]},
		{k,Length[elsd]}]];
	If[kc===Automatic, kc = Table[{Hue[k/(Length[elsc]+1)],elsc[[k]]},
		{k,Length[elsc]}]];
	{t1,domkey} = textRules[fdom, "g", True];
	{t2, codomkey} = textRules[fcod, "h", Not[fdom === fcod]];
	{dom, cod} = Map[First, {t1, t2}, {2}];
	{pts1, pts2} = {pts1/. Map[Reverse, t1], pts2/. Map[Reverse, t2]};
	{n1, n2} = Map[Length, {dom, cod}];
	dx = n1/n2;
	domrls = Table[Rule[dom[[i]], {i-1, 4-eps}], {i, n1}];
	codrls = Table[Rule[cod[[i]], {(i-1)dx, eps}], {i, n2}];
	row1 = Prepend[Table[Text[dom[[i]], {i-1, 4}], {i, n1}],
		Text[StructureName[fdom], {(n1-1)/2, 4.5},{0,0}]];
	row2 = Prepend[Table[Text[cod[[i]], {(i-1)dx, 0}], {i, n2}],
		Text[StructureName[fcod], {(n1-1)/2, -.5},{0,0}]];
(*Print[{kd,kc, t1, t2}];*)
	{kd, kc} = Map[Cases[#, {RGBColor[_,_,_], _} | {Hue[_],_}]&, {kd, kc}];
(*Print[{kd,kc}];*)
	kd = Select[kd, ElementQ[Last[#], fdom]&];
	kc = Select[kc, ElementQ[Last[#], fcod]&];
	kd = If[kd =!= {}, 
		{temp1, temp2} = Transpose[kd /. Map[Reverse, t1]];
		temp2 = temp2/. domrls;
		Transpose[{temp1,temp2}], kd];  (* The problems are right here with the replacements entering in to change the colors*)
	kc = If[kc =!= {}, 
		{temp1, temp2} = Transpose[kc /. Map[Reverse, t2]];
		temp2 = temp2/. codrls;
		Transpose[{temp1,temp2}], kc];
(*Print[{"4kc",kc, t2, codrls, kd}];*)
	{pts1, pts2} = {pts1 /. domrls, pts2 /. codrls};
(*Print[{pts1,pts2}];*)
(*Print[{"kcMap",Map[Rule[{OtherColors[[5]], Arrow[{x_, Last[#]}]}, {First[#],Arrow[{x,Last[#]}]}]&, kc]}];*)
(*Print[{kd, "kdMap",Map[Rule[{OtherColors[[5]], Arrow[{Last[#],x_}]}, {First[#],Arrow[{Last[#],x}]}]&, kd]}];*)
	first = Map[RuleDelayed[{OtherColors[[5]], Arrow[{x_, Last[#]}]}, {First[#],Arrow[{x,Last[#]}]}]&, kc];
	second = Map[RuleDelayed[{OtherColors[[5]], Arrow[{Last[#],x_}]}, {First[#],Arrow[{Last[#],x}]}]&, kd];
	kd = Join[first, second];
	lines = Map[{OtherColors[[5]], Arrow[{#[[1]], #[[2]]}]}&, Transpose[{pts1, pts2}], 1];
(*Print[{x, "diff",kd, lines}];*)
	lines = lines/.kd;
(*Print[{kd, lines}];*)
	lines = lines/.RGBColor[a_,b_,c_]:>RGBColor[ToExpression[a],ToExpression[b],ToExpression[c]];
	(*lines = lines/.Hue[a_]:>Hue[If[Head[a]===String,ToExpression[a],a]];
fix this line to take care of 1 
	lines = lines /. Hue["1"]:>Hue[1];*)
	img = Panel[Show[Graphics[{row1, row2, lines}], showopts, 
		PlotRange -> {{-0.5, n1-0.5}, {-1, 5}}]];
	If[domkey=!={}&& codomkey=!={}, Column[{img,domkey,codomkey}, Center],
		If[domkey=!={},Column[{img,domkey}, Center],
			If[codomkey=!={},Column[{img,codomkey}, Center], img]]]]

textRules[S_, lab_String, printkeyQ_] := Module[{fff, x, rules, Els = Elements[S], key={}},
	If[WideElementsQ[S],
		fff[x_,{n_}] := lab<>ToString[n] -> x;
		If[printkeyQ, key=TextCayleyKey[Els,  (* changed from PrintCayleyKey to TextCayleyKey 
so that the text can be passed along and kept with image of map *)
			StructureName[S], S, KeyForm[S],lab]],
		fff[x_,{n_}] := ToString[KeyForm[S][x]] -> x];
	rules = MapIndexed[fff, Els];
	{rules, key}]


(* ::Section:: *)
(* 61. Formation of Ringoids*)


(* ::Subsection::Closed:: *)
(* 61.1 Another FormRingoid*)


FormRingoid[G1_?GroupoidQ, G2_?GroupoidQ, opts___?OptionQ] :=
	If[SameSetQ[Elements[G1], Elements[G2]],
		FormRingoid[Elements[G1], Operation[G1], Operation[G2], 
			opts],
		Message[FormRingoid::diffels, Elements[G1], Elements[G2]]]


(* ::Subsection:: *)
(* 61.2 FormRingoidByTable*)


FormRingoidByTable[list_List,additiontab_List, multiplicationtab_List,
		opsymbols_List:{"+","*"}, opts___?OptionQ] :=
	Module[{R,wideq,ringq,genset,rngdesc,rngnm,optional,formop,
	formels,maxshow,keyForm,cayleyForm, ei, add, mult},
		wideq = WideElements/.Flatten[{opts, Options[FormRingoid]}];
		ei = ExtraInformation/.Flatten[{opts, 
			Options[FormRingoidExtra]}];
		ringq = IsARing/.Flatten[{opts, Options[FormRingoid]}];
		rngdesc = RingoidDescription/.Flatten[{opts, Options[FormRingoid]}];
		rngnm = RingoidName/.Flatten[{opts, Options[FormRingoid]}];
		formop = FormatOperator/.Flatten[{opts, Options[FormRingoid]}];
		keyForm = KeyForm/.Flatten[{opts, Options[FormRingoid]}];
		cayleyForm = CayleyForm/.Flatten[{opts, Options[FormRingoid]}];
		formels = FormatElements/.Flatten[{opts, Options[FormRingoid]}];
		maxshow = MaxElementsToList/.Flatten[{opts, Options[FormRingoid]}];
		add = (additiontab[[#1//Position[list,#]&//First,
    	#2//Position[list,#]&//First]]//Flatten//First)&;
    mult = (multiplicationtab[[#1//Position[list,#]&//First,
			#2//Position[list,#]&//First]]//Flatten//First)&;
		AppendTo[ei, {opts}];
		R = ringoid[list, add, mult, ei];
		FormatOpQ[R] = formop;
		FormatElsQ[R] = If[Length[list] > maxshow, True, formels];
		WideElementsQ[R] = wideq;
		KeyForm[R] = keyForm;
		CayleyForm[R] = cayleyForm;
		If[ringq,ringQ[R] = ringq];
		RingoidDescription[R] = rngdesc;
		RingoidName[R] = If[rngnm === "", "TheRing", rngnm];
		If[untestedQ[RingInfo[R]],
			RingInfo[R] = {};
			If[rngnm =!= "", AppendTo[RingInfo[R],rngnm]];
			If[rngdesc =!= "", AppendTo[RingInfo[R],rngdesc]];
			];
		(* start tracking info about groupoid if not yet started *)
		PlusSymbol[R] = opsymbols[[1]];
		TimesSymbol[R] = opsymbols[[2]];
		R]
(* note that the R created is a ringoid not Ringoid *)


(* ::Section:: *)
(* 62. Construction of basic rings*)


(* ::Subsection:: *)
(*62.1 Z as a ring*)


Unprotect[ZR];

Options[ZR] = {};

ZR[n_Integer?Positive, opts___?OptionQ] := (Unprotect[ZR];
	ZR[n] = 
	Module[{R=FormRingoid[Range[0,n-1],
  	Mod[#1 + #2,n]&, Mod[#1 #2,n]&, {"+","*"}, RingoidName -> 
  	"Z["<>ToString[n]<>"]", RingoidDescription ->
  	"the ring of integers mod "<>ToString[n], FormatOperator -> 
  	False]}, NegationOf[R, k_] := Mod[n-k,n];
  MultiplicativeInverse[R, k_] := ExtendedGCD[n,k]//If[First[#]==1,
  	Mod[#[[2,2]],n],
    Message[Inverse::fail,k,StructureName[R]];$Failed]&;
  R]; Protect[ZR]; ZR[n])

Unprotect[ZR];

ZR[n_Integer?Positive, k_Integer?Positive]/;(Mod[n, k]==0) := 
	(Unprotect[ZR]; ZR[n, k]=
  FormRingoid[Range[0, n-k, k], Mod[#1+#2,n]&, Mod[#1 #2,n]&,
  {"+","*"}, RingoidName-> "Z["<>ToString[n]<>","<>ToString[k]<>"]", 
  RingoidDescription -> "the multiples of "<>ToString[k]<>" mod "<>
  ToString[n], FormatOperator -> False]; Protect[ZR]; ZR[n,k])
  
Unprotect[ZR];

ZR[n_] := (Message[ZR::intpm,"ZR["<>ToString[n]<>"]",1];$Failed)

Protect[ZR];


(* ::Subsection:: *)
(*62. 2 Other*)


Options[TrivialZR] = {};

TrivialZR[n_/;(n >= 2)] := TrivialZR[n] = Module[{R},
	R = FormRingoid[Range[0, n-1], Mod[#1 + #2,n]&, 0&, {"+","0"},
		RingoidName -> "Trivial["<>ToString[n]<>"]", RingoidDescription -> 
		"the trivial Ring mod "<>ToString[n]];
	R]

BooleanRing[n_Integer?NonNegative/;n<=6] := BooleanRing[n]=
   FormRingoid[Range[2^n,2^(n+1)-1]//
          Map[IntegerDigits[#,2]&,#]&//
          Map[Rest,#]&//
          Map[(Range[1,n]*#)&,#]&//
          Map[Select[#,(#>0)&]&,#]&,
          Union[Complement[#1,#2],Complement[#2,#1]]&,
          Intersection[#1,#2]&,
          RingoidName -> "Bool["<>ToString[n]<>"]",
          RingoidDescription -> "the boolean Ring on {1,...,"<>ToString[n]<>"}",
          WideElements->True]

BooleanRing[n_Integer?NonNegative] := (Message[FormRingoid::size, 7, n]; $Failed)

BooleanRing[B_List] := BooleanRing[B] =
				FormRingoid[Elements[BooleanRing[Length[B]]//
           MapAt[(#/.Inner[Rule,Range[1,Length[B]],Sort[B],List])&,
                  #,1]&],
           Union[Complement[#1,#2],Complement[#2,#1]]&,
          Intersection[#1,#2]&,
          RingoidName -> "Bool["<>ToString[B]<>"]",
          RingoidDescription -> "Boolean Ring on "<>ToString[Sort[B]],
          WideElements->True]      
                      
LatticeRing[n_/;(n>=2)] := FormRingoid[Divisors[n],
	(LCM[#1,#2]/GCD[#1,#2])&, GCD[#1,#2]&, RingoidName -> 
	"Lattice["<>ToString[n]<>"]", RingoidDescription -> 
	"the lattice Ring of divisors of "<>ToString[n]];


(* ::Section:: *)
(* 63. Misc. ring-related code*)


AddRingInfo[G_, ok_, mess1_, mess2_] := 
	(If[untestedQ[RingInfo[G]], RingInfo[G] = {}];
	If[ok,
		If[!MemberQ[RingInfo[G],mess1],
			AppendTo[RingInfo[G],mess1]],
		If[!MemberQ[RingInfo[G],mess2],
			AppendTo[RingInfo[G],mess2]]];)
			
ModifiedAnd[x_, y_] := If[MemberQ[{x,y},$Failed],
	$Failed, x && y]


(* ::Section::Closed:: *)
(* 64. Interface with Groups*)


AdditiveGroupoid[R_?RingoidQ] := AGroupoid[R]

MultiplicativeGroupoid[R_?RingoidQ] := MGroupoid[R]

newName[pre_, nm_, post_] :=
	Switch[Head[nm], 
		String, pre<>nm<>post, 
		SequenceForm, Prepend[Append[nm, post],pre],
		_, "add. groupoid"]

AGroupoid[R_?RingoidQ] := AGroupoid[R] =
	FormGroupoid[R[[1]], R[[2]], PlusSymbol[R],
		WideElements -> WideElementsQ[R], GroupoidName -> 
		newName["Add(", RingoidName[R],")"], 
		FormatOperator -> FormatOpQ[R], 
		FormatElements -> FormatElsQ[R],
		KeyForm -> 
			If[untestedQ[KeyForm[R]],
				InputForm, KeyForm[R]],
		CayleyForm -> 
			If[untestedQ[CayleyForm[R]],
				OutputForm, CayleyForm[R]], 
		ExtraInformation -> {{},{},{},{},{"AG" -> True}}];

MGroupoid[R_?RingoidQ] := MGroupoid[R] = 
	FormGroupoid[R[[1]], R[[3]], TimesSymbol[R],
		WideElements -> WideElementsQ[R], GroupoidName -> 
		newName["Mult(", RingoidName[R],")"], 
		FormatOperator -> FormatOpQ[R], 
		FormatElements -> FormatElsQ[R],
		KeyForm -> 
			If[untestedQ[KeyForm[R]],
				InputForm, KeyForm[R]],
		CayleyForm -> 
			If[untestedQ[CayleyForm[R]],
				OutputForm, CayleyForm[R]],
		ExtraInformation -> {{},{},{},{},{"MG" -> True}}];
				
NonZeroMGroupoid[R_?RingoidQ] := NonZeroMGroupoid[R] = 
	FormGroupoid[Complement[R[[1]], {Zero[R]}], R[[3]], TimesSymbol[R],
		WideElements -> WideElementsQ[R], GroupoidName -> RingoidName[R], 
		FormatOperator -> FormatOpQ[R], 
		FormatElements -> FormatElsQ[R]];


(* ::Section:: *)
(* 65. Defining Properties of Rings*)


(* ::Subsection:: *)
(*Closure*)


Options[ClosedQ] = {Mode -> Computational, Operation -> Both,
	Structure -> Ring};

ClosedQ[R_?RingoidQ] := ClosedQ[R] = 
	ModifiedAnd[ClosedQ[R, Operation -> Addition],
		ClosedQ[R, Operation -> Multiplication]]

ClosedQ[R_?RingoidQ, Operation -> Addition]:=
	ClosedQ[R, Operation -> Addition] = Module[{AG = AGroupoid[R], aok},
		aok = ClosedQ[AG];
		AddRingInfo[R, aok, "the set is closed under addition",
			"the set is not closed under this addition"];
		aok]

ClosedQ[R_?RingoidQ, Operation -> Multiplication]:=
	ClosedQ[R, Operation -> Multiplication] = Module[{MG = MGroupoid[R], mok},
		mok = ClosedQ[MG];
		AddRingInfo[R, mok, "the set is closed under multiplication",
			"the set is not closed under this multiplication"];
		mok]
	
ClosedQ[R_?RingoidQ, Operation -> Addition, Mode -> mode_]:=
	(ClosedQ[R, Operation -> Addition]; 
	ClosedQ[AGroupoid[R], Mode -> mode])
(* first line to set the RingInfo 
removed , Structure -> Ring in last command 9/14/08 *)

ClosedQ[R_?RingoidQ, Mode -> mode_, Operation -> Addition]:=
	(ClosedQ[R, Operation -> Addition]; 
	ClosedQ[AGroupoid[R], Mode -> mode])

ClosedQ[R_?RingoidQ, Operation -> Multiplication, Mode -> mode_]:=
	(ClosedQ[R, Operation -> Multiplication]; 
	ClosedQ[MGroupoid[R], Mode -> mode])

ClosedQ[R_?RingoidQ, Mode -> mode_, Operation -> Multiplication]:=
	(ClosedQ[R, Operation -> Multiplication]; 
	ClosedQ[MGroupoid[R], Mode -> mode])

ClosedQ[R_, Operation -> Both]:=
	ClosedQ[R]
	
ClosedQ[R_?RingoidQ, Mode -> mymode_, Operation -> Both]:= 
	ClosedQ[R,Operation -> Both, Mode -> mymode]

ClosedQ[R_?RingoidQ, Operation -> Both, Mode -> mymode_]:=
	Module[{AG = AGroupoid[R], MG = MGroupoid[R], aok, mok, 
			mode=Mode/.Flatten[{Mode -> mymode, Options[ClosedQ]}], gr1, gr2},
		{aok, mok} = {ClosedQ[R, Operation -> Addition],
			ClosedQ[R, Operation -> Multiplication]};
		If[mode === Textual && aok =!= $Failed && mok =!= $Failed,
			Column[{Style["Additive Groupoid:",Blue],
				ClosedQ[AG, Structure -> Ring, Mode -> Textual ],
				Style["Multiplicative Groupoid:",Blue],
				ClosedQ[MG, Structure -> Ring, Mode -> Textual]}]//Return
		];
		If[mode === Visual && aok =!= $Failed && mok =!= $Failed,
			Return[Row[{ClosedQ[AG, Mode -> Visual],ClosedQ[MG, Mode -> Visual]}]]			
		];
		ModifiedAnd[aok , mok]
	]

ClosedQ[R_?RingoidQ, opts__?OptionQ]:=
  Switch[Operation/.Flatten[{opts, Options[ClosedQ]}],
    Multiplication, ClosedQ[R, Operation -> Multiplication, opts],
    Addition, ClosedQ[R, Operation -> Addition, opts],
    Both, ClosedQ[R, Operation -> Both, opts]]

ClosedQ[R_?RingoidQ, S_List]:=
	ClosedQ[R, S, Operation -> Both, Mode -> Computational]

ClosedQ[R_?RingoidQ, S_List, Operation -> Addition, opts___?OptionQ]:=
	ClosedQ[AGroupoid[R], S, opts]

(* removed , Structure -> Ring in last command 9/14/08 *)
	
ClosedQ[R_?RingoidQ, S_List, Operation -> Multiplication, opts___?OptionQ]:=
	ClosedQ[MGroupoid[R], S, opts]
	
ClosedQ[R_?RingoidQ, S_List, Mode->mymode_, Operation -> Both]:=
	ClosedQ[R, S, Operation -> Both, Mode->mymode]

ClosedQ[R_?RingoidQ, S_List, Mode->mymode_]:=
	ClosedQ[R, S, Operation -> Both, Mode->mymode]

ClosedQ[R_?RingoidQ, S_List, Operation -> Both, Mode->mymode_]:=
	Module[{AG = AGroupoid[R], MG = MGroupoid[R], aok, mok, 
			mode=Mode/.Flatten[{Mode->mymode, Options[ClosedQ]}], gr1, gr2},
		{aok, mok} = {ClosedQ[AG, S], ClosedQ[MG, S]};
		If[mode === Textual && aok =!= $Failed && mok =!= $Failed,
			Column[{Style["Additive Groupoid:",Blue],
				ClosedQ[AG, S, Structure -> Ring, Mode -> Textual ],
				Style["Multiplicative Groupoid:",Blue],
				ClosedQ[MG, S, Structure -> Ring, Mode -> Textual]}]//Return
		];
		If[mode === Visual && aok =!= $Failed && mok =!= $Failed,
			Return[Row[{ClosedQ[AG,S, Mode -> Visual],ClosedQ[MG,S, Mode -> Visual]}]]
		];
		ModifiedAnd[aok , mok]
	]
	
ClosedQ[R_?RingoidQ, S_List, opts___?OptionQ]:=
  Switch[Operation/.Flatten[{opts, Options[ClosedQ]}],
    Multiplication, ClosedQ[R, S, Operation -> Multiplication, opts],
    Addition, ClosedQ[R, S, Operation -> Addition, opts],
    Both, ClosedQ[R, S, Operation -> Both, opts]]

ClosedQ[R_?RingoidQ, S_?RingoidQ, opts___?OptionQ]:=
	ClosedQ[R, Elements[S], opts]

ClosedPlusQ[R_?RingoidQ, S_List]:=
     ClosedQ[FormGroupoid[S, Addition[R]]];
     
ClosedPlusQ[R_?RingoidQ, S_?RingoidQ]:=
     ClosedQ[FormGroupoid[Elements[S], Addition[R]]];
     
ClosedTimesQ[R_?RingoidQ, S_List]:=
     ClosedQ[FormGroupoid[S, Multiplication[R]]];

ClosedTimesQ[R_?RingoidQ, S_?RingoidQ,opts___?OptionQ]:=
     ClosedTimesQ[R,S//Elements, opts];

Options[ClosedDiffQ] = {Mode -> Computational};

ClosedDiffQ[R_?RingoidQ, S_List] := 
  ClosedQ[FormGroupoid[S,(Addition[R][#1,NegationOf[R,#2]])&]];

ClosedDiffQ[R_?RingoidQ, S_?RingoidQ,opts___?OptionQ] := 
  ClosedDiffQ[R, Elements[S], opts];

ClosedDiffQ[R_?RingoidQ, S_List, opts__?OptionQ] := 
    Block[{fn=ClosedDiffQ[R,S],tests,op,
            md=Mode/.Flatten[{opts, Options[ClosedDiffQ]}],
            tr,a,b,c},
         If[(md == Textual),
            (* Textual Stuff *)
            tr:=S[[Random[Integer,{1,Length[S]}]]];
            op="Representative Tests for closure with respect to difference";
            tests=Table[a=tr;b=tr;c=(Addition[R][a,NegationOf[R,b]]);
               {StringJoin[ToString[a]," + NegationOf[",ToString[b],"] = ",
					ToString[a]," + ",ToString[NegationOf[R,b]]," = ",ToString[c]],
               If[MemberQ[S,c],"\t Result is in the set - closure still possible",
                               "\t Result is not in the set - closure not true."]},{4}];
			Return[Column[Flatten[{op,tests}]]];
            ];
         If[(md == Visual),
            (* Visual Stuff *)
            Return[CayleyTable[AGroupoid[R],Mode -> Visual]]];
        fn];

Options[ClosedTimesQ] = {Mode -> Computational};

ClosedTimesQ[R_?RingoidQ, S_List, opts__?OptionQ] := 
    Block[{fn=ClosedTimesQ[R,S],op,tests,
            md=Mode/.Flatten[{opts, Options[ClosedTimesQ]}],
            tr,a,b,c},
         If[(md== Textual),
            (* Textual Stuff *)
            tr:=S[[Random[Integer,{1,Length[S]}]]];
            op="Representative Tests for closure with respect to multiplication";
            tests=Table[a=tr;b=tr;c=(Multiplication[R][a,b]);
               {StringJoin[a//ToString," . ",b//ToString," = ",c//ToString],
               If[MemberQ[S,c],"\t Result is in the set - closure still possible",
                               "\t Result is not in the set - closure not true."]},{4}];
			Return[Column[Flatten[{op,tests}]]];
            ];
         If[(md== Visual),
            (* Visual Stuff *)
            Return[MultiplicationTable[R,Mode ->  Visual]]];
        fn];



(* ::Subsection:: *)
(*Commutativity*)


Options[CommutativeQ] = {Mode -> Computational, Operation -> Both,
	Structure -> Ring};

CommutativeQ[R_?RingoidQ] := CommutativeQ[R] = 
	ModifiedAnd[CommutativeQ[R, Operation -> Addition],
		CommutativeQ[R, Operation -> Multiplication]]
	
CommutativeQ[R_?RingoidQ, Operation -> Addition]:=
	CommutativeQ[R, Operation -> Addition] = Module[{AG = AGroupoid[R],aok},
		aok = CommutativeQ[AG];
		AddRingInfo[R, aok, "the addition operation is commutative",
			"the addition operation is not commutative"];
		aok]

CommutativeQ[R_?RingoidQ, Operation -> Multiplication]:=
	CommutativeQ[R, Operation -> Multiplication] = 
		Module[{MG = MGroupoid[R],mok},
		mok = CommutativeQ[MG];
		AddRingInfo[R, mok, "the multiplication operation is commutative",
			"the multiplication operation is not commutative"];
		mok]

CommutativeQ[R_?RingoidQ, Mode -> mode_, Operation -> Addition]:=
	CommutativeQ[R, Operation -> Addition, Mode -> mode]

CommutativeQ[R_?RingoidQ, Operation -> Addition, Mode -> mode_]:=
	(CommutativeQ[R, Operation -> Addition]; 
	CommutativeQ[AGroupoid[R], Mode -> mode])
	(* first line to set the RingInfo *)
	
CommutativeQ[R_?RingoidQ, Mode -> mode_, Operation -> Multiplication]:=
	CommutativeQ[R, Operation -> Multiplication, Mode -> mode]

CommutativeQ[R_?RingoidQ, Operation -> Multiplication, Mode -> mode_]:=
	(CommutativeQ[R, Operation -> Multiplication]; 
	CommutativeQ[MGroupoid[R], Mode -> mode])
	(* first line to set the RingInfo *)
	
CommutativeQ[R_, Operation -> Both] := CommutativeQ[R]
	
CommutativeQ[R_?RingoidQ, Operation -> Both, opts__?OptionQ]:=
	Module[{AG = AGroupoid[R], MG = MGroupoid[R], aok, mok, 
			mode=Mode/.Flatten[{opts, Options[CommutativeQ]}], gr1, gr2,
			showopts = FilterRules[{opts},Options[Graphics]]},
		{aok, mok} = {CommutativeQ[R, Operation -> Addition],
			CommutativeQ[R, Operation -> Multiplication]};
		If[mode === Textual && aok =!= $Failed && mok =!= $Failed,
			Return[Column[{Style["Additive Groupoid:",Blue],
				CommutativeQ[AG, Mode -> Textual ],
				Style["Multiplicative Groupoid:",Blue],
				CommutativeQ[MG, Mode -> Textual]}]]
		];
		If[mode === Visual && aok =!= $Failed && mok =!= $Failed,
			Return[Row[{CommutativeQ[AG, Mode -> Visual],CommutativeQ[MG, Mode -> Visual]}]];
		];
		ModifiedAnd[aok, mok]]

CommutativeQ[R_?RingoidQ, opts__?OptionQ]:=
  Switch[Operation/.Flatten[{opts, Options[CommutativeQ]}],
    Multiplication, CommutativeQ[R, Operation -> Multiplication, opts],
    Addition, CommutativeQ[R, Operation -> Addition, opts],
    Both, CommutativeQ[R, Operation -> Both, opts]]


(* ::Subsection:: *)
(*Associativity*)


Options[AssociativeQ] = {Mode -> Computational, Operation -> Both,
	Structure -> Ring};

AssociativeQ[R_?RingoidQ] := AssociativeQ[R] = 
	ModifiedAnd[AssociativeQ[R, Operation -> Addition],
		AssociativeQ[R, Operation -> Multiplication]]
	
AssociativeQ[R_?RingoidQ, Operation -> Addition]:=
	AssociativeQ[R, Operation -> Addition] = 
			Module[{AG = AGroupoid[R], aok},
		aok = AssociativeQ[AG];
		AddRingInfo[R, aok, "the addition operation is associative",
			"the addition operation is not associative"];
		aok]
	
AssociativeQ[R_?RingoidQ, Mode -> mode_, Operation -> Addition]:=
	AssociativeQ[R, Operation -> Addition, Mode -> mode]

AssociativeQ[R_?RingoidQ, Operation -> Addition, Mode -> mode_]:=
	(AssociativeQ[R, Operation -> Addition]; 
	AssociativeQ[AGroupoid[R], Mode -> mode])
	(* first line to set the RingInfo *)
	
AssociativeQ[R_?RingoidQ, Operation -> Multiplication]:=
	AssociativeQ[R, Operation -> Multiplication] = 
			Module[{MG = MGroupoid[R], mok},
		mok = AssociativeQ[MG];
		AddRingInfo[R, mok, "the multiplication operation is associative",
			"the multiplication operation is not associative"];
		mok]
	
AssociativeQ[R_?RingoidQ, Mode -> mode_, Operation -> Multiplication]:=
	AssociativeQ[R, Operation -> Multiplication, Mode -> mode]

AssociativeQ[R_?RingoidQ, Operation -> Multiplication, Mode -> mode_]:=
	(AssociativeQ[R, Operation -> Multiplication]; 
	AssociativeQ[MGroupoid[R], Mode -> mode])
	(* first line to set the RingInfo *)

AssociativeQ[R_?RingoidQ, Operation -> Both]:=
	AssociativeQ[R]
	
AssociativeQ[R_?RingoidQ, Operation -> Both, opts__?OptionQ]:=
	Module[{AG = AGroupoid[R], MG = MGroupoid[R], aok, mok, 
			mode=Mode/.Flatten[{opts, Options[AssociativeQ]}], gr1, gr2,
			showopts = FilterRules[{opts},Options[Graphics]]},
		{aok, mok} = {AssociativeQ[R, Operation -> Addition],
			AssociativeQ[R, Operation -> Multiplication]};
		If[mode === Textual && aok =!= $Failed && mok =!= $Failed,
			Return[Column[{Style["Additive Groupoid:",Blue],
				AssociativeQ[AG, Mode -> Textual ],
				Style["Multiplicative Groupoid:",Blue],
				AssociativeQ[MG, Mode -> Textual]}]];
		];
		If[mode === Visual && aok =!= $Failed && mok =!= $Failed,
			Return[Row[{AssociativeQ[AG, Mode -> Visual],AssociativeQ[MG, Mode -> Visual]}]];
		];
		ModifiedAnd[aok, mok]]

AssociativeQ[R_?RingoidQ, opts__?OptionQ]:=
  Switch[Operation/.Flatten[{opts, Options[AssociativeQ]}],
    Multiplication, AssociativeQ[R, Operation -> Multiplication, opts],
    Addition, AssociativeQ[R, Operation -> Addition, opts],
    Both, AssociativeQ[R, Operation -> Both, opts]]
    
Options[RandomAssociativeQ] = {Mode -> Computational, Operation -> Both,
	Structure -> Ring};

RandomAssociativeQ[R_?RingoidQ, max_:25] := RandomAssociativeQ[R, max] = 
	ModifiedAnd[RandomAssociativeQ[R, Operation -> Addition, max],
		RandomAssociativeQ[R, Operation -> Multiplication, max]]
	
RandomAssociativeQ[R_?RingoidQ, Operation -> Addition, max_:25]:=
	RandomAssociativeQ[R, Operation -> Addition] = 
			Module[{AG = AGroupoid[R], aok},
		aok = RandomAssociativeQ[AG, max];
		AddRingInfo[R, aok, "the addition operation is probably associative",
			"the addition operation is not associative"];
		aok]
	
RandomAssociativeQ[R_?RingoidQ, Operation -> Addition, opts__?OptionQ]:=
	(RandomAssociativeQ[R, Operation -> Addition]; 
	RandomAssociativeQ[AGroupoid[R], Structure -> Ring, opts])
	(* first line to set the RingInfo *)
	
RandomAssociativeQ[R_?RingoidQ, Operation -> Multiplication, 
		max_:25]:=
	RandomAssociativeQ[R, Operation -> Multiplication] = 
			Module[{MG = MGroupoid[R], mok},
		mok = RandomAssociativeQ[MG, max];
		AddRingInfo[R, mok, "the multiplication operation is probably associative",
			"the multiplication operation is not associative"];
		mok]
	
RandomAssociativeQ[R_?RingoidQ, Operation -> Multiplication, opts__?OptionQ]:=
	(RandomAssociativeQ[R, Operation -> Multiplication]; 
	RandomAssociativeQ[MGroupoid[R], Structure -> Ring, opts])
	(* first line to set the RingInfo *)

RandomAssociativeQ[R_?RingoidQ, Operation -> Both]:=
	RandomAssociativeQ[R]
	
RandomAssociativeQ[R_?RingoidQ, Operation -> Both, opts__?OptionQ]:=
	Module[{AG = AGroupoid[R], MG = MGroupoid[R], aok, mok, 
			mode=Mode/.Flatten[{opts, Options[RandomAssociativeQ]}], gr1, gr2,
			showopts = FilterRules[{opts},Options[Graphics]]},
		{aok, mok} = {RandomAssociativeQ[R, Operation -> Addition],
			RandomAssociativeQ[R, Operation -> Multiplication]};
		If[mode === Textual && aok =!= $Failed && mok =!= $Failed,
			multipleQ = True;
			firstPassQ = True;
			Print["Additive Groupoid:"];
			RandomAssociativeQ[AG, Structure -> Ring, Mode -> Textual];
			Print["Multiplicative Groupoid:"];
			RandomAssociativeQ[MG, Structure -> Ring, opts];
			multipleQ = False;
		];
		If[mode === Visual && aok =!= $Failed && mok =!= $Failed,
			RandomAssociativeQ[{AG, MG}, Mode -> Visual, showopts];
		];
		ModifiedAnd[aok, mok]]

RandomAssociativeQ[R_?RingoidQ, opts__?OptionQ]:=
  Switch[Operation/.Flatten[{opts, Options[RandomAssociativeQ]}],
    Multiplication, RandomAssociativeQ[R, Operation -> Multiplication, opts],
    Addition, RandomAssociativeQ[R, Operation -> Addition, opts],
    Both, RandomAssociativeQ[R, Operation -> Both, opts]]


(* ::Subsection:: *)
(*Identities*)


(* ::Subsubsection:: *)
(*zero*)


Options[HasZeroQ] = {Mode -> Computational, Structure -> Ring};

HasZeroQ[R_?RingoidQ] := HasZeroQ[R] = 
	Module[{AG = AGroupoid[R], aok, z},
		{aok, z} = {HasIdentityQ[AG], GroupIdentity[AG]};
		Zero[R] = z;
		AddRingInfo[R, aok, "the Ringoid has as a zero the element "<>ToString[z],
			"the Ringoid does not have a zero"];
		aok]
	
HasZeroQ[R_?RingoidQ, opts__?OptionQ]:=
	Module[{AG = AGroupoid[R], aok, z, 
			mode=Mode/.Flatten[{opts, Options[HasZeroQ]}],
			showopts = FilterRules[{opts},Options[Graphics]]},
		{aok, z} = {HasZeroQ[R], Zero[R]};
		If[mode === Textual && aok =!= $Failed,
			HasIdentityQ[AG, Mode -> Textual]//Return];
		If[mode === Visual && aok =!= $Failed,
			HasIdentityQ[AG, Mode -> Visual]//Return];
		aok]
		
Options[Zero] = {Mode -> Computational, Structure -> Ring};

Zero[R_?RingoidQ] := Zero[R] = 
	Module[{AG = AGroupoid[R], aok, z},
		{aok, z} = {HasIdentityQ[AG], GroupIdentity[AG]};
		HasZeroQ[R] = aok;
		AddRingInfo[R, aok, "the Ringoid has as a zero the element "<>ToString[z],
			"the Ringoid does not have a zero"];
		z]
	
Zero[R_?RingoidQ, opts__?OptionQ]:=
	Module[{AG = AGroupoid[R], aok, z, 
			mode=Mode/.Flatten[{opts, Options[Zero]}],
			showopts = FilterRules[{opts},Options[Graphics]]},
		{aok, z} = {HasZeroQ[R], Zero[R]};
		If[mode === Textual && z =!= $Failed,
			GroupIdentity[AG, Mode -> Textual]//Return];
		If[mode === Visual && z =!= $Failed,
			GroupIdentity[AG,  Mode -> Visual]//Return];
		z]


(* ::Subsubsection:: *)
(*unity*)


Options[WithUnityQ] = {Mode -> Computational, Structure -> Ring};

WithUnityQ[R_?RingoidQ] := WithUnityQ[R] = 
	Module[{MG = MGroupoid[R], mok, u},
		{mok, u} = {HasIdentityQ[MG], GroupIdentity[MG]};
		Unity[R] = u;
		AddRingInfo[R, mok, "the Ringoid has as unity the element "<>ToString[u],
			"the Ringoid does not have a unity element"];
		mok]
	
	
WithUnityQ[R_?RingoidQ, opts__?OptionQ]:=
	Module[{MG = MGroupoid[R], mok, u, 
			mode=Mode/.Flatten[{opts, Options[WithUnityQ]}],
			showopts = FilterRules[{opts},Options[Graphics]]},
		{mok, u} = {WithUnityQ[R], Unity[R]};
		If[mode === Textual && mok =!= $Failed,
			HasIdentityQ[MG, Mode -> Textual]//Return];
		If[mode === Visual && mok =!= $Failed,
			HasIdentityQ[MG, Mode -> Visual]//Return];
		mok]        

HasUnityQ[args__] := WithUnityQ[args]
         
Options[Unity] = {Mode -> Computational, Structure -> Ring};

Unity[R_?RingoidQ] := Unity[R] = 
	Module[{MG = MGroupoid[R], mok, u},
		{mok, u} = {HasIdentityQ[MG], GroupIdentity[MG]};
		WithUnityQ[R] = mok;
		AddRingInfo[R, mok, "the Ringoid has as unity the element"<>ToString[u],
			"the Ringoid does not have a unity element"];
		u]
	
Unity[R_?RingoidQ, opts__?OptionQ]:=
	Module[{MG = MGroupoid[R], mok, u, 
			mode=Mode/.Flatten[{opts, Options[Unity]}],
			showopts = FilterRules[{opts},Options[Graphics]]},
		{mok, u} = {WithUnityQ[R], Unity[R]};
		If[mode === Textual && u =!= $Failed,
			GroupIdentity[MG, Mode -> Textual]//Return];
		If[mode === Visual && u =!= $Failed,
			GroupIdentity[MG, Mode -> Visual]//Return];
		u]


(* ::Subsubsection:: *)
(*combined*)


Options[HasIdentityQ] = {Mode -> Computational, Operation -> Both,
	Structure -> Ring};

HasIdentityQ[R_?RingoidQ] := HasIdentityQ[R] = ModifiedAnd[HasZeroQ[R], WithUnityQ[R]]
		
HasIdentityQ[R_?RingoidQ, Operation -> Addition]:=
	HasIdentityQ[R, Operation -> Addition] = 
		HasZeroQ[R]
HasIdentityQ[R_?RingoidQ, Mode -> mode_, Operation -> Addition]:=
	HasIdentityQ[R, Operation -> Addition, Mode -> mode]
	
HasIdentityQ[R_?RingoidQ, Operation -> Addition, Mode -> mode_]:=
	(HasIdentityQ[R]; HasIdentityQ[AGroupoid[R], Mode -> mode])
	(* first line to set the RingInfo *)

HasIdentityQ[R_?RingoidQ, Operation -> Multiplication]:=
	HasIdentityQ[R, Operation -> Multiplication] = 
		WithUnityQ[R]
	
HasIdentityQ[R_?RingoidQ, Mode -> mode_, Operation -> Multiplication]:=
	HasIdentityQ[R, Operation -> Multiplication, Mode -> mode]

HasIdentityQ[R_?RingoidQ, Operation -> Multiplication, Mode -> mode_]:=
	(HasIdentityQ[R]; HasIdentityQ[MGroupoid[R], Mode -> mode])
	(* first line to set the RingInfo *)

HasIdentityQ[R_, Operation -> Both] := HasIdentityQ[R]
	
HasIdentityQ[R_?RingoidQ, Operation -> Both, opts__?OptionQ]:=
	Module[{AG = AGroupoid[R], MG = MGroupoid[R], aok, mok, 
			mode=Mode/.Flatten[{opts, Options[HasIdentityQ]}], gr1, gr2,
			showopts = FilterRules[{opts},Options[Graphics]]},
		{aok, mok} = {HasZeroQ[R], WithUnityQ[R]};
		If[mode === Textual && aok =!= $Failed && mok =!= $Failed,
			Return[Column[{Style["Additive Groupoid:",Blue],
				HasIdentityQ[AG, Mode -> Textual ],
				Style["Multiplicative Groupoid:",Blue],
				HasIdentityQ[MG, Mode -> Textual]}]];
		];
		If[mode === Visual && aok =!= $Failed && mok =!= $Failed,
			Return[Column[{HasIdentityQ[AG, Mode -> Visual], HasIdentityQ[MG, Mode -> Visual]}]];
		];
		ModifiedAnd[aok, mok]]

HasIdentityQ[R_?RingoidQ, opts__?OptionQ]:=
  Switch[Operation/.Flatten[{opts, Options[HasIdentityQ]}],
    Multiplication, HasIdentityQ[R, Operation -> Multiplication, opts],
    Addition, HasIdentityQ[R, Operation -> Addition, opts],
    Both, HasIdentityQ[R, Operation -> Both, opts]]


(* ::Subsection:: *)
(*Inverses*)


(* ::Subsubsection:: *)
(*Additive*)


Options[HasNegativeQ] = {Mode -> Computational, Structure -> Ring};

HasNegativeQ[R_?RingoidQ, r_] := HasNegativeQ[R,r] = 
	If[ElementQ[r,R], 
	Module[{AG = AGroupoid[R], aok, n},
		{aok, n} = {InvertibleQ[AG,r], GroupInverse[AG,r]};
		NegationOf[R,r] = n;
		AddRingInfo[R, aok, "the negation of "<>ToString[r]<>" is "<>ToString[n],
			ToString[r]<>" does not have a negation"];
		aok],
	Message[MemberQ::elmnt, r, StructureName[R]]; False]
	
HasNegativeQ[R_?RingoidQ, r_, opts__?OptionQ] :=
	If[ElementQ[r,R],
	Module[{AG = AGroupoid[R], aok, n, 
			mode=Mode/.Flatten[{opts, Options[HasNegativeQ]}],
			showopts = FilterRules[{opts},Options[Graphics]]},
		{aok, n} = {HasNegativeQ[R,r], NegationOf[R,r]};
		If[mode === Textual && aok =!= $Failed,
			InvertibleQ[AG, r, Mode -> Textual]//Return];
		If[mode === Visual && aok =!= $Failed,
			InvertibleQ[AG, r, Mode -> Visual]//Return];
		aok],
	Message[MemberQ::elmnt, r, StructureName[R]]; False]
		
Options[NegationOf] = {Mode -> Computational, Structure -> Ring};

NegationOf[R_?RingoidQ, r_] := NegationOf[R,r] = 
	If[ElementQ[r,R],
	Module[{AG = AGroupoid[R], aok, n},
		{aok, n} = {InvertibleQ[AG,r], GroupInverse[AG,r]};
		HasNegativeQ[R,r] = aok;
		AddRingInfo[R, aok, "the negation of "<>ToString[r]<>" is "<>ToString[n],
			ToString[r]<>" does not have a negation"];
		n],
	Message[MemberQ::elmnt, r, StructureName[R]]; $Failed]
	
NegationOf[R_?RingoidQ, r_, opts__?OptionQ] :=
	If[ElementQ[r,R],
	Module[{AG = AGroupoid[R], aok, n, 
			mode=Mode/.Flatten[{opts, Options[NegationOf]}],
			showopts = FilterRules[{opts},Options[Graphics]]},
		{aok, n} = {HasNegativeQ[R,r], NegationOf[R,r]};
		If[mode === Textual && aok =!= $Failed,
			InvertibleQ[AG, r, Mode -> Textual]//Return];
		If[mode === Visual && aok =!= $Failed,
			InvertibleQ[AG, r, Mode -> Visual]//Return];
		n],
	Message[MemberQ::elmnt, r, StructureName[R]]; 
	$Failed]
	
Unprotect[Inverse];

ringoid /: 
Inverse[R_ringoid, r_, Operation -> Addition, opts___?OptionQ] :=
	NegationOf[R, r, opts]

ringoid /:
Inverse[R_ringoid, r_, opts___?OptionQ, Operation -> Addition] :=
	NegationOf[R, r, opts]

Protect[Inverse];


(* ::Subsubsection:: *)
(*Multiplicative*)


Options[UnitQ] = {Mode -> Computational, Structure -> Ring};

UnitQ[R_?RingoidQ, r_] := UnitQ[R,r] = 
	If[ElementQ[r,R],
	Module[{MG = MGroupoid[R], mok, inv},
		{mok, inv} = {InvertibleQ[MG,r], GroupInverse[MG,r]};
		MultiplicativeInverse[R,r] = inv;
		AddRingInfo[R, mok, "the multiplicative inverse of "<>ToString[r]<>" is "<>ToString[inv],
			ToString[r]<>" does not have a multiplicative inverse"];
		mok],
	Message[MemberQ::elmnt, r, StructureName[R]]; False]
	
UnitQ[R_?RingoidQ, r_, opts__?OptionQ] :=
	If[ElementQ[r,R],
	Module[{MG = MGroupoid[R], mok, inv, 
			mode=Mode/.Flatten[{opts, Options[UnitQ]}],
			showopts = FilterRules[{opts},Options[Graphics]]},
		{mok, inv} = {UnitQ[R,r], MultiplicativeInverse[R,r]};
		If[mode === Textual && mok =!= $Failed,
			InvertibleQ[MG, r, Mode -> Textual]//Return];
		If[mode === Visual && mok =!= $Failed,
			InvertibleQ[MG, r, Mode -> Visual]//Return];
		mok],
	Message[MemberQ::elmnt, r, StructureName[R]]; False]
		

Options[MultiplicativeInverse] = {Mode -> Computational, Structure -> Ring};

MultiplicativeInverse[R_?RingoidQ, r_] := MultiplicativeInverse[R,r] = 
	If[ElementQ[r,R], 
	Module[{MG = MGroupoid[R], mok, inv},
		{mok, inv} = {InvertibleQ[MG,r], GroupInverse[MG,r]};
		UnitQ[R,r] = mok;
		AddRingInfo[R, mok, "the multiplicative inverse of "<>ToString[r]<>" is "<>ToString[inv],
			ToString[r]<>" does not have a multiplicative inverse"];
		inv],
	Message[MemberQ::elmnt, r, StructureName[R]]; $Failed]
	
MultiplicativeInverse[R_?RingoidQ, r_, opts__?OptionQ] :=
	If[ElementQ[r,R], 
	Module[{MG = MGroupoid[R], mok, inv, 
			mode=Mode/.Flatten[{opts, Options[MultiplicativeInverse]}],
			showopts = FilterRules[{opts},Options[Graphics]]},
		{mok, inv} = {UnitQ[R,r], MultiplicativeInverse[R,r]};
		If[mode === Textual && mok =!= $Failed,
			InvertibleQ[MG, r, Mode -> Textual]//Return];
		If[mode === Visual && mok =!= $Failed,
			InvertibleQ[MG, r, Mode -> Visual]//Return];
		inv],
	Message[MemberQ::elmnt, r, StructureName[R]];
	 $Failed]
	
Unprotect[Inverse];

ringoid /: 
Inverse[R_ringoid, r_, Operation -> 
	Multiplication, opts___?OptionQ] :=
	MultiplicativeInverse[R, r, opts]

ringoid /:
Inverse[R_ringoid, r_, opts___?OptionQ, 
	Operation -> Multiplication] :=
	MultiplicativeInverse[R, r, opts]

Protect[Inverse];

Options[Units] = {Mode->Computational};

Units[R_?RingoidQ] := Units[R] = 
	DeleteCases[Inverses[MGroupoid[R]],
		{x_,"no inverse"}]//Flatten[#,1]&//Union
		
Units[R_?RingoidQ, opts__?OptionQ] := 
   If[WithUnityQ[R],
     Block[{pairs,
            jm=(ToString[#1]<>
                " is a unit because "<>
                ToString[#1]<>" . "<> 
                ToString[#2]<>" = "<> 
                ToString[Unity[R]]<>".")&,
            md=Mode/.Flatten[{opts, Options[Units]}],
            gr=MGroupoid[R],
            us=Units[R],
            zeroOneFirst=Join[{Zero[R],Unity[R]},
                           Complement[First[R],{Zero[R],Unity[R]}]]},
        OperatorSymbol[gr]=".";
        us=Units[R];
        If[(md==Textual)(*||(md==Visual)*),
           pairs=Map[{#,MultiplicativeInverse[R,#]}&,us];
           Apply[jm,pairs,{1}]//
               TableForm//Print//Return];
        If[(md==Visual),
            (*Print["\nNotice the locations of unity (pink) in the table below."];*)
            MultiplicationTable[R,Mode -> Visual,
                                         TheSet->zeroOneFirst]//Return];
        us],
        (* ********** *)
        Print["Ringoid has no unity, units not applicable"]];


(* ::Subsubsection:: *)
(*combined*)


Options[InvertibleQ] = {Mode -> Computational, Operation -> Both,
	Structure -> Ring};

InvertibleQ[R_?RingoidQ, r_] := InvertibleQ[R, r] = 
	ModifiedAnd[HasNegativeQ[R,r], UnitQ[R,r]]
		
InvertibleQ[R_?RingoidQ, r_, Operation -> Addition] :=
	InvertibleQ[R, r, Operation -> Addition] = 
		HasNegativeQ[R,r]
	
InvertibleQ[R_?RingoidQ, r_, Operation -> Addition, opts__?OptionQ]:=
	(InvertibleQ[R,r]; HasNegativeQ[R, r, opts])

InvertibleQ[R_?RingoidQ, r_, Operation -> Multiplication]:=
	InvertibleQ[R, r, Operation -> Multiplication] = 
		UnitQ[R,r]
	
InvertibleQ[R_?RingoidQ, r_, Operation -> Multiplication, opts__?OptionQ]:=
	(InvertibleQ[R,r]; UnitQ[R, r, opts])

InvertibleQ[R_, r_, Operation -> Both]:=
	InvertibleQ[R,r]
	
InvertibleQ[R_?RingoidQ, r_, Operation -> Both, opts__?OptionQ]:=
	Module[{AG = AGroupoid[R], MG = MGroupoid[R], aok, mok, 
			mode=Mode/.Flatten[{opts, Options[InvertibleQ]}],
			showopts = FilterRules[{opts},Options[Graphics]]},
		{aok, mok} = {HasNegativeQ[R,r], UnitQ[R,r]};
		If[mode === Textual && aok =!= $Failed && mok =!= $Failed,
			Return[Column[{Style["Additive Groupoid:",Blue],
				InvertibleQ[AG,r, Mode -> Textual ],
				Style["Multiplicative Groupoid:",Blue],
				InvertibleQ[MG, r, Mode -> Textual]}]]
		];
		If[mode === Visual && aok =!= $Failed && mok =!= $Failed,
			Return[Row[{InvertibleQ[AG,r, Mode -> Visual],InvertibleQ[MG,r, Mode -> Visual]}]];
		];
		ModifiedAnd[aok, mok]]

InvertibleQ[R_?RingoidQ, r_, opts__?OptionQ]:=
  Switch[Operation/.Flatten[{opts, Options[InvertibleQ]}],
    Multiplication, InvertibleQ[R, r, Operation -> Multiplication, opts],
    Addition, InvertibleQ[R, r, Operation -> Addition, opts],
    Both, InvertibleQ[R, r, Operation -> Both, opts]]

Unprotect[Inverse];

ringoid /: 
Inverse[R_ringoid, r_, Operation -> Both, opts___?OptionQ] :=
	{NegationOf[R, r, opts], MultiplicativeInverse[R, r, opts]}

ringoid /:
Inverse[R_ringoid, r_, opts___?OptionQ, Operation -> Both] :=
	{NegationOf[R, r, opts], MultiplicativeInverse[R, r, opts]}

ringoid /:
Inverse[R_ringoid, r_, opts___?OptionQ] :=
	Inverse[R, r, Operation -> Both, opts]

Protect[Inverse];
	
Options[HasInversesQ] = {Mode -> Computational, Operation -> 
	Both, Structure -> Ring};

HasInversesQ[R_?RingoidQ] := HasInversesQ[R] = 
	ModifiedAnd[HasInversesQ[R, Operation -> Addition],
		HasInversesQ[R, Operation -> Multiplication]]
		
HasInversesQ[R_?RingoidQ, Operation -> Addition] := 
	HasInversesQ[R, Operation -> Addition] = 
	Module[{AG = AGroupoid[R], ok},
		ok = HasInversesQ[AG];
		AddRingInfo[R, ok, "every element has an additive inverse",
			 "there are elements that do not have an additive inverse"];
		ok]

HasInversesQ[R_?RingoidQ, Operation -> Multiplication] := 
	HasInversesQ[R, Operation -> Multiplication] = 
	Module[{MG = MGroupoid[R], ok},
		ok = HasInversesQ[MG];
		AddRingInfo[R, ok, "every element has a multiplicative inverse",
			 "there are elements that do not have a multiplicative inverse"];
		ok]

HasInversesQ[R_?RingoidQ, Operation -> Addition, Mode->mode_]:=
	HasInversesQ[AGroupoid[R], Mode->mode]
	
HasInversesQ[R_?RingoidQ, Mode->mode_, Operation -> Addition]:=
	HasInversesQ[AGroupoid[R], Mode->mode]

HasInversesQ[R_?RingoidQ, Operation -> Multiplication, Mode->mode_]:=
	HasInversesQ[MGroupoid[R], Mode->mode]

HasInversesQ[R_?RingoidQ, Mode->mode_, Operation -> Multiplication]:=
	HasInversesQ[MGroupoid[R], Mode->mode]
	
HasInversesQ[R_?RingoidQ, Operation -> Both, opts___?OptionQ]:=
	Module[{AG = AGroupoid[R], MG = MGroupoid[R], ac, mc, 
			mode=Mode/.Flatten[{opts, Options[HasInversesQ]}], gr1, gr2,
			showopts = FilterRules[{opts},Options[Graphics]]},
		{ac, mc} = {HasInversesQ[R, Operation -> Addition],
			HasInversesQ[R, Operation -> Multiplication]};
		If[mode === Textual && ac =!= $Failed && mc =!= $Failed,
			Return[Column[{Style["Additive Groupoid:",Blue],
				HasInversesQ[AG, Mode -> Textual ],
				Style["Multiplicative Groupoid:",Blue],
				HasInversesQ[MG, Mode -> Textual]}]]
		];
		If[mode === Visual && ac =!= $Failed && mc =!= $Failed,
			Return[Row[{HasInversesQ[AG, Mode -> Visual],HasInversesQ[MG, Mode -> Visual]}]]
		];
		ModifiedAnd[ac, mc]]

HasInversesQ[R_?RingoidQ, opts___?OptionQ] :=
  Switch[Operation/.Flatten[{opts, Options[HasInversesQ]}],
    Multiplication, HasInversesQ[R, Operation -> Multiplication, opts],
    Addition, HasInversesQ[R, Operation -> Addition, opts],
    Both, HasInversesQ[R, Operation -> Both, opts]]

Options[Inverses] = {Mode -> Computational, Operation -> 
	Both, Structure -> Ring};

Inverses[R_?RingoidQ, Operation -> Addition]:=
	Inverses[AGroupoid[R]]

Inverses[R_?RingoidQ, Operation -> Multiplication]:=
	Inverses[MGroupoid[R]]

Inverses[R_?RingoidQ, Operation -> Addition, Mode -> mode_]:=
	Inverses[AGroupoid[R],  Mode -> mode]

Inverses[R_?RingoidQ, Mode -> mode_, Operation -> Addition]:=
	Inverses[AGroupoid[R],  Mode -> mode]

Inverses[R_?RingoidQ, Mode -> mode_, Operation -> Multiplication]:=
	Inverses[MGroupoid[R], Mode -> mode]
	
Inverses[R_?RingoidQ, Operation -> Multiplication, Mode -> mode_]:=
	Inverses[MGroupoid[R], Mode -> mode]
	
Inverses[R_?RingoidQ, Operation -> Both, opts___?OptionQ]:=
	Module[{AG = AGroupoid[R], MG = MGroupoid[R], ac, mc, 
			mode=Mode/.Flatten[{opts, Options[Inverses]}], gr1, gr2,
			showopts = FilterRules[{opts},Options[Graphics]]},
		ac = Inverses[AG];
		mc = Inverses[MG];
		If[mode === Textual,
			Return[Column[{Style["Additive Groupoid:",Blue],
				Inverses[AG,  Mode -> Textual ],
				Style["Multiplicative Groupoid:",Blue],
				Inverses[MG,  Mode -> Textual]}]]
		];
		If[mode === Visual,
			Return[Row[{Inverses[AG, Mode -> Visual],Inverses[MG, Mode -> Visual]}]];
		];
		{ac, mc}]

Inverses[R_?RingoidQ, opts___?OptionQ] :=
  Switch[Operation/.Flatten[{opts, Options[Inverses]}],
    Multiplication, Inverses[R, Operation -> Multiplication, opts],
    Addition, Inverses[R, Operation -> Addition, opts],
    Both, Inverses[R, Operation -> Both, opts]]


(* ::Subsection:: *)
(*Distributivity*)


LeftDistributiveQ[R_?RingoidQ] := 
	Module[{els = Elements[R], plus = Addition[R],
	    times=Multiplication[R],
		ok, i,j,k, len,mymode},
	len = Length[els];
	Off[Part::partd];
	Do[ok = times[els[[i]],plus[els[[j]],els[[k]]]] === 
		plus[times[els[[i]],els[[j]]],times[els[[i]],els[[k]]]];
		If[!ok,Break[]], {i,1,len},{j,1,len},{k,1,len}];
	On[Part::partd];
	AddRingInfo[R,ok,"multiplication is left distributive over addition", 
		"multiplication is not left distributive over addition"];
	ok]
	
RightDistributiveQ[R_?RingoidQ] := 
	Module[{els = Elements[R], plus = Addition[R],
	    times=Multiplication[R],
		ok, i,j,k, len,mymode},
	len = Length[els];
	Off[Part::partd];
	Do[ok = times[plus[els[[j]],els[[k]]], els[[i]]] === 
		plus[times[els[[j]],els[[i]]],times[els[[k]],els[[i]]]];
		If[!ok,Break[]], {i,1,len},{j,1,len},{k,1,len}];
	On[Part::partd];
	AddRingInfo[R,ok,"multiplication is right distributive over addition", 
		"multiplication is not right distributive over addition"];
	ok]
	
DistributiveQ[R_?RingoidQ] := DistributiveQ[R] = 
	Module[{ok},
	ok = LeftDistributiveQ[R] && RightDistributiveQ[R];
	AddRingInfo[R,ok,"multiplication is distributive over addition", 
		"multiplication is not distributive over addition"];
	ok]
	
DistributiveQ[R_?RingoidQ, Mode -> Visual]:=
	(Message[Mode::novis]; $Failed)

DistributiveQ[R_?RingoidQ, Mode -> Textual]:=
	(Message[Mode::notext]; $Failed)
	
(* Added 7/26/04 *)

RandomDistributiveQ[R_?RingoidQ, n_Integer:25] :=
	 Module[{els = Elements[R], plus = Addition[R],
	    times=Multiplication[R],
		ok, i,j,k,len = Length[R[[1]]],mymode},
	Off[Part::partd];
	Do[i = Random[Integer,{1,len}];
		j = Random[Integer,{1,len}];
		k = Random[Integer,{1,len}];
		ok = times[els[[i]],plus[els[[j]],els[[k]]]] === 
		 plus[times[els[[i]],els[[j]]],times[els[[i]],els[[k]]]] &&
		 times[plus[els[[j]],els[[k]]], els[[i]]] === 
		 plus[times[els[[j]],els[[i]]],times[els[[k]],els[[i]]]];
		If[!ok,Break[]], {n}];
	On[Part::partd];
	AddRingInfo[R,ok, "multiplication is probably distributive over addition",
		"multiplication is not distributive over addition"];
	ok]


(* ::Subsection:: *)
(*Ring*)


ZRingoidQn[R_?RingoidQ] := Module[{chars, zpartq, index, ok, nm = RingoidName[R]},
	If[Head[nm] === String, 
		Off[ToExpression::esntx, ToExpression::sntx, ToExpression::sntxi];
		chars = Characters[nm];
		zpartq = Join[Take[chars,2],{Last[chars]}];
		index = ComplementNoSort[chars,zpartq]//StringJoin//ToExpression;
		On[ToExpression::esntx, ToExpression::sntx, ToExpression::sntxi];
		zpartq = StringJoin[zpartq];
		ok = IntegerQ[index] && zpartq === "Z[]";
		If[ok, {ok, index}, {ok, Null}], {False, Null}]]
	
Options[RingQ] = {Mode -> Computational};
	
RingQ[R_?RingoidQ] := RingQ[R] = Module[{ok,zq,n,crq},
	{zq,n} = ZRingoidQn[R];
	crq = If[!untestedQ[ringQ[R]],
		ringQ[R],False];
	If[zq || crq, ok = True,
		ok = ClosedQ[R, Operation -> Both];
		If[ok, ok = HasIdentityQ[R, Operation -> Addition]];
		If[ok, ok = HasInversesQ[R, Operation -> Addition]];
		If[ok, ok = CommutativeQ[R, Operation -> Addition]];
		If[ok, ok = DistributiveQ[R]];
		If[ok, ok = AssociativeQ[R, Operation -> Both]]];
	AddRingInfo[R,ok,"this is a ring","this is NOT a ring"];
	ok]
			
RingQ[R_?RingoidQ, Mode -> mode_] := 
	If[mode===Textual,
		RingQTextual[G],
		If[mode===Visual,
			RingQVisual[G]
		]
	]

RingQTextual[R_] := 
	(ClosedQ[R, Mode -> Textual, Operation -> Both];
	HasIdentityQ[R, Mode -> Textual, Operation -> Addition];
	HasInversesQ[R, Mode -> Textual, Operation -> Addition];
	CommutativeQ[R, Mode -> Textual, Operation -> Addition];
	(*DistributiveQ[R, Mode -> Textual];*)
	AssociativeQ[R, Mode -> Textual, Operation -> Both])
	
RingQVisual[R_] := 
	(ClosedQ[R, Mode -> Visual, Operation -> Both];
	HasIdentityQ[R, Mode -> Visual, Operation -> Addition];
	HasInversesQ[R, Mode -> Visual, Operation -> Addition];
	CommutativeQ[R, Mode -> Visual, Operation -> Addition];
	(*DistributiveQ[R, Mode -> Visual];*)
	AssociativeQ[R, Mode -> Visual, Operation -> Both])
	
Options[RingQ] = {Mode -> Computational};

ProbableRingQ[R_?RingoidQ] := ProbableRingQ[R] = Module[{ok},
	ok = ClosedQ[R, Operation -> Both];
	If[ok, ok = HasIdentityQ[R, Operation -> Addition]];
	If[ok, ok = HasInversesQ[R, Operation -> Addition]];
	If[ok, ok = CommutativeQ[R, Operation -> Addition]];
	If[ok, ok = RandomDistributiveQ[R]];
	If[ok, ok = RandomAssociativeQ[R, Operation -> Both]];
	AddRingInfo[R, ok, "this is probably a ring","this is NOT a ring"]; 
	ok]

ProbableRingQ[R_?RingoidQ, Mode -> mode] := 
	If[mode===Textual,
		ProbableRingQTextual[G],
		If[mode===Visual,
			ProbableRingQVisual[G]
		]
	]
	
ProbableRingQTextual[R_] := 
	(ClosedQ[R, Mode -> Textual, Operation -> Both];
	HasIdentityQ[R, Mode -> Textual, Operation -> Addition];
	HasInversesQ[R, Mode -> Textual, Operation -> Addition];
	CommutativeQ[R, Mode -> Textual, Operation -> Addition];
	(*RandomDistributiveQ[R, Mode -> Textual];*)
	RandomAssociativeQ[R, Mode -> Textual, Operation -> Both])
	
ProbableRingQVisual[R_] := 
	(ClosedQ[R, Mode -> Visual, Operation -> Both];
	HasIdentityQ[R, Mode -> Visual, Operation -> Addition];
	HasInversesQ[R, Mode -> Visual, Operation -> Addition];
	CommutativeQ[R, Mode -> Visual, Operation -> Addition];
	(*RandomDistributiveQ[R, Mode -> Visual];*)
	RandomAssociativeQ[R, Mode -> Visual, Operation -> Both])


(* ::Section:: *)
(* 66. Additional Ring properties*)


(* ::Subsection:: *)
(*Zero Divisors*)


ZeroDivisorQ[R_?RingoidQ, a_] := MemberQ[ZeroDivisors[R], a];
      
Options[ZeroDivisors] = {Mode -> Computational};

ZeroDivisors[R_?RingoidQ] := ZeroDivisors[R]=
	If[HasZeroQ[R],
		Module[{G = FormGroupoid[Complement[Elements[R],{Zero[R]}],
				Multiplication[R]], zd},
			zd = CayleyTable[G, Mode->Computational]//Map[Fold[(#1||(Zero[R]==#2))&,
				(First[#]==Zero[R]),Rest[#]]&,#]&//
				{#,Elements[G]}&//Transpose//
				Select[#,First[#]&]&//If[#=={},{},#//Transpose//Last]&;
			AddRingInfo[R,zd==={},"the ring has no zero divisors", "the
ring has the following zero divisors: "<>ToString[zd]];
			zd], 
	Message[ZeroDivisors::NA]; $Failed];

ZeroDivisors[R_?RingoidQ, opts__?OptionQ] := 
   If[HasZeroQ[R],
     Block[{pairs,
            jm=("One reason why "<>ToString[#1]<>
                " is a zero divisor is that "<>
                ToString[#1]<>" * "<> 
                ToString[#2]<>" = "<> 
                ToString[Zero[R]]<>".")&,
            md = Mode/.Flatten[{opts, Options[ZeroDivisors]}],
            G = MGroupoid[R],
            zd = ZeroDivisors[R],
            showopts = FilterRules[{opts},Options[Graphics]],
            zeroFirst=Join[{Zero[R]},
                           Complement[First[R],{Zero[R]}]]},
        OperatorSymbol[G] = "*";
        If[(md==Textual),
           pairs=Map[{#,RingSolve[R,#,Zero[R]]//
                       Complement[#,{Zero[R]}]&//
                       randElement}&,zd];
           If[pairs=={},
              Return["There are no zero divisors in "<>
              						ToString[RingInfo[R][[1,1]]]],
             Apply[jm,pairs,{1}]//
               TableForm//Return]];
        If[(md==Visual),
        	    (*Print["\nNotice the locations of zero "<>
        	    	ToString[Zero[R]]<>" in the table below."];*)
             MultiplicationTable[R, Mode -> Visual,
                                         TheSet->zeroFirst]//Return];
          zd],
        Message[ZeroDivisors::NA];$Failed];


(* ::Subsection::Closed:: *)
(*Types of Rings*)


FieldQ[R_?RingoidQ] := FieldQ[R] = 
	Module[{zq,n},
	{zq,n} = ZRingoidQn[R];
	If[zq && PrimeQ[n], True, 
 (RingQ[R] &&
  CommutativeQ[R, Operation -> Multiplication] &&
  WithUnityQ[R] &&
  Units[R]===Complement[R[[1]],{Zero[R]}])]]

IntegralDomainQ[R_?RingoidQ] := IntegralDomainQ[R] = 
	Module[{zq,n},
	{zq,n} = ZRingoidQn[R];
	If[zq && PrimeQ[n], True, 
   (RingQ[R] &&
    CommutativeQ[R, Operation -> Multiplication] &&
    WithUnityQ[R] &&
    (ZeroDivisors[R]==={}))]]


(* ::Subsection:: *)
(*other properties*)


Characteristic[R_?RingoidQ] := Module[{unity},
	If[WithUnityQ[R] && RingQ[R],
		unity = Unity[R];
		FixedPointList[Addition[R][unity,#]&,unity,
			SameTest->(#2===Zero[R]&)]//Length,
		Message[Characteristic::fail];$Failed]]
		
NilpotentDegree[R_?RingoidQ, r_] := NilpotentDegree[R, r] = 
	Module[{f,n,u,uns,nl, z = Zero[R],stop,nil,m},
	n = Length[Elements[R]];
	f = Floor[n/3];
	nl = NestList[Multiplication[R][r,#]&,r,f];
	stop = (m=MemberQ[nl,z]) || Union[nl] =!= UnionNoSort[nl];
	If[stop, nil = If[m, Position[nl,z]//Flatten//First,0],
		nl = NestList[Multiplication[R][Last[nl],#]&,r,f];
		stop = (m=MemberQ[nl,z]) || Union[nl] =!= UnionNoSort[nl];
		If[stop, nil = If[m,Position[nl,z]//Flatten//First+f,0],
			nl = NestList[Multiplication[R][Last[nl],#]&,r,n-2f];
			stop = (m=MemberQ[nl,z]) || Union[nl] =!= UnionNoSort[nl];
			If[stop, nil = If[m,Position[nl,z]//Flatten//First+f +f,0],
				nil = 0]]];
	nil
]

NilpotentQ[R_?RingoidQ, r_] := NilpotentDegree[R,r]=!=0

IdempotentQ[R_?RingoidQ, r_] := Multiplication[R][r,r]===r

Idempotents[R_?RingoidQ] := 
	Select[Map[{#,IdempotentQ[R,#]}&,Elements[R]],Last[#]===True&]//
	Transpose//First
	
Nilpotents[R_?RingoidQ] := 
	Select[Map[{#,NilpotentQ[R,#]}&,Elements[R]],Last[#]===True&]//
	Transpose//First


(* ::Section:: *)
(* 67. Working with elements*)


(* ::Subsection:: *)
(*RandomElement(s)*)


randElement[{}] := {};

randElement[Dom_List]:=
       Dom[[Random[Integer,{1,Length[Dom]}]]];
       
Options[RandomElement]= {SelectFrom -> NonZero, LowerDegreeOK -> False, 
	Monic -> False, SelectBaseElementsFrom -> Any};

RandomElement[R_?RingoidQ, opts___?OptionQ]:=
	Module[{p,sel=(SelectFrom/.Flatten[{opts, Options[RandomElement]}]),
			d=Elements[R], chooseFrom, aok,mok},
		Off[Identity::lfail, Identity::rfail, Identity::fail];
		{aok,mok} = {HasZeroQ[R], WithUnityQ[R]};
		If[sel===NonZero && aok,
			chooseFrom = Complement[d, {Zero[R]}],
			If[sel===NonUnity && mok,
				chooseFrom = Complement[d, {Unity[R]}],
				If[sel===NonIdentity && aok && mok,
					chooseFrom = Complement[d, {Zero[R],Unity[R]}],
					chooseFrom = d]]];
		On[Identity::lfail, Identity::rfail, Identity::fail];
		If[chooseFrom =!= {},
			randElement[chooseFrom],
			Message[RandomElement::fail, sel]; $Failed]]

Options[RandomElements]={SelectFrom -> Any, Replacement -> True, 
	LowerDegreeOK -> False, Monic -> False, SelectBaseElementsFrom -> Any};

RandomElements[R_?RingoidQ ,n_Integer?Positive, opts___?OptionQ]:= 
	Module[{sel, rep, els=Elements[R], list, possible, aok,mok, p,s,chooseFrom},
	sel=SelectFrom/.Flatten[{opts, Options[RandomElements]}];
	rep=Replacement/.Flatten[{opts, Options[RandomElements]}];
	s = Length[els];
	{aok,mok} = {HasZeroQ[R], WithUnityQ[R]};
	If[sel===NonZero && aok,
			chooseFrom = Complement[els, {Zero[R]}];
			possible = rep || n < s,
			If[sel===NonUnity && mok,
				chooseFrom = Complement[els, {Unity[R]}];
				possible = rep || n < s,
				If[sel===NonIdentity && aok && mok,
					chooseFrom = Complement[els, {Zero[R],Unity[R]}];
					possible = rep || n < s - 1,
					chooseFrom = els;
					possible = rep || n <= s]]];
	If[possible && chooseFrom =!= {},
    	If[rep,
    		(* just find some random elements, replacement ok *)
    		list = Table[randElement[chooseFrom],{n}],
    		(* replacement not ok *)
    		p = RandomPermutationAA[s];
    		p = Map[els[[#]]&,p];
				If[n <= s && sel=!=NonIdentity && sel=!=NonZero && 
					sel=!=NonUnity, list = Take[p, n]];
				If[n < s && sel === NonZero,
					p = Take[p, n+1];
					id = If[HasZeroQ[R],
    				Zero[R],{}];
    			p = DeleteCases[p,id];
    			If[Length[p] == n, list = p, list = Drop[p,1]]
					];
				If[n < s && sel === NonUnity,
					p = Take[p, n+1];
					id = If[WithUnityQ[R],
    				Unity[R],{}];
    			p = DeleteCases[p,id];
    			If[Length[p] == n, list = p, list = Drop[p,1]]
					];
				If[n < s - 1 && sel === NonIdentity,
					p = Take[p, n+2];
					id = If[HasZeroQ[R],
    				Zero[R],{}];
    			p = DeleteCases[p,id];
    			id = If[WithUnityQ[R],
    				Unity[R],{}];
    			p = DeleteCases[p,id];
    			list = Take[p,n]
					]
    		]
    	];
    If[!rep,
  		If[n > s, Message[RandomElements::toomany,n,s]; list = $Failed];
   		If[n == s && (sel === NonZero || sel === NonUnity),
   				Message[RandomElements::toomanyni,n,s]; list = $Failed];
   		If[n == s-1 && sel === NonIdentity,
   				Message[RandomElement::fail, sel]; list = $Failed]];
   	If[chooseFrom === {},
   		Message[RandomElement::fail, sel]; list = $Failed];
    list
    ]


(* ::Subsection::Closed:: *)
(*ElementToPower (MultipleOfElement)*)


ElementToPower[R_?RingoidQ, r_, n_Integer] := 
	ElementToPower[MGroupoid[R], r, n]
	
MultipleOfElement[R_?RingoidQ, r_, n_Integer] := 
	ElementToPower[AGroupoid[R], r, n]


(* ::Section:: *)
(* 68. CayleyTables*)


Options[CayleyTables] := {Mode -> Computational, Operation -> Both,
	ShowExtraCayleyInformation->False};

CayleyTables[many:{_?RingoidQ..}, Mode -> Visual] := 
	Column[Table[CayleyTables[many[[i]], Mode -> Visual], {i, Length[many]}]]
		
CayleyTables[R_?RingoidQ, Operation -> Addition] := 
	CayleyTables[R, Operation -> Addition] = CayleyTable[AGroupoid[R],Mode -> Computational]
	
CayleyTables[R_?RingoidQ, Operation -> Multiplication] := 
	CayleyTables[R, Operation -> Multiplication] = CayleyTable[MGroupoid[R],Mode -> Computational]
		
CayleyTables[R_?RingoidQ]:= 
	Row[{CayleyTable[AGroupoid[R],Mode -> Visual], CayleyTable[MGroupoid[R],Mode -> Visual]}];

CayleyTables[R_?RingoidQ, Operation -> rngop_, Mode -> Visual, 
	opts___?OptionQ] := CayleyTables[R, Mode -> Visual, Operation -> rngop, opts]

CayleyTables[R_?RingoidQ, Operation -> rngop_, Mode -> Textual, 
	opts___?OptionQ] := (Message[Mode::notavail, CayleyTables, Textual];CayleyTables[R])

CayleyTables[R_?RingoidQ, Mode -> Textual, 
	opts___?OptionQ] := (Message[Mode::notavail, CayleyTables, Textual];CayleyTables[R])
	
CayleyTables[R_?RingoidQ, Mode -> Visual, opts___?OptionQ]:= 
   Module[{G,Gm, wide = MemberQ[{List,Func,Poly},Head[R[[1,1]]]],
   ctopts = FilterRules[{opts},Options[CayleyTable]],
   gropts = FilterRules[{opts},Options[Graphics]],
   rngop = Operation/.Flatten[{opts, Options[CayleyTables]}]},
  (* find any CayleyTable  or Graphics options and pass these through *)
  G = AGroupoid[R];
  Gm = MGroupoid[R];
	ctopts = Apply[Sequence,
   	{ctopts}/.{a___,Mode->_,b___}->{a,b}];
	If[wide || WideElementsQ[R],
		WideElementsQ[G]=True;
		WideElementsQ[Gm]=True];
	(* only specify wide if we know they are - otherwise let
	basicCayley fuss over width issues *)
	If[rngop === Addition, CayleyTable[G, Mode->Visual, ctopts, gropts,
		TableName -> "("<>
		StructureName[R] <>", +)"],
		If[rngop === Multiplication, CayleyTable[Gm, Mode->Visual,
			ctopts, gropts,
			TableName -> "("<>
			StructureName[R] <>", x)"],
		CayleyTable[{{G,ctopts,gropts, TableName -> 
			"Add."},{Gm,ShowKey -> False,
			ctopts,gropts,TableName -> "Mult."}},
			Mode->Visual, ShowExtraCayleyInformation->False]]]];

MultiplicationTable[R_?RingoidQ, opts___?OptionQ]:=
	CayleyTables[R, Operation -> Multiplication, opts];

CayleyTable[R_?RingoidQ, Operation -> rngop_] := 
	CayleyTables[R, Operation -> rngop]

CayleyTable[R_?RingoidQ, Operation -> rngop_, opts___?OptionQ] :=
	CayleyTables[R, Operation -> rngop, opts]

CayleyTable[R_?RingoidQ, opts1___?OptionQ, Operation -> rngop_, 
	opts2___?OptionQ] := CayleyTables[R, Operation -> rngop, opts1, opts2]



(* ::Section:: *)
(* 69. Subrings*)


Options[SubringQ] = {Mode->Computational};

SubringQ[S_List, R_?RingoidQ] := (RingQ[R] && Length[S] > 0 && 
	ClosedQ[R,S, Operation -> Multiplication] && ClosedDiffQ[R,S])
	
SubringQ[S_?RingoidQ, R_?RingoidQ,  opts___?OptionQ] :=
	If[Addition[R] === Addition[S] && Multiplication[R]===Multiplication[S],
		If[RingQ[R],SubringQ[Elements[S], R,  opts],
			Message[Ring::fail, StructureName[R]]; False],
		Message[Operation::fail]; False]
                           
SubringQ[S_List, R_?RingoidQ,  Mode -> Textual] := 
	Block[{fn=SubringQ[S,R],  tr, messg},
		messg = If[Length[S]>0,
			"Prospective subring is not empty; passes the first test.",
			"Prospective subring is empty; it can not be a subring."];
		messg = messg <> "\n" <> If[ClosedQ[R,S,Operation->Addition],
			"Prospective subring is closed with respect to addition; passes the second test.", 
			"Prospective subring is not closed with respect to addition; it can not be a subring."];
		messg = messg <> "\n" <> If[ClosedQ[R,S,Operation->Multiplication],
		"Prospective subring is closed with respect to multiplication; passes the third test.", 
		"Prospective subring is not closed with respect to multiplication; it can not be a subring."];
        messg]
        
SubringQ[S_List, R_?RingoidQ, Mode -> Visual] := Message[Mode::novis]


(* ::Section:: *)
(* 70. Ideals*)


LeftIdealQ[S_List, R_?RingoidQ] := 
	If[SubringQ[S,R],
		SubsetQAA[Union[Map[Apply[Multiplication[R],#]&,
			CartesianProduct[Elements[R],S]]],S],
		Message[Ring::subringfail,S];False]

LeftIdealQ[S_?RingoidQ, R_?RingoidQ] :=
	If[Addition[R] === Addition[S] && Multiplication[R]===Multiplication[S],
		If[RingQ[R], LeftIdealQ[Elements[S], R],
			Message[Ring::fail, StructureName[S]]; False],
		Message[Operation::fail]; False]
	
RightIdealQ[S_List, R_?RingoidQ] := 
	If[SubringQ[S,R],
		SubsetQAA[Union[Map[Apply[Multiplication[R],#]&,
			CartesianProduct[S,Elements[R]]]],S],
		Message[Ring::subringfail,S];False]

RightIdealQ[S_?RingoidQ, R_?RingoidQ] :=
	If[Addition[R] === Addition[S] && Multiplication[R]===Multiplication[S],
		If[RingQ[R], RightIdealQ[Elements[S], R],
			Message[Ring::fail, StructureName[S]]; False],
		Message[Operation::fail]; False]
		
(* IdealQ[S_List, R_?RingoidQ] := If[LeftIdealQ[S,R],RightIdealQ[S,R],
	False]

Why is there a comma between left and right - should be And 9/14/08
*)

IdealQ[S_List, R_?RingoidQ] := If[LeftIdealQ[S,R] && RightIdealQ[S,R],True,
	False]

IdealQ[S_?RingoidQ, R_?RingoidQ] :=
	If[Addition[R] === Addition[S] && Multiplication[R]===Multiplication[S],
		If[RingQ[R], IdealQ[Elements[S], R],
			Message[Ring::fail, StructureName[S]]; False],
		Message[Operation::fail]; False]
		
PrincipalIdeal[R_?RingoidQ,r_] := If[CommutativeQ[R] && WithUnityQ[R],
	FormRingoid[Map[Multiplication[R][r,#]&,Elements[R]]//Union,
		Addition[R],Multiplication[R],
		GatherRingoidOptions[R]],
	Message[IdealQ::fail]; $Failed]

PrincipalIdeal[R_?RingoidQ, S_?RingoidQ] :=
	If[Addition[R] === Addition[S] && Multiplication[R]===Multiplication[S],
		If[RingQ[R], PrincipalIdeal[R, Elements[S]],
			Message[Ring::fail, StructureName[S]]; $Failed],
		Message[Operation::fail]; $Failed]
		
PrimeIdealQ[S_List, R_?RingoidQ] := Module[{ok},
	If[ElementsQ[S,R],
		If[CommutativeQ[R] && WithUnityQ[R],
			Off[QuotientRing::NS];
			ok = If[ProperSubsetQAA[S, Elements[R]],
				IntegralDomainQ[QuotientRing[R,S]], False];
			On[QuotientRing::NS]; ok,
		Message[IdealQ::fail];False],
	Message[MemberQ::elmnts, S, StructureName[R]]; $Failed]]

PrimeIdealQ[S_?RingoidQ, R_?RingoidQ] :=
	If[Addition[R] === Addition[S] && Multiplication[R]===Multiplication[S],
		If[RingQ[R], PrimeIdealQ[Elements[S], R],
			Message[Ring::fail, StructureName[S]]; False],
		Message[Operation::fail]; False]
			
MaximalIdealQ[S_?RingoidQ, R_?RingoidQ] :=
	If[Addition[R] === Addition[S] && Multiplication[R]===Multiplication[S],
		If[RingQ[R], MaximalIdealQ[Elements[S],R],
			Message[Ring::fail, StructureName[S]]; False],
		Message[Operation::fail]; False]

MaximalIdealQ[S_List, R_?RingoidQ] := Module[{ok},
	If[ElementsQ[S,R],
		If[CommutativeQ[R] && WithUnityQ[R],
			Off[QuotientRing::NS];
			ok = If[ProperSubsetQAA[S, Elements[R]],
				FieldQ[QuotientRing[R,S]], False];
			On[QuotientRing::NS]; ok,
		Message[IdealQ::fail];False],
	Message[MemberQ::elmnts, S, StructureName[R]]; $Failed]]
			
(* Annihilator[R_?RingoidQ,S_List] := 
	If[CommutativeQ[R] && SubsetQAA[S, Elements[R]],
		FormRingoid[Map[First,Select[Transpose[{Elements[R],
			Map[(Apply[Multiplication[R],#,2]//Union)&,
			CartesianProduct[Elements[R],S,
			Partition->True]]}], 
			(#[[2]]=={Zero[R]})&]], Addition[R], Multiplication[R],
			GatherRingoidOptions[R]],$Failed]*)
			
Annihilator[R_?RingoidQ, S_List] :=
		Module[{els},
	els=Map[First,Select[Transpose[{Elements[R],
                        Map[(Apply[Multiplication[R],#,1]//Union)&,
                        CartesianProduct[Elements[R],S,
                        Partition->True]]}],
                        (#[[2]]=={Zero[R]})&]];
        If[CommutativeQ[R] && SubsetQAA[S, Elements[R]],
                FormRingoid[els, Addition[R], Multiplication[R],
GatherRingoidOptions[R]],$Failed]]

Annihilator[R_?RingoidQ, S_?RingoidQ] :=
	If[Addition[R] === Addition[S] && Multiplication[R]===Multiplication[S],
		If[RingQ[R], Annihilator[R, Elements[S]],
			Message[Ring::fail, StructureName[S]]; $Failed],
		Message[Operation::fail]; $Failed]


(* ::Section:: *)
(* 71. Factor/quotient ring*)


LeftCoset[R_?RingoidQ, H_List, r_] := LeftCoset[AGroupoid[R], H, r]

LeftCoset[R_?RingoidQ, H_List, r_, LeftMeans -> lm_] := 
	LeftCoset[AGroupoid[R], H, r, LeftMeans -> lm]
	
LeftCoset[R_?RingoidQ, H_List, r_, opts___?OptionQ] := 
	LeftCoset[AGroupoid[R], H, r, opts]

LeftCoset[R_?RingoidQ, S_?RingoidQ, other__] :=
	If[Addition[R] === Addition[S] && Multiplication[R]===Multiplication[S],
		LeftCoset[R, Elements[S], other],
		Message[Operation::fail]; $Failed]
			
RightCoset[R_?RingoidQ, H_List, r_] := RightCoset[AGroupoid[R], H, r]

RightCoset[R_?RingoidQ, H_List, r_, LeftMeans -> lm_] := 
	RightCoset[AGroupoid[R], H, r, LeftMeans -> lm]
	
RightCoset[R_?RingoidQ, H_List, r_, opts___?OptionQ] := 
	RightCoset[AGroupoid[R], H, r, opts]

RightCoset[R_?RingoidQ, S_?RingoidQ, other__] :=
	If[Addition[R] === Addition[S] && Multiplication[R]===Multiplication[S],
		RightCoset[R, Elements[S], other],
		Message[Operation::fail]; $Failed]
			
LeftCosets[R_?RingoidQ, H_List] := LeftCosets[AGroupoid[R], H]

LeftCosets[R_?RingoidQ, H_List, LeftMeans -> lm_] := 
	LeftCosets[AGroupoid[R], H, LeftMeans -> lm]
	
LeftCosets[R_?RingoidQ, H_List, Operation -> Multiplication, Mode -> Visual] := 
	BothCosetsVisual[MultiplicativeGroupoid[R],H,
	LeftCosets[AdditiveGroupoid[R],H]]
	
LeftCosets[R_?RingoidQ, H_List, Mode -> Visual, Operation -> Multiplication] := 
	LeftCosets[R, H, Operation -> Multiplication, Mode -> Visual]

LeftCosets[R_?RingoidQ, H_List, opts___?OptionQ] := 
	LeftCosets[AGroupoid[R], H, opts]

LeftCosets[R_?RingoidQ, S_?RingoidQ, other___] :=
	If[Addition[R] === Addition[S] && Multiplication[R]===Multiplication[S],
		LeftCosets[R, Elements[S], other],
		Message[Operation::fail]; $Failed]
			
RightCosets[R_?RingoidQ, H_List] := RightCosets[AGroupoid[R], H]

RightCosets[R_?RingoidQ, H_List, LeftMeans -> lm_] := 
	RightCosets[AGroupoid[R], H, LeftMeans -> lm]

RightCosets[R_?RingoidQ, H_List, Operation -> Multiplication, Mode -> Visual] := 
	BothCosetsVisual[MultiplicativeGroupoid[R],H,
	RightCosets[AdditiveGroupoid[R],H]]
	
RightCosets[R_?RingoidQ, H_List, Mode -> Visual, Operation -> Multiplication] := 
	RightCosets[R, H, Operation -> Multiplication, Mode -> Visual]

RightCosets[R_?RingoidQ, H_List, opts___?OptionQ] := 
	RightCosets[AGroupoid[R], H, opts]

RightCosets[R_?RingoidQ, S_?RingoidQ, other___] :=
	If[Addition[R] === Addition[S] && Multiplication[R]===Multiplication[S],
		RightCosets[R, Elements[S], other],
		Message[Operation::fail]; $Failed]
			
Index[R_?RingoidQ, H_List, opts___?OptionQ] :=
	Index[AGroupoid[R], H, opts]

Index[R_?RingoidQ, S_?RingoidQ, other___] :=
	If[Addition[R] === Addition[S] && Multiplication[R]===Multiplication[S],
		Index[R, Elements[S], other],
		Message[Operation::fail]; $Failed]
			
CosetToList[QR_?RingoidQ, coset_] := Module[{QG,R,S, form},
	R = Qnum /. QR[[4,5]];
	S = Qden /. QR[[4,5]];
	form = Qform /. QR[[4,5]];
	QG = QuotientGroup[AGroupoid[R], S, Form -> form,
		ShowMessage -> False];
	CosetToList[QG, coset]]
	
FactorRing[args___] := QuotientRing[args]

Options[QuotientRing] = {Mode -> Computational, Form -> Cosets, Representatives -> Canonical, SizeLimit->50, Staged -> False};

QuotientRing[R_?RingoidQ, S_?RingoidQ, opts___?OptionQ] :=
	If[Addition[R] === Addition[S] && Multiplication[R]===Multiplication[S],
		QuotientRing[R, Elements[S], opts],
		Message[Operation::fail]; $Failed]

QuotientRing[R_?RingoidQ, S_List, opts___?OptionQ] :=
	Module[{cosets,reps,mymode,sc,form,repmethod,QR,els,
		id,ok=True,rands, AG = AGroupoid[R], MG = MGroupoid[R], QG},
If[IdealQ[S,R],
	QG = QuotientGroup[AG, S, opts, 
		ShowMessage -> False];
If[QG =!= $Failed,
	els = Elements[QG];
	cosets = cosetlist /. QG[[3,5]];
	reps = cosetreps /. QG[[3,5]];
	form = Form/.Flatten[{opts, Options[QuotientRing]}];
	If[form === Representatives,
		QR = FormRingoid[reps, 
		QGRepProd[AG,cosets,#1,#2,reps]&,
			QGRepProd[MG,cosets,#1,#2,reps]&, 
			RingoidName -> RingoidName[R]<>"/NS", IsARing -> True, 
			ExtraInformation -> {{True},{Zero[R], Unity[R]},
			{},{},{cosetlist -> cosets,
			cosetreps -> reps, Qnum -> R, Qden -> S, Qform -> form}}]];
	If[form === CosetLists,
		QR = FormRingoid[cosets, 
			QGListProd[AG,cosets,#1,#2,reps]&,
			QGListProd[MG,cosets,#1,#2,reps]&, 
			RingoidName -> RingoidName[R]<>"/NS", IsARing -> True,
			ExtraInformation -> {{True},{LeftCoset[R,S,Zero[R]], 
			LeftCoset[R,S,Unity[R]]},{},{},
			{cosetlist -> cosets, cosetreps -> reps, Qnum -> R, Qden -> S, Qform -> form}}]];
	If[form === Cosets,
		QR = FormRingoid[els, 
			QGCosetSum[AG,cosets,#1,#2,reps]&,
			QGCosetSum[MG,cosets,#1,#2,reps]&, 
			RingoidName -> RingoidName[R]<>"/NS", KeyForm -> OutputForm, 
			IsARing -> True, WideElements -> True,
			ExtraInformation -> {{True},{NS, Unity[R] + NS},{},{},
			{cosetlist -> cosets, cosetreps -> reps, Qnum -> R, Qden -> S, Qform -> form}}];
			If[MessageCount[QuotientRing,NS]++ < 5, Message[QuotientRing::NS,S]]]];
	If[Head[QR]===ringoid, QR, $Failed],
	Message[QuotientRing::notideal,S,
		StructureName[R]];$Failed]]
		
MessageCount[QuotientRing,NS] = 0;


(* ::Section:: *)
(* 72. Other*)


(* ::Subsection::Closed:: *)
(*Solution of Equations*)


RingSolve[R_?RingoidQ, a_, b_] :=
    Select[Elements[R], (Multiplication[R][a,#]==b)&]


(* ::Subsection:: *)
(*Z[I]/<a+bI> code*)


IntegerLatticeGrid[{a_Integer,b_Integer},{c_Integer,d_Integer},
	opts___?OptionQ] := Module[{pts},
	pts = Table[{i,j},{i,a,b},{j,c,d}]//Flatten[#,1]&;
	ListPlot[pts,opts]]

SortByPosXAxis[{}] = {};

SortByPosXAxis[pts_List] := Map[{Abs[N[Arg[#]]],#}&,pts]//Sort//
	Transpose//Last
	
RectangleOfLatticePoints[{xmin_Integer,xmax_Integer},{ymin_Integer,ymax_Integer}] := 
	pts = Table[{i,j},{i,xmin,xmax},{j,ymin,ymax}]//Flatten[#,1]&

distance[{a_,b_},{c_,d_}] := Sqrt[(a-c)^2 + (b-d)^2]

slope[{a_,b_},{c_,d_}] := (d-b)/(c-a)

ComplexToPoint[z_] := {Re[z],Im[z]}

CircleOfLatticePoints[{xCent_Integer,yCent_Integer}, rad_] := 
		Module[{rd = Floor[rad]+1, pts},
	pts = RectangleOfLatticePoints[{xCent - rd, xCent + rd},{yCent - rd, yCent + rd}];
	Select[pts, (N[distance[#, {xCent, yCent}]] <= rad) &]
	]

CircleOfLatticePoints[{xCent_Integer,yCent_Integer}, rad_, {theta1_, theta2_}] := 
		Module[{pts, arg, out},
	pts = CircleOfLatticePoints[{xCent, yCent},rad];
	Off[Arg::indet];
	out = Select[pts, (((arg = N[Arg[Complex@@#]])>= N[theta1]) && 
		(arg <= N[theta2])) &];
	out]

makeSquare[c_] := Module[{x = Re[c], y = Im[c],
	A, B, C, O},
	A = {x,y};
	C = {{0, 1}, {-1,0}}.A;
	B = C + A;
	O = {0,0};
	{O,A, B, C, O}]
	
Stretch[x_] := If[x < 0, Floor[x], Ceiling[x]]

makeSquares[c_, window_List] := Module[{x = Re[c], y = Im[c], xl,xr, 
		yd,yu, len, C, lnpts},
	len = N[Abs[c] Sqrt[2]];
	C = {{0, -1},{1,0}}.{x,y};
	{{xl, xr}, {yd, yu}} = window/len;
	{{xl, xr}, {yd, yu}} = Map[Stretch, {{xl, xr}, {yd, yu}}, {2}];
	lnpts = Table[Map[i {x,y} + j C + #&, makeSquare[c]], {i, xl, xr}, 
		{j, yd, yu}]//Flatten[#, 1]&;
	Graphics[Map[Line, lnpts, {1}]]
	]

drawSquare[c_] := Graphics[Line[makeSquare[c]]]

(* The following few functions are from Stan Wagon's 'Mathematica
in Action' book, pages 334, 335 (in first edition with Freeman) *)

Orientation[{{x1_,y1_}, {x2_,y2_}, {x3_,y3_}}] :=
	Sign[Chop[Det[{{x1,y1,1}, {x2,y2,1}, {x3,y3,1}}]]]

LeftOf[p_, q_, r_] := Orientation[{p, q, r}] == 1 

norm[p_] := N[Sqrt[p.p]]

Unprotect[Between] (* Added 5/20/16 since 10.3 introduces Between *)
Between[p_, q_, r_] := Orientation[{p, q, r}] == 0 &&
	       (r-p) . (q-p) >= 0 && norm[r-p] <= norm[q-p]
Protect[Between] 

IntersectQ[{a_, b_}, {c_, d_}] :=  
	 (LeftOf[a,b,c] ~Xor~ LeftOf[a,b,d]) &&
	 (LeftOf[c,d,a] ~Xor~ LeftOf[c,d,b])     ||
	 
	 Between[a,b,c] || Between[a,b,d]  ||
	 Between[c,d,a] || Between[c,d,b]
	 
(* end of contribution from Stan Wagon *)

SortByArg[{}] = {};

SortByArg[pts_List] := Module[{out},
	Off[Arg::indet];
	out = Map[{If[N[Arg[#]]<0, N[Arg[#] + 2Pi],N[Arg[#]]],#}&,pts]//Sort//
		Transpose//Last;
	out]

LatticePointsInSquare[c_] := Module[{x,y, sq, th1, th2, slp, pts, a, b, inside,
			notsure, p2, p3, p4, l1, l2},
	{x, y} = ComplexToPoint[c];
	sq = makeSquare[c];
	{p2, p3, p4} = sq[[{2,3,4}]];
	l1 = {p2, p3}; l2 = {p3, p4};
	Off[Power::infy];
	slp = slope[sq[[1]], p2];
	Off[Arg::indet];
	th2 = Arg[c]//N;
	slp = slope[sq[[1]], p4];
	th1 = Arg[Complex@@{Im[c],-Re[c]}]//N;
	pts = If[th1 > th2, Join[CircleOfLatticePoints[{0,0},N[Sqrt[2] Abs[c]], 
		{th1, Pi}], CircleOfLatticePoints[{0,0},N[Sqrt[2] Abs[c]], 
		{-Pi, th2}]], CircleOfLatticePoints[{0,0},N[Sqrt[2] Abs[c]], 
		{th1, th2}]];
	inside = Select[pts, N[distance[#,{0,0}]] <= N[Abs[c]]&];
	notsure = Complement[pts, inside];
	pts = Join[inside, Select[notsure, (((!IntersectQ[l1, {{0,0},#}]) && 
		(!IntersectQ[l2, {{0,0},#}])) || Between[p2,p3,#] || Between[p3,p4,#])&]];
	On[Power::infy];
	Join[{{0,0}},DeleteCases[SortByArg[pts],{0,0}]] (* to adjust for {0,0} in middle *)
]

CalculateZICosets[z_, {{a_, b_}, {c_, d_}}] := CalculateZICosets[z, {{a,b},{c,d}}] =
	Module[{J,gr,g,rep,starting, cstarting,
	remaining,Iremaining,pts,cpts,done = False,iter = 0},
starting = LatticePointsInSquare[z];
cstarting = Map[Apply[Complex,#]&,starting];
pts = RectangleOfLatticePoints[{a,b},{c,d}];
cpts = Map[Apply[Complex,#]&,pts];
J[0] = Intersection[cpts,z cpts];
rep[iter++] = 0;
Iremaining = ComplementNoSort[cstarting, Intersection[J[0],cstarting]]//SortByArg;
While[!done,
	rep[iter] = First[Iremaining];
	J[iter] = Intersection[cpts, rep[iter] + J[0]];
	Iremaining = ComplementNoSort[Iremaining,
		Intersection[cstarting,J[iter++]]]//SortByArg;
	done = Iremaining == {}];
Table[{rep[k],J[k]},{k,0,iter-1}]//Transpose]

ZICosetReps[z_] := CalculateZICosets[z, FindGoodWindow[z]][[1]]

DetermineOneZICoset[z_, rep_, {{a_, b_}, {c_, d_}}] := 
		OneZICosetWork[z, rep, {{a,b},{c,d}}]//Last

OneZICosetWork[z_, rep_, {{a_, b_}, {c_, d_}}] := 
	OneZICosetWork[z, rep, {{a,b},{c,d}}] = 
		Module[{reps, cosets,nums, pos, repQ},
	{reps, cosets} = CalculateZICosets[z, {{a,b},{c,d}}];
	{repQ, pos} = If[MemberQ[reps, rep], {True, Position[reps, rep,{1}]},
		{False, Position[cosets, rep]}];
	nums = If[pos =!= {}, cosets[[First[Flatten[pos]]]],
		$Failed];
	If[repQ, {1, nums}, {pos, nums}]]

OneZICosetGraphics[z_, rep_, {{a_, b_}, {c_, d_}}, width_:0.02] := 
		Module[{pos,coset, len},
	len = Abs[z]^2;
	{pos, coset} = OneZICosetWork[z, rep, {{a,b},{c,d}}];
	Graphics[{PointSize[width], Hue[pos/len], (* not the right color *)
		Map[Point[ComplexToPoint[#]]&, coset]}]]

DotSize[n_] := Which[n<13, .04, n < 15, .035, n<17, .03, n<21, .025, n<26, .02,
	n>25, .015];
	
AllZICosetGraphics[z_, reps_, {{a_, b_}, {c_, d_}}, width_:0.02] := 
		Module[{pos,coset, len, size = Length[reps], wd},
	wd = If[width == 0.02, 0.02, DotSize[n]];
	{Graphics[{Thickness[0.015],Line[makeSquare[z]], Table[
	{pos, coset} = OneZICosetWork[z, reps[[i]], {{a,b},{c,d}}];
	{PointSize[width], Hue[i/size], Map[Point[ComplexToPoint[#]]&, coset]},
	{i,size}]}], makeSquares[z,{{a,b},{c,d}}]}]

PartialZICosetGraphics[z_, reps_, n_, {{a_, b_}, {c_, d_}}, width_:0.02] := 
		Module[{pos,coset, len, size = Length[reps], wd},
	wd = If[width == 0.02, 0.02, DotSize[n]];
	{Graphics[{Thickness[0.015],Line[makeSquare[z]], Table[
	{pos, coset} = OneZICosetWork[z, reps[[i]], {{a,b},{c,d}}];
	{PointSize[width], Hue[i/size], Map[Point[ComplexToPoint[#]]&, coset]},
	{i,n}]}], makeSquares[z,{{a,b},{c,d}}]}]

ZICosetsVisual[z_, {{a_, b_}, {c_, d_}}] := 
		Module[{extra = Abs[z]^2,reps},
	reps = CalculateZICosets[z, {{a-extra, b+extra},{c-extra,d+extra}}]//First;
	Show[AllZICosetGraphics[z, reps, {{a-extra, b+extra},{c-extra,d+extra}},DotSize[extra]],
		Axes -> True, PlotRange -> {{a,b},{c,d}}, Frame -> True]]

QuotientRingVisualAll[z_,n_,opts___?OptionQ] := Module[{i},
	QuotientRingVisualStaged[z, opts];
	Manipulate[Show[QuotientRingVisualStagedSlide[i]],
	{{i, 1,"stage"}, 1, n, 1, Appearance->"Open"}]]

QuotientRingVisualStaged[z_,opts___?OptionQ] := 
Module[{i, reps, n, wd,extra = Abs[z]^2, a, b, c, d},
	{{a,b},{c,d}} = FindGoodWindow[z];
	reps = CalculateZICosets[z, {{a-extra, b+extra},{c-extra,d+extra}}]//First;
	n = Length[reps];
	wd = DotSize[n];
	Do[QuotientRingVisualStagedSlide[i] = 
		Show[PartialZICosetGraphics[z,reps, i, {{a-extra, b+extra},
			{c-extra,d+extra}}, wd],opts, Axes -> True, PlotRange -> {{a,b},{c,d}}, Frame -> True],{i, n}];
	TotalStages[QuotientRing] = n;
	CurrentStage[QuotientRing] = 1;
	Show[QuotientRingVisualStagedSlide[1]]]

NextStage[QuotientRing] := (CurrentStage[QuotientRing]++;
	If[CurrentStage[QuotientRing] <= TotalStages[QuotientRing],
		Show[QuotientRingVisualStagedSlide[CurrentStage[QuotientRing]]],
		CurrentStage[QuotientRing]=1;
		Show[QuotientRingVisualStagedSlide[1]]])
			
PreviousStage[QuotientRing] := (CurrentStage[QuotientRing]--;
	If[CurrentStage[QuotientRing] > 0,
		Show[QuotientRingVisualStagedSlide[CurrentStage[QuotientRing]]],
		CurrentStage[QuotientRing]=TotalStages[QuotientRing];
		Show[QuotientRingVisualStagedSlide[TotalStages[QuotientRing]]]];)

FindGoodWindow[z_] := FindGoodWindow[z] = 
	Module[{sq = makeSquare[z], len = Abs[z]},
	{x,y} = sq[[3]]/2;
	{{Ceiling[N[x - 2 len]], Ceiling[N[x + 2 len]]},
		{Ceiling[N[y - 2 len]],Ceiling[N[y + 2 len]]}}]

ZICosetsVisual[z_] := 
	ZICosetsVisual[z, FindGoodWindow[z]]
	
Unprotect[Z];

Z[I] = "Z[I]";

Protect[Z];

QuotientRing["Z[I]", z_, opts___?OptionQ] :=
	Module[{cosets,reps,mymode,sc,form,repmethod,els, staged, 
		id,ok=True,rands, QG, gr},
mymode = Mode/.Flatten[{opts, Options[QuotientRing]}];
staged = Staged/.Flatten[{opts, Options[QuotientRing]}];
If[N[Abs[z]] > 1 && IntegerQ[Re[z]] && IntegerQ[Im[z]],
	{reps, cosets} = CalculateZICosets[z, FindGoodWindow[z]];
	If[mymode === Visual, Switch[staged,
		False, gr = ZICosetsVisual[z],
		All, gr = QuotientRingVisualAll[z, Length[reps]],
		True, gr = QuotientRingVisualStaged[z]]];
	form = Form/.Flatten[{opts, Form -> Cosets}];
	If[form === Representatives,
		QR = FormRingoid[reps, ZICosetSum[z,#1, #2]&, ZICosetProduct[z,#1, #2]&,
			RingoidName -> "Z[I]/<"<>ToString[z]<>">", WideElements -> True]];
	If[form === Cosets,
		reps = Map[#+J&, reps];
		QR = FormRingoid[reps, ZICosetSum[z,#1, #2]&, ZICosetProduct[z,#1, #2]&,
			RingoidName -> "Z[I]/<"<>ToString[z]<>">", WideElements -> True];
			If[MessageCount[QuotientRing,j]++ < 5, Message[QuotientRing::J,z]]];
	If[Head[QR]===ringoid, 
		If[mymode ===Visual, gr, QR, $Failed]],
	Message[QuotientRing::badz,z];$Failed]]
	
MessageCount[QuotientRing,j] = 0;

ZICosetProduct[zPIgen_, (z1_:0) + J, (z2_:0) + J] :=
	ZICosetProduct[zPIgen, z1, z2] + J

ZICosetSum[zPIgen_, (z1_:0) + J, (z2_:0) + J] :=
	ZICosetSum[zPIgen, z1, z2] + J
	
ZICosetProduct[zPIgen_, J + (z1_:0), J + (z2_:0)] :=
	J + ZICosetProduct[zPIgen, z1, z2]

ZICosetSum[zPIgen_, J + (z1_:0), J + (z2_:0)] :=
	J + ZICosetSum[zPIgen, z1, z2]

ZICosetProduct[zPIgen_, (z1_:0), (z2_:0)] :=
	Module[{pr = z1 z2, searchlist,cosets},
	cosets = ZICosetReps[zPIgen];
	searchlist = Map[Simplify[(pr-#)/(zPIgen)]&,cosets];
	cosets[[(Position[searchlist,_?GaussianIntegerQ]//Flatten)[[1]]]]
]

ZICosetSum[zPIgen_, (z1_:0), (z2_:0)] :=
	Module[{sum = z1+z2, searchlist,cosets},
	cosets = ZICosetReps[zPIgen];
	searchlist = Map[Simplify[(sum-#)/(zPIgen)]&,cosets];
	cosets[[(Position[searchlist,_?GaussianIntegerQ]//Flatten)[[1]]]]
]

GaussianIntegerQ[z_] := IntegerQ[z] || (Head[z]===Complex &&
	IntegerQ[Re[z]] && IntegerQ[Im[z]])


(* ::Subsection::Closed:: *)
(*Misc.*)


DirectProduct[R_?RingoidQ, Rs__] := Module[{factorsAreRings,numgrps = Length[{R,Rs}]},
  If[Apply[And,Map[RingoidQ,{R, Rs}]],
  	factorsAreRings = Apply[And,Map[RingQ,{R, Rs}]];
    FormRingoid[Distribute[Elements/@{R,Rs},List],
    	MapThread[(#1[#2,#3])&, {Addition/@{R,Rs},#1,#2}]&,
   	 MapThread[(#1[#2,#3])&, {Multiplication/@{R,Rs},#1,#2}]&,
    	RingoidName -> Apply[StringJoin,Transpose[{Map[RingoidName,{R,Rs}],
		Table[" x ",{numgrps}]}]//Flatten//Drop[#,-1]&],
   	 WideElements -> True, IsARing -> If[factorsAreRings, True, False]],
  Message[DirectProduct::ArgErr]]]


(* ::Subsection:: *)
(*working with polynomials*)


RationalRootCandidates[expr_] := 
  Module[{cl, cand,var,ok}, 
  	var = Variables[expr];
		ok = Length[var]==1;
		If[Not[ok],$Failed,
			cl = CoefficientList[expr, var]; 
    	cand = Union[Flatten[Outer[Divide, Divisors[First[cl]], 
        Divisors[Last[cl]]]]]; cand = Union[cand, -cand]]]
        
RationalRootTheorem[expr_] := 
  Module[{cand, vals, a, b, pairs, T, F,var,ok},
  	var = Variables[expr];
		ok = Length[var]==1;
		If[Not[ok],$Failed,
			var = First[var];
  		cand = RationalRootCandidates[expr]; 
    	vals = expr /. var :> cand; 
   	 pairs = Transpose[{cand, vals}] /. 
     	 {{a_, 0} :> {a, True}, 
       {a_, (b_)?NumberQ} :> {a, False}}; 
    	T = Select[pairs, #1[[2]] === True & ] /. 
      {a_, True} :> a; 
    	F = Select[pairs, #1[[2]] === False & ] /. {a_, False} :> a;
 {T, F}]]

dividesQ[a_Integer, b_Integer] := IntegerQ[b/a]

EisensteinsCriterionQ[zpoly_] := Module[{var, ok, coef, npoly, gcd, primes,fi},
	var = Variables[zpoly];
	ok = Length[var]==1;
	coef = CoefficientList[zpoly, var];
	If[ok, 
		var = First[var];
		coef = CoefficientList[zpoly, var];
		gcd = GCD[Sequence@@coef];
		npoly = If[Head[gcd]===Rational, Expand[1/gcd zpoly], zpoly];
		coef = CoefficientList[npoly, var];
		gcd = GCD[Sequence@@Drop[coef, -1]];
		fi = FactorInteger[gcd];
		ok = If[fi =!= {}, True, False];
		If[ok, 
			primes = fi//Transpose//First;
			ok = Or@@Map[(Not[dividesQ[#,Last[coef]]] && Not[dividesQ[#^2, 
				First[coef]]]) &,primes]]];
	ok]

EisensteinsCriterionQ[zpoly_, Mode -> All]:=
	Labeled[TabView[{"Computation" -> EisensteinsCriterionQ[zpoly],
	"Explanation" -> EisensteinsCriterionQ[zpoly, Mode->Textual]}, 
	ImageSize->Automatic],"Via Eisenstein's Criterion, is "<>ToString[zpoly,TraditionalForm]<>" irreducible?", Top]

EisensteinsCriterionQ[zpoly_, Mode -> Textual] := 
		Module[{var, ok, coef, npoly, gcd, primes,fi, lenpr, i, pr,txt},
	var = Variables[zpoly];
	txt = "";
	ok = Length[var]==1;
	If[ok, 
		var = First[var];
		coef = CoefficientList[zpoly, var];
		gcd = GCD[Sequence@@coef];
		npoly = If[Head[gcd]===Rational, 
			txt = txt <> "Typically, Eisenstein's Criterion requires the polynomial "<>
			"to have integer coefficients, but the polynomial entered will be "<>
			"irreducible if the following is also: "<>
				ToString[Expand[1/gcd zpoly],StandardForm]<>".\n\n";
			Expand[1/gcd zpoly], zpoly];
		coef = CoefficientList[npoly, var];
		gcd = GCD[Sequence@@Drop[coef, -1]];
		fi = FactorInteger[gcd];
		ok = If[fi =!= {}, True, False];
		If[ok, 
			primes = fi//Transpose//First;
			lenpr = Length[primes];
			txt = txt <> "The coefficients to consider (from low degree to high degree) are: "<>
				ToString[coef]<>".\n\n";
			Do[
				pr = primes[[i]];
				txt = txt <> ToString[pr]<>" is a prime that divides all of the first n-1 coefficients.\n";
				txt = txt <> "Is it true that "<>ToString[pr]<> " does not divide "<>
					ToString[Last[coef]]<>"?" <>If[$VersionNumber >2.5,
		" -> "," -> "]<>ToString[Not[dividesQ[pr,Last[coef]]]]<>".\n";
				txt = txt <> "Is it true that "<>ToString[pr^2]<> " does not divide "<>
					ToString[First[coef]]<>"?" <>If[$VersionNumber >2.5,
		" -> "," -> "]<>ToString[Not[dividesQ[pr^2,First[coef]]]]<>".\n";
				txt = txt <> "Therefore, "<>ToString[pr]<>If[Not[dividesQ[pr,Last[coef]]]&&
					Not[dividesQ[pr^2,First[coef]]]," is a prime that illustrates the "<>
					"polynomial is irreducible.", " is a prime that does not satisfy "<>
					"the hypotheses of Eisenstein's Criterion.\n"];,
				{i,lenpr}];
			ok = Or@@Map[(Not[dividesQ[#,Last[coef]]] && Not[dividesQ[#^2, 
				First[coef]]]) &,primes],
			txt = txt <> "The gcd of the coefficients (ignoring leading one) is 1; "<>
			"the hypotheses of Eisenstein's Criterion are not satisfied."],
		txt = txt <> "This function can only test polynomials in a single variable."];
	txt]
	
ModpIrreducibilityQ[zpoly_] := ModpIrreducibilityQ[zpoly, 25]

ModpIrreducibilityQ[zpoly_, max_Integer?Positive] := 
		Module[{var, ok, coef, npoly, gcd,lcv = 0, done = False, p, pzpoly,
			dego, degn},
	var = Variables[zpoly];
	coef = CoefficientList[zpoly, var];
	ok = Length[var]==1 && (dego = First[Exponent[zpoly, var]]) >= 1 &&
		And@@Map[Head[#]===Rational || Head[#]===Integer&, coef];
	If[ok, 
		var = First[var];
		gcd = GCD[Sequence@@coef];
		npoly = If[Head[gcd]===Rational, Expand[1/gcd zpoly], zpoly];
		coef = CoefficientList[npoly, var];
		While[Not[done],
			lcv++;
			p = Prime[lcv];
			pzpoly = PolynomialMod[zpoly, p];
			degn = Exponent[pzpoly, var];
			If[degn =!= dego, ok = False,
				ok = IrreducibleListQ[FactorList[pzpoly, Modulus -> p],p]];
			done = ok || lcv > max
			],
		Message[ModpIrreducibilityQ::badpoly, zpoly]];
	ok]

ModpIrreducibilityQ[p_?PrimeQ, zpoly_] := 
		Module[{var, ok, coef, npoly, gcd,lcv = 0, done = False, pzpoly, max = 25,
			dego, degn},
	var = Variables[zpoly];
	coef = CoefficientList[zpoly, var];
	ok = Length[var]==1 && (dego = First[Exponent[zpoly, var]]) >= 1 &&
		And@@Map[Head[#]===Rational || Head[#]===Integer&, coef];
	If[ok, 
		var = First[var];
		gcd = GCD[Sequence@@coef];
		npoly = If[Head[gcd]===Rational, Expand[1/gcd zpoly], zpoly];
		coef = CoefficientList[npoly, var];
		pzpoly = PolynomialMod[zpoly, p];
		degn = Exponent[pzpoly, var];
		If[degn =!= dego, Message[ModpIrreducibilityQ::baddeg,p];
			ok = $Failed,
				ok = IrreducibleListQ[FactorList[pzpoly, Modulus -> p],p]],
		Message[ModpIrreducibilityQ::badpoly, zpoly]];
	ok]
	
	IrreducibleListQ[flist_List, p_] := (Length[flist] == 1 && Last[First[flist]] == 1) ||
		(Length[flist] == 2 && Last[Last[flist]] == 1 && MemberQ[Range[0,p-1],flist[[1,1]]])
	
ModpIrreducibilityQ[zpoly_, Mode -> All]:=
	Labeled[TabView[{"Computation" -> ModpIrreducibilityQ[zpoly],
	"Explanation" -> ModpIrreducibilityQ[zpoly, Mode->Textual]}, 
	ImageSize->Automatic],"Via Mod p test, is "<>ToString[zpoly,TraditionalForm]<>" irreducible?", Top]

	ModpIrreducibilityQ[zpoly_, Mode -> Textual] := 
		Module[{var, ok, coef, npoly, gcd,lcv = 0, done = False, p, pzpoly, max = 25,fp,
			dego, degn, ratQ, txt = ""},
	var = Variables[zpoly];
	coef = CoefficientList[zpoly, var];
	ok = Length[var]==1 && (dego = First[Exponent[zpoly, var]]) >= 1 &&
		And@@Map[Head[#]===Rational || Head[#]===Integer&, coef];
	If[ok, 
		var = First[var];
		gcd = GCD[Sequence@@coef];
		npoly = If[(ratQ = Head[gcd]===Rational), Expand[1/gcd zpoly], zpoly];
		coef = CoefficientList[npoly, var];
		If[ratQ,
			txt = "Modifying the polynomial with rational coefficients to integer coefficients results in ",npoly,".\n"];
		While[Not[done],
			lcv++;
			p = Prime[lcv];
			pzpoly = PolynomialMod[npoly, p];
			txt = txt <> " When the coefficients are reduced mod "<>ToString[p]<>
				", this polynomial becomes "<>
				ToString[pzpoly,TraditionalForm]<>".";
			degn = Exponent[pzpoly, var];
			If[degn =!= dego, ok = False,
				ok = IrreducibleListQ[FactorList[pzpoly, Modulus -> p],p]];
			If[ok,
				txt = txt <> " Since this modified polynomial is irreducible over Z["<>ToString[p]<>
				"], then the original is irreducible over Q by the Mod p Irreducibility Test.",
				txt = txt <> "Factoring over Z["<>ToString[p]<>"], we obtain "<>
					ToString[Factor[pzpoly,Modulus -> p],TraditionalForm]<>
				". Since this modified polynomial is not irreducible or does not have the same degree as the original, we try the next prime."];
			done = ok || lcv > max;
			If[done && Not[ok], 
				txt = txt <> "After trying the first 25 primes, we have not been able to show that the polynomial is irreducible."]
			];
		];
	txt] (*max_Integer?Positive:25*)


(* ::Section:: *)
(* 73. RingExtensions*)


(* ::Subsection::Closed:: *)
(*Functions to act on extensions*)


BaseRing[RingExtension[Type_,base_,param_,test_]] := base;

ExtensionType[RingExtension[Type_,base_,param_,test_]]:=Type

TestFunction[RingExtension[Type_,base_,param_,test_]]:=test

ClosedQ[R_RingExtension] := 
	ModifiedAnd[ClosedQ[R, Operation -> Addition],
		ClosedQ[R, Operation -> Multiplication]]
		
HasIdentityQ[R_RingExtension] := ModifiedAnd[HasZeroQ[R], WithUnityQ[R]]

HasIdentityQ[R_RingExtension, Operation -> Addition] :=	HasZeroQ[R]

HasIdentityQ[R_RingExtension, Operation -> Multiplication] :=	WithUnityQ[R]

InvertibleQ[R_RingExtension, r_] :=  
	ModifiedAnd[HasNegativeQ[R,r], UnitQ[R,r]]

InvertibleQ[R_RingExtension, r_, Operation -> Addition] := HasNegativeQ[R,r]
	
InvertibleQ[R_RingExtension, r_, Operation -> Multiplication] :=UnitQ[R,r]


(* ::Subsection:: *)
(*Polynomial Rings*)


(* ::Subsubsection:: *)
(*Basic Definitions*)


Format[RingExtension[PolyRing,R_,__]] := 
"-Ring of Polynomials over " <> RingoidName[R] <> "-"

PolynomialsOver[R_?RingoidQ] := PolynomialsOver[R] = Module[{er},
	er = RingExtension[PolyRing, R, {}, (Head[#]===poly) && 
		(Apply[And,Map[MemberQ[R[[1]],#]&,Last[#]]])&];
	RingInfo[er]={"ring of polynomials over "<>RingoidName[R]};
	er]

identitiesToStrings[R_, coeffs_List] := Module[{one = Unity[R], 
		zero = Zero[R], newone, newzero},
	newzero = If[zero === 0, 0, ToString[zero]];
	newone = If[one === 1, 1, ToString[one]];
	coeffs/.{zero -> newzero, one -> newone}]

polyToPolynomial[var_Symbol,coef_List,RightToLeft, True] := 
		Module[{n = Length[coef], pol},
	pol = coef.Table[Subscripted[var[k],{},{1}], {k, 0, n-1}]/.
		{Subscripted[var[0],{},{1}] -> 1, Subscripted[var[1],{},{1}] -> var};
	pol = If[Head[pol]===Plus,
		Flatten[{List@@pol},1],
		{pol}];
	pol = Drop[MapThread[Sequence, {Reverse[pol], Table[" + ", {Length[pol]}]}],-1];
	pol = 
		Apply[SequenceForm,Flatten[pol /. Times[c_, h_] :> List[c," ",h],1]/.Power[var,e_] :>
		Subscripted[var[e],{},{1}]]]
		
polyToPolynomial[var_Symbol,coefs_List,LeftToRight,False] := 
		Module[{n = Length[coefs],k,powers,polystuff, coef = ToString /@ coefs},
	If[n > 2, powers = Join[{1,var}, Table[Subscripted[var[k],{},{1}], 
		{k, 2, n-1}]]];
	If[n == 1, polystuff = {First[coef]}];
	If[n == 2, polystuff = {First[coef]," + ", coef[[2]]," ",var}];
	If[n > 2, polystuff = Join[{First[coef]," + ", coef[[2]]," ",var},
		Flatten[Table[{" + ", coef[[k]]," ",powers[[k]]},{k, 3, n}],1]]];
	Apply[SequenceForm,polystuff]]
	

polyToPolynomial[var_Symbol,coefs_List,RightToLeft,False] := 
		Module[{n = Length[coefs],k,powers,polystuff, coef = ToString /@ coefs},
	If[n > 2, powers = Join[{1,var}, Table[Subscripted[var[k],{},{1}], 
		{k, 2, n-1}]]//Reverse];
	If[n == 1, polystuff = {First[coef]}];
	If[n == 2, polystuff = {coef[[2]]," ",var," + ",First[coef]}];
	If[n > 2, polystuff = Join[Flatten[Table[{coef[[n-k+1]]," ",
		powers[[k]]," + "},{k, 1, n-2}],1],{coef[[2]]," ",var," + ",First[coef]}]];
	Apply[SequenceForm,polystuff]]

(*polyToPolynomial[var_Symbol,coef_List,LeftToRight,True] := 
	coef.Table[Subscripted[var[k],{},{1}], {k, 0, Length[coef] - 1}]/.
		{Subscripted[var[0],{},{1}] -> 1, Subscripted[var[1],{},{1}] -> var}*)

polyToPolynomial[var_Symbol,coef_List,LeftToRight,True] :=
 (Rest[coef].Table[Subscripted[var[k],{},{1}], {k, 1, Length[coef] -
1}]/.
  {Subscripted[var[1],{},{1}] -> var})//
  If[First[coef]==0,#,ToString[First[coef]]+#]&
  
Format[p_poly] := polyToPolynomial[p[[1,3]], Last[p], p[[1,2]],
	p[[1,4]]]
	
ZRingoidQn[R_?RingoidQ] := Module[{chars, zpartq, index, ok, nm = RingoidName[R]},
	If[Head[nm] === String, 
		Off[ToExpression::esntx, ToExpression::sntx,ToExpression::sntxi];
		chars = Characters[nm];
		zpartq = Join[Take[chars,2],{Last[chars]}];
		index = ComplementNoSort[chars,zpartq]//StringJoin//ToExpression;
		On[ToExpression::esntx, ToExpression::sntx, ToExpression::sntxi];
		zpartq = StringJoin[zpartq];
		ok = IntegerQ[index] && zpartq === "Z[]";
		If[ok, {ok, index}, {ok, Null}], {False, Null}]]
	
numericalCoefficientsQ[coefs_List]:= 
   Fold[(#1&&NumberQ[#2])&,NumberQ[First[coefs]],Rest[coefs]]

PolyQ[p_] := Head[p] === poly

Options[Poly] = {PowersIncrease -> LeftToRight, Indeterminate -> Global`x,
	FlexibleEntering -> True};

Poly[R_?RingoidQ, exprs__, opts___?OptionQ] := Module[{ok,
		ind = Indeterminate/.Flatten[{opts, Options[Poly]}],
		pi = PowersIncrease/.Flatten[{opts, Options[Poly]}],
		fe = FlexibleEntering/.Flatten[{opts, Options[Poly]}],
		coefficients, nc, znq, index,vars, varsUsedQ = False, 
		indNotSpecQ = FreeQ[{opts},Indeterminate], expr},
	Off[Head::argx];
	If[Head[exprs]===TraditionalForm, expr = exprs[[1]], expr = exprs];
	If[Not[MemberQ[{String,Symbol},Head[ind]]], 
		Message[Poly::badInd,ind];
		ind = Global`x];
	If[Not[MemberQ[{Plus,Symbol, Power, Times},Head[expr]]], ok = True; 
		coefficients = 
		If[pi === RightToLeft,
			Reverse[{expr}], {expr}],
		(* else *)
		vars = Variables[expr];
		varsUsedQ = True;
		ok = Length[vars] == 1;
		If[ok, coefficients = CoefficientList[expr, First[vars]]/. 0 -> Zero[R],
			Message[Poly::mixvars, expr, Variables[expr]]]];
	On[Head::argx];
	If[ok, 
		If[fe, 
			{znq, index} = ZRingoidQn[R];
			If[znq,
				coefficients = Mod[coefficients, index],
				coefficients = coefficients /. Times[-1, r_] :> NegationOf[R, r];
				coefficients = Map[If[Abs[#] === -#, NegationOf[R,-#], #]&,coefficients]]];
		ok = ElementsQ[coefficients,R];
		If[indNotSpecQ && varsUsedQ, ind =First[vars]];
		If[Not[ok], Message[MemberQ::elmnts,"the coefficients "<>ToString[coefficients],
			" the base ring"]]];
	If[ok, 
		coefficients = coefficients //.{{cc__,Zero[R]}:>{cc}}; (* remove extra zeros *)
		coefficients = identitiesToStrings[R,coefficients];
		nc = numericalCoefficientsQ[coefficients]];
	If[ok && Not[nc], coefficients = Map[If[Head[#]===String,
		ToExpression[#],#]&,coefficients]];
	If[ok,poly[{R, pi, ind, nc}, coefficients], $Failed]
]

Poly[RingExtension[PolyRing,R_,{},test_], expr__, opts___?OptionQ] :=
	Poly[R, expr, opts]

pring[p_poly] := p[[1,1]]
pdir[p_poly] := p[[1,2]]
pind[p_poly] := p[[1,3]]
pnc[p_poly] := p[[1,4]]

Unprotect[Variables,CoefficientList, Coefficient];

Variables[p_poly] ^:= {pind[p]}

CoefficientList[p_poly] ^:= Last[p]

poly /: Coefficient[p_poly, ind_, 0] := If[pind[p]===ind, First[Last[p]],
	Message[Coefficient::ind, p, pind[p], ind]; $Failed]

poly /: Coefficient[p_poly, ind_, n_Integer?Positive] := 
	If[pind[p]===ind,Part[Last[p],n+1],
	Message[Coefficient::ind, p, pind[p], ind];$Failed]

poly /: Coefficient[p_poly, n_Integer?Positive] := Part[Last[p],n+1]

Protect[Variables,CoefficientList, Coefficient];

BaseRing[p_poly] := pring[p]

ToOrdinaryPolynomial[p_poly] :=
	Last[p].Table[pind[p]^k,{k,0, Length[Last[p]]-1}]
	
ToOrdinaryPolynomial[p_] :=  
	If[Length[Variables[p]]==1 && 
		PolynomialQ[p, First[Variables[p]]],p]

zeepoly[R_,k_] := Poly[R,Sequence@@Table[Zero[R],{k}]]

Addition[RingExtension[PolyRing,R_,{},test_]]:=
	Addition[RingExtension[PolyRing,R,{},test],#1, #2]&

extAndBaseMatchQ[RingExtension[PolyRing,R_,{},test_], p_poly] :=
	If[R === pring[p], True,
		Message[Poly::extagrm]; False]
		
extAndBasesMatchQ[RingExtension[PolyRing,R_,{},test_], p_poly, q_poly] :=
	If[R === pring[p] && R === pring[q], True,
		Message[Poly::extagrm]; False]
		
basesMatchQ[p_poly, q_poly] :=
	If[pring[p]  === pring[q], True,
		Message[Poly::bragrm]; False]

indToUse[p_poly, q_poly] := If[p[[1,3]] === q[[1,3]], p[[1,3]], 
			Indeterminate/.Options[Poly]]
			
dirToUse[p_poly, q_poly] := If[p[[1,2]] === q[[1,2]], p[[1,2]], 
			PowersIncrease/.Options[Poly]]
			
Addition[RingExtension[PolyRing,R_,{},test_], p_poly, q_poly]:=
	If[extAndBasesMatchQ[RingExtension[PolyRing,R,{},test], p, q] &&
		basesMatchQ[p,q],
	Block[{m1,m2,max,k,cc,coef, c1=Last[p], c2=Last[q], dir, var},
		m1=Length[c1];m2=Length[c2];
		max=Max[m1,m2];
		coef = Apply[Addition[R],{Join[c1, Table[Zero[R],{max-m1}]],
			Join[c2,Table[Zero[R],{max-m2}]]}//Transpose,1];
		coef = coef //.{{cc__,Zero[R]}->{cc}};
		dir = dirToUse[p,q];
		var = indToUse[p,q];
		Poly[R, Sequence@@If[dir===RightToLeft,Reverse[coef],coef], 
			PowersIncrease -> dir, Indeterminate -> var]
	], $Failed]

Addition[p_poly, q_poly]:=
	If[basesMatchQ[p,q],
		Addition[PolynomialsOver[p[[1,1]]],p,q], $Failed]
		
Unprotect[Plus, Times];

poly /: Plus[p_poly, q_poly] := Addition[p,q]
poly /: Times[p_poly, q_poly] := Multiplication[p,q]
poly /: Times[-1, q_poly] := NegationOf[q]

Protect[Plus, Times];
		
Multiplication[RingExtension[PolyRing,R_,{},test_], p_poly, q_poly]:=
	If[extAndBasesMatchQ[RingExtension[PolyRing,R,{},test], p, q] &&
		basesMatchQ[p,q],
	Block[{m1,k,cc,coef, c1=Last[p], c2=Last[q], dir, var, tr},
		m1=Length[c1];
		coef = Table[Join[Table[Zero[R],{k-1}], 
			Map[Multiplication[R][c1[[k]],#]&,
			c2], Table[Zero[R],{m1-k}]],{k,1,m1}];
		coef = If[Length[coef] < 2, First[coef],
			Map[Fold[Addition[R],First[#],Rest[#]]&, Transpose[coef]]];
		coef = coef //.{{cc__,Zero[R]}->{cc}};
		dir = dirToUse[p,q];
		var = indToUse[p,q];
		Poly[R, Sequence@@If[dir===RightToLeft,Reverse[coef],coef], 
			PowersIncrease -> dir, Indeterminate -> var]
	], $Failed]

Multiplication[RingExtension[PolyRing,R_,{},test_]]:=
	Multiplication[RingExtension[PolyRing,R,{},test],#1, #2]&

Multiplication[p_poly, q_poly]:=
	If[basesMatchQ[p,q],
		Multiplication[PolynomialsOver[p[[1,1]]],p,q], $Failed]
	
ClosedQ[RingExtension[PolyRing,R_,{},test_], Operation -> Addition]:=
	Module[{aok},
		aok = ClosedQ[R, Operation -> Addition];
		AddRingInfo[RingExtension[PolyRing,R,{},test], aok, "the set is closed under addition",
			"the set is not closed under this addition"];
		aok]

ClosedQ[RingExtension[PolyRing,R_,{},test_], Operation -> Multiplication]:=
	Module[{mok},
		mok = ClosedQ[R, Operation -> Multiplication];
		AddRingInfo[RingExtension[PolyRing,R,{},test], mok, 
			"the set is closed under multiplication",
			"the set is not closed under this multiplication"];
		mok]

HasZeroQ[RingExtension[PolyRing,R_,{},test_]] := HasZeroQ[R]

Zero[RingExtension[PolyRing,R_,{},test_]] := Zero[RingExtension[PolyRing,R,{},test]] =
	If[HasZeroQ[R], Poly[R,Zero[R]],
		Message[RingExtension::NoZero]; $Failed]

WithUnityQ[RingExtension[PolyRing,R_,{},test_]] := WithUnityQ[R]
           
Unity[RingExtension[PolyRing,R_,{},test_]] := Unity[RingExtension[PolyRing,R,{},test]] =
	If[WithUnityQ[R], Poly[R,Unity[R]],
	Message[RingExtension::NoUnity]; $Failed]
	
HasNegativeQ[RingExtension[PolyRing,R_,{},test_], p_poly] :=
	If[extAndBaseMatchQ[RingExtension[PolyRing,R,{},test], p],
	Module[{ng = Apply[And,Map[HasNegativeQ[R,#]&,Last[p]]]},
		If[Not[test[p]], Message[MemberQ::elmnt, p, "the ring of polynomials"]; 
			ng = False];
		If[ng===True, True,False]], $Failed]

HasNegativeQ[p_poly] :=
	Module[{ng = Apply[And,Map[HasNegativeQ[p//pring,#]&,Last[p]]]},
		If[Not[test[p]], Message[MemberQ::elmnt, p, "the ring of polynomials"]; 
			ng = False];
		If[ng===True, True,False]]

NegationOf[RingExtension[PolyRing,R_,{},test_], p_poly] :=
	If[extAndBaseMatchQ[RingExtension[PolyRing,R,{},test], p],
		If[HasNegativeQ[RingExtension[PolyRing,R,{},test],p], poly[First[p],
				Map[NegationOf[R,#]&,Last[p]]],
			Message[RingExtension::NoNegat];$Failed], $Failed]

NegationOf[p_poly] :=
		If[HasNegativeQ[p], poly[First[p],Map[NegationOf[p//pring,#]&,Last[p]]],
			Message[RingExtension::NoNegat];$Failed]

UnitQ[RingExtension[PolyRing,R_,{},test_], poly[info_List,{a_}]] := 
	If[extAndBaseMatchQ[RingExtension[PolyRing,R,{},test], poly[info,{a}]],
	If[test[poly[info,{a}]], UnitQ[R, a],
		Message[MemberQ::elmnt, poly[info,{a}], "the ring of polynomials"]; False],
	$Failed]

UnitQ[RingExtension[PolyRing,R_,{},test_], $Failed] := $Failed

UnitQ[poly[info_List,{a_}]] := UnitQ[First[info], a]

UnitQ[RingExtension[PolyRing,R_,{},test_], poly[info_List,coef_List]] := 
	If[UnitQ[normalizePolynomial[poly[info,coef]]], True, False]

UnitQ[poly[info_List,__]] := False

MultiplicativeInverse[RingExtension[PolyRing,R_,{},test_], poly[info_List,{a_}]]:=
	If[extAndBaseMatchQ[RingExtension[PolyRing,R,{},test], poly[info,{a}]],
	If[UnitQ[RingExtension[PolyRing, R, {}, test], poly[info,{a}]], 
		Poly[R,MultiplicativeInverse[R,a]],
		Message[Ringoid::NotUnit,Poly[R,a],"the polynomials over "<>
    	RingoidName[R]]; $Failed], $Failed]
                                            
MultiplicativeInverse[poly[info_,coef_]]:=
	MultiplicativeInverse[PolynomialsOver[info//First],poly[info,coef]]
                                            
MultiplicativeInverse[RingExtension[PolyRing,R_,{},test_], poly[info_List, {a__}]]:=
	If[extAndBaseMatchQ[RingExtension[PolyRing,R,{},test], poly[info,{a}]],
		Module[{temp},
			If[UnitQ[RingExtension[PolyRing, R, {}, test], temp = 
					normalizePolynomial[poly[info,{a}]]],  
				Poly[R,MultiplicativeInverse[R,temp[[2,1]]]],
				Message[Ringoid::NotUnit,poly[info,{a}],"the polynomials over "<>
    	RingoidName[R]]; $Failed]], $Failed]
                                            
Units[RingExtension[PolyRing,R_,{},test_]] := Map[Poly[R,#]&,Units[R]]

(* TO DO:Fix problem with nonstandard rings such as DirectProducts *)

Monomial[RingExtension[PolyRing,R_,{},test_], c_, k_] := 
	Poly[R, Sequence@@Join[Table[Zero[R],{k}],{c}], PowersIncrease -> LeftToRight]

Monomial[R_?RingoidQ, c_, k_] := 
	Monomial[PolynomialsOver[R], c, k]

changeIndeterminate[p_poly, var_] := p /. pind[p] -> var


(* ::Subsubsection:: *)
(*extensions of Polynomial functions*)


Unprotect[PolynomialQuotient, PolynomialRemainder, PolynomialGCD,
	PolynomialDivision, PolynomialLCM];

poly /: PolynomialDivision[c_poly, d_poly] :=
	If[basesMatchQ[c,d],
		PolynomialDivision[PolynomialsOver[pring[c]], c, d], 
		$Failed]
		
poly /: PolynomialDivision[RingExtension[PolyRing,R_,{},t_], c_poly, d_poly] :=
	If[extAndBasesMatchQ[RingExtension[PolyRing,R,{},t], c, d] && basesMatchQ[c,d],
		Module[{lq,lr,PR=RingExtension[PolyRing,R,{},t], a = Last[c], 
			b = Last[d],lc,var = indToUse[c,d]},
	If[UnitQ[R, lc = Last[b]],
		{lq,lr} = If[Length[b]==1,
			{poly[First[c],Map[(Multiplication[R][MultiplicativeInverse[R, First[b]],#])&,a]],
			Poly[R,Zero[R]]},      
		Module[{lci=MultiplicativeInverse[R, Last[b]],
			deg=Length[b],ah,qh,monom,divison,Nmonom},
		division[ah_,qh_] := If[Length[ah//Last]<deg,{qh,ah},
			monom=Monomial[R, Multiplication[R][Last[ah//Last],lci],
				Length[ah//Last]-deg];
			Nmonom=Monomial[R,Multiplication[R][Last[ah//Last],NegationOf[R,lci]],
				Length[ah//Last]-deg];
			division[Addition[PR][ah,Multiplication[PR][Nmonom,d]],
				Addition[PR][qh,monom] ]];
		division[c, Poly[R,Zero[R]]] ]];
		{changeIndeterminate[lq,var],changeIndeterminate[lr,var]},     
		Message[PolynomialDivision::undef,lc, StructureName[R]];
		$Failed]], $Failed]

poly /: PolynomialDivision[c_poly, d_poly, Mode -> Textual] :=
	If[basesMatchQ[c,d],
		PolynomialDivision[PolynomialsOver[pring[c]], c, d, Mode -> Textual],
		$Failed]

poly /: PolynomialDivision[RingExtension[PolyRing,R_,{},t_], c_poly, d_poly, Mode -> Textual]:=
		Module[{lq,lr, da, a = Last[c], b = Last[d]},
	da = PolynomialDivision[RingExtension[PolyRing,R,{},t], c,d];
	If[UnitQ[R, Last[b]],
		{lq,lr} = If[da =!= $Failed, da];
		PolynomialDivisionTextual[c,d,lq,lr]
		(*{lq,lr}*),     
		$Failed]];

PolynomialDivisionTextual[a_poly, b_poly, q_poly, r_poly] := 
	Module[{var = pind[a]//ToString, mssg},
		mssg = "a("<>var<>") = b("<>var<>")q("<>var<>") + r("<>var<>") where\n";
		mssg = mssg <> "a(" <> var <> ") = " <> ToString[a] <> ",\n";
		mssg = mssg <> "b(" <> var <> ") = " <> ToString[b] <> ",\n";
		mssg = mssg <> "q("<>var<>") = " <> ToString[q] <> " and\n";
		mssg = mssg <> "r("<>var<>") = " <> ToString[r] <> ".\n";
		mssg = mssg <> "Notice that either r(" <> var <> ") = 0 or deg r < deg b."]
 
poly /: PolynomialQuotient[c_poly, d_poly] :=
	If[basesMatchQ[c,d],
		PolynomialQuotient[PolynomialsOver[c[[1,1]]], c, d],
		$Failed]
            
poly /: PolynomialQuotient[RingExtension[PolyRing,R_,{},t_], a_poly, b_poly] :=
	Module[{da = PolynomialDivision[RingExtension[PolyRing,R,{},t], a,b]},
		If[da =!= $Failed, First[da], $Failed]]

poly /: PolynomialRemainder[c_poly, d_poly] :=
	If[basesMatchQ[c,d],
		PolynomialRemainder[PolynomialsOver[c[[1,1]]], c, d],
		$Failed]
   
poly /: PolynomialRemainder[RingExtension[PolyRing,R_,{},t_], a_poly, b_poly] :=
	Module[{da = PolynomialDivision[RingExtension[PolyRing,R,{},t], a,b]},
		If[da =!= $Failed, Last[da], $Failed]]

poly /: PolynomialGCD[c_poly, d_poly] :=
	If[basesMatchQ[c,d],
		PolynomialGCD[PolynomialsOver[c[[1,1]]], c, d],
		$Failed]

poly /: PolynomialGCD[RingExtension[PolyRing,basering_?RingoidQ,{},t_], c_poly, d_poly]:=
	If[extAndBasesMatchQ[RingExtension[PolyRing,basering,{},t], c, d] && basesMatchQ[c,d],
	Module[{gcd,result,T,zp=Poly[basering,Zero[basering]], a = Last[c], b = Last[d]},
		If[(RingQ[basering] && WithUnityQ[basering] &&
				Length[b]>0 && (UnitQ[basering, Last[b]]||(b===Last[zp]))),
		(*case where result is returned *)
			T = PolynomialsOver[basering];
			gcd = (If[(Last[#2]===Last[zp]), #1, If[UnitQ[basering, Last[#2//Last]],
				gcd[#2,PolynomialRemainder[T,#1,#2]], 
				Message[PolynomialGCD::undefined];$Failed]])&;     
			result=gcd[c,d],
		(*case where no result is returned *)
	   Message[PolynomialGCD::undefined];$Failed]], $Failed]
      
poly /: PolynomialLCM[c_poly, d_poly] :=
	If[basesMatchQ[c,d],
		PolynomialLCM[PolynomialsOver[c[[1,1]]], c, d],
		$Failed]

poly /: PolynomialLCM[RingExtension[PolyRing,basering_?RingoidQ,{},t_], c_poly, d_poly]:=
	If[extAndBasesMatchQ[RingExtension[PolyRing,basering,{},t], c, d] && basesMatchQ[c,d],
	Module[{result,T,zp=Poly[basering,Zero[basering]], a = Last[c], b = Last[d]},
		If[(RingQ[basering] && WithUnityQ[basering] &&
				Length[b]>0 && (UnitQ[basering, Last[b]]||(b===Last[zp]))),
		(*case where result is returned *)
			PolynomialQuotient[RingExtension[PolyRing,basering,{},t],c * d,PolynomialGCD[c,d]],
		(*case where no result is returned *)
	   Message[PolynomialGCD::undefined];$Failed]], $Failed]
      
Protect[PolynomialQuotient, PolynomialRemainder, PolynomialGCD,
	PolynomialDivision, PolynomialLCM];


(* ::Subsubsection:: *)
(*Quotient Rings*)


Options[QuotientRingPR]={SizeLimit->16};

(* removed comments on above 9/8/99 *)
(* Renamed the above, and below, with PR added to distinguish it from other QuotientRings since the packages are now all together - 7/15/04 *)

QuotientRing[basering_?RingoidQ, p_poly,opts___?OptionQ] := 
	QuotientRing[basering, p,opts] = 
	QuotientRing[PolynomialsOver[basering], p]

(* QuotientRing[RingExtension[PolyRing,basering_?RingoidQ,{},t_], q_poly, 
		opts___?OptionQ]:= 
QuotientRing[RingExtension[PolyRing,basering,{},t], q, opts] =
	If[extAndBaseMatchQ[RingExtension[PolyRing,basering,{},t], q],
	Block[{small,qr,p = Last[q], dir = pdir[q], var = pind[q]},
  	small=(SizeLimit/.Flatten[{opts, Options[QuotientRingPR]}]);
	If[(Length[Elements[basering]]^(Length[p]-1))<=small,
		If[WithUnityQ[basering],
			If[UnitQ[basering, Last[p]],
				qr = Block[{dom, m=Length[p]-1,z=Zero[basering]},
        	dom=CartesianProduct@@Table[Elements[basering],{m}]//
						Map[(#//.{{a__,z}->{a}})&,#]&;
				If[dir === RightToLeft, dom = Map[Reverse,dom]];
				dom =	Map[Poly[basering,Sequence@@#, Indeterminate -> var]&,dom];
				FormRingoid[dom,(Addition[PolynomialsOver[basering]][#1,#2])&,
					(PolynomialRemainder[RingExtension[PolyRing,basering,{},True],
					(Multiplication[RingExtension[PolyRing,basering,{},True]][#1,#2]),
					q])&, RingoidName -> "Quotient Ring mod "<>
						ToString[ToOrdinaryPolynomial[q]//StandardForm],
  				WideElements->True, KeyForm -> StandardForm, IsARing -> True]
  			];
      BaseRing[qr]=basering;
      RingQ[qr]=RingQ[basering];
      If[HasZeroQ[basering], HasZeroQ[qr] = True;
      	Zero[qr] = Poly[basering, Zero[basering]],
        HasZeroQ[qr] = False];
      If[WithUnityQ[basering], WithUnityQ[qr]=True;
      	Unity[qr]=Poly[basering,Unity[basering]],
   			WithUnityQ[qr]=False];
      ModulusPolynomial[qr] = q;
      qr,
			Message[PolynomialDivision::undef, Last[p],
				StructureName[R]];$Failed],
		Message[Ringoid::NoUnity];$Failed],
	Message[QuotientRing::toobig];$Failed]], $Failed] *)
	
(* changes in Red 9/8/99 *)
(* changes in Blue 7/10/00 *)
QuotientRing[RingExtension[PolyRing,basering_?RingoidQ,{},t_], qq_poly, 
		opts___?OptionQ]:= 
QuotientRing[RingExtension[PolyRing,basering,{},t], qq, opts] = Module[{q},
q = qq;
q[[1,2]]=LeftToRight;
	If[extAndBaseMatchQ[RingExtension[PolyRing,basering,{},t], q],
	Block[{small,qr,p = Last[q], dir = pdir[q], var = pind[q],RT,unitq},
  	small=(SizeLimit/.Flatten[{opts, Options[QuotientRingPR]}]);
	If[(Length[Elements[basering]]^(Length[p]-1))<=small,
		If[WithUnityQ[basering],
			If[UnitQ[basering, Last[p]],
				qr = Block[{dom, m=Length[p]-1,z=Zero[basering]},
        	dom=CartesianProduct@@Table[Elements[basering],{m}]//
						Map[(#//.{{a__,z}->{a}})&,#]&;
				If[dir === RightToLeft, dom = Map[Reverse,dom]];
				dom =	Map[Poly[basering,Sequence@@#, Indeterminate -> var]&,dom];
RT=FormRingoid[dom,(Addition[PolynomialsOver[basering]][#1,#2])&,
(PolynomialRemainder[RingExtension[PolyRing,basering,{},True],					(Multiplication[RingExtension[PolyRing,basering,{},True]][#1,#2]),
					q])&, RingoidName -> "Quotient Ring mod "<>
						ToString[ToOrdinaryPolynomial[q]//StandardForm],
  				WideElements->True, KeyForm -> StandardForm, IsARing -> True];
  				unitq=(PolynomialGCD[PolynomialsOver[basering], q, #]//(Length[#[[2]]]==1 && UnitQ[basering, #[[2,1]]])&)&;
  				Units[RT]=Select[dom,unitq[#]&];
ZeroDivisors[RT]=Complement[dom,Union[Units[RT],{Poly[basering,Zero[basering], Indeterminate -> var]}]];
  				RT
  			];
      BaseRing[qr]=basering;
      RingQ[qr]=RingQ[basering];
      If[HasZeroQ[basering], HasZeroQ[qr] = True;
      	Zero[qr] = Poly[basering, Zero[basering]],
        HasZeroQ[qr] = False];
      If[WithUnityQ[basering], WithUnityQ[qr]=True;
      	Unity[qr]=Poly[basering,Unity[basering]],
   			WithUnityQ[qr]=False];
      ModulusPolynomial[qr] = q;
      qr,
			Message[PolynomialDivision::undef, Last[p],
				StructureName[R]];$Failed],
		Message[Ringoid::NoUnity];$Failed],
	Message[QuotientRing::toobig];$Failed]], $Failed]]

InducedCosetPolynomialFunction[QR_?RingoidQ] := 
	Module[{coef, deg, R = BaseRing[QR], var, p = ModulusPolynomial[QR]},
		coef = p[[2]];
		deg = Length[coef] - 1;
		coef = Map[Poly[R, #, Indeterminate -> p[[1,3]]]&, coef];
		Function[var,
			Sum[coef[[k+1]] ElementToPower[QR, var, k], {k, deg, 0, -1}]]]

ExtensionEvaluation[extension_?RingoidQ, lst_List]:= 
	Map[ExtensionEvaluation[extension, #]&, lst]

ExtensionEvaluation[extension_?RingoidQ, a_poly]:=
	InducedCosetPolynomialFunction[extension][a]
	
(*UnitQ[R_?RingoidQ, a_poly, opts___?OptionQ]:=
   Module[{p=ModulusPolynomial[R],
           b=BaseRing[R],g},
         If[Head[p]==poly && (Head[b]==Ringoid || Head[b]==ringoid),
              g=PolynomialGCD[PolynomialsOver[b], p, a];
              Length[g]==1 && UnitQ[b, g[[1]]],
              False]]*)



(* ::Subsubsection:: *)
(*misc.*)


Unprotect[Degree, Exponent];

poly /: Degree[RingExtension[PolyRing,R_,{},t_],p_poly] := 
	Degree[p]
	
poly /: Degree[p_poly] := 
	Length[Last[normalizePolynomial[p]]]-1

poly /: Exponent[RingExtension[PolyRing,R_,{},t_],p_poly] := 
	If[extAndBaseMatchQ[RingExtension[PolyRing,R,{},t], p],
		Degree[RingExtension[PolyRing,R,{},t],p], $Failed]

poly /: Exponent[p_poly] := Degree[p]

Protect[Degree, Exponent];

Unprotect[Equal];

Options[Equal] = {IgnoreIndeterminate -> True};

poly /: Equal[RingExtension[PolyRing,R_,{},t_], p_poly, q_poly, opts___?OptionQ] :=
	Equal[p,q, opts]
	
poly /: Equal[p_poly, q_poly, opts___?OptionQ] :=
	BaseRing[p]===BaseRing[q] &&
	SameQ[Last[normalizePolynomial[p]],
		Last[normalizePolynomial[q]]] && 
		If[IgnoreIndeterminate/.Flatten[{opts, Options[Equal]}], True,
			SameQ[Variables[p], Variables[q]]]
	
Protect[Equal];

normalizePolynomial[RingExtension[PolyRing,R_,{},t_],p_poly] := 
	normalizePolynomial[p]

normalizePolynomial[p_poly] := 
	poly[First[p],(Last[p])//.{vvv___,Zero[pring[p]]} :>{vvv}]

PolynomialEvaluation[RingExtension[PolyRing,R_,{},test_],poly[{R_,d_,var_,n_},
		coef_List], Rule[var_,r_]] :=
	PolynomialEvaluation[RingExtension[PolyRing,R,{},test],poly[{R,d,var,n},coef], r]

PolynomialEvaluation[RingExtension[PolyRing,R_,{},test_],poly[{R_,d_,var_,n_},
		coef_List], {{Rule[var_,r_]}}] :=
	PolynomialEvaluation[RingExtension[PolyRing,R,{},test],poly[{R,d,var,n},coef], r]

PolynomialEvaluation[RingExtension[PolyRing,R_,{},test_],poly[{R_,d_,var_,n_},
		coef_List], {Rule[var_,r_]}] :=
	PolynomialEvaluation[RingExtension[PolyRing,R,{},test],poly[{R,d,var,n},coef], r]

PolynomialEvaluation[RingExtension[PolyRing,R_,{},test_],p_poly, rules:{_Rule..}] :=
	Map[PolynomialEvaluation[RingExtension[PolyRing,R,{},test],p, {#}]&, rules]

PolynomialEvaluation[RingExtension[PolyRing,R_,{},test_],p_poly, rules:{{_Rule}..}] :=
	Map[PolynomialEvaluation[RingExtension[PolyRing,R,{},test],p, {#}]&, rules]
	
PolynomialEvaluation[RingExtension[PolyRing,R_,{},test_],p_poly, {}] := {}

PolynomialEvaluation[q_poly, r_] :=
	PolynomialEvaluation[PolynomialsOver[q[[1,1]]], q, r]

PolynomialEvaluation[RingExtension[PolyRing,R_,{},test_],q_poly, r_] := 
	If[extAndBaseMatchQ[RingExtension[PolyRing,R,{},t], q],
		Module[{out, p = Last[q]},
	If[test[q] && ElementQ[r,R],
		out = Module[{rest,f,mult},
			mult = Multiplication[R];
			rest = Drop[p,1];
			f[c_,{d_}] := Multiplication[R][c,ElementToPower[R,r,d]];
			Fold[Addition[R],p[[1]],MapIndexed[f,rest]]],
		If[Not[test[q]],
			Message[MemberQ::elmnt, q, "the ring of polynomials"]; out = $Failed];
		If[Not[ElementQ[r,R]],Message[RingExtension::NotBaseElement, r]; out = $Failed];
		out]], $Failed]
		
Zeros[RingExtension[PolyRing,R_,{},test_], p_poly] :=
		If[test[p] && extAndBaseMatchQ[RingExtension[PolyRing,R,{},test], p],
			Module[{els,z,evals, temp},
				els = Elements[R];
				z = Zero[R];
				evals = Map[PolynomialEvaluation[RingExtension[PolyRing,R,{},
					test],p,#]&,els];
				temp = Select[Transpose[{els,evals}],(#[[2]]===z)&];
				If[temp==={},temp,temp//Transpose//First]],
			Message[MemberQ::elmnt, p, "the ring of polynomials"]; 
			$Failed]

Zeros[p_poly] := Zeros[PolynomialsOver[p[[1,1]]],p]
	   		
Unprotect[Solve, ReplaceAll];

Solve[p_poly == r_] := 
		Module[{er, sols, R = p[[1,1]], d = p[[1,2]], var = p[[1,3]],
			n = p[[1,4]], coef = p[[2]], q=p},
			If[ElementQ[r,R],
				er = PolynomialsOver[R];
				q[[2,1]] = Addition[R][NegationOf[R,r], First[coef]];
				sols = Zeros[er, q];
				If[sols === {}, sols, Map[{Rule[var,#]}&,sols]],
			$Failed]]

RingExtension /: Solve[RingExtension[PolyRing,R_,{},test_], p_poly == r_] := Solve[p == r]

poly /: ReplaceAll[poly[{R_,d_,var_,n_}, coef_List], {{Rule[var_, r_]}}] := 
	PolynomialEvaluation[poly[{R,d,var,n},coef], r]

poly /: ReplaceAll[p_poly, rules:{{_Rule}..}] := Module[{temp},
	temp = Transpose[Flatten[rules/.Rule :> List,1]];
	If[Union[First[temp]] === Variables[p],
		Map[PolynomialEvaluation[p, #]&,Last[temp]],
		Print["Bad rules - change to Message about mixing up variables"]; $Failed]]
	
Protect[Solve, ReplaceAll];

constantToPoly[R_?RingoidQ, r_, opts___?OptionQ] := If[ElementQ[r,R], 
	Poly[R, r, opts],
	Message[MemberQ::elmnt, r, StructureName[R]]; $Failed]
	
Options[PolynomialsOfDegreeN] = {SizeLimit -> 125, Indeterminate -> Global`x};

PolynomialsOfDegreeN[basering_?RingoidQ, 0, opts___?OptionQ] :=
	Map[constantToPoly[basering, #, Indeterminate -> 
		(Indeterminate/.Flatten[{opts, Options[PolynomialsOfDegreeN]}])]&, 
		Elements[basering]]

PolynomialsOfDegreeN[basering_?RingoidQ, n_,opts___?OptionQ] :=
	PolynomialsOfDegreeN[basering, n, opts] =
	Module[{k, z = Zero[basering], coef, els = Elements[basering],
		ind = Indeterminate/.Flatten[{opts,Options[PolynomialsOfDegreeN]}],
		small = SizeLimit/.Flatten[{opts,Options[PolynomialsOfDegreeN]}]},
		If[(k = Length[els]^n * (Length[els]-1)) <= small,
 		coef = CartesianProduct@@Append[Table[els,{n}],Complement[els,{z}]];
 		Map[Poly[basering, Sequence@@#, Indeterminate->ind]&, coef],
	Message[PolynomialsOfDegreeN::toobig,n,k,small];$Failed]]
	 	
 	PolynomialsUpToDegreeN[basering_?RingoidQ, n_,opts___?OptionQ] :=
	PolynomialsUpToDegreeN[basering, n, opts] =
	Module[{k,j,
		ind = Indeterminate/.Flatten[{opts, Options[PolynomialsOfDegreeN]}],
		small = SizeLimit/.Flatten[{opts, Options[PolynomialsOfDegreeN]}]},
		If[(k = Length[els]^(n+1)) <= small,
 			Flatten[Table[PolynomialsOfDegreeN[basering,j,
 				Indeterminate -> ind, SizeLimit->small],{j,n,0,-1}],1],
 			Message[PolynomialsOfDegreeN::toobig,n,k,small];
		$Failed]]


(* ::Subsection::Closed:: *)
(*ElementQ*)


ElementQ[exp_, RingExtension[Type_,base_,param_,test_,___]] := test[exp];

ElementsQ[exps_List, RingExtension[Type_,base_,param_,test_,___]] := 
	Apply[And,Map[test,exps]]


(* ::Subsection:: *)
(*Function Rings*)


Format[RingExtension[FuncRing,R_,__]] := 
"-Ring of Functions over " <> RingoidName[R] <> "-"

FunctionsOver[R_] := FunctionsOver[R] = 
	RingExtension[FuncRing, R, {}, (Length[#]===Length[Elements[R]] && 
		Apply[And,Map[ElementQ[#,R]&,#]])&];

Addition[RingExtension[FuncRing,R_,{},t_]][a_Func,b_Func]:=
	Inner[Addition[R],a,b,Func];
	
Addition[RingExtension[FuncRing,R_,{},t_], a_Func, b_Func] :=
	Addition[RingExtension[FuncRing,R,{},t]][a,b]
    
Multiplication[RingExtension[FuncRing,R_,{},t_]][a_Func,b_Func]:=
	Inner[Multiplication[R],a,b,Func];
                        
Multiplication[RingExtension[FuncRing,R_,{},t_], a_Func, b_Func] :=
	Multiplication[RingExtension[FuncRing,R,{},t]][a,b]
    
PolyToFunction[RingExtension[FuncRing,R_,{},t_], a_poly]:=
	Catch[If[WithUnityQ[R],Map[First[PolynomialRemainder[PolynomialsOver[R],a,
		poly[{R, LeftToRight,a[[1,3]],a[[1,4]]},{NegationOf[R,#],Unity[R]}]]//Last]&,
      Elements[R]]//Apply[Func,#]&,Throw[$Failed]]]

PolyToFunction[R_?RingoidQ, a_poly]:=  PolyToFunction[FunctionsOver[R], a]

PolyToFunction[a_poly]:= PolyToFunction[FunctionsOver[a[[1,1]]], a]
  
HasZeroQ[RingExtension[FuncRing,R_,{},t_]] := HasZeroQ[R]
 
Zero[RingExtension[FuncRing,R_,{},t_]] := Zero[RingExtension[FuncRing,R,{},t]] = 
	If[HasZeroQ[R], Func@@Table[Zero[R],{Length[Elements[R]]}],
		Message[RingExtension::NoZero];$Failed];

WithUnityQ[RingExtension[FuncRing,R_,{},t_]] := WithUnityQ[R]

Unity[RingExtension[FuncRing,R_,{},t_]]:= Unity[RingExtension[FuncRing,R,{},t]] = 
	If[WithUnityQ[R],
		Func@@Table[Unity[R],{Length[Elements[R]]}],
		Message[RingExtension::NoUnity];$Failed];

ZeroDivisorQ[RingExtension[FuncRing,R_,{},t_], f_Func]:=
	!UnitQ[RingExtension[FuncRing,R,{},t], f];

HasNegativeQ[RingExtension[FuncRing,R_,{},t_], f_Func]:=
	Fold[And[#1,HasNegativeQ[R, #2]]&,HasNegativeQ[R, First[f]],
		List@@Rest[f]];
                  
NegationOf[RingExtension[FuncRing,R_,{},t_], f_Func]:=
	If[HasNegativeQ[RingExtension[FuncRing,R,{},t],f],
		Map[NegationOf[R, #]&,f],
		Message[RingExtension::NoNegat]];

UnitQ[RingExtension[FuncRing,R_,{},t_], f_Func]:=
	Fold[And[#1,UnitQ[R,#2]]&,UnitQ[R, First[f]],
		List@@Rest[f]]

MultiplicativeInverse[RingExtension[FuncRing,R_,{},t_], f_Func]:=
	If[UnitQ[RingExtension[FuncRing,R,{},t], f],
		Map[MultiplicativeInverse[R,#]&,f],
		Message[RingExtension::NoInverse];$Failed]

FuncToRules[RingExtension[FuncRing,R_,{},t_], f_Func]:=
	If[Length[f]==Length[Elements[R]],
		Inner[Rule[#1,#2]&,Elements[R],List@@f,List],
		Message[FuncToRules::invalid];{}]


(* ::Subsubsection:: *)
(*Interpolation*)


distinct = (Length[#]==Length[Union@@Map[{#}&,#]])&;

L[i_,{pts__},R_?RingoidQ]:=
		Module[{denom,numer,uno=({pts}[[i]]),zeros, P = PolynomialsOver[R]},
			zeros = Complement[{pts},{uno}];
			denom = Fold[Multiplication[R][#1,Addition[R][uno,NegationOf[R, #2]]]&,
				Unity[R],zeros];
			numer = Fold[Multiplication[P][#1, poly[{R,LeftToRight,Global`X,
    		True},{NegationOf[R, #2],Unity[R]}]]&,
				Unity[P],zeros];
			Multiplication[P][numer,poly[{R,LeftToRight,Global`X,
    		True},{MultiplicativeInverse[R, denom]}]]];

InterpolatingPolynomial//Unprotect;

ringoid /: 
	InterpolatingPolynomial[R_ringoid,
		 {pairs__}]:=
	Module[{xs,ys,len,P=PolynomialsOver[R]}, 
		{xs,ys}=Transpose[{pairs}];
  If[distinct[xs],
    len=Length[xs];
    Fold[Addition[P][#1,Multiplication[P][poly[{R,LeftToRight,Global`X,
    		True},{ys[[#2]]}],
      L[#2,xs,R]]]&, Zero[P],Range[1,len]],
    Message[InterpolatingPolynomial::ipdup]]]
 
 Protect[InterpolatingPolynomial];    


(* ::Subsection:: *)
(*RandomElement(s)*)


randElement[{}] := {};

randElement[Dom_List]:=
       Dom[[Random[Integer,{1,Length[Dom]}]]];

RandomElement[RingExtension[PolyRing,R_,{},t_], 0, opts___?OptionQ]:=
	Poly[R, RandomElement[R, opts]]
       
RandomElement[RingExtension[PolyRing,R_,{},t_], deg_Integer?Positive, opts___?OptionQ]:=
	Module[{z,cc,selp=SelectFrom/.Flatten[{opts, Options[RandomElement]}],
	flag = LowerDegreeOK/.Flatten[{opts, Options[RandomElement]}],
		mon=(Monic/.Flatten[{opts, Options[RandomElement]}]),
		coef, dir = PowersIncrease/.Options[Poly], ind = Indeterminate/.Options[Poly]},
	If[mon,flag=False];
	If[Not[flag],(*Degree is exactly deg *)
	           coef = RandomElements[R,deg,SelectFrom->Any];
	           PrependTo[coef,If[mon, Unity[R],
		        RandomElement[R, SelectFrom->NonZero]]],
		        (*Degree can be less than deg*)
		        z=Zero[R];
		        coef = RandomElements[R,deg+1,SelectFrom->Any];
		        If[selp==NonZero,While[And@@((#==z)&/@coef),
		       		coef=RandomElements[R,deg+1,SelectFrom->Any]],coef]
	       ];
	(*coef = coef //.{{cc__,Zero[R]}->{cc}};*)
	coef = If[dir===RightToLeft,coef,Reverse[coef]];
	Poly[R, Sequence@@coef, Indeterminate -> ind,
		PowersIncrease -> dir]]
		
(* RandomElement[RingExtension[PolyRing,R_,{},t_], deg_Integer?Positive, opts___?OptionQ]:=
	Module[{z,cc,selp=SelectFrom/.Flatten[{opts, {SelectFrom->All}}],
	flag = LowerDegreeOK/.Flatten[{opts, {LowerDegreeOK->True}}],
		mon=(Monic/.Flatten[{opts, {Monic->False}}]),
		coef, dir = PowersIncrease/.Options[Poly], ind = Indeterminate/.Flatten[{opts,Options[Poly]}]},
	If[mon,flag=False];
	If[Not[flag],(*Degree is exactly deg *)
	           coef = RandomElements[R,deg,SelectFrom->Any];
	           PrependTo[coef,If[mon, Unity[R],
		        RandomElement[R, SelectFrom->NonZero]]],
		        (*Degree can be less than deg*)
		        z=Zero[R];
		        coef = RandomElements[R,deg+1,SelectFrom->Any];
		        If[selp==NonZero,While[And@@((#==z)&/@coef),
		       							coef=RandomElements[R,deg+1,SelectFrom->Any]],coef]
	       ];
	(*coef = coef //.{{cc__,Zero[R]}->{cc}};*)
	coef = If[dir===RightToLeft,coef,Reverse[coef]];
	Poly[R, Sequence@@coef, Indeterminate -> ind,
		PowersIncrease -> dir]] 
		
(* above was changed by Ken on 9/8/99 *) *)
      
RandomElements[RingExtension[PolyRing,R_,{},t_], deg_Integer?Positive, 
	k_Integer?Positive, opts___?OptionQ]:= Module[{rep, done, its=0, tab, ok=True},
rep=Replacement/.Flatten[{opts, Options[RandomElements]}];
tab = Table[RandomElement[RingExtension[PolyRing,R,{},t], deg, opts], {k}];
If[rep, tab,
	tab = UnionNoSort[tab];
	done = Length[tab]==k;
	While[Not[done],
		tab = Table[RandomElement[RingExtension[PolyRing,R,{},t], deg, opts], {2k}];
		tab = UnionNoSort[tab];
		If[Length[tab] >= k, 
			done = ok = True;
			tab = Take[tab,k],
			done = its++ > 6;
			ok = False]];
	If[done && ok, tab, Message[RandomElements::toomanyk,k];$Failed]
	]]

RandomElement[RingExtension[FuncRing,R_,{},t_], opts___?OptionQ]:=
	Module[{sel = SelectBaseElementsFrom/.Flatten[{opts, Options[RandomElement]}]},
		RandomElements[R, Length[Elements[R]], SelectFrom->sel]//
        (Func@@#)&]

RandomElements[RingExtension[FuncRing,R_,{},t_], k_Integer?Positive, opts___?OptionQ]:=
	Module[{sel = SelectFrom/.Flatten[{opts, Options[RandomElements]}]},
		Table[RandomElements[R, Length[Elements[R]], SelectFrom->sel]//
        (Func@@#)&,{k}]]


(* ::Subsection::Closed:: *)
(*Misc*)


EvaluationInExtension[E_?RingoidQ, poly[{R_,d_,z_,boo_}, {a_}], 
	poly[{R_,d_,z_,boo_},{c__}]] := poly[{R,d,z,boo}, {a}]

EvaluationInExtension[E_?RingoidQ, poly[{R_,d_,z_,boo_}, {a_,b__}],
	poly[{R_,d_,z_,boo_}, {c__}]]:=
	Addition[E][poly[{R,d,z,boo}, {a}],
		Multiplication[E][EvaluationInExtension[E, poly[{R,d,z,boo}, {b}],
		poly[{R,d,z,boo},{c}]],poly[{R,d,z,boo},{c}]]]
		
EvaluationInExtension[E_?RingoidQ, poly[{R_,d_,z_,boo_}, {a_,b__}],
	polys_List]:= Map[EvaluationInExtension[E, poly[{R,d,z,boo},{a,b}],#]&, polys]


(* ::Section:: *)
(* 80. Code from Algebra`FiniteFields*)


(* ***************** Find Irreducible Polynomial ***************** *)

(* Find an irreducible polynomial modulo p to generate the finite 
   field of p^n elements.  Ideally we will have an irreducible 
   polynomial so that {0,1} is a primitive element.

   'x' is the symbol in which the polynomial is expressed
   'p' is the characteristic of the field
   'degree' is the degree of the polynomial and so the extension *)
   
IrreduciblePolynomial[x_Symbol, p_Integer?PrimeQ, 1] := x;

IrreduciblePolynomial[
    x_Symbol, 
    p_Integer?PrimeQ, 
    degree_Integer?Positive] :=
Module[{irred},
    irred = OneIrreducible[x,p,degree];
    TransformIrreducible[ irred, findprim[irred,p], p]
]

(* the following two lines added by Al Hibbard July 6, 1998 *)
IrreduciblePolynomial[x_Symbol, p_, degree_] :=
(Message[IrreduciblePolynomial::badindex, p, degree]; $Failed)

(*  OneIrreducible looks for a polynomial which is irreducible mod p
    by a brute force search.  Since the density of such polynomials 
    is reasonably high, the method is not too bad.  The old method,
    factoring a large cyclotomic polynomial, was ok for small fields.
    But when the number of elements in the field grew larger than 
    about 1000, it took too much time and space to factor the 
    polynomial.*)

OneIrreducible[
    x_Symbol, 
    p_Integer?PrimeQ,
    degree_Integer?Positive] :=
Module[{dottbl,i},
    dottbl = x^Range[0,degree-1];
    i = (p^(degree-1));
    While[
        Head[
            Factor[x^degree + dottbl . IntegerDigits[i,p],Modulus->p]
        ] =!= Plus,
        i++
    ];
    x^degree + dottbl . IntegerDigits[i,p]
]

(*  Here we assume we have a monic irreducible polynomial 'irred' 
    and a polynomial 'prim' which is a primitive field element with 
    respect to irred.  To simplify the discussion, let us assume that
    the polynomials are both in x.We are looking for an irreducible 
    polynomial which has x as a primitive element.  So, we want an 
    automorphism of the field which maps the prim to x.  An 
    automorphism of the field is a multiplication-preserving linear 
    transformation of the vector space.  First, we find the linear 
    transformation, then we use it to find the new irreducible.  
    Since prim is primitive, {1,prim,...,prim^(degree-1)} is a basis 
    for the vector space.  The transformation mapping {1,prim,...} to 
    {1,x,...} is given by the inverse of the matrix which maps 
    {1,x,...} to {1,prim,...}.  It is somewhat more natural in 
    Mathematica to work with the transposes of the conventional 
    transformation matrices.Once we have the transformation, we use
    it to find the image of prim^degree.  The irreducible 
    polynomial we want is then just x^degree - image[prim^degree].*)

TransformIrreducible[ irred_, prim_, char_ ] :=
Module[{sym,deg,mat},
    sym = First[Variables[irred]];
    deg = Exponent[irred,sym];
    mat =
        Map[
            Drop[CoefficientList[sym^(deg) + #,sym],-1]&,
            NestList[PolynomialMod[prim #, {irred,char}]&, 1, deg]
        ];
    sym^deg +
        (Mod[-(Last[mat] . Inverse[Drop[mat,-1],Modulus->char]),char] .
        Map[(sym^#)&,Range[0,deg-1]])
]

findprim[ gen_ /; FreeQ[gen,Power], chr_Integer ] := PrimitiveRoot[chr]

findprim[ gen_, chr_Integer ] :=
Module[{deg, mp2, pws, sym, vecs, target, poly},
    sym = Variables[gen][[1]];
    deg = Exponent[gen,sym];
    target = (chr^deg-1)/(chr-1);
    mp2 = Floor[N[Log[2,target]]];
    vecs = Map[
	(Reverse[Drop[IntegerDigits[# + 2^mp2,2],1]])&,
	Map[(target/#[[1]])&,FactorInteger[target]]
    ];
    poly = sym;
    While[
	(
	pws = NestList[PolynomialMod[(# #),{gen,chr}]&,poly,mp2-1];
	Or @@ Map[
	    (Head[
		PolynomialMod[Inner[Power,pws,#,Times], {gen, chr}]
	    ] === Integer)&,
	    vecs
	]),
	poly = Reverse[IntegerDigits[1+(poly/.sym->chr),chr]];
	poly = poly . Map[(sym^#)&,Range[0,Length[poly]-1]];
    ];
    poly
]

(* A primitive element of a field is one whose powers include all 
   elements of the field except 0. PowerList finds a 
   primitive element, then returns a list with the identity first, 
   the primitive element next, and successive powers of the primitive
   element following. The elements of the list are only the data part 
   of the field elements, without all the field information in the 
   head. *)


(* ::Section:: *)
(* 81. Our functions for finite fields*)


RingoidQ[R_] := (Head[R]===Ringoid || 
	Head[R]===ringoid) && 
	Head[First[R]]===List

RingoidQ[many:{_ringoid..}] := 
	Map[RingoidQ,many]

RingoidQ[many:{_?RingoidQ..}] := Map[RingoidQ,many]

GroupoidQ[G_] := (Head[G]===Groupoid || 
	Head[G]===groupoid) && 
	Head[First[G]]===List

Unprotect[GF];

Options[GF] = {Indeterminate -> Global`x, Mode -> Computational};

GF[n_Integer?Positive, opts___?OptionQ] := Module[{nok, fi, p, d,
	ind = Indeterminate/.Flatten[{opts, Options[GF]}],
	mode = Mode/.Flatten[{opts, Options[GF]}]},
	nok = Length[fi = FactorInteger[n]]==1 && PrimeQ[fi[[1,1]]];
	If[nok,
		{{p,d}} = fi;
		If[mode === Textual, GFTextual[p, d, ind]];
		GF[p, d, opts],
		Message[GF::badindex, n]; $Failed]]

GF[p_?PrimeQ, d_Integer?Positive, opts___?OptionQ] := Module[{
		ind = Indeterminate/.Flatten[{opts, Options[GF]}],
		mode = Mode/.Flatten[{opts, Options[GF]}]},
	If[mode === Textual, GFTextual[p, d, ind]];
	GFWork[p, d, IrreduciblePolynomial[ind, p, d]]]
	
GFWork[p_?PrimeQ, d_Integer?Positive, ipoly_] := GFWork[p, d, ipoly] = 
		Module[{pok, els, var},
	{var} = Variables[ipoly]; 
	els = Adjoin[Z[p, Structure -> Ring], var, d-1];
	FormRingoid[els, PolynomialMod[ #1 + #2, p]&, 
		PolynomialMod[PolynomialRemainder[#1 * #2,ipoly,
		var], p]&, {"+","*"},  WideElements -> True, 
		RingoidName -> "GF["<>ToString[p^d]<>"]", IsARing -> True,
		ExtraInformation ->
			{{True},{0, 1},{},{},
			{primeUsed -> p, degreeOfExtension -> d, irredPoly -> ipoly}}]]

GFTextual[p_,d_, ind_] := Print["Up to isomorphism, there is one
and only one finite field for each prime power p^d. In this case,
with the prime being "<>ToString[p]<>" and the power being "<>
ToString[d]<>", we have "<>ToString[p^d]<>" elements. For some
irreducible polynomial f("<>ToString[ind]<>") of degree "<>
ToString[d]<>", the elements
in this field are represented as coset representatives in the
quotient ring Z["<>ToString[p]<>"]["<>ToString[ind]<>"]/<f("<>
ToString[ind]<>")>, all of whose elements
are of degree "<>ToString[d-1]<>" or lower. The operations are
ordinary addition and multiplication of these elements, modulo the
given polynomial. Alternative methods of arithmetic may be found
by using the MultiplicativeToAdditive or AdditiveToMultiplicative
functions (or TableOfPowers function)."]

PolyQ[p_] := Head[p] === poly

GF[n_Integer?Positive, ipoly_?PolyQ, opts___?OptionQ] := 
Module[{nok, fi, p, d},
	nok = Length[fi = FactorInteger[n]]==1 && PrimeQ[fi[[1,1]]];
	If[nok,
		{{p,d}} = fi;
		GF[p, d, ipoly, opts],
		Message[GF::badindex, n]; $Failed]]
		
GF[p_?PrimeQ, d_Integer?Positive, ipoly_?PolyQ, opts___?OptionQ] := 
	If[BaseRing[ipoly]===Z[p, Structure -> Ring],
		GF[p, d, ToOrdinaryPolynomial[ipoly], opts],
		Message[GF::bases, ipoly, RingoidName[BaseRing[ipoly]], p];
		$Failed]

GF[n_Integer?Positive, ipoly_, opts___?OptionQ] := 
Module[{nok, fi, p, d},
	nok = Length[fi = FactorInteger[n]]==1 && PrimeQ[fi[[1,1]]];
	If[nok,
		{{p,d}} = fi;
		GF[p, d, ipoly, opts],
		Message[GF::badindex, n]; $Failed]]
		
testPoly[p_, d_, var_, ipoly_] :=
	If[PolynomialQ[If[Head[ipoly]===
		poly,
			ToOrdinaryPolynomial[ipoly],ipoly], var],
		If[IrreduciblePolyOverZpQ[ipoly,p],
			If[Exponent[ipoly, var] == d, True,
				Message[GF::deg, p, d, ipoly, Exponent[ipoly, var]]; 
				False],
			Message[GF::irr, ipoly, p]; False],
		Message[GF::var, ipoly, var]; False]

GF[p_?PrimeQ, d_Integer?Positive, ipoly_, opts___?OptionQ] := 
		Module[{pok, els, var,
			ind = Indeterminate/.Flatten[{opts, Options[GF]}],
			mode = Mode/.Flatten[{opts, Options[GF]}]},
	{var} = Variables[ipoly];
	pok = testPoly[p, d, var, ipoly];
	If[pok, 
		If[mode === Textual, GFTextual[p, d, ind]];
		GFWork[p, d, ipoly/.var :> ind], $Failed]]

GF[n_, ___] := (Message[GF::badindex, n]; $Failed)

IrreduciblePolyOverZpQ[ipoly_?PolyQ, p_?PrimeQ] := 
	If[BaseRing[ipoly]===Z[p, Structure -> Ring],
		IrreduciblePolyOverZpQ[ToOrdinaryPolynomial[ipoly], p],
		Message[GF::bases, ipoly, RingoidName[BaseRing[ipoly]], p]; 
		$Failed]

IrreduciblePolyOverZpQ[polynom_, p_?PrimeQ] := 
	ModpIrreducibilityQ[p,polynom]

IrreduciblePolyOverZpQ[polynom_, p_] := 
	(Message[IrreduciblePolyOverZpQ::prime, p]; $Failed)
					
PrimitivePolynomials[R_?RingoidQ] := 
Module[{n = Length[Elements[R]] -1, G, ords},
	G = NonZeroMGroupoid[R];
	ords = Map[{#, orderOfElement[G,#]}&, Elements[G]];
	Select[ords, #[[2]]==n&]/.{p_, n} :> p]

TableOfPowers[$Failed] := $Failed

TableOfPowers[R_?RingoidQ] := TableOfPowers[R] = 
Module[{n, prim, p, MG},
		n = Length[Elements[R]];
		MG = NonZeroMGroupoid[R];
		prim = First[PrimitivePolynomials[R]];
		Join[{{0,0}}, Table[{prim^k, ElementToPower[MG, prim, k]},
			{k,1,n-2}], {{1,1}}]]
		
GFInd[R_] := Module[{fourth, var},
	fourth = R[[4]];
	{var} = (irredPoly /. 
		fourth[[5]])//Variables;
	var]
	
MultiplicativeToAdditive[R_?RingoidQ, form_] := Module[{top = 
	TableOfPowers[R], pos, ind, pow, ok = True, nform = form},
If[Head[form] === Power, 
	{ind, pow} = List @@ form;
	If[ind =!= GFInd[R], 
		ok = False,
		nform = Power[ind, Mod[pow,Size[R]]]]];
If[ok,
	pos = Position[top//Transpose//First,nform,1];
	If[Length[pos] > 1, $Failed,
		top[[pos[[1,1]]]]//Last],
	Message[GF::var,form,GFInd[R]];$Failed]]
	
AdditiveToMultiplicative[R_?RingoidQ, form_] := Module[{top = 
	TableOfPowers[R], pos},
pos = Position[top//Transpose//Last,form,1];
If[Length[pos] > 1, $Failed,
	top[[pos[[1,1]]]]//First]]

orderOfElement[G_?GroupoidQ, g_] := orderOfElement[G, g] = 
Module[{id, ord},
	If[Not[ElementQ[g,G]],
		Message[MemberQ::elmnt, g, GroupoidName[G]];$Failed,
		If[ClosedQAndIdentityQ[G],
			id = GroupIdentity[G];
			ord=Length[Elements[G]];
			If[g===id, 1,
				Length[FixedPointList[Operation[G][g,#]&,g,ord,
 					SameTest ->((#2===id)&)]]//If[#==ord+1,$Failed,#]&], 
 					$Failed]]]

FieldIrreducible[R_?RingoidQ] := 
	irredPoly /. R[[4,5]]

PowerList[args__] := TableOfPowers[args]

ExtensionDegree[R_?RingoidQ] := 
	degreeOfExtension /. R[[4,5]]
	
SetAttributes[FieldIrreducible, HoldFirst];

GaloisFieldQ[R_?RingoidQ] := PrimeQ[primeUsed /. R[[4,5]]]

SetAttributes[BaseRing, HoldFirst];

BaseRing[R_?RingoidQ] := 
	Z[primeUsed /. R[[4,5]], Structure -> Ring]
	
Protect[GF];


(* ::Section:: *)
(* 85. MatricesOver RingExtension*)


(* ::Subsection::Closed:: *)
(*General*)


RingoidQ[R_] := (Head[R]===Ringoid || Head[R]===ringoid) && 
	Head[First[R]]===List

RingoidQ[many:{_ringoid..}] := Map[RingoidQ,many]

RingoidQ[many:{_?RingoidQ..}] := Map[RingoidQ,many]

GroupoidQ[G_] := (Head[G]===Groupoid || Head[G]===groupoid) && 
	Head[First[G]]===List

StructuredSetQ[S_] := GroupoidQ[S] || RingoidQ[S]

StructuredSetQ[S_List] := Map[StructuredSetQ,S]


(* ::Subsection:: *)
(*Creation*)


Format[RingExtension[Matrices,R_,{m_, n_},t_, All,_]] := 
SequenceForm["-",Subscripted["Mat"["("<>ToString[m]<>","<>ToString[n]<>")"]],
	"("<>RingoidName[R]<>")-"]

Format[RingExtension[Matrices,R_,{n_, n_},t_, All,_]] := 
SequenceForm["-",Subscripted["Mat"[ToString[n]]],"("<>RingoidName[R]<>")-"]

Format[RingExtension[Matrices,R_,{n_, n_},t_, GL,_]] := 
SequenceForm["-",Subscripted["GL"[ToString[n]]],"("<>RingoidName[R]<>")-"]

Format[RingExtension[Matrices,R_,{n_, n_},t_, SL,_]] := 
SequenceForm["-",Subscripted["SL"[ToString[n]]],"("<>RingoidName[R]<>")-"]

Format[RingExtension[Matrices,R_,{n_, n_},t_, Diag,_]] := 
SequenceForm["-",Subscripted["Diag"[ToString[n]]],"("<>RingoidName[R]<>")-"]

Format[RingExtension[Matrices,R_,{n_, n_},t_, UT,_]] := 
SequenceForm["-",Subscripted["UT"[ToString[n]]],"("<>RingoidName[R]<>")-"]

Format[RingExtension[Matrices,R_,{n_, n_},t_, LT,_]] := 
SequenceForm["-",Subscripted["LT"[ToString[n]]],"("<>RingoidName[R]<>")-"]

Format[RingExtension[Matrices,R_,{n_, n_},t_, UTD,_]] := 
SequenceForm["-",Subscripted["UTD"[ToString[n]]],"("<>RingoidName[R]<>")-"]

Format[RingExtension[Matrices,R_,{n_, n_},t_, LTD,_]] := 
SequenceForm["-",Subscripted["LTD"[ToString[n]]],"("<>RingoidName[R]<>")-"]

Unprotect[GL, LT, LTD, SL, UT, UTD, Diag];

MatrixTypes = {All, GL, SL, Diag, UT, UTD, LT, LTD, GenA, GenM};

Options[MatricesOver] = {MatrixType -> All, AnotherTest -> True, Operation ->
	Both};

MatricesOver[R_?RingoidQ, n_Integer?Positive, opts___?OptionQ] := 
	MatricesOver[R, {n,n},opts]

MatricesOver[R_?RingoidQ, {m_Integer?Positive, n_Integer?Positive}, opts___?OptionQ] := 
		Module[{at = AnotherTest/.Flatten[{opts, Options[MatricesOver]}],
		tom = MatrixType/.Flatten[{opts, Options[MatricesOver]}],
		op = Operation/.Flatten[{opts, Options[MatricesOver]}]}, 
	RingExtension[Matrices, R, {m,n}, ((GoodElementsDimensionsQ[#, Elements[R],{m,n}]) &&
	AnotherTest/.Flatten[{opts, Options[MatricesOver]}])& , tom, op]]

TestFunction[RingExtension[Matrices,base_,param_,test_, ___]]:=test

BaseRing[RingExtension[Matrices,base_,param_,test_, ___]]:=base

ExtensionType[RingExtension[Type_,base_,param_,test_, _, _]] := Matrices

Mat[R_?RingoidQ, n_Integer?Positive] := 
	MatricesOver[R, {n,n}, MatrixType -> All, Operation -> Both]
	
Mat[n_Integer?Positive, R_?RingoidQ] := Mat[R, n]

MatM[R_?RingoidQ, n_Integer?Positive] := 
	MatricesOver[R, {n,n}, MatrixType -> All, Operation -> Multiplication]
	
MatM[n_Integer?Positive, R_?RingoidQ] := MatM[R, n]

Mat[R_?RingoidQ, {n_Integer?Positive, n_Integer?Positive}] := 
	MatricesOver[R, {n,n}, MatrixType -> All, Operation -> Both]

Mat[R_?RingoidQ, {m_Integer?Positive, n_Integer?Positive}] := 
	MatricesOver[R, {m,n}, MatrixType -> All, Operation -> Addition]

Mat[{m_Integer?Positive, n_Integer?Positive}, R_?RingoidQ] := Mat[R, {m,n}]
		
MatA[R_?RingoidQ, {m_Integer?Positive, n_Integer?Positive}] := 
	MatricesOver[R, {m,n}, MatrixType -> All, Operation -> Addition]

MatA[{m_Integer?Positive, n_Integer?Positive}, R_?RingoidQ] := MatA[R, {m,n}]

GL[R_?RingoidQ, n_Integer?Positive] := 
	MatricesOver[R, {n,n}, MatrixType -> GL, AnotherTest -> GLQ[R,#],
	Operation -> Multiplication]

GL[n_Integer?Positive, R_?RingoidQ] := GL[R,n]

GL[n_Integer?Positive, k_Integer?Positive] := GL[Z[k, Structure -> Ring],n]

GeneralLinear[args__] := GL[args]

GeneralLinearGroup[args__] := GL[args]

SL[R_?RingoidQ, n_Integer?Positive] := 
	MatricesOver[R, {n,n}, MatrixType -> SL, AnotherTest -> SLQ[R,#],
	Operation -> Multiplication]

SL[n_Integer?Positive, R_?RingoidQ] := SL[R,n]

SL[n_Integer?Positive, k_Integer?Positive] := SL[Z[k, Structure -> Ring],n]

SpecialLinear[args__] := SL[args]

SpecialLinearGroup[args__] := SL[args]

Diag[R_?RingoidQ, n_Integer?Positive] := 
	MatricesOver[R, {n,n}, MatrixType -> Diag, AnotherTest -> DiagQ[R,#], 
	Operation -> Multiplication]

Diag[n_Integer?Positive, R_?RingoidQ] := Diag[R,n]

DiagonalMatrices[args__] := Diag[args]

UT[R_?RingoidQ, n_Integer?Positive] := 
	MatricesOver[R, {n,n}, MatrixType -> UT, AnotherTest -> UTQ[R,#], 
	Operation -> Addition]

UT[n_Integer?Positive, R_?RingoidQ] := UT[R,n]

LT[R_?RingoidQ, n_Integer?Positive] := 
	MatricesOver[R, {n,n}, MatrixType -> LT, AnotherTest -> LTQ[R,#],
	Operation -> Addition]

LT[n_Integer?Positive, R_?RingoidQ] := LT[R,n]

UTD[R_?RingoidQ, n_Integer?Positive] := 
	MatricesOver[R, {n,n}, MatrixType -> UTD, AnotherTest -> UTDQ[R,#]]

UTD[n_Integer?Positive, R_?RingoidQ] := UTD[R,n]

LTD[R_?RingoidQ, n_Integer?Positive] := 
	MatricesOver[R, {n,n}, MatrixType -> LTD, AnotherTest -> LTDQ[R,#]]

LTD[n_Integer?Positive, R_?RingoidQ] := LTD[R,n]

Protect[GL, LT, LTD, SL, UT, UTD, Diag];



(* ::Subsection:: *)
(*Tests for types*)


GoodElementsDimensionsQ[A_List, els_, {m_,n_}] := 
	MatrixQ[A, MemberQ[els,#]&] && Take[Dimensions[A],2]==={m,n}

DiagQ[R_?RingoidQ, A_?squareQ] := 
	Union[LowerTriangleElements[A], UpperTriangleElements[A]] === {Zero[R]} &&
	GLQ[R, A]

UTQ[R_?RingoidQ, A_?squareQ] := Union[LowerTriangleElements[A], 
	DiagonalElements[A]] === {Zero[R]}

UTDQ[R_?RingoidQ, A_?squareQ] := LowerTriangleElements[A] === {Zero[R]} &&
	GLQ[R, A]

LTQ[R_?RingoidQ, A_?squareQ] := Union[UpperTriangleElements[A], 
	DiagonalElements[A]] === {Zero[R]}

LTDQ[R_?RingoidQ, A_?squareQ] := UpperTriangleElements[A] === {Zero[R]} &&
	GLQ[R, A]

GLQ[R_?RingoidQ, A_?squareQ] := UnitQ[R,Det[R, A]]

SLQ[R_?RingoidQ, A_?squareQ] := Det[R, A] == Unity[R]


(* ::Subsection:: *)
(*Operations on matrices and extensions*)


SizeOfMatrices[RingExtension[Matrices,R_,{m_, n_},test_, tom_, 
	op_]] := {m,n}
	
MatrixOperation[RingExtension[Matrices,R_,{m_, n_},test_, tom_, 
	op_]] := op

Addition[RingExtension[Matrices,R_,{m_, n_},test_, tom_, op_]] := 
	If[test[#1] && test[#2],
		Block[{m1 = Flatten[#1,1], m2 = Flatten[#2,1]},
			MapThread[(Addition[R][#1,#2])&,{m1,m2}]//Partition[#,n]&],
		Message[MemberQ::elmnts, {#1, #2},"the ring of matrices"]; 
		$Failed]&

Addition[RingExtension[Matrices,R_,{m_, n_},test_, tom_, op_], 
	A_List, B_List] := 
	Addition[RingExtension[Matrices,R,{m,n},test,tom, op]][A, B]
	
Addition[R_?StructuredSetQ, A_?MatrixQ, B_?MatrixQ] := 
	Addition[MatricesOver[R, Take[Dimensions[A],2]]][A, B]

Multiplication[RingExtension[Matrices,R_,{n_, n_},test_, tom_, 
		op_]]:=
	If[test[#1] && test[#2],
  	Block[{a = #1, b = Transpose[#2],j,k},
    	Table[Dot[R,a[[j]],b[[k]]],{j,1,n},{k,1,n}]],
		Message[MemberQ::elmnts, {#1, #2},"the ring of matrices"]; 
		$Failed]&

Multiplication[RingExtension[Matrices,R_,{n_, n_},test_, tom_,
		op_], A_List, B_List] := 
	Multiplication[RingExtension[Matrices,R,{n,n},test,tom, op]][A, B]
	
Multiplication[RingExtension[Matrices,R_,{m_, n_},test_, tom_, op_], 
	A_List, B_List] := Multiplication[R, A, B]
	
Multiplication[RingExtension[Matrices,R_,{m_, n_},test_, tom_, op_]]:=
	Multiplication[R, A, B]

Multiplication[R_?StructuredSetQ, A_?MatrixQ, B_?MatrixQ]:= Module[{dimok, elsok, a = A, 
		b = Transpose[B], dim1, dim2, j,k, ra,ca,rb, cb},
	dimok = Length[dim1 = Take[Dimensions[A],2]]==2 && 
		Length[dim2 = Take[Dimensions[B],2]] ==2 &&
		(rb=First[dim2]) === (ca=Last[dim1]);
	elsok = ElementsQ[Union[Flatten[Join[A,B]]],R];
	If[dimok,
		If[elsok,
    	Table[Dot[R,a[[j]],b[[k]]],{j,1,First[dim1]},{k,1,Last[dim2]}],
			Message[MemberQ::elmnts, {A, B},"the ring of matrices"]; $Failed],
		Message[Multiplication::fail,First[dim1],ca,rb,Last[dim2]]; $Failed]]

Unprotect[MatrixPower, IdentityMatrix];

RingExtension /: IdentityMatrix[RingExtension[Matrices,R_,{n_Integer?Positive, n_Integer?Positive},
		t_, tom_, op_]] := 
	Unity[RingExtension[Matrices,R,{n,n},t,tom, op]] 
	
RingExtension /: IdentityMatrix[RingExtension[Matrices,R_,{m_Integer?Positive, n_Integer?Positive},
		t_, tom_, op_]] := 
	(Message[Identity::nonsquare]; $Failed)
	
ringoid /: 
	IdentityMatrix[R_ringoid, n_Integer?Positive] := 
	Unity[MatricesOver[R,{n,n}]]  
	
RingExtension /: MatrixPower[RingExtension[Matrices,R_,{n_, n_},t_, 
tom_, op_], A_List, 0] := 
	IdentityMatrix[RingExtension[Matrices,R,{n,n},t,tom, op]]
	
ringoid /: 
MatrixPower[R_ringoid, 
	A_?squareQ, 0] := 
	IdentityMatrix[R,First[Dimensions[A]]]
	
RingExtension /: MatrixPower[RingExtension[Matrices,R_,{n_, n_},t_, tom_, op_], 
	A_List, 1] := A
	
ringoid /: 
MatrixPower[R_ringoid, A_?squareQ, 1] := A
	
ringoid /:
MatrixPower[R_ringoid, A_?squareQ,
	k_Integer?Positive] :=
	Fold[Multiplication[R,#1, #2]&, A, Table[A, {k-1}]]
	
ringoid /: 
MatrixPower[R_ringoid, 
	A_?squareQ, k_Integer?Negative] :=
	Module[{n = First[Dimensions[A]], B},
		B = MultiplicativeInverse[MatricesOver[R,Take[Dimensions[A],2]], A];
		Fold[Multiplication[R,#1, #2]&, B, Table[B, {Abs[k]-1}]]]
		
RingExtension /: MatrixPower[RingExtension[Matrices,R_,{n_, n_},t_, tom_, op_], 
	A_List, -1] := 
	MultiplicativeInverse[RingExtension[Matrices,R,{n,n},t,tom, op], A]
	
ringoid /: 
MatrixPower[R_ringoid, A_?squareQ, -1] := 
	MultiplicativeInverse[MatricesOver[R,Take[Dimensions[A],2]], A]

RingExtension /: MatrixPower[RingExtension[Matrices,R_,{n_, n_},t_, tom_, op_], A_List, 
k_Integer] :=
	If[k < 0,
		Module[{B = MultiplicativeInverse[RingExtension[Matrices,R,{n,n},t,tom, op], A]},
			Fold[Multiplication[RingExtension[Matrices,R,{n,n},t,tom, op]], B, Table[B, {Abs[k]-1}]]],
	If[k > 0,
		Fold[Multiplication[RingExtension[Matrices,R,{n, n},t,tom, op]], A, 
			Table[A, {k-1}]]]]

Protect[MatrixPower,IdentityMatrix];

HasZeroQ[RingExtension[Matrices,R_,{m_, n_},test_, tom_, op_]] := HasZeroQ[R]

Zero[RingExtension[Matrices,R_,{m_, n_},test_, tom_, op_]] := 
	If[HasZeroQ[R], 
		Table[Zero[R],{m},{n}],
		Message[RingExtension::NoZero]; $Failed]

WithUnityQ[RingExtension[Matrices,R_,{n_,n_},test_, tom_, op_]] := 
	HasZeroQ[R] && WithUnityQ[R]

Unity[RingExtension[Matrices,R_,{n_, n_},test_, tom_, op_]] := 
		Unity[RingExtension[Matrices,R,{n,n},test,tom, op]] =
	If[HasZeroQ[R] && WithUnityQ[R],
		IdentityMatrix[n]/.{0->Zero[R],1->Unity[R]},
		Message[RingExtension::NoUnity]; $Failed]

HasNegativeQ[RingExtension[Matrices,R_,{m_, n_},test_, tom_, op_], A_] /; test[A] :=
	Module[{ng = Apply[And,Map[HasNegativeQ[R,#]&,Flatten[A,1]]]},
		If[ng===True, True,False]]

(* HasNegativeQ[R_?RingoidQ, A_?MatrixQ] :=
	HasNegativeQ[MatricesOver[R,Take[Dimensions[A],2]],A]
Added ?MatrixQ on 7/15/04 *)

NegationOf[RingExtension[Matrices,R_,{m_, n_},test_, tom_, op_], A_] :=
	If[HasNegativeQ[RingExtension[Matrices,R,{m,n},test,tom, op],A], Map[NegationOf[R,#]&,A,{2}],
		Message[RingExtension::NoNegat];$Failed]

(* NegationOf[R_?RingoidQ, A_?MatrixQ] :=
	NegationOf[MatricesOver[R,Take[Dimensions[A],2]],A]
Added ?MatrixQ on 7/15/04 

commented out 11/26/08  - let ordinary ringoid call handle this *)

UnitQ[RingExtension[Matrices,R_,{n_,n_},t_, tom_, op_], A_] := 
		UnitQ[RingExtension[Matrices,R,{nn},t,tom, op], A] =
	If[t[A],UnitQ[R, Det[RingExtension[Matrices,R,{n,n},t,tom, op],A]],
		Message[MemberQ::elmnt, A,"the extension ring"]; False]

UnitQ[R_?RingoidQ, A_?squareQ] := UnitQ[R, A] =
	UnitQ[MatricesOver[R,Take[Dimensions[A],2]],A]
	
MultiplicativeInverse[RingExtension[Matrices, R_,  {n_,n_},  t_, tom_, op_], A_?squareQ] := 
	If[(Take[Dimensions[A],2]==={n,n}) && UnitQ[RingExtension[Matrices,R,{n,n},t,tom, op], A], 
		Block[{ B,  f,  i, j,  a,  b,  RT},
		Off[ExtendedGCD::egcd];
			B =(Inverse[Array[ f, { n,  n}]]) /. 
				{Power[a__,-1]:>MultiplicativeInverse[RT, a]} /.
				{-(( a_)*( b___)) :> NegationOf[RT, a]* b} /. 
				{( a_)*( b__) :> Fold[Multiplication[RT][#1,#2]&,a,{b}]} /. 
				{( a_) + ( b__) :> Fold[Addition[ RT][#1, #2] & ,  a,{b}]};
		On[ExtendedGCD::egcd];
      B /. { f[ i_,  j_] :> A[[ i, j]]} /. { RT ->  R}], 
	Message[Inverse::fail,A,"this extension ring"];$Failed];   
       
MultiplicativeInverse[R_?RingoidQ, A_?squareQ] := 
	MultiplicativeInverse[MatricesOver[R,Take[Dimensions[A],2]],A]
	
Unprotect[Inverse];

ringoid /: 
	Inverse[R_ringoid, A_?squareQ] := 
	MultiplicativeInverse[MatricesOver[R,Take[Dimensions[A],2]],A]

Protect[Inverse];

ZeroDivisorQ[RingExtension[Matrices,R_,{n_,n_},t_, tom_, op_], A_]:=
	If[t[A], Not[UnitQ[R, Det[RingExtension[Matrices,R,{n,n},t,tom, op],A]]] &&
			(A =!= Zero[RingExtension[Matrices,R,n,t,tom, op]]),
		Message[MemberQ::elmnt, A,"the extension ring"]; False]
		



(* ::Section:: *)
(* 86. Dot/Det*)


Unprotect[Dot, Det];

ringoid /: Dot[R_ringoid,
	 A_List, B_List]:=
	If[Length[A]===Length[B] && Length[Dimensions[A]]==1,
		MapThread[Multiplication[R],{A,B},1]//Fold[Addition[R],
			First[#],Rest[#]]&,
		Message[Dot::DimErr]; $Failed]

negationOf[R_?RingoidQ, r_] := negationOf[R,r] = 
	If[ElementQ[r,R],
		GroupInverse[FormGroupoid[Elements[R], R[[2]]],r]]

ZQn[R_?StructuredSetQ] := ZRingoidQn[R]
		
squareQ[A_List] := Equal@@Take[Dimensions[A],2]

ringoid /: 
	Det[R_ringoid, A_?squareQ]:=
	Module[{F,f,i,j,a,b,RT,m,n,zq,index},
		{m,n} = Take[Dimensions[A],2];
		{zq, index} = ZQn[R];
		If[zq, Mod[Det[A],index],
			If[m == n && CommutativeQ[R],
				F=((Det[Array[f,{n,n}]]/.{Times[-1,a_,b___]:>
					Times[negationOf[RT,a],b]})/.
						{Times[a_,b__]:>Fold[(Multiplication[RT][#1,#2])&,a,{b}]})/.
						{Plus[a_,b__]:>Fold[(Addition[RT][#1,#2])&,a,{b}]};
				F/.{f[i_,j_]:>A[[i,j]]}/.{RT->R}]]]

RingExtension /: Det[RingExtension[Matrices,R_,
	{n_,n_},t_, tom_, op_], A_]:=
	If[Take[Dimensions[A],2]=={n,n}, Det[R, A]]

Protect[Dot, Det];



(* ::Section:: *)
(* 87. Working with elements of extensions*)


(* ::Subsection::Closed:: *)
(*extracting parts of a matrix*)


LowerTriangleElements[A_?squareQ] := Module[{n = Length[A]},
	Flatten[Table[Take[A[[i]], {1, i-1}], {i, 2, n}],1]//Union]
	
UpperTriangleElements[A_?squareQ] := Module[{n = Length[A]},
	Flatten[Table[Take[A[[i]], {i+1, n}], {i, 1, n-1}],1]//Union]
	
DiagonalElements[A_?squareQ] := Module[{n = Length[A]},
	Flatten[Table[A[[i,i]], {i, n}],1]//Union]	


(* ::Subsection:: *)
(*Random matrices*)


RandomElement[RingExtension[Matrices,R_,{n_,n_},t_, tom_, op_]]:=
	RandomMatrix[R, n, MatrixType -> tom]

RandomElement[RingExtension[Matrices,R_,{m_,n_},t_, tom_, op_], opts___?OptionQ]:=
	Module[{sel = SelectBaseElementsFrom/.Flatten[{opts, Options[RandomElement]}],
		randels},
	randels = RandomElements[R, m*n, SelectFrom->sel];
	If[randels =!= $Failed, Partition[randels,n], $Failed]]

RandomElements[RingExtension[Matrices,R_,{m_,n_},t_, tom_, op_], k_Integer?Positive, 
		opts___?OptionQ]:=
	Module[{sel = SelectBaseElementsFrom/.Flatten[{opts, Options[RandomElements]}]},
		Table[RandomElement[RingExtension[Matrices,R,{m,n},t, tom, op], opts],{k}]]

RandomMatrix[R_?RingoidQ, n_Integer] := RandomMatrix[R,n,MatrixType -> All]

RandomMatrix[R_?RingoidQ, n_Integer, MatrixType -> type_] := 
	Switch[type,
		All, RandomAll[R,n],
		GL, RandomGL[R,n],
		SL, RandomSL[R,n],
		Diag, RandomDiag[R,n],
		UTD, RandomUTDiag[R,n],
		LTD, RandomLTDiag[R,n],
		UT, RandomUT[R,n],
		LT, RandomLT[R,n],
		_, Message[Random::notype, type];$Failed]

RandomGL[R_?RingoidQ,n_Integer] := Module[{els = Elements[R], A, 
		toomany = False, count = 0},
	A = RandomElements[els, n^2]//Partition[#, n]&;
	count++;
	While[Not[GLQ[R, A]] && Not[toomany],
		A = RandomElements[els, n^2]//Partition[#, n]&;
		count++;
		toomany = count > 500];
	If[toomany, Message[Random::toomany];$Failed, A]]
	
RandomSL[R_?RingoidQ,n_Integer] := Module[{A, det},
	A = RandomGL[R,n];
	If[Not[SLQ[R, A]],
		det = Det[R,A];
		A = MapAt[Multiplication[R][MultiplicativeInverse[R,det],
			#]&, A, Table[{1,k},{k,Length[A]}]]];
	A]

RandomDiag[R_?RingoidQ,n_Integer] := 
		Module[{toomany = False, count = 0, A, zero = Zero[R]},
	A = Table[Join[Table[zero,{i-1}],{RandomElement[Units[R]]}, 
		Table[zero,{j,i+1,n}]],{i,n}];
	count++;
	While[Not[GLQ[R, A]] && Not[toomany],
		A = Table[Join[Table[zero,{i-1}],{RandomElement[Units[R]]}, 
			Table[zero,{j,i+1,n}]],{i,n}];
		count++;
		toomany = count > 500];
	If[toomany, Message[Random::toomany];$Failed, A]]

RandomUTDiag[R_?RingoidQ,n_Integer] := 
		Module[{A, els = Elements[R],toomany=False, count = 0,
			zero = Zero[R],mat},
	mat := Table[Join[Table[zero,{i-1}],{RandomElement[Units[R]]},
		RandomElements[els, n-i]],{i,n}];
	A = mat;
	count++;
	While[Not[GLQ[R, A]] && Not[toomany],
		A = mat;
		count++;
		toomany = count > 500];
	If[toomany, Message[Random::toomany];$Failed, A]]

RandomLTDiag[R_?RingoidQ,n_Integer] := 
		Module[{A, els = Elements[R], toomany=False, count = 0,
			zero = Zero[R],mat},
	mat := Table[Join[RandomElements[els, i-1],{RandomElement[Units[R]]},
		Table[zero,{n-i}]],{i,n}];
	A = mat;
	count++;
	While[Not[GLQ[R, A]] && Not[toomany],
		A = mat;
		count++;
		toomany = count > 500];
	If[toomany, Message[Random::toomany];$Failed, A]]
	
RandomLT[R_?RingoidQ,n_Integer] := Module[{els = Elements[R], zero = Zero[R]},
	Table[Join[RandomElements[els, i-1], Table[zero,{n-i+1}]],{i,n}]]
		
RandomUT[R_?RingoidQ,n_Integer] := Module[{els = Elements[R],zero = Zero[R]},
	Table[Join[Table[zero,{i}], RandomElements[els, n-i]],{i,n}]]
		
RandomAll[R_?RingoidQ,n_Integer] := 
	Table[RandomElements[R, n],{i,n}]


(* ::Subsection:: *)
(*Size & Elements*)


MakeMatrices[els_List,m_,n_] := MakeMatrices[els, m, n] = Module[{f},
	Map[Partition[#,n]&, Flatten[Outer[f,Sequence@@Table[els,{m * n}]]]]/.f->List
	]
	
Size[RingExtension[Matrices, R_?RingoidQ, {m_,n_}, test_, All,_]] := Size[R]^(m*n)

Size[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, GL,_]] := Module[{q = Size[R]},
	If[FieldQ[R], q^(n (n-1)/2)*Product[q^i - 1, {i, 1, n}], -1 (* not computed *)]]
	
Size[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, SL,_]] := Module[{q = Size[R]},
	If[FieldQ[R], q^(n (n-1)/2)*Product[q^i - 1, {i, 2, n}], -1(* not computed *)]]

Size[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, Diag,_]] := Length[Units[R]]^n

Size[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, UT,_]] := Size[R]^((n-1)n/2)

Size[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, LT,_]] := Size[R]^((n-1)n/2)

Size[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, LTD,_]] := Length[Units[R]]^n *
	Size[R]^((n-1)n/2)
	
Size[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, UTD,_]] := Length[Units[R]]^n *
	Size[R]^((n-1)n/2)

Options[Elements] := {SizeLimit -> 1500}

Elements[RingExtension[Matrices, R_?RingoidQ, {m_,n_}, test_,tom_, op_], opts___?OptionQ] := 
	Elements[RingExtension[Matrices, R, {m,n}, test,tom, op], opts] =
	Module[{size = Size[RingExtension[Matrices, R, {m,n}, test,tom, op]], sl = 
		SizeLimit/.Flatten[{opts, Options[Elements]}]},
	If[size < sl && size > 0,
		Switch[tom, 
			All, MakeMatrices[Elements[R],m,n], 
			GL, Select[MakeMatrices[Elements[R],m,n], GLQ[R,#]&],
			SL, Select[Elements[RingExtension[Matrices,R,{m,n},test,GL,Multiplication]], SLQ[R,#]&],
			Diag, Select[Elements[RingExtension[Matrices,R,{m,n},test,GL,Multiplication]], DiagQ[R,#]&],
			UTD, Select[Elements[RingExtension[Matrices,R,{m,n},test,GL,Multiplication]], UTDQ[R,#]&],
			LTD, Select[Elements[RingExtension[Matrices,R,{m,n},test,GL,Multiplication]], LTDQ[R,#]&],
			LT, Select[MakeMatrices[Elements[R],m,n], LTQ[R,#]&],
			UT, Select[MakeMatrices[Elements[R],m,n], UTQ[R,#]&]
			],
		Message[SizeLimit::toobig]; $Failed]]


(* ::Section::Closed:: *)
(* 88. General Matrix Functionality*)


CommutingMatricesQ[A_?MatrixQ, B_?MatrixQ] := A.B === B.A

CommutingMatricesQ[R_?RingoidQ, A_?MatrixQ, B_?MatrixQ] := Multiplication[R, A, B] === 
	Multiplication[R, B, A]
	
CommutingMatricesQ[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, tom_, op_], A_List, 
	B_List] := If[test[A] && test[B], Multiplication[R, A, B] === 
	Multiplication[R, B, A]]
	
AntiCommutingMatricesQ[A_?MatrixQ, B_?MatrixQ] := A.B === -(B.A)

AntiCommutingMatricesQ[R_?RingoidQ, A_?MatrixQ, B_?MatrixQ] := Multiplication[R, A, B] === 
	NegationOf[R,Multiplication[R, B, A]]
	
AntiCommutingMatricesQ[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, tom_, op_], A_List, 
	B_List] := If[test[A] && test[B], Multiplication[R, A, B] === 
	NegationOf[R,Multiplication[R, B, A]]]
	
MatrixTrace[A_?squareQ] := Sum[A[[i,i]], {i, Length[A]}]

MatrixTrace[R_?RingoidQ, A_?squareQ] := Fold[Addition[R],
			A[[1,1]], Table[A[[i,i]], {i, 2, Length[A]}]]

SymmetricQ[A_?squareQ] := A === Transpose[A]

SymmetricQ[R_?RingoidQ, A_?squareQ] := SymmetricQ[A]

SkewSymmetricQ[A_?squareQ] := A === - Transpose[A]

SkewSymmetricQ[R_?RingoidQ, A_?squareQ] := A === NegationOf[R,Transpose[A]]

Unprotect[Conjugate];

Conjugate[A_?MatrixQ] := Map[Conjugate, A, {2}]

Protect[Conjugate];

MatrixConjugate[A_?MatrixQ] := Map[Conjugate, A, {2}]

MatrixDelete[A_?MatrixQ, {i_Integer?Positive, j_Integer?Positive}] :=
	Module[{k, {m,n} = Take[Dimensions[A],2]},
		Drop[Table[Join[Take[A[[k]], {1, i-1}],Take[A[[k]], {i+1, n}]], 
			{k,m}],{j}]]
			
DetAdjoint[A_?squareQ] := Module[{},
	Table[(-1)^(i+j) Det[Transpose[MatrixDelete[A,{i,j}]]],{i,Length[A]},
		{j, Length[A]}]]

Adjoint[A_?squareQ] := Transpose[MatrixConjugate[A]]

Unprotect[HermitianQ];

HermitianQ[A_?squareQ] := A === Adjoint[A]

Protect[HermitianQ];

SkewHermitianQ[A_?squareQ] := A === -Adjoint[A]

IntegerMatrixQ[A_?MatrixQ] := And@@Flatten[Map[IntegerQ, A, {2}],1]

RationalMatrixQ[A_?MatrixQ] := And@@Flatten[Map[(IntegerQ[#] || Head[#]===Rational)&, 
	A, {2}],1]
	
RealMatrixQ[A_?MatrixQ] := And@@Flatten[Map[(IntegerQ[#] || Head[#]===Real)&, 
	N[A], {2}],1]
	
ComplexMatrixQ[A_?MatrixQ] := And@@Flatten[Map[(Head[#]===Real || 
	IntegerQ[#] || Head[#] === Complex)&, N[A], {2}],1]
	
MatrixOverQ[R_?RingoidQ, A_?MatrixQ] := ElementsQ[Flatten[A,1],R]
	
OrthogonalQ[A_?squareQ] := RealMatrixQ[A] && Transpose[A].A === IdentityMatrix[Length[A]]

OrthogonalQ[R_?RingoidQ, A_?squareQ] :=  MatrixOverQ[R, A] && 
	Multiplication[R,Transpose[A],A] === IdentityMatrix[R,Length[A]]

UnitaryQ[A_?squareQ] := A.Adjoint[A] === IdentityMatrix[Length[A]]


(* ::Section:: *)
(* 90. ToGroupoid/ToRingoid*)


Options[ToRingoid] = {SizeLimit -> 1000};

ToRingoid[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, All, 
	Both], opts___?OptionQ] := 
		Module[{size, G, AG,
			ext = RingExtension[Matrices, R, {n,n}, test, All, Both]},
	If[(size = Size[ext]) < 
			SizeLimit/.Flatten[{opts, Options[Elements]}],
		G = FormRingoid[Elements[ext], Addition[ext][#1,#2]&,
			Multiplication[ext][#1,#2]&, {"+","*"},
			WideElements -> True, 
			RingoidDescription -> ToString[n]<>" by "<>ToString[n]<>
				" matrices over "<>RingoidName[R], 
			RingoidName -> 
				SequenceForm["-",Subscripted["Mat"["("<>ToString[n]<>")"]],
	"("<>RingoidName[R]<>")-"], MaxElementsToList -> 32];
		Unity[G] = IdentityMatrix[R, n];
		WithUnityQ[G] = True;
		AssociativeQ[G] = True;
		DistributiveQ[G] = DistributiveQ[R];
		AG = AGroupoid[G];
		HasIdentityQ[AG] = HasZeroQ[R];
		AssociativeQ[AG] = True;
		inverseFunction[MGroupoid[G]] = 
			MultiplicativeInverse[R, #]&;
		G,
		Message[SizeLimit::toobig]; $Failed]]
		
ToGroupoid[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, All, 
	Multiplication], opts___?OptionQ] := 
		Module[{size,G},
	If[(size = Size[RingExtension[Matrices, R, {n,n}, test, All, Multiplication]]) < 
			SizeLimit/.Flatten[{opts, Options[Elements]}],
		G = FormGroupoid[Elements[RingExtension[Matrices, R, {n,n}, test, All,_]],
			Multiplication[RingExtension[Matrices, R, {n,n}, test, All,Multiplication]][#1,#2]&, "*",
			WideElements -> True, GroupoidDescription -> ToString[n]<>" by "<>ToString[n]<>
			" matrices over "<>RingoidName[R], GroupoidName -> 
			SequenceForm["-",Subscripted["Mat"["("<>ToString[n]<>")"]],
	"("<>RingoidName[R]<>")-"], MaxElementsToList -> 32];
		GroupIdentity[G] = IdentityMatrix[R, n];
		HasIdentityQ[G] = True;AssociativeQ[G] = True;
		inverseFunction[G] = MultiplicativeInverse[R, #]&;
		G,
		Message[SizeLimit::toobig]; $Failed]]
			
ToGroupoid[RingExtension[Matrices, R_?RingoidQ, {m_,n_}, test_, All, Addition], opts___?OptionQ] := 
		Module[{size,G},
	If[(size = Size[RingExtension[Matrices, R, {m,n}, test, All,Addition]]) < 
			SizeLimit/.Flatten[{opts, Options[Elements]}],
		G = FormGroupoid[Elements[RingExtension[Matrices, R, {m,n}, test, All,_]],
			Addition[RingExtension[Matrices, R, {m,n}, test, All,Addition]][#1,#2]&, "+",
			WideElements -> True, GroupoidDescription -> ToString[m]<>" by "<>ToString[n]<>
			" matrices over "<>RingoidName[R], GroupoidName -> 
			SequenceForm["-",Subscripted["Mat"["("<>ToString[m]<>","<>ToString[n]<>")"]],
	"("<>RingoidName[R]<>")-"], MaxElementsToList -> 32];
		GroupIdentity[G] = Zero[RingExtension[Matrices,R,{m, n},test, LT, Addition]];
		HasIdentityQ[G] = True;AssociativeQ[G] = True;
		inverseFunction[G] = NegationOf[R, #]&;
		G,
		Message[SizeLimit::toobig]; $Failed]]

ToGroupoid[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, All, 
	Both], opts___?OptionQ] := 
		Module[{size,G},
	If[(size = Size[RingExtension[Matrices, R, {n,n}, test, All, Both]]) < 
			SizeLimit/.Flatten[{opts, Options[Elements]}],
		G = FormGroupoid[Elements[RingExtension[Matrices, R, {n,n}, test, All,_]],
			Multiplication[RingExtension[Matrices, R, {n,n}, test, All,Multiplication]][#1,#2]&, "*",
			WideElements -> True, GroupoidDescription -> ToString[n]<>" by "<>ToString[n]<>
			" matrices over "<>RingoidName[R], GroupoidName -> 
			SequenceForm["-",Subscripted["Mat"["("<>ToString[n]<>")"]],
	"("<>RingoidName[R]<>")-"], MaxElementsToList -> 32];
		GroupIdentity[G] = IdentityMatrix[R, n];
		HasIdentityQ[G] = True;AssociativeQ[G] = True;
		inverseFunction[G] = MultiplicativeInverse[R, #]&;
		G,
		Message[SizeLimit::toobig]; $Failed]]

ToGroupoid[RingExtension[Matrices, R_?RingoidQ, {m_,n_}, test_, GenA, Addition], 
	opts___?OptionQ] := ToGroupoid[RingExtension[Matrices, R, {m,n}, test, All, Addition], 
	opts]
	
ToGroupoid[RingExtension[Matrices, R_?RingoidQ, {m_,n_}, test_, GenM, Multiplication], 
	opts___?OptionQ] := ToGroupoid[RingExtension[Matrices, R, {m,n}, test, All, Multiplication], 
	opts]

ToGroupoid[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, GL, Multiplication], opts___?OptionQ] := 
		Module[{size,G},
	If[(size = Size[RingExtension[Matrices, R, {n,n}, test, 
			GL,Multiplication]]) < 
			SizeLimit/.Flatten[{opts, Options[Elements]}],
		G = FormGroupoid[Elements[RingExtension[Matrices, R, {n,n}, test, GL,_]],
			Multiplication[RingExtension[Matrices, R, {n,n}, test, GL,Multiplication], #1,#2]&, "*",
			WideElements -> True, GroupoidDescription -> ToString[n]<>" by "<>ToString[n]<>
			" invertible matrices over "<>RingoidName[R], GroupoidName -> 
			SequenceForm["-",Subscripted["GL"[ToString[n]]],"("<>RingoidName[R]<>")-"],
			MaxElementsToList -> 32];
		GroupIdentity[G] = IdentityMatrix[R, n];
		HasIdentityQ[G] = True;AssociativeQ[G] = True;
		inverseFunction[G] = MultiplicativeInverse[R, #]&;
		G,
		Message[SizeLimit::toobig]; $Failed]]

ToGroupoid[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, SL, Multiplication], opts___?OptionQ] := 
		Module[{size,G},
	If[(size = Size[RingExtension[Matrices, R, {n,n}, test, SL,
			Multiplication]]) < 
			SizeLimit/.Flatten[{opts, Options[Elements]}],
		G = FormGroupoid[Elements[RingExtension[Matrices, R, {n,n}, test, SL,_]],
			Multiplication[RingExtension[Matrices, R, {n,n}, test, SL,Multiplication]][#1,#2]&, "*",
			WideElements -> True, GroupoidDescription -> ToString[n]<>" by "<>ToString[n]<>
			" invertible matrices over "<>RingoidName[R]<>" with Det(A) = 1", GroupoidName -> 
			SequenceForm["-",Subscripted["SL"[ToString[n]]],"("<>RingoidName[R]<>")-"],
			MaxElementsToList -> 32];
		GroupIdentity[G] = IdentityMatrix[R, n];
		HasIdentityQ[G] = True;AssociativeQ[G] = True;
		inverseFunction[G] = MultiplicativeInverse[R, #]&;
		G,
		Message[SizeLimit::toobig]; $Failed]]

ToGroupoid[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, Diag, Multiplication], opts___?OptionQ] := 
		Module[{size,G},
	If[(size = Size[RingExtension[Matrices, R, {n,n}, test, Diag,
			Multiplication]]) < 
			SizeLimit/.Flatten[{opts, Options[Elements]}],
		G = FormGroupoid[Elements[RingExtension[Matrices, R, {n,n}, test, Diag,Multiplication]],
			Multiplication[RingExtension[Matrices, R, {n,n}, test, Diag,Multiplication]][#1,#2]&, "*",
			WideElements -> True, GroupoidDescription -> ToString[n]<>" by "<>ToString[n]<>
			" diagonal matrices over "<>RingoidName[R], GroupoidName -> 
			SequenceForm["-",Subscripted["Diag"[ToString[n]]],"("<>RingoidName[R]<>")-"],
			MaxElementsToList -> 32];
		GroupIdentity[G] = IdentityMatrix[R, n];
		HasIdentityQ[G] = True;AssociativeQ[G] = True;
		inverseFunction[G] = MultiplicativeInverse[R, #]&;
		G,
		Message[SizeLimit::toobig]; $Failed]]

ToGroupoid[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, UT, Addition], opts___?OptionQ] := 
		Module[{size,G},
	If[(size = Size[RingExtension[Matrices, R, {n,n}, test, UT, Addition]]) < 
			SizeLimit/.Flatten[{opts, Options[Elements]}],
		G = FormGroupoid[Elements[RingExtension[Matrices, R, {n,n}, test, UT, Addition]],
			Addition[RingExtension[Matrices, R, {n,n}, test, UT, Addition]][#1,#2]&, "+",
			WideElements -> True, GroupoidDescription -> ToString[n]<>" by "<>ToString[n]<>
			" upper triangular matrices over "<>RingoidName[R], GroupoidName -> 
			SequenceForm["-",Subscripted["UT"[ToString[n]]],"("<>RingoidName[R]<>")-"],
			MaxElementsToList -> 32];
		GroupIdentity[G] = Zero[RingExtension[Matrices,R,{n, n},test, LT, Addition]];
		HasIdentityQ[G] = True;AssociativeQ[G] = True;
		inverseFunction[G] = NegationOf[R, #]&;
		G,
		Message[SizeLimit::toobig]; $Failed]]

ToGroupoid[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, LT, Addition], opts___?OptionQ] := 
		Module[{size,G},
	If[(size = Size[RingExtension[Matrices, R, {n,n}, test, LT, Addition]]) < 
			SizeLimit/.Flatten[{opts, Options[Elements]}],
		G = FormGroupoid[Elements[RingExtension[Matrices, R, {n,n}, test, LT, Addition]],
			Addition[RingExtension[Matrices, R, {n,n}, test, LT, Addition]][#1,#2]&, "+",
			WideElements -> True, GroupoidDescription -> ToString[n]<>" by "<>ToString[n]<>
			" lower triangular matrices over "<>RingoidName[R], GroupoidName -> 
			SequenceForm["-",Subscripted["LT"[ToString[n]]],"("<>RingoidName[R]<>")-"],
			MaxElementsToList -> 32];
		GroupIdentity[G] = Zero[RingExtension[Matrices,R,{n, n},test, LT, Addition]];
		HasIdentityQ[G] = True;AssociativeQ[G] = True;
		inverseFunction[G] = NegationOf[R, #]&;
		G,
		Message[SizeLimit::toobig]; $Failed]]

ToGroupoid[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, UTD, Multiplication], opts___?OptionQ] := 
		Module[{size,G},
	If[(size = Size[RingExtension[Matrices, R, {n,n}, test, UTD, Multiplication]]) < 
			SizeLimit/.Flatten[{opts, Options[Elements]}],
		G = FormGroupoid[Elements[RingExtension[Matrices, R, {n,n}, test, UTD, Multiplication]],
			Multiplication[RingExtension[Matrices, R, {n,n}, test, UTD, Multiplication]][#1,#2]&, "*",
			WideElements -> True, GroupoidDescription -> ToString[n]<>" by "<>ToString[n]<>
			" upper triangular (with diagonal) matrices over "<>RingoidName[R], GroupoidName -> 
			SequenceForm["-",Subscripted["UTD"[ToString[n]]],"("<>RingoidName[R]<>")-"],
			MaxElementsToList -> 32];
		GroupIdentity[G] = IdentityMatrix[R, n];
		HasIdentityQ[G] = True;AssociativeQ[G] = True;
		inverseFunction[G] = MultiplicativeInverse[R, #]&;
		G,
		Message[SizeLimit::toobig]; $Failed]]

ToGroupoid[RingExtension[Matrices, R_?RingoidQ, {n_,n_}, test_, LTD, Multiplication], opts___?OptionQ] := 
		Module[{size,G},
	If[(size = Size[RingExtension[Matrices, R, {n,n}, test, LTD, Multiplication]]) < 
			SizeLimit/.Flatten[{opts, Options[Elements]}],
		G = FormGroupoid[Elements[RingExtension[Matrices, R, {n,n}, test, LTD, Multiplication]],
			Multiplication[RingExtension[Matrices, R, {n,n}, test, LTD, Multiplication]][#1,#2]&, "*",
			WideElements -> True, GroupoidDescription -> ToString[n]<>" by "<>ToString[n]<>
			" lower triangular (with diagonal) matrices over "<>RingoidName[R], GroupoidName -> 
			SequenceForm["-",Subscripted["LTD"[ToString[n]]],"("<>RingoidName[R]<>")-"],
			MaxElementsToList -> 32];
		GroupIdentity[G] = IdentityMatrix[R, n];
		HasIdentityQ[G] = True;AssociativeQ[G] = True;
		inverseFunction[G] = MultiplicativeInverse[R, #]&;
		G,
		Message[SizeLimit::toobig]; $Failed]]


(* ::Section:: *)
(* 94. Later*)


(* ::Input:: *)
(*(*RandomElement[Mat[n_Integer?Positive, Z],max_:100] :=*)
(*	Table[Random[Integer,{-max,max}],{n},{n}]*)
(*		*)
(*RandomElement[Mat[n_Integer?Positive, k_Integer?Positive]] :=*)
(*	Table[Random[Integer,{0,k-1}],{n},{n}]*)
(*	*)
(*RandomElements[Mat[n_Integer?Positive, Z],max_:100, num_Integer?Positive] :=*)
(*	Table[RandomElement[Mat[n,Z],max],{num}]*)
(*		*)
(*RandomElements[Mat[n_Integer?Positive, k_Integer?Positive], num_Integer?Positive] :=*)
(*	Table[RandomElement[Mat[n,k]],{num}]  *)
(*	*)
(*Mat[n_,2] := With[{ma = MatA[n,2]},*)
(*	FormRingoid[Elements[ma],Operation[ma],Operation[MatM[n,2]],*)
(*	WideElements->True]]*)
(*	*)
(*Mat[n_,3] := With[{ma = MatA[n,3]},*)
(*	FormRingoid[Elements[ma],Operation[ma],Operation[MatM[n,3]],*)
(*	WideElements->True]]*)                      *)


(* ::Section:: *)
(* 95. Disguising*)


(* ::Subsection:: *)
(* DisguiseGroupoid*)


Options[DisguiseGroupoid] = {Randomize -> False};

DisguiseGroupoid[G_?GroupoidQ, rules:{_Rule..},opts___?OptionQ] :=
	Module[{mymode,scramble,els = Elements[G]},
mymode = Mode/.Flatten[{opts, Options[DisguiseGroupoid]}];
scramble = Randomize/.Flatten[{opts, Options[DisguiseGroupoid]}];
els = If[scramble,Randomize[els],els];
FormGroupoid[els/.rules,
	GenericOperation[G,rules,#1,#2]&, GroupoidName -> "???"]
]

DisguiseGroupoid[G_?GroupoidQ,opts___?OptionQ] := 
	DisguiseGroupoid[G,GenericRules[If[
	Randomize/.Flatten[{opts, Options[DisguiseGroupoid]}],
	Randomize[Elements[G]],Elements[G]]],opts]

GenericOperation[G_?GroupoidQ,rules:{_Rule..},g_,h_] :=
	Module[{op = Operation[G], a, b},
{a,b} = Map[First,Flatten[Map[Position[rules,#]&,{g,h}],1]];
op[rules[[a,1]],rules[[b,1]]]/.rules
]

GenericRules[els_List] := 
	If[Length[els] < 27, MapThread[Rule,{els,
		Map[FromCharacterCode,Range[97,Length[els]+96]]}]]


(* ::Subsection::Closed:: *)
(* DisguiseRingoid*)


Options[DisguiseRingoid] = {Randomize -> False};

DisguiseRingoid[R_?RingoidQ, opts___]:=
	Module[{AG=DisguiseGroupoid[AGroupoid[R],opts]},
		FormRingoid[Elements[AG], Operation[AG], 
			Operation[DisguiseGroupoid[MGroupoid[R], opts]],
    	RingoidName -> "???"]]


(* ::Section:: *)
(* 99. Wrap up*)


SwitchStructureTo[Group];
End[];
(* Protect[Z, ZG, ZR, NS, Rot, Ref, U, Zx, GF, Diag, GL, LT, LTD, SL, UT, UTD, Aut, S]; *)
EndPackage[];

(* Declarations for file AbstractAlgebra`LabCode`*)

DeclarePackage["AbstractAlgebra`LabCode`",{"AddPermToGroup", "CInf", "CollectOrders", "CompleteGroupQ", "DropPermFromGroup", "D1Prod", "D2Prod", "GoodGroupElementsQ", "GroupsToConsider", "Ind", "Lab2", "Lab3", "Lab4", "LG", "ListOperationPreservingElements", "myDiv", "myDivisorSigma", "myDot", "myMod", "myPower", "MySymmetryGroup", "myZees", "quatOp", "ReduceList", "RestrictList", "SE", "ShowGroupOrders", "ShowOne", "ShowPossiblePermsAsRules", "ShowPossiblePermutations", "TestPermutationQ", "trivProd", "undef", "Verbal"}];




