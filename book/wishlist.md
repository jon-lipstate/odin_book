--- open ---

--- discussed with bill ---

`#shadow` + `-ban-shadowing` compiler flag

dont like auto init `{}` or make-on-append for dynamic and map... too magical

-   bill: prefer make over panic; hate {} but need it. policy need to delete regardless
-   if explicit make, just allocator or add len/cap

compiler: ordered errors, structured errors
compiler: terse errors need to be properly terse

-   todo: Structured; delayed till hit N-errs

compiler: basic front end return stack allocator

-   todo

compiler: testing.t -> useful for runners (not implicit thing)
