# The Odin Programming Language

~5 char per word -> 500 word/page
~1500 char/page

## Preface

-   The Origins of Odin
-   Philosophy (imperitive procedural, Data Oriented, multi-platform support etc, usage-patterns & psychology vs mathematical basis of decision making)
-   Target Audience (Teach Odin, not programming, should be able to read macro-free C, have cursory understanding of C's semantics)
-   Organization of the Book / How to Use the book?
-   Where to Find More Information
-   Acknowledgements

## Chapter: Getting Started

-   Installation
-   Basic Compiler Commands
-   Hellope
-   A slightly more complicated example, Raylib demo?
-   Basic Syntax Overview (?)

## Chapter: Program Structure

-   Primer on attributes, directives, build system directives
-   Package Declaration / File Structure
-   Import Statements (?)
-   Uniform Syntax for Assignment/Declaration (:: and :=) (fancy #define for ::)
-   Procedures
    -   Multiple Return Values
-   Scopes
-   Naming Collisions

## Chapter: Operators

## Chapter: Printing and IO

## Chapter: Primer on Transitioning Managed to Unmanaged Languages

## Chapter: Control Flow

-   If/Else
-   Switch
-   For Loop
-   Break, Continue, fallthrough
-   Labels

## Chapter: Basic Types

    NOTE: builtin types are lowercase

-   Machine Size, endianness, portability
-   Explicit Type Conversions
-   Zero-Values & nil, ---, {}
-   Implicit Type System (Untyped Types)
    -   Numerical Literals
        -   Base-10 (default), binary, octal, hex
    -   String-literals
    -   Implicit Conversions
-   Type Conversion (Casts, Transmutes, auto_cast)
-   bool,int,float, be/le,
-   rawptr
-   complex, quaternions \*\*special syntax
-   runes
-   strings/cstrings (utf8 primer)
-   RTTI Types: any, typeid

## Chapter: Composite Types

-   Cover Base Item, then Attributes & Directives that can apply
-   Structs: Memory Layout, Access Patterns, Nesting, Procs, examples
-   Enums: backing types, values, bitmasking(?), Common Uses for Odin
-   Unions: shared memory, Tagged Explaination, Accessing esp ptr
-   Avoiding Common Mistakes

## Chapter: Arrays, Slices & Matrices

-   Static-Arrays, (point out :: faux pas), stack-allocated and risks, slicing
-   Slices Layout, Cheapness, accessing, iterating
-   Matrices: stack-allocated

## Chapter: [dynamic] & map

-   Subchapter ?

## Chapter: Pointers

-   Basics
-   Multipointers
-   c-style arithmatic
-   ?

## Chapter: Procedures

-   values immutable
-   auto by-ref
-   explicit ptr when mutating
-   return values, types, naming, return signature
-   default values
-   overload

## Chapter: Context System & Heap Allocation

-   structure of context
-   Nesting downwards, show how to recover the default context
-   show example of losing things from context because of nesting
-   new/free, make/delete

## Chapter: Allocators

-   go over each type of allocator in detail

## Chapter: Collections

## Chapter: Polymorphism & Constraints

## Chapter: FFI System

-   nasm
-   c

## Chapter: Binding Generation

## Chapter: Linking

-   using obj,lib,dll

## Chapter: Interop

-   C++(?),Fortran(?),python/julia?
-   using Odin from other languages, restrictions
-   lua integration

## Chapter: VTables (->) & COM API

## Chapter: Error Handling

-   panic, debug_trap, enums bools etc

## Chapter: Idioms

-   (len(a) < 3) or_return

## Chapter: Style

## Chapter: Reflection

## Chapter: Builtin & Intrinsics

## Chapter: Core Libraries

## Chapter: Vendor Libraries

## Chapter: Testing

## Chapter: Metaprogramming

## Chapter: Paralellism

-   threads & simd, or just threads?

## Chapter: STDIN/OUT/ERR

## Chapter: Related Projects

-   OLS
-   Tilde
-   Spall

## Common Uses

-   file IO
-   Serialization/JSON
-   user IO
-   Networking
-   ?

## Why not Feature X?

-   classes/objects
-   methods
-   garbage collection
-   async / await
-   relaxed typecasting
-   comptime
-   moar reflection
-   vtables
-   release flag
-   rust enums
-   ?
