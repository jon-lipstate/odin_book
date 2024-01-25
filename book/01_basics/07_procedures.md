`using` for procedure parameters was implemented for refactoring purposes, it is now considered a design mistake, and should not be used.

g

````

A procedure is declared with the keyword `proc`. It is followed by the input args signature, the return signature and then the body. The parens are always required, return signatures only present if there are return values, and a body may be omitted if decaring a type versus a concrete implementation.

Procedures may be declared at the package level, or inside of a scope, for example it could be inside another procedure, an if statement, or just a plain block statement (`{}`).

A procedures body is wrapped in braces, it contains its own scope, and the package-level/global scope. Nested procedures do not gain access to the scopes that contain them.

```odin
outer :: proc() {
	a := 5
	inner :: proc() {
		// a = 7 <- will not work: scopes are _not_ passed down like closures
	}
}
````

##### Inputs Signature

The arguments signature follows the keyword, wrapped in parens. Arguments are structured as `Identifier: Type`, just like we saw above in the declaration syntax. Note that args may not use the `::` operators as declaring a constant as an arg is not logical. The `:=` operators however are permitted; they set default args for that arguement. Default args are permitted in any position of the signature, however, placement of them combined with the neighboring types may make it difficult for the compiler to infer if the default is to be used or a value was supplied. Traditionally, default arg assignments should be placed at the far right side of a procedure.

Odin supports variadic arguments, as shown in the `aprintf` sample above. Variadic arguments must be the last argument in the arg-list, except for default arg assignments (`:=`). If a default arg is the same type of the variadic type, that arg is unreachable; the compiler cannot know where the variadic args end and the default arg starts.

```odin
a_proc :: proc(a: int, b: ..int, c: int = 42) // c is unreachable because its type matches b
```

Procedures may be called by a mixture of positional arguments, and named arguments using `arg_name = value`, however once the named argument syntax is used, no further positional arguments to the right may be used, all remaining args must also be named. In the example below `c` must be called by its name.

```odin
main :: proc() {
	a_proc(3, b = 42, c = true)
}
a_proc :: proc(a := 3, b: int, c: bool) {}
```

##### Immutable Arguments

Args are immutable, TODO: WRITE MORE STUFF

##### By-Pointer Upgrades

If passing >16 byte items, they automatically are upgraded to passing by pointer. TODO: WRITE MORE STUFF

##### Returns Signature

```odin
no_return_proc :: proc(a:int)
```

When no value is returned, there is nothing present after the closing paren of the input portion of the signature.

```odin
single_return_proc :: proc(a:int) -> int
```

When a single value is returned, it may be specified using the arrow `->` followed by the type, or follow the multi-return signature type.

```odin
multi_return_proc :: proc(a:int) -> (int, ok:bool)
```

Multiple return signatures have an arrow followed by parens. The contents may either be unnamed, named, or mixed, each return-value comma seperated. Similar to mixed calling syntax, everything to the right of a named-value must also be named.

```odin
diverging_proc :: proc(a:int) -> !
main :: proc(){
    a:=3
    diverging_proc()
    // no code below this point
}
```

A diverging procedure is one that never returns, the program goes into a trapped state. Odin does not permit any statements after diverging statements.

##### Procedure Body

```odin
multi_return_proc :: proc() -> (a:int, ok:bool) {
    a = 1
    ok = true
    return
    // return a, ok
    // return 7, false
}
```

Named return values are zero-initialized, and may not be re-declared. You may use them as declared variables through the procedure. Return statements with named variables may either have a naked `return` with no other values, or it may be positional arguments returned. If using values in the return statement, all of them must be present, and ordered correctly per the signature.

#### Procedures

````odin
read_entire_file :: proc(path:string, allocator:=context.allocator) -> (data:[]byte, success:bool)
aprintf::proc(fmt:string, args: ..any, allocator:=context.allocator) -> strin
### Entry Point

```odin
main :: proc() {
	// application entry-point
}
````

**FIXME:**
main has no prototype to keep it simple, behind the scenes the application startup code will insert a platform-correct signature for you. access to the IO is core:os.

### Attbributes

@(deferred_x=target_proc)
in, out, in_out, none

@(deprecated)

@(require_results)

@(warning)

@(disabled)

@(init)

@(cold)

@(optimization_mode)

### Directives

`#no_alias`: Provides a hint to the compiler about pointer aliasing. The compiler is told that this pointer does not alias any other pointer in the same scope. This allows the compiler to be less conservative in its assumptions and results in more aggressive optimization. Similar to the `__restrict` keyword in C.

```odin
foo::proc(#no_alias i:i8)
```

`#any_int`: Relaxes integer type rules on arguments. If the values overflow, they will wrap by default.

```odin
foo::proc(#any_int i:i8)
// usage:
bar:i64 = 0xFF
foo(bar)
```

`#caller_location`: Provides a struct containing information about the callsite that executed a procedure using this directive. The struct that is emitted is `Source_Code_Location`.

```odin
parse_error::proc(msg:string, loc:=#caller_location)
// Found in core:runtime
Source_Code_Location :: struct {
	file_path:    string,
	line, column: i32,
	procedure:    string,
}
```

`#c_varag`: Used to transform an Odin style vararg into a C-style vararg.

```odin
foo::proc(#c_vararg args:..any)
```

`#by_ptr`: Allows Odin code to pass by value in appearance, but the underlying call is assured to be passed by pointers. The common use case is for FFI interfacing with C's `const T*`. HALP HALP: NEED MORE INFO.

```odin
foo::proc(#by_ptr i:int)
```

`#optional_ok`: Allows the far right return value, when a bool, to be omitted.

```odin
foo ::  proc()->(a:int,ok:bool) #optional_ok {...}
// calling:
a, ok := foo() // Typically requires both args be captured
a := foo() // Because optional, last bool can be omitted
```

`#type`: Serves exclusively for aiding code readability. Prevents adding a procedure body.

```odin
foo :: #type proc()
```

`#no_bounds_check` & `#bounds_check`: Opts in or out of bounds-checking at the procedure level. Also applies to scopes.

```odin
foo :: proc() #no_bounds_check {...}
```
