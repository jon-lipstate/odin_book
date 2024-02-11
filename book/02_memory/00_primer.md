# Primer for Transitioning to Manual Memory Management

Managed languages offer simplified interfaces to program, making it easier for the developer to get something to work. This ease of use comes at a cost though, and that is control. Because the language is controlling memory, many choices are taken away from the developer that could have significant performance implications.

Manual memory management is often perceived as being too difficult or error prone to be practical for applications programmers. This perception conflates language implementation details (explained in the following section). Modern language features reduce (but do not eliminate) the risk to hit memory errors. Understanding how the hardware, OS and application use memory is critical for success, but once understood, there is very little special knowledge required to write performant applications. Custom allocators offer a path to reaching fine-tuned optimal performance, however using the default allocator is often the right choice in most applications and use cases. It also eases the transition into memory management as there is one less thing to need to be concerned with at the outset.

In this chapter, we will go over the problems that exist in C, and a brief statement about how Odin tackles them. We then discuss the stack versus heap, and follow that with Virtual Memory which is the basis of the heap. We will discuss how the OS protects memory (rwx), and then how it protects applications from each other and other general problems that can result in application crashes. We will lastly explain how Odin lays out a compiled application in memory with each of its sections, and how the OS loads it in to run the application.

## Problems with C Related to Memory & Management

C is specifically selected given its prominence, comparing to Fortran or other manual memory languages first has less overlap with the semantics of Odin, and also far fewer developers know other manual memory languages than C. Many of the perceived difficulties of manual memory are due to C's design. The following samples explain common problems in C, and how Odin addresses them to improve both safety and ergonomics.

Pointer arithmetic is error prone, and confusing to novices. It consists of adding/subtracting n-bytes to an existing address in order to find the correct address of some nearby piece of memory. If the arithmetic is off at all, any data read is corrupted. In Odin this is addressed by the use of the multipointer `[^]` for array-like accesses, and when traditional pointer arithmetic is still required, it lives in the `core:mem` package via the `ptr_offset` procedure. An example where this might still be necessary is when data is packed with headers and each header must be read to unpack the data, and then jump to the next header. **EXAMPLE**

Allocating memory in `C` is done via `malloc` / `calloc` and it is released with `free`. In this regard, Odin has the same requirements via `new`/`free` for normal types such as `structs` and `make`/`delete` for fat-pointer types such as `slices`. Where Odin alleviates the burden of allocation is via the keyword `defer`. Using `defer` allows the deletion call to be made directly adjacent to the allocation call (most of the time). The other feature offered is the `temp_allocator`, which is an arena used specifically for transient data needs. Another allocator is readily available to help detect when de-allocations were missed, the tracking-allocator. It records each allocation and de-allocation. When there is a missing de-allocation, or bad de-allocation, it is able to report that back to the user. The temp & tracking allocators will be covered in **Chapter X**.

In C, arrays are a pointer, the length of the array must be passed separately. It is the developer's responsibility to perform bounds checking to ensure that they do not overrun the array's memory. This is a tedious task and often forgotten. In Odin, slices and slice-like types have builtin length metadata, and by default perform bounds checking. Additionally, in C arrays degrade into a pointer whereas in Odin they are conceptually different types.

Type punning, or the practice of treating a pointer as a different data type than it was originally stored as, is another area that is possible to make an error resulting in misalignment and corrupted memory. In this scenario, there are significant performance/space benefits as well as the ability to use _intrusive_ strategies, so Odin permits it largely unchanged from C. Type alteration must be performed explicitly in Odin, but otherwise this is considered an advanced technique and there are few safeguards as none are really feasible. The builtin `offset_of` helps ensure that the pointer arithmetic performed is correct when performing.

**any other major landmines?**

## Application Startup

When the OS launches an application, it performs a series of steps to prepare the environment for the application to run in. The following is a brief summary of the steps required to run a user-application.

First, a new process is initialized with a unique id (PID) and control block (PCB), which contains metadata about the process. Each process is granted its own isolated Virtual Memory space from the OS to prevent both collisions and also intrusions between independent applications.

Next the executable is loaded into memory, on linux this is the ELF file, on windows it is the PE file. This is parsed to determine where the code & data sections are, as well as dependencies on shared libraries.

