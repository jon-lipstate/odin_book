package tmp
import "core:fmt"


main :: proc() {
	a := u8(0b_0101_0101)
	fmt.printf("%b\n", ~a) // 0b_1010_1010
	c := i8(0b_0101_0101) // 85 in base10
	d := transmute(u8)~c // we want to read the value as a u8 to understand its raw values
	fmt.printf("%b\n", d) // 0b_1010_1010 // -86 in base10
}


bar :: enum {}
