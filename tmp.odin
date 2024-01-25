//+private, +build windows, !linux
package tmp
import "core:fmt"

import "core:container/queue"

@(require, export = false, thread_local)
foo: int

main :: proc() {
	q: queue.Queue(int)
	queue.init(&q)
	fmt.println(q)
}


// an_array :: [3]int{1, 2, 3}

// invalid_use_examples :: proc(v: int) {
// 	// Error: 'v + 1' is not a compile-time known constant
// 	constant :: v + 1
// 	// Resolution: Use Assignment Operator
// 	not_a_constant := v + 1

// 	// Error: Cannot index a constant 'an_array'
// 	arr_val := an_array[v]
// 	// Evaluable at Compile-Time, this is OK to do:
// 	ok_arr_val := an_array[2]
// }
