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
