No language is omnicsent, these are mistakes that Odin has made in its design:

**bill:**
`using` in procs - (Harms readability, Unless it's a small proc body, Readability, refactoring, pollution of the scope, etc.)

**jon opinion or questions to ask, discuss / verify:**

-   #volatile as a proc (fixable)
-   error value unification on zero (maybe OS-constraints here...)
-   tradeoffs of: implicit vs explicit context (part of context chapter)
    -   duplicate passing of allocator and context (fixable)
-   array-slice diff, pascal had `len->string as single ptr` rather than odin slice (slice ownership when it shouldnt have had it) -walter
-   ^testing.t should have been implicit
-   packages are a tradeoff (namespacing problems, bookmarked graphite's complaints in contrib)

--- walter comments:
foo:int
bar::proc()->(int,bool)
foo, (ok:bool) = bar()

when have a proc type, make proc-lit to assign to proc-type. still have to write full sig. issue is what are param names?

Type :: #type proc(int,bool) <- not so sure that it stores param names
walter idea: lit init is Type(a,b){...}

casting is annoying, the `cast()` needs wrapped if nesting. ^u32() cant cast to u32 ptr
