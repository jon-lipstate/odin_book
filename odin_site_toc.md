Introduction
Hellope!
Lexical elements and literals

Comments
String and character literals
Escape Characters
Numbers
Variable declarations
Assignment statements
Constant declarations
Packages
import statement
Exported names
Authoring a package
Organizing packages

Control flow statements
for statement
Basic for loop
Range-based for loop
for reverse iteration
if statement
switch statement
#partial switch
defer statement
when statement
Branch statements
break statement
continue statement
fallthrough statement

Procedures
Parameters
Multiple results
Named results
Named arguments
Default values
Explicit procedure overloading
Rationale behind explicit overloading

Basic types
Zero values
Type conversion
Cast operator
Transmute operator
Untyped types
Auto cast operation

Built-in constants, values, and procedures
Built-in procedures

string type
string iteration
string format printing
cstring type
string type conversions
From string to X
From cstring to X
From a string literal to X
From []u8 to X
From []rune to string
From [^]u8 to cstring
From [^]u8 and length int to string

Operators
Arithmetic operators
Comparison operators
Logical operators
Address operator
Ternary Operators
Other operators
Operator precedence
Integer operators
---Integer overflow
Floating-point operators

Advanced types
Type alias
Distinct types
Fixed arrays
Array programming
Slices
Slice literals
Slice shorthand
Nil slices
Sort slices
Dynamic arrays
Appending to a dynamic array
Inject / Assign to a dynamic array
Removing from a dynamic array
Slice & Sort a dynamic array
Making and deleting slices and dynamic arrays
Clearing a dynamic array
Resize / Reserve with a dynamic array
Small\*Array(N, T) container dynamic array
Enumerations
Implicit Selector Expression
Iterating an Enumeration
Enumerated Array
Bit sets
Pointers
Structs
Struct literals
Struct tags
Unions
Type switch statement
Union tags
Maps
Map Container Calls

Procedure type
Calling conventions
‘typeid’ type
‘any’ Type
Multi Pointers

SOA Data Types
SOA Struct Arrays
SOA Struct Slices and Dynamic Arrays
soa_zip and soa_unzip

matrix type
Submatrix Casting
Technical Information of matrix Types

raw_data procedure
using statement
Using statement with structs
Subtype polymorphism
or_else expression
or_return operator

Conditional compilation
File suffixes
when statements
Command-line defines
Build tags

Implicit context system
Allocators
Explicit context Definition

Logging System

Foreign system

Using a vendor library

Parametric polymorphism
Explicit parametric polymorphism
Procedures using explicit parametric polymorphism (parapoly)
Data types using explicit parametric polymorphism (parapoly)
Implicit parametric polymorphism
Procedures using implicit parametric polymorphism (parapoly)

Specialization
where clauses
-> operator (selector call expressions)

Attributes
General attributes
@(private)
@(require)
Linking and foreign attributes
@(link_name=<string>)
@(link_prefix=<string>)
@export or @(export=true/false)
@(linkage=<string>)
@(default_calling_convention=<string>)
@(link_section=<string>)
@(extra_linker_flags=<string>)
Procedure attributes
(deferred\*\*=<proc>)
@(deprecated=<string>)
@(require_results)
@(warning=<string>)
@(disabled=<boolean>)
@(init)
@(cold)
@(optimization_mode=<string>)

Variable attributes
@(static)
@(thread_local)
Specialized attributes

Directives
Record memory layout
#packed
#raw_union
#align
#no_nil

Control statements
#partial
Procedure parameters
#no_alias
#any_int
#caller_location
#c_vararg
#by_ptr
#optional_ok

Expressions
#type
Statements
#bounds_check and #no_bounds_check

Built-in procedures
#assert(<boolean>)
#panic(<string>)
#config(<identifer>, default)
#defined
#file, #line, #procedure
#location() or #location(<entity>)
#load(<string-path>) or #load(<string-path>, <type>)
#load_or(<string-path>, default)
#load_hash(<string-path>, <string-hash>)

Useful idioms
Basic idioms
Ternary operator
If-statements with initialization
Iterating through slices of structs by value or by reference
‘defer if’
‘Maybe(T)’

Advanced idioms
Implicit Type Conversions
Extra Information
What to do if you get stuck
