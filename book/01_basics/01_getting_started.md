# Getting started

## Installation

**method: clone master only?**

### Prerequisites

In order to install Odin and build it, the following prerequisites are required:

Windows: MSVC Compiler
Linux: **...**
Darwin: **...**

**Prebuilt Binaries?**

### Windows

### Mac

### Linux

### PATH

`PATH` is a system environment variable. When an application is run, it is first attempted to be found in the current working directory. If that fails, it searches through the list of directories specified on `PATH`. When you want to be able to call a program from anywhere (e.g. the Odin compiler), you need to add the directory of the executable to your `PATH` variable.

In a slightly amusing story of forgetting how `PATH` works, I wrote a process package for Odin. I decided to name it `cmd` because it was used to call Windows `cmd` for the usecase I had. As mentioned earlier, the local folder is searched first. When I went to test the application, `cmd` was my Odin exe, not the Windows one I had expected. Since it was spawning a `cmd` when it ran, I essentially fork bombed myself.

**TODO: SHOW HOW TO DO ON WINDOWS MAC LINUX**

## Basic Compiler Usage

## Hellope

## Syntax & Reading

Odin was design to be explicitly read left to right in all scenarios. This is not a well appreciated attribute until after understanding C's declaration syntax.

This section shows a wide array of the language's features to show the syntax of the language. Each feature will be covered in detail starting in _Ch2_.

In the example below, `foo` is a pointer to a static array (of length 7) that contains pointer's to ints. `bar` is declared to be the 4th entry of foo (a pointer), that is dereferenced to the underlying value, an `int`.

```odin
foo: ^[7]^int
bar := foo[3]^
```

Note that foo contained two pointers, and yet bar is a value, but only dereferenced one pointer. When the compiler detects that a pointer derefence can be elided, it will do so implicitly on your behalf. In the case above, the explicit syntax would have been `foo^[3]^`. There is no harm in being explicit, but it is not required on elidable scenarios.

Notice that for both pointers and array/slice accesses, there is symmetry in the declaration and access. It is never ambiguous whether either are being declared, or used.

### Identifiers

Define Identifier
RULES OF IDENTS HERE?? Maybe do all of the syntactic structures & symbols here

move Primer for seeing `@,#,??`

## Style

When someone is reading your code, they are trying to emulate your mind to learn to think about the problem at hand in the same way as you do so they can efficiently retrace your steps. Because we all think quite differently, the task proves to be more difficult than it seems it should be. When reading thier code, we're searching for the structure and patterns in it that help us unlock the map. There are parts of our brains that are simultaneously doing the same, but for _any_ pattern, regardless of if it is useful.

For example, When scanning you might encounter a place where one line indented with 7 spaces instead of 4, does that mean something? Hard to say without reading more, but it does make you pause. In another example, some of the code is pascal case and some is snake case, why? Is there a rational change of style to denote something?

I outline below what Odin's style is typically, however the key is consistency. If you elect to do something else in your projects, I am not the style police, but I do implore you to stick to what it is you choose.

---

Types are `Title_Case`. Variables & procedures are `snake_case`. Constants are `SCREAMING_SNAKE_CASE`. I personally use the screaming snake case for all global variables as well; however the core libraries treat them the same as a scoped variable.

Naming of Variables and procedures is often by convention more descriptive than many languages. _A variable's lifetime dictates its name; long lived and important variables should have more effort than trivial ones._ There is no problem to write out a variable as `i` in a for loop or some other short-lived lifetime, but often names are more descriptive. `cwd` is represented as `current_working_directory` (though cwd is an alias of it) provides an example of this. Note that there is still a balance of making terms sufficiently terse that you can still read a line of code coherently. The cwd example above is about the limit of reasonableness in this regard.

Braces are always opened on the line the block is opened on, in the same style as K&R. Spaces are placed between all terms to improve readability.