The executable code is loaded into the `.text` segment. This segment is given a read & executable permissions, but not write. The `.data` segment contains global and static variables, it is given read-write permissions. Readonly data is placed in the `.rodata` section, which has only read permissions. Each of these segments are granted allocated memory, and then copied into these allocated positions.

Next the OS prepares a contiguous block of memory, the stack. It is used for local variables, procedure calls. Each thread is given its own stack. Stack sizes are limited to 1-8 Mib, depending on the OS. There are ways to adjust the stack size at startup, but this is not typical.

The process marks an initial region for the heap, which is later configured and managed by the runtime.

Where required any symbolic references to memory addresses are relocated to the correct positions once the runtime is loaded. Dynamic linking is performed, if required including loading the dynamic libraries. Similarly, symbolic references are relocated into concrete addresses, such as a procedure pointer.

At this point the application is prepared to run, the OS removes the write and adds the execute permission to the code segment, and hands off control to the entry point. The language's runtime is first initialized, which sets up the base-allocator (e.g. `malloc` in C or `new`/`make` in Odin) and the heap management structures.

Finally, the environment is fully prepared, and control is now passed to the application's entry point (`main`).

---

**maybe just leave terse instead??**

When an OS launches an application, it follows a series of steps to ready the execution environment:

1. **Process Initialization**: Assigns a unique process ID (PID) and control block (PCB) and allocates a separate virtual memory space for process isolation.
2. **Executable Loading**: Loads the executable into memory, parsing it to identify code, data sections, and library dependencies. On Linux, this is an ELF file; on Windows, a PE file.
3. **Memory Segmentation**:
    - `.text` segment for executable code is set to read and execute permissions.
    - `.data` segment for global/static variables is set to read-write permissions.
    - `.rodata` segment for read-only data is set to read permissions.
      These segments are allocated memory and populated accordingly.
4. **Stack Preparation**: Allocates a contiguous memory block for the stack, used for local variables and procedure calls. Each thread receives its own stack, with sizes typically ranging from 1-8 MiB, depending on the OS.
5. **Heap Region Setup**: The process marks an initial region for the heap, which is later configured and managed by the runtime.
6. **Address Relocation and Dynamic Linking**: Adjusts symbolic references to correct memory addresses and performs dynamic linking, including loading necessary dynamic libraries.
7. **Runtime Initialization**: Hands off control to the entry point after setting up permissions. The language's runtime initializes, setting up the base allocator (e.g., `malloc` in C) and heap management structures.
8. **Start Execution**: Control is passed to the application's main entry point (`main`), beginning application execution.

---

**heap and stack ate towards each other in physical memory**

**PICTURE OF ACTUAL MEMORY SPACE - STACK DATA ETC**
https://en.wikipedia.org/wiki/Page_table

## What is the Stack?

**todo** make pic similar to the one with 820 up votes:
https://stackoverflow.com/questions/79923/what-and-where-are-the-stack-and-heap
**ackshually** wikipedia one is better maybe
https://en.wikipedia.org/wiki/Stack-based_memory_allocation

The stack is a contiguous block of virtual memory that is allocated by the OS and given to the application. Each thread in the application has its own stack allocated by the OS to isolate it from other threads. The stack is structured to be last-in, first-out (LIFO), meaning that the last piece of data placed onto the stack will be the first one to be removed. This structure is especially conducive to the way procedures call each other and return values.

The stack operates with two dedicated registers, the Stack Pointer (SP) and the Base (or Frame) Pointer (BP/FP). The stack pointer points to the first free position on the stack, each push and pop adjusts SP. The BP is a stable reference that is set to the state of the stack when first entering the procedure.

When a procedure is called, a new block of memory, called a "stack frame," is created on the stack. This frame contains the procedure's parameters, its local variables, and the address to return control to once the procedure completes. As procedures call other procedures, more frames are added to the stack; as procedures return, frames are removed in the reverse order they were added.

