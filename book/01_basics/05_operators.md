## Operators

Odins operator selection is common to most languages except in a few places. There is now exponent operator (`**` or `^` in other languages). The `pow` procedure in `core:math` is instead used. Odin reserves the caret `^` for use with pointers instead of `*` as C uses. C uses `^` for XOR, in Odin this is `~`.

Basic arithmatic operations work on Numeric Types, which include Integers, Floats (including complex/quaternion), Enums.

### Arithmatic Operators

Unary operators act on a single token, Odin has the following unary operators:

| Symbol | Action             | Works On |
| ------ | ------------------ | -------- |
| +      | Declare Positive   | Numeric  |
| \-     | Declare Negative   | Numeric  |
| ~      | Bitwise Complement | Numeric  |

The bitwise complement performs a bitwise not operation on each bit in the value. The following example shows the results of the operation:

```odin
    // unsigned
	a := u8(0b_0101_0101)
	fmt.printf("%b\n", ~a) // 0b_1010_1010
    // signed
	b := i8(0b_0101_0101) // 85 in base10
	c := transmute(u8)~b // we want to read the value as a u8 to understand its raw value
	fmt.printf("%b\n", c) // 0b_1010_1010 // -86 in base10
```

Binary Math Operators:

| Symbol | Action              | Works On                                      |
| ------ | ------------------- | --------------------------------------------- |
| +      | Add                 | Numeric, [?]Numeric, matrix, constant-strings |
| -      | Subtract            | Numeric, [?]Numeric, matrix                   |
| \*     | Multiply            | Numeric, [?]Numeric,matrix                    |
| /      | Divide              | Numeric, [?]Numeric                           |
| %      | Modulo (Truncated)  | Integers                                      |
| %%     | Remainder (Floored) | Integers                                      |

Multiplication operates on fixed-arrays with length of 4 or less. Slices are not permitted to use these operators. When multipying a scalar with an array, it performs a scalar multiply. When multipying two arrays of the same length, a Hadamard Product is performed (element-wise multiply). Division operates in the same manner.

```odin
	a := [4]int{1, 2, 3, 4}
	b := a * a // [1, 4, 9, 16]
	c := 5 * a // [5, 10, 15, 20]
```

Matrices may be multiplied following the rules of matrix multiplication, the inner dimensions must match, and the outer dimensions produce the new matrix, `m,n * n,k -> m,k`. Matrices are stack allocated, they have a maximum number of values limit (Total elements of N=16) to prevent using them for large dense matrix problems. It is possible to produce a size that violates these constraints.

Matrix-Vector multiplication also operates as as one would expect mathematically. The vector side of the multiply is either interpetd as a row or column vector, depending which shape is needed to satify the constraints of matrix multiplication.

```odin
	d := matrix[2, 2]f64 {
		1, 0,
		0, 1,
	}
	e := matrix[2, 2]f64 {
		1, 2,
		3, 4,
	}
	h := [2]f64{10, 10}
	f := 5 * d // matrix[5, 0; 0, 5]
	g := d * e // matrix[1, 2; 3, 4]
	i := e * h // [10, 10]
```

Binary Bitwise Operators:

| Symbol | Action      | Works On                 |
| ------ | ----------- | ------------------------ |
| \|     | Or          | Integers, Enums          |
| &      | And         | Integers, Enums          |
| ~      | Not         | Integers, Enums          |
| &~     | And Not     | Integers, Enums          |
| <<     | Shift Left  | unsigned Integers, Enums |
| >>     | Shift Right | unsigned Integers, Enums |

TODO: show bits library?
