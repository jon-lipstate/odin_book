## Preface

TODO

### Origin Story

a new years resolution was to make a new project in pure c to find what wanted in a language. cpp is the best of the worst. scripting langs not as good as c. c std lib is dreadful. if using c, must meta-program it. inspired by sean barrett on tools dev. started with single file header lib gb.h. had allocators, concurrency, platform layers, opengl and so on. on a night of drinking and watching a stream of sean mcgrath, got a wild hare to make a language. it was not a good impl, bill was quite toasted after all, but the seed was planted. Later he investigated and ruled out numerous languages, and returned to the idea of making his own.

### Design Philosophy

pragmatic design - solve actual problems
doesnt restrain the programmer (if want to do unsafe, let them)
high performance
simplicity & consistency
express in modern way, eg matlab vector adds
-simd, concurrency
sanity: fast compile, less tooling needs (no pkg mgr etc), better refactoring
metaprogramming capability

WHY NOT:
errors are just values like go. exceptions are dreadful.
raii: odd concept, linking data to create delete of it -> defer/scope_exit instead
oop: let data be data, no desire to orient around anything, the goal is solely to solve the problem
mem-alloc: gc is never needed (95% of all allocs are lifetime and size, fully deterministic), (3-4% know lifetime but not size) (know size but not lifetime, solve by RC) (dont know size or lifetime, needs GC, should ever get here)

llvm byte code from start
first demo Aug 2016

### Book Organization

TODO

### Target Audience

This books strives to strike a balance between being a comprehensive reference manual and an engaging, accessible book. It is intended to aid in learning the Odin Programming Language, but it is _not_ intended to teach programming itself. Language features will be presented in examples prior to thier formal introduction. For those coming from other languages, most of these features should be intuitive, but a novice is likely to be overwhelmed.

Experience with C will provide the most intuitive onramp to understanding Odin. Understaning C's macro-madness is not required, Odin does not use macros. Odin leans heavily into the lineage and idioms of C, retaining many of its excellent features, and shedding the cruft and lost opportunities accrued over the decades. If you do not understand C, take heart as many commonly used languages fall into the same lineage as C, descendants of Algol, making understanding and reasoning about code _similar_.

#### Programmers from an Object Oriented Lineage

When transitioning from Object-Oriented languages to Odin, a key adjustment involves the conceptual separation of data from operations on data. This shift can initially feel awkward for those accustomed to the OO approach, where data and methods are encapsulated together in classes. Odin does offer polymorphism (Generics), which will be familiar, though they are not used nearly as extensively in Odin as might be in an OO language. These differences are a design decision of Odin, with the goal of providing clarity in operations and eliminating excessive abstraction or over-application of taxonomies. Object-Oriented programmers, once adapted will find the simplicity of Odin's design refreshing compared to the unintentional complexity that arises in many OO codebases.

#### Programmers from a Functional Lineage

Transitioning to Odin's imperative procedural style presents a significant paradigm shift. Functional programming, with its emphasis on immutability, pure functions, and higher-order functions, differs markedly from the imperative approach. In Odin uses explicit state management and step-by-step sequences of operations. This change requires adapting to a mindset where data is often manipulated directly rather than through the composition of functions. Despite these differences, functional programmers can leverage their skills in reasoning about program flow and applying mathematical logic to problem-solving.

#### Transitioning from Memory-Managed Languages

Chapter XX serves as a primer on working in a manual memory language, written specifically to help ease the transition of those not versed in memory management. It is placed at the end of Part 1, after which we begin to start dealing with user-allocated memory. The performance and reasoning benefits manual memory management offer far outweigh the costs of needing to be concerned about it, but there is a learning curve to internalize it.

#### Use Cases

Odin has excellent capabilities for tooling, computer graphics, game-development and general systems programming. It is a fully cross-platform language with builtin platform-specific tooling, making it well suited for the fabled write once deploy anywhere claim.

As of the time of writing this book, the language does _not_ have strong tooling for web-servers, Async-Await or Garbage Collection. If there are C-ABI libraries that fill the niche, Odin's foriegn binding system makes bindings generation and usage trivial. Additionally, Odin is perhaps not the best choice for scripting or glue code, simpler languages like Python are likely a better choice in those domains. Embedded Systems & Mobile support are nascent, they are not officially supported at this time, but may be in the future. Note that Odin supports _only_ 32 and 64 bit systems with no intention of ever supporting less than 32 bit systems.

### Where to Find More Information

TODO

### Example Snippets

Many snippets are provided in the book; if each snippet were able to be entirely copy-pasted into running examples, there would be considerable repeated boilerplate. When deemed useful, full, runnable examples are provided. However in most cases some omissions will occur. These are not setting a package declaration, not showing imports (though names will not be aliased, so you can add the import easily) and showing snippets of code outside of procedure bodies. These omissions are done in the name of berevity and clarity. After reading the Chapter on Program Structure, you should be able to trivially modify any snippet into executable code.

```odin
package fully_specified_example

import "core:fmt"
import "core:os"

main :: proc() {
    input_args: []string = os.args // arguments passed to the application
    for arg in input_args {
        fmt.println(arg)
    }
}
```

A shortened example snippet might be as follows, with perhaps the goal being to show examples of capturing application args, `for` loops, or iteration of slices using the `in` syntax.

```odin
for arg in os.args {
    fmt.println(arg)
}
```

### Acknowledgements

TODO

---

### move this

The language strives to offer fine-grained control over memory with strong assurances on type-safety as well as no undefined behavior on all officially supported platforms. There is not hidden control flow, there are no macros, the language is very conservative in its choices of features, taking the best knowledge of the past 50 years of language development. It is quite plain in this regard, everything is centered around solving real problems without having ponder advanced mathematical concepts to simply reason about basic programming. Because of this, there is a zen-like clarity that arises from Odin, making reading and reasoning about it clearer than other languages. The tagline of _Joy in Programming_ is the natural result.
