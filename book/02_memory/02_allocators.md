# Custom Allocators

-   [ ] Why Custom Allocators?

    -   [ ] Problem Statement
        -   [ ] Sea of Mallocs
    -   [ ] Bill's Size-Lifetime comparison

## Size & Lifetime

When dealing with allocation, the two critical pieces of information is to know how long it must live (lifetime), and how much space does it use (size). The following table shows the general fraction of values that fall in each category and the idiomatic allocation strategy that would correspond to them. The allocation strategies themselves will be covered in detail in the following chapter.

| Lifetime | Size    | Percent | Typical Allocation Strategies |
| -------- | ------- | ------- | ----------------------------- |
| Known    | Known   | 95%     | Arena                         |
| Known    | Unknown | ~4%     | Freelist, Malloc              |
| Unknown  | Known   | ~1%     | Ref Counting                  |
| Unknown  | Unknown | <1%     | Garbage Collection            |

**TODO: update per article**

https://www.gingerbill.org/article/2019/02/01/memory-allocation-strategies-001/

## Default & Temp Allocators

## Custom Allocators

for each: Aliases, Explain it, Pros/Cons, When is appropriate choice, Examples of use

### Tracking Allocator

### Arena Allocator

### Nil Allocator

acts as nop (preallocated array, replace with nil to ensure no growth)

### Panic Allocator

#### Temp & Scratch Resets

### Scratch Allocator

### Stack Allocator

#### Small_Stack

### Dynamic Pool Allocator

freelists are fixed/variable with

odin cannot support GC. really needs to be at language level

can support manual ref counting