Because the stack is intrinsically linked to procedure scopes, it is automatically managed memory. When returning from a procedure, the stack will return to the same position it was in prior to entering the procedure. Additionally, because the stack is pre-allocated and has its own dedicated registers, it is 'fast' memory. data can be written to it quickly without requesting an allocation to occur from the OS. This makes it an ideal resource for transient data within a procedure. However, because it is limited in size, you must be conscientious of the amount of memory you're placing on the stack. In practice this simply means thinking twice before making large items. Very little changes in practice regarding the stack coming from a managed to an unmanaged language other than the fact that it now explicit when something is stack versus heap allocated. If you did not call `new`/`make`/os-specific direct allocation, it is on the stack\*.

\* Cursed auto init `{}` calling `make`

**TODO** go read this again
https://unix.stackexchange.com/questions/473416/why-on-modern-linux-the-default-stack-size-is-so-huge-8mb-even-10-on-some-di

### Recursion & Stack Overflow

Consider a scenario where a procedure recursively calls itself without storing any data on the stack. The question arises: how many such calls can be made before the stack overflows? For an upper bound estimate, let's initially disregard the preservation of register states at each call (thus momentarily setting aside the specifics of System V or the Microsoft x64 calling convention), focusing on an empty stack where only the Instruction Pointer and return address are stored. Under these simplified conditions, we could expect up to 65,000 recursive calls per megabyte of stack space before an overflow occurs. However, incorporating the need to preserve register states into our calculation—reflecting a more realistic scenario. The number decreases to around 22,000 calls. Any additional data stored (e.g. doing real work) within these calls can significantly reduce this limit to hundreds to low thousands of recursions per megabyte of stack. This illustrates the inherent risk associated with recursive calls without a clear understanding of the recursion depth and required data to be stored at each call.

## Heap Memory

+os examples. important to explain kernel transitions

## Virtual Memory

Nearly all modern CPUs are designed around the concept of virtual memory. The physical memory (RAM) is hidden behind a translation table, presenting the virtual address space to the user's code. This has numerous benefits:

1. Overcommitment: More memory can be reserved than the system has RAM capabilities for.
    - Allows Demand Paging (loading content larger than capacity)
2. Concurrency/Isolation: Each process is given its own isolated address space, it cannot collide with other processes, and other processes may not maliciously access it's memory. This enables significantly more concurrent processes than if it were not the case.
3. Efficiency: Enables the OS to pass out memory via pages and segments.
4. Swap Space: Low-use memory pages can be placed on disk to free up RAM for other processes
5. Abstract Linking: Programs may be linked & loaded to arbitrary locations with the system translating virtual to physical addresses transparently.
6. Enhanced Security: Features like Address Space Layout Randomization (ASLR) leverage virtual memory to improve the security of the system by randomizing the location of memory segments, making it harder for malicious exploits to predict target addresses.

### Physical Implementation

The physical implementation of virtual memory in CPUs relies heavily on the Memory Management Unit (MMU), a critical hardware component. The MMU's primary function is to translate virtual addresses provided by the CPU into physical addresses in RAM, while also implementing memory protection policies to safeguard the system's integrity (read-write-execution permissions). This translation process utilizes a hierarchical tree of Page Tables, up to 5 levels deep.

Within the MMU, the Translation Lookaside Buffer (TLB) serves as a specialized cache for storing recently used address mappings. When a virtual address needs to be translated to a physical address, the MMU first checks the TLB for a cached translation. A successful hit allows the MMU to quickly provide the physical address, bypassing the more time-consuming page table walk.

If the TLB does not contain the mapping (a TLB miss), the MMU initiates a page table walk. This process involves traversing the hierarchical page tables, starting from the highest level down to the specific entry that maps the virtual address to a physical address. Upon locating the mapping, it is cached in the TLB for future access, and the address translation is completed. A failure to find a valid mapping during the page table walk triggers a page fault.

#### Page Faults

When a page fault occurs, the OS intercedes to handle it. Page faults may be caused by the following:

-   Demand Paging: Page is valid, but not in memory
-   Access Violation: Attempting to access invalid memory, or valid memory with incorrect permissions
-   Uncommited Memory: Read/Write from memory that is _reserved_ but _uncommitted_

In the case of Demand Paging, the OS will load the memory into RAM and reattempt the faulted read.
An access violation will terminate the offending application. Uncommitted memory will commit the memory, and continue execution.

### Protections

### Bad Accesses / Segfaults

## Common Memory Errors

-   Overwriting Data

**malloc is basically is a bunch of arenas and a freelist - see how musl implements it**
