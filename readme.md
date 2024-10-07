# The Odin Programming Language

I started this project early in the year, but work became too time-consuming for me to continue it. 

Ref for page estimating:

~5 char per word -> 500 word/page
~1500 char/page

## Outline

-   [~] Preface
    -   [x] Origins
    -   [x] Philosophy
    -   [x] Target Audience
    -   [x] Book Organization
    -   [ ] Acknowledgements

## Part 1: The Basics

-   [ ] Getting Started
    -   [ ] Installation
        -   [ ] Windows
        -   [ ] Darwin
        -   [ ] Linux
    -   [ ] Basic Compiler Commands
    -   [ ] Hellope
    -   start with main (what order hit concepts)
    -   [ ] Basic Syntax Overview
        -   [ ] Left To Right
    -   [ ] Style
-   [~] Program Structure
    -   [x] Attr, Tag, Directive Primer
    -   [x] Package Declaration
    -   [x] Import Statements
        -   [ ] Collections (Use & Making of)
    -   [x] Declarations & Assignments
    -   [x] Scopes
    -   [x] Naming Collisions (MOVE THIS)
-   [ ] Basic Types

    -   [ ] Portability Discussion
    -   [ ] Numeric Types

        -   [ ] Endian Types
        -   [ ] Runes + UTF-8 Primer
        -   [ ] Numeric Literals (10,bin,oct,hex)
        -   [ ] String Literals **<- i am homeless**
        -   [ ] RTTI Types (Any, typeid) -> later in book

    -   [ ] Implicit Type

        -   [ ] Implicit Conversion
        -   [ ] Type Conversion

    -   Mathsy

        -   [ ] Complex & Quaternion (SPECIAL SYNTAX)
        -   [ ] Matrices - talk col major storage, row major entry
        -   [ ] Vectors

    -   [ ] Static Arrays

    -   [ ] Pointers

        -   [ ] rawptr
        -   [ ] implict convert to rawptr
        -   [ ] Basics
        -   [ ] Multipointers (slice w/o no-bounds-check)
        -   [ ] C-Style Pointer Arithmetic
        -   [ ] Fat-Pointers

    -   [ ] Slices
    -   [ ] strings
        -   Distinction between what string is (value,backing buffer, builder are all distinct; cant concat because alloc & confuses str+bldr)
        -   str val in practice always immutable
        -   builder is container for backing data
    -   [ ] dynamic
    -   [ ] map (see you later, allocator )

    -   [ ] Zero Values

-   [ ] Structured Types

    -   [ ] Enums

        -   [ ] Backing Types
        -   [ ] Namespaced
        -   [ ] Enumerated Arrays
        -   [ ] Bitmasking (?)
        -   [ ] Uses
        -   [ ] attrs ?
        -   [ ] Directives

    -   [ ] bit_set
    -   [ ] bit_fields

    -   [ ] Structs

        -   [ ] Memory Layout/Packing
        -   [ ] Access Patterns
        -   [ ] Nesting, using for composition
        -   [ ] Procs
        -   [ ] offset_of and examples
        -   [ ] Attrs
            -   [ ] String-Attr
        -   [ ] Directives
            -   [ ] #raw_union
        -   [ ] #SOA Types
            -   [ ] Explanation as a veneer
            -   [ ] Examples + Perf Implications
            -   [ ] Zip/Unzip

    -   [ ] Unions

        -   [ ] Layout
        -   [ ] Tags (dont cheat them)
        -   [ ] Accessing (esp ptr)
        -   [ ] Comparison to Rust Enum

-   [ ] Operators (arithmatic, bitwise, ternary)
    -   [x] Arithmetic, Bitwise
    -   [x] Matrix
-   [ ] Control Flow

    -   [ ] if-else +?:
    -   [ ] switch +fallthrough,break
    -   [ ] for +continue,break
    -   [ ] labels +break-nested
    -   [ ] defer +scopes, +if

-   [ ] Procedures
    -   [ ] Inputs Signature
        -   [ ] Immutable Args
        -   [ ] Auto by-ptr upgrades @>16b
    -   [ ] Outputs Signature
    -   [ ] First Class (can pass as args, can use nameless)
    -   [ ] Body
    -   [ ] Overloads
    -   [ ] Attrs/Directives
            **FWD REF $T**

## Part 2: Memory

-   [ ] Primer on Transitioning Managed to Unmanaged Languages

    -   [ ] Code Memory Layout Block
    -   [ ] What is the Stack?
    -   [ ] Virtual Memory
    -   [ ] Heap Memory +os call samples
        -   [ ] may not have protections
    -   [ ] Bad Access: Segfaults +windows nonsense
    -   [ ] Common Memory Errors
        -   [ ] overwriting data

-   [ ] Context System & Heap Allocation

    -   [ ] Structure Of
    -   [ ] Hidden Arg in procs
    -   [ ] Scope Tied Behavior

