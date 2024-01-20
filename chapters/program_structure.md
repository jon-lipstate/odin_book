## Chapter: Program Structure

Odin programs are parsed out of order, meaning that there is no need for forward declarations, and insofar as contents are within the same package.

### Primer on Attbributes, Directives and Build-Directives

This section introduces Tags, Attributes & Directives to provide a foundational understanding of them and to correctly identify thier syntax. Through the rest of the book, where relevant, they will be introduced where they may be used with explainations on the specific effects they impart. Lists of each may be found in Chapter XX.

#### Attributes

Attributes are used to modify the compilation details of declarations. There are a set of built-in attributes, which will be detailed at the conclusion of each relevant section, particularly in relation to the types they affect. The syntax for attributes is denoted as @(...) where the ellipsis represents a comma-separated list of attributes to be applied. The topic of Custom Attributes is thoroughly explored in Chapter XX.

#### Directives

Directives modify the behavior of language features. The syntax for directives is `#directive_name`.

#### Build Tags

Build tags may be found on the first line of a file, preceding the package declaration. They take the form of `//+private` or `//+build linux, darwin, windows`.

### Package Declaration

`package foo`

The package declaration is the first\* declaration in an odin file. A package as a concept, is a group of types, procedures and data that are all sharing the same domain/global scope. Odin does not employ the concept of namespaces in the traditional sense, but in some sense a package can be thought of as a namespace. The languages package-centric design results in most Odin projects being far flatter structurally than you might find in other languages.

Multiple packages should only be made when there are clear scopes of work with no interdependance on the other packages. For example `package png_loader` might be seperate from `package the_game`. The png_loader has no relation to a game, it simply loads a png into a buffer, and hands it off. The game may then import the png_loader and utilize it. If however the png_loader's load procedure needed to be given a game-asset and it loads into that asset, now the two packages need to know about each other's types and cannot be directly imported to each other.

If packages need knowledge of shared types (eg A imports B, and B imports A), a strategy to address the cyclic imports would be to make a third package, `shared`. A then imports shared and B imports shared, the cyclic dependancy is resolved. When this is used, the types are only visible via accessing through the shared name or alias, eg `shared.value_type`. This can be burdonsome if shared contains a large number of types. An alias file could be used in each consumer package, which aliases out the shared packages types into the other packages, but this needs done for each package using shared. For example:

```odin
package A
import "../shared"
foo :: shared.foo   // <- Alias foo across the current package to not have to type shared.foo
```

Naming collisions are often brought up as a case against flat structures, however in practice occurances are rare, and more often a naming collision is with a _builtin_ procedure than user-defined ones. Handling Naming collisons is discussed more in Section XX.

A caution for those accustomed to object oriented languages: Odin's design makes code organization and taxonomy formation seperate concepts where in many OOP languages they are merged. It is strongly discouraged to try to apply taxonomies to your codebase in Odin. Instead you are encouraged to group like functionalty by file in the same directory. Odin does not allow cyclic imports, making unneccesary code-splitting even more trouble than it would be in other languages.

#### Requirements:

-   \*It must be on the first line of the file, except when build tags are present.
-   A package may be named any valid Identifier.
-   All `.odin` files within a directory must share the same package name.
-   All imports must be acyclic

#### Tags:

The first line of the file can contain build directives or a file-wide attribute.

`//+private`: Make all data in the file private to the package
`//+build linux, !windows, darwin`: Restrict compilation of the current file to the Targets listed. An exclaimation can be used to logically invert the claim.

### Import Statements

```
import "./shared"
import la "core:math/linalg"
```

Import statements are used to bring packages into _scope_ for the _current_ file. A valid Identifier may precede the _relative_ path of the package as an alias. In the example above `linalg` is aliased to be `la`. Note that because import statements use relative paths, the default name of an imported package is that of the _final_ folder containing it, _not_ the package's package name or the full path-tree. It is convention to keep the package name and folder name the same, but is not required or enforced.

