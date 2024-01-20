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

#### Assignment

```odin
foo := 0x2A
foo = 42
```

A newly, or previously declared type may be assigned using the equals sign. Using `:=` declares and then assigns a _mutable_ variable, recall that it is two operations, 1. Declare a variable (and optionally its type), 2. Assign the variable a concrete value. Solely using equals on an existing variable re-assigns it.

Assignments are attached to the symbol table at the scope they are in. A variable globally declared is in the global scope, similarly in a procedure or any block scope for the matter, the variable is in that scope.

##### Shadowing

```odin
	a := 3
	{
		a := 5
	}
```

If you re-use the `:=` operators on an existing variable inside of a child scope, you will shadow the previous declaration. After using Odin for some time, the := operators become reflexive, and it can be quite easy to accidentally shadow . The `-vet-shadowing` compiler flag catches these sometimes, the conditions it will permit are: **TODO- SHADOW RULES** **TODO: FILE ISSUE FOR #SHADOW+BAN-SHADOWING**

#### Procedures

```odin
read_entire_file :: proc(path:string, allocator:=context.allocator) -> (data:[]byte, success:bool)
aprintf::proc(fmt:string, args: ..any, allocator:=context.allocator) -> string
```

A procedure is declared with the keyword `proc`. It is followed by the args-signature, the return signature and then the body.

### Inputs Signature

The arguments signature follows the keyword, wrapped in parens. Arguments are structured as `Identifier: Type`, just like we saw above in the declaration syntax. Note that args may not use the `::` operators as declaring a constant as an arg is not logical. The `:=` operators however are permitted; they set default args for that arguement. Default args are permitted in any position of the signature, however, placement of them combined with the neighboring types may make it difficult for the compiler to infer if the default is to be used or a value was supplied. Traditionally, default arg assignments should be placed at the far right side of a procedure.

Odin supports variadic arguments, as shown in the `aprintf` sample above. Variadic arguments must be the last argument in the arg-list, except for default arg assignments (`:=`). If a default arg is the same type of the variadic type, that arg is unreachable; the compiler cannot know where the variadic args end and the default arg starts.

```odin
a_proc :: proc(a: int, b: ..int, c: int = 42) // c is unreachable because its type matches b
```

Named

```odin
main :: proc() {
	a_proc(3, s = "soo", b = true)
}
a_proc :: proc(f := 3, s: string, b: bool) {
	fmt.println(s, f)
}
```
