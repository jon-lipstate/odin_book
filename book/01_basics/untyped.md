untyped bool, int, float, ptr, string, rune

zeros: esc string "", raw-strings `` (rawstring nice for shaders)

&~ bitclear a & (~b)

-- procs
scoping rules mean a nested value is more tightly bound than a distant value

add::(x,y)

fibonacci::proc(n:int)->int

ASSIGN: COVER swap values

#inline if mandatory unlike C

-- constants
Not like define in C
Constants are not considered even present in the program, until they are used. At that point, they begin to be type-checked and brought into the program. By default they are `untyped T` where the most relaxed type that can be offered is assigned (eg numbers are numbers, an integer value can be implictly cast into a float when consumed). Explicit typing is also permitted.

Compile time constants:
diff :: (pi-close_to_pi)/pi

casting with `as`?

pointer is pascal style, symetric operation LH is decl, RH is deref

^z - ptr to z
z^ - z from ptr

**odin is 100% read left to right**

implicit cast allowed - permits ^T to rawptr

fixed array - len known at comp time so cant OOB it with fixed numbers

array is column major mda:[][][]int// mda[x][y][z]

slices: []T, [0:5],[:5],[:],[3:]

\_ underscore variables to ignore

slicing a string returns substring

[n]f32 allows simd arithmatic
v:=[]int{1,2,3,4}
v2:=swizzle(v,3,2,1,0)

enums are namespaced to the enum

[]int{} is same as ([3]int{1,2,3})[:]
specify only one val to broacast
[3]int{1} is [3]int{1,1,1}
for setting?

procedures are first class, can have procs as args, can even have unnamed procs passed as an arg

\# is used to reduce keywords in the lang

for loop conditions must be boolean unlike C

unified init syntax, same for statements
if x:=2; x<3 { ... }

defer is FILO per scope rules(?)

defer can be applied to a block

struct ptr derefs are implicit:

Thing::struct{x,y:f32}
a:=Thing{}
b:=&a
b.x is same as b^.x

using can be used for subtyping

```odin
frog::struct{
    using _:Entity,
}
```

Live Drunk Coding Jun 2016
spent 2 months effort to get to first demo,spent a month of it just on llvm. name nearly changed, another language named oden.
no name-mangling (proc-groups?)
