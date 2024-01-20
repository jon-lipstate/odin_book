package tmp
import "./foo"
import "core:fmt"


fonvo :: struct {
	a: u8,
	c: u16,
	b: u64,
}
main :: proc() {
	// a_proc(3, s = "soo", b = true)
	a_proc(1, 2, 3, 4, false)
}
a_proc :: proc(a: int, b: ..int, c: int = 42) {
	fmt.println(a, b, c)
}
