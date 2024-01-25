## Chapter: Program Structure

Odin programs are parsed out of order, meaning that there is no need for forward declarations, and insofar as contents are within the same package.

### Primer on Attbributes, Directives and Build-Directives

This section introduces Tags, Attributes & Directives to provide a foundational understanding of them and to correctly identify thier syntax. Through the rest of the book, where relevant, they will be introduced where they may be used with explainations on the specific effects they impart. These exist primarily to reduce the number of keywords in the language.

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

If packages need knowledge of shared types (eg A imports B, and B imports A), the strategy to address the cyclic imports would be to make a third package, `shared`. A then imports shared and B imports shared, the cyclic dependancy is resolved. When this is used, the types are only visible via accessing through the shared name or alias, eg `shared.value_type`. This can be burdonsome if shared contains a large number of types. An alias file could be used in each consumer package, which aliases out the shared packages types into the other packages, but this needs done for each package using shared. For example:

```odin
package A
import "../shared"
foo :: shared.foo   // <- Alias foo across the current package to not have to type shared.foo all the time
```

#### Design Tradeoff

Historically, there was only one namespace, the global scope. This led to the need to prefix entities with some pseudo namespace, which is admittedly less than ideal. Scoped namespacing was the obvious solution to this, and has been implemented widely amongst languages. The resulting effect however has been that given the tools to do so, developers tend to overly taxonomize thier projects, such that there ends up more abstraction than actual code. Odin elects to partially-return to the pre-namespace days to get away from the knock-on effects caused by it. The cure is postulated to be worse than the disease.

The low-friction organizational path in Odin is to have larger files in a relatively flat structure, only splitting into packages when functionality demonstrates it is truly insulated from cross-cutting concerns.

#### Package Requirements

-   Must be on the first line of the file, except when build tags are present.
-   A package may be named any valid Identifier.
-   All `.odin` files within a directory must share the same package name.
-   All imports must be acyclic

#### Build Tags:

The first line of the file can contain build directives or a file-wide attribute. **comma seperated?**

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

#### Scopes

A _Symbol_ represents a variable, constant, procedure or other usable entity in the program. Scopes contain _Symbol Tables_, which are the set if symbols which exist inside of that scope. Scopes in Odin are organized hierarchically, where outer scopes envelope more interior/local scopes. Scope visibility is from innermost to outermost; a child may see all of its parent's scopes, but a parent does not have visibility to its children's scopes.

Symbol conflicts (e.g. Shadowing) are resolved by precedence of the nearest scope. Within a given scope, a variable has a lifetime from the point it was declared, until the end of that scope.

The outer-most scope is the `package-scope`, it spans all files in the current package. The next scope is the `file-scope`, visibility is of the contents of the specific file. The package and file scopes permit out-of-order declaration, effectively having no temporal/order constraints (Note: The `@init` attribute relies on some ordering).

All other scopes, from the procedure downwards have constraints of in-order declaration, you cannot use something before it has been declared. A scope is defined by a pair of curly braces `{}`. Procedures, loops, branches all contain braces, and each defines a scope. You may define a block scope at will with a pair of braces as well.

```odin
package foo
// scopes: file, package
main :: proc() {
    // scopes: main, file, package
    {
        // scopes: block, main, file, package
    }
}
```

Exceptions:

-   `@static` variables are exempted from temporal restrictions, they have no lifetime constraints
-   A `case` inside of a `switch` statment also forms its own scope
-   `when` & `foreign` have scopes at compile-time, but not at run-time

```odin
main :: proc() {
  foreign foo {
    print :: proc(s: string) ---
  }
  when true {
    hello := "world"
  }
  print(hello) // the when and foreign blocks do not exist at runtime
}
```

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