-   [ ] Allocators

    -   [ ] Why Custom Allocators?

        -   [ ] Problem Statement
            -   [ ] Sea of Mallocs
        -   [ ] Bill's Size-Lifetime comparison

    -   [ ] Default & Temp Allocators
    -   [ ] Nil Allocator
    -   [ ] Panic Allocator
    -   [ ] Arena Allocator
        -   [ ] Temp Scratch Resets
    -   [ ] Scratch Allocator
    -   [ ] Stack/Small_Stack Allocator
    -   [ ] Dynamic Pool Allocator
    -   [ ] Tracking Allocator

## Part 3: Core/Vendor

-   [ ] Builtins, Intrinsics, Runtime Packages
    -   [ ] Builtins
    -   [ ] Intrinsics
    -   [ ] Runtime
-   [ ] Printing & IO
    -   [ ] stdin/out/err
    -   [ ] formatters
    -   [ ] pros/cons of RTTI based string printing
    -   [ ] use-cases (aprintf, tprintf, sb etc)
-   [ ] Core Libraries

    -   [ ] Overviews of Each
    -   [ ] Detailed examples from:
        -   [ ] strings
        -   [ ] log
        -   [ ] json/csv
        -   [ ] prof
        -   [ ] slice (sorting)
        -   [ ] net

-   [ ] Vendor Libraries
    -   [ ] more general overview, diffs and thing to pay attention in the interfaces (cool things of this lib in Odin)
    -   [ ] Graphics Demos
        -   [ ] Raylib (out of date within a year)
        -   [ ] SDL2
        -   [ ] GLFW (probaly not.. too much openGL?)
    -   [ ] WASM, zlib, lua, stb

## Part 4: Advanced Topics

-   [ ] Compilation
-   [ ] Compiler Flags
    -   [ ] ? todo
    -   [ ] when, ODIN_XX, #config #load
    -   [ ] bat/sh
    -   [ ] Compiler errors (?)
-   [ ] Polymorphism & Constraints
    -   [ ] Simple Paropoly
    -   [ ] Slice Paropoly
    -   [ ] Constraints & Limits
    -   [ ] Coloring of types (eg struct($T))
-   [ ] Correctness
    -   [ ] Bounds-Checks
    -   [ ] ?
    -   [ ] Asserts, Panics
        -   [ ] handlers
-   [ ] Error Handling
    -   [ ] Bools, Unions, Enums
    -   [ ] Aggregate with Union
    -   [ ] or_return, or_else
-   [ ] Testing
    -   [ ] Setting up a Test
    -   [ ] ?
-   [ ] Cross-Platform Support
    -   [ ] OS-Specific Builds
    -   [ ] Git Actions to test other OS (?)
-   [ ] wasm
    -   [ ] Example Project
    -   [ ] JS-WASM Interop
    -   [ ] Memory Limitations
-   [ ] SIMD
    -   [ ] Overview of Vectorization
    -   [ ] Simd usage in Odin (esp in-out)
    -   [ ] Using masks in liue of branching
    -   [ ] When auto-vectorization works well, when it does not
    -   [ ] Sample Use Cases (csv parser?)
-   [ ] Threading
    -   [ ] Intro to Threading +ahmdahls law
    -   [ ] Creating & Managing Threads
    -   [ ] Thread_Local & Arenas (?)
    -   [ ] Issues / Errors (Races etc)
-   [ ] Nonblocking IO (not Odin per-se, reduce down to useful set)
    -   [ ] Event-Driven
    -   [ ] State-Machine
    -   [ ] Callback/Promise
    -   [ ] CSP Model
        -   [ ] Goroutines
    -   [ ] Actor Model
        -   [ ]
-   [ ] Reflection & RTTI
    -   [ ] Concepts & Limitations
    -   [ ] Examples
    -   [ ] Perf impact (?)
-   [ ] Metaprogramming
    -   [ ] core:odin/ast/parser/tokenizer
    -   [ ] Demo: Sig-Scraper
-   [x] Entry Point & Runtime
    -   [ ] ?

## Part 5: FFI & Building

-   [ ] FFI System
    -   [ ] Foriegn with Obj/Lib
    -   [ ] nasm (nix?)
    -   [ ] DLLs
    -   [ ] Hot-Reload
-   [ ] Bindings Generation
    -   [ ] CUIK Bindgen
    -   [ ] Odinic Bindings Wrappers
-   [ ] Linking
    -   [ ] explain linker so understand errors, static lib
    -   [ ] obj->lib
    -   [ ] ?
-   [ ] Interop (To-From Odin)
    -   [ ] No-Context
    -   [ ] Call From: Python, ?
    -   [ ] Embed Lua (skytrias or Lua Whiperer)
-   [ ] VTables & COM API
    -   [ ] Making a VTable
    -   [ ] How to use COM API
    -   [ ] Objective-C Nonsense (ask bill)
    -   [ ] ?

## Part 6: Misc

-   [ ] Related Projects
-   [ ] Why not Feature X?
-   [ ] Freestanding (?)
    -   [ ] Kernel Demo (?)
    -   [ ] RPI Blinky (?)
-   [ ] Larger Samples

## Part 7: Reference Manual

-   [ ] lang-spec

-   [ ] "big demos" Tetris, snake, checker, sokoban, pong?

-   ODIN for C-PROGRAMMERS
