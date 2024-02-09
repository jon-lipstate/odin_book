# Custom Allocators

- [ ] Why Custom Allocators?

  - [ ] Problem Statement
    - [ ] Sea of Mallocs
  - [ ] Bill's Size-Lifetime comparison

## Size & Lifetime

When dealing with allocation, the two critical pieces of information is to know how long it must live (lifetime), and how much space does it use (size). The following table shows the general fraction of values that fall in each category and the idiomatic allocation strategy that would correspond to them. The allocation strategies themselves will be covered in detail in the following chapter.

| Lifetime | Size    | Percent | Typical Allocation Strategies    |
| -------- | ------- | ------- | -------------------------------- |
| Known    | Known   | 75-90%  | Arena, Stack, Freelist           |
| Known    | Unknown | 15-20%  | Pool                             |
| Unknown  | Known   | 5-10%   | Arena, Freelist                  |
| Unknown  | Unknown | 0-1%    | Garbage Collection, Ref Counting |

## Default & Temp Allocators

## Custom Allocators

for each: Aliases, Explain it, Pros/Cons, When is appropriate choice, Examples of use

### Nil Allocator

### Panic Allocator

### Arena Allocator

#### Temp & Scratch Resets

### Scratch Allocator

### Stack Allocator

#### Small_Stack

### Dynamic Pool Allocator

### Tracking Allocator