In the example, the `linalg` library is using a **Collection** (Chapter XX) to access the core library. Collections may be thought of as being similar to symlinks for directories. It would be very inconvienent to have to manually find relative paths to your Odin installation from any package you might make. Collections solve this by allowing you to alias directly into a specific folder, and then continue to use relative pathing the rest of the way to the destination package.

Import statements must be imported in _each_ file that uses them, unless the desired procedures from that package are aliased into your package, as demonstrated by the shared package in the previous section.

### Declaration and Assignment Syntax

```odin
A_CONSTANT :: 42
x, y: int
```

#### Declaration

Odin prioritizes readability of the code, and the most important thing when reading a declaration is its name. Therefore names are always placed first in declarations. A declaration is made with a colon `:`. After the colon, a type may be optionally supplied. A second colon makes the variable into a constant, but more similar to the way that C's `#define` makes a constant rather than it is just an immutable global variable. If you do not use it, it will not be emitted in the output code. These immutable values (`::`) are placed in the readonly-data section of the program (`.rodata`).
The `::` operator is valid on all type declarations. For example, you will almost never see a procedure with an explicitly declared type, but it is valid (though redundant) to do so:

```odin
a_type :: #type proc(i: int)
a_concrete_proc: a_type : proc(i: int) { /*...*/ }
```

Note: The `#type` directive has no direct impact on code, it is a present for readablity purposes to make it clear that this procedure is a type declaration. It may be safely omitted, if desired.

A declaration may have the starting colon followed by a type and nothing else, in this case a type is required. If multiple declarations are all of the same type, they may be declared together, comma seperated.

##### Attbributes

@(private)
@(require)
@(export)

#### Assignment

```odin
foo := 0x2A // declare & assign
foo = 42    // re-assign
```

A newly, or previously declared type may be assigned using the equals sign. Using `:=` declares and then assigns a _mutable_ variable, recall that it is two operations, 1. Declare a variable (and optionally its type), 2. Assign the variable a concrete value. Solely using equals on an existing variable re-assigns it.

Assignments are attached to the symbol table at the scope they are in. A variable globally declared is in the global scope, similarly in a procedure or any block scope for the matter, the variable is in that scope.

##### Shadowing

If you re-use the `:=` operators on an existing variable inside of a child scope, you will shadow the previous declaration. After using Odin for some time, the := operators become reflexive, and it can be quite easy to accidentally shadow . The `-vet-shadowing` compiler flag catches these sometimes, the conditions it will permit are: **TODO- SHADOW RULES** **TODO: FILE ISSUE FOR #SHADOW+BAN-SHADOWING**

```odin
	a := 3
	{
		a := 5
	}
```

#### Procedures

```odin
read_entire_file :: proc(path:string, allocator:=context.allocator) -> (data:[]byte, success:bool)
aprintf::proc(fmt:string, args: ..any, allocator:=context.allocator) -> string
```

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
```

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

### Entry Point

```odin
main :: proc() {
	// application entry-point
}
```

In Odin the application's entry point is the procedure `main`. Note that in Odin, the main procedure does not accept or return arguments, atypical to most other languages. This is done to unify the function signatures across platforms, each platform-specific entry-point (below) will have the correct signature for that platform, and the data is placed into a global variable in the `core:os` package.

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

### Naming Collisions

The most common collision you will find is with the builtin procedures. They are by default always available whether you imported them or not, and to be idiomatic with the language you may opt to use similar, ergo colliding naming. When this occurs with the builtins, you can either rename your values to be something else, or you can explicitly call a builtin.

```odin
import "core:builtin
max::proc(){...}
main::proc(){
    m:=max(3,4) // this is ambiguous but typically resolves to local declarition
    m:=builtin.max(3,4) // ambiguity resolved
}
```

By convention, types can be part of the names for procedures, eg to not collide with `new`, you could have a `Tower` type, and rather than write `new ::proc()->^Tower`, you can use `tower_new` or similar. This is observable throughout the core libraries.

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
