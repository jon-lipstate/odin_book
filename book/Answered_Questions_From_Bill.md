1. Why an Implicit context vs Explicit like Zig uses?

   The implicit context I've written about in the overview and FAQ already, but most people really misunderstand it even when they read it. It's for intercepting third-party code because most people will not use custom allocators and only the defaults, but the context allows you to override it when others don't even use it.

2. Pros/Cons of RTTI vs comptime printing?
   As for RTTI vs comptime (Zig-term) printing, comptime bloats the executable like mad because it's an exponential issue. And I mean exponential, not power-law.

3. complex & quat, why not structs?
   Complex and quaternions not haveing T{} structure is just me not having them supported with that syntax yet. That's about it.

types reformat:
what it be
what it do
