**MOVE ENTRY POINT STUFF TO ADVANCED**

In Odin the application's entry point is the procedure `main`. Note that in Odin, the main procedure does not accept or return arguments, atypical to most other languages. This is done to unify the function signatures across platforms, each platform-specific entry-point (below) will have the correct signature for that platform, and the data is placed into a global variable in the `core:os` package. Access to the program's input arguments or specifying an exit-code is done as follows:

```odin
import "core:os"
main :: proc() {
	args:[]string = os.args // argv converted to a slice of string
	os.exit(-1) // OS-Specific exit (e.g. ExitProcess on Windows)
}
```

Note that prior to your main procedure executing, the Odin runtime starts up. The runtime's startup code can be found in `core:runtime/entry_OS.odin` where `os` is the target-OS. From the `entry_unix.odin` file, we can see the expected `main` signature you'd expect of the OS, it takes in a list of arguments, and returns an integer. The context system is initialized, the runtime is started and finally, the user-main is called at `intrinsics.__entry_point()`.

```odin
@(link_name="main", linkage="strong", require)
main :: proc "c" (argc: i32, argv: [^]cstring) -> i32 {
	args__ = argv[:argc]
	context = default_context()
	#force_no_inline _startup_runtime()
	intrinsics.__entry_point()
	#force_no_inline _cleanup_runtime()
	return 0
}
```

For cases where an entrypoint is not needed or desired such as static/dynamic libraries, see Chapter X.

### Naming Collisions TODO: MOVE THIS

The most common collision you will find is with the builtin procedures. They are by default always available whether you imported them or not, and to be idiomatic with the language you may opt to use similar naming, which tends to collide. When this occurs with the builtins, you can either rename your values to be something else, or you can explicitly call a builtin.

```odin
import "core:builtin" // explicitly import the builtin package
max :: proc(a, b: int) {...} // Collides with `max` from builtins
main :: proc() {
    m := max(3,4) // Attempts to resolve to local declaration
    n := builtin.max(3,4) // explicit call to the builtin
}
```

By convention, types can be part of the names for procedures, eg to not collide with `new`, you could have a `Tower` type, and rather than write `new ::proc()->^Tower`, you can use `tower_new` or similar. This is observable throughout the core libraries.
