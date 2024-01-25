## Preface

**TODO**

### Origin Story

In 2016, Bill Hall set a New Year's resolution that would mark the beginning of an ambitious journey in the world of programming languages. Fueled by his dissatisfaction with C++, which he described as the "still the best language around, unfortunately" he aimed to embark on a new project written entirely in pure C, replacing the dreadful standard library. He found inspiration in Sean Barrett's single-file header libraries for tool development and stream _Advice for writing small programs in C_. This led to the creation of his own header library, gb.h, which laid the groundwork for what he sought in a programming tool – custom allocators, concurrency, platform layers, OpenGL, and more. Languages are often not the problem, the libraries are. And many libraries were stuck in paradigms of the early 90s.

One eventful evening, after enjoying a few pints and watching a Sean McGrath stream, Bill was struck by a spontaneous idea to create his own programming language. Although the initial attempt, slightly impaired by the evening's libations, was far from perfect, it planted a seed in his mind. He initially toyed with a Pascal clone, attempting to enhance the C-preprocessor to expand the capabilities of his toy language. However, this approach soon proved to be a dead end, bogged down by the inherent limitations and accumulated complexities of C. It was at this point that Bill decided to break free from the constraints of patching C's flaws and embarked on the journey of building a new language from scratch.

He dedicated approximately two months to developing the first demo of this new language, which he showcased in a live stream at the end of August 2016. For context, this era was significant in the landscape of programming languages: Rust, a language that emphasized safety and performance, had celebrated its first stable release nearly a year prior, signaling a shift towards more modern and robust systems programming. Concurrently, the early development of Jai, was being live-streamed, capturing the interest of the game-dev community, though it remained inaccessible for public use. Similarly, Zig was independantly also in its nascent stages of development. This simultaneous emergence of several innovative languages, including Odin, reflected a broader sentiment within the programming world — a desire for modern, effective and safe tools for software development. Odin, with its own unique features and philosophy, thus entered the scene at a time ripe with potential and appetite for new solutions in the realm of programming languages.

From there the language has steadily improved and grown a close knit community formed around it. Today Odin has moved well beyond a hobby project borne of frustration to a practical language solving real problems used on multiple commercial projects.

#### Language Influence

**TODO: not sure if i keep this? maybe more useful as research than materials...**

The overarching design philosophy of Odin is significantly inspired by Niklaus Wirth and Rob Pike. Wirth’s approach to creating languages that are Simple, Minimal, Clear, Efficient & Modular. Wirth believed that languages should only include the features neccesary to achieve thier goals, and should be simple to learn and _know_. The simplicity of the language makes it clearer to readers what is occuring, making for easier maintainace and learning. Wirth was an advocate of strong type systems to minimize the proliferation of statically analyzable defects; Types improve clarity. Wirth found it distasteful to waste resources because they were cheap, he strived to make efficient use of what was available.
Wirth’s philosophy of “less is more” is evident in his approach to modularity. He believed in providing just enough language features to support robust and efficient software development without overcomplicating the language.

Rob Pike, one of the key figures behind Go, echos the sentiments of Wirth in his designs, he aims for a small tangible footprint that provides the features a language needs and no more. He brought forward first class concurrency, made quality tooling a priority and designed for collaborative development in the language via clear unambiguous syntax, and a concise modules system.

#### Initial Design Goals

**these were bills 2016 goals, present goals are not exactly the same**

The initial design goals of Odin were founded on a set of principles that aimed to address real-world programming challenges with a blend of modern capabilities and pragmatic design.

Odin's central theme is to have a pragmatic design; it aims to solve real problems. It prioritizes practicality, focusing on providing tools and features that are directly useful in the development process. This approach is a departure from theoretical or overly abstract designs many of the other languages of the era were pursuing.

Another key aspect of Odin's design philosophy is not to restrain the programmer. It acknowledges that there are times when operations that might be considered unsafe need to be done. Instead of imposing strict limitations, Odin uses intentional friction to guide developers down the language's preferred path, but should they decide to go the another way, it will not prevent them from doing so.

High performance is a cornerstone of Odin. It's designed to facilitate efficient and optimized code, ensuring that performance is a primary consideration in its features and capabilities. This is particularly evident in its support for modern hardware features like vector instructions and concurrency mechanisms, making it well-suited for computationally intensive tasks.

Simplicity and consistency are also central to Odin's design. The language aims to be straightforward and intuitive, avoiding unnecessary complexity. This simplicity is balanced with a strong focus on maintaining consistency across the language, making it easier to learn, understand, and apply in various contexts.

It embraces contemporary advancements in computing, such as SIMD (Single Instruction, Multiple Data) for efficient data processing and robust concurrency models, essential for modern multi-threaded and parallel computing tasks.

Sanity in the development process is another design goal. Odin emphasizes fast compilation times and minimizes the need for extensive tooling. This includes a deliberate decision to avoid complex package managers, thereby simplifying the development workflow and making code refactoring more manageable.

Lastly, metaprogramming capabilities in Odin allow for writing more expressive and flexible code. This feature enables developers to write code that can generate or manipulate other code, providing a powerful tool for creating highly adaptable and dynamic software solutions. This goal has faded to a backburner position over time as the language has matured. Rather than apply metaprogramming, many domains that would have been metaprogrammed simply became language features.

### Design Philosophy

**TODO: this feels more like marketing than the psych angle i wanted to go for...**

Odin is the embodiment of half a century's progress in software development, meticulously synthesized into a coherent and unified language. Its design philosophy does not chase novelty. Instead, Odin adopts a measured, conservative approach in its choice of features. It aspires to offer an adequate number of functionalities, eschewing the complexities and the consequent emergence of dialects characteristic of more elaborate languages.

A prominent element of Odin's design is its focus on the practical application and the behavior of developers in real-world scenarios. The language is crafted with a discerning perspective on the actual use of features, beyond theoretical considerations. Hence, if a feature, ostensibly advantageous in theory, proves to be commonly misused or detrimental in practice, it is subject to exclusion. (Inquire with Bill for specific examples, and possible exceptions.)

The ethos of Odin prioritizes practicality and the ease of understanding over the intricacies of abstract mathematical concepts. This guiding principle is evident across the language's spectrum, as its features are not only logically coherent but also intuitively graspable. The result is a language that aligns with the cognitive processes of developers, rendering the act of programming in Odin both natural and gratifying.

In amalgamating real-world usage patterns with a judicious selection of features, Odin stands as a language that respects the rich heritage of software development. It offers a suite of tools that are pertinent, efficacious, and appealingly accessible in the context of contemporary programming.

### Book Organization

The difficulty in writing a book on a programming language is that languages operate whollistically, attempting to tease apart a linear introduction of the language without some level of previously assumed knowledge on languages in general leans into teaching programming itself, which is outside the scope of this book. As such, the book tries to organize topics fairly linearly, but does not concern itself with guaranteeing a topic has been formally introduced prior to usage or demos.

Part 1: The Basics
In the initial segment of this book, the reader is methodically introduced to the Odin programming language in as linear a fashion as practical. It commences with an overview of installation procedures and basic syntax, progressing through the structural elements of Odin programs such as package declarations and scope management. A detailed examination of basic types, their conversion, and initialization principles lays the groundwork for subsequent chapters. The exploration of structured types, pointers, and their associated paradigms reinforces the reader's grasp on Odin's approach to data organization and manipulation.

Part 2: Memory
Part 2 delves into manual memory management, a critical aspect of programming in Odin. This section provides a primer on transitioning from managed languages, fostering an understanding of the stack and heap, and the nature of virtual memory. The Implicit Context System is reviewed, showing how it propegates allocators, and is a point at which the user can anchor thier own custom data. A comprehensive study of custom allocators emphasizes the significance of memory management tailored to specific application needs.

Part 3: Core and Vendor Libraries
In Part 3 the core and Vendor collections are reviewed. Most packages have only cursory discussion, simply to know when you may wish to investigate them further. Selected packages have much more in depth review with several examples to ensure these commonly tread packages are concretely understood.

Part 4: Advanced Topics
Advanced Topics introduce to more specific or specialized use cases. This section covers setting up build scripts, error handling techniques in Odin, polymorphism, cross-platform support, concurrency, vectorization, reflection, metaprogramming and **...**

Part 5: FFI and Building
Part 5 focuses on the Foreign Function Interface (FFI) system in Odin and building/linking. This section elucidates the process of integrating Odin with other languages and systems, demonstrating the creation and usage of bindings, managing dynamic libraries, and delving into interoperability concerns. It also goes over compiler flags in depth.

Part 6: Miscellaneous
A wide range of diverse and supplementary topics are explored. This includes an overview of related projects within the Odin community, discussions on feature requests and decisions, larger code samples, and a look at freestanding and embedded applications. The section also delves into graphics programming, showcasing Odin's capabilities in this domain.

Part 7: Reference Manual
**hopefully is avail by then..?**

### Target Audience

This books strives to strike a balance between being a comprehensive reference manual and an engaging, accessible book. It is intended to aid in learning the Odin Programming Language, but it is _not_ intended to teach programming itself. Language features will be presented in examples prior to thier formal introduction. For those coming from other languages, most of these features should be intuitive, but a novice is likely to be overwhelmed.

Experience with C will provide the most intuitive onramp to understanding Odin. Understaning C's macro-madness is not required, Odin does not use macros. Odin leans heavily into the lineage and idioms of C, retaining many of its excellent features, and shedding the cruft and lost opportunities accrued over the decades. If you do not understand C, take heart as many commonly used languages fall into the same lineage as C, descendants of Algol, making understanding and reasoning about code _similar_.

#### Programmers from an Object Oriented Lineage

When transitioning from Object-Oriented languages to Odin, a key adjustment involves the conceptual separation of data from operations on data. This shift can initially feel awkward for those accustomed to the OO approach, where data and methods are encapsulated together in classes. Odin does offer polymorphism (Generics), which will be familiar, though they are not used nearly as extensively in Odin as might be in an OO language. These differences are a design decision of Odin, with the goal of providing clarity in operations and eliminating excessive abstraction or over-application of taxonomies. Object-Oriented programmers, once adapted will find the simplicity of Odin's design refreshing compared to the unintentional complexity that arises in many OO codebases.

#### Programmers from a Functional Lineage

Transitioning to Odin's imperative procedural style presents a significant paradigm shift. Functional programming, with its emphasis on immutability, pure functions, and higher-order functions, differs markedly from the imperative approach. In Odin uses explicit state management and step-by-step sequences of operations. This change requires adapting to a mindset where data is often manipulated directly rather than through the composition of functions. Despite these differences, functional programmers can leverage their skills in reasoning about program flow and applying mathematical logic to problem-solving.

#### Transitioning from Memory-Managed Languages

Chapter XX serves as a primer on working in a manual memory language, written specifically to help ease the transition of those not versed in manual memory control. It is placed at the end of Part 1, after which we begin to start dealing with user-allocated memory. The performance and reasoning benefits manual memory management offer far outweigh the costs of needing to be concerned about it, but there is a learning curve to internalize it.

### Use Cases

Odin has excellent capabilities for tooling, computer graphics, game-development and general systems programming. It is a fully cross-platform language with builtin platform-specific tooling, making it well suited for the fabled write once deploy anywhere claim.

As of the time of writing this book, the language does _not_ have strong tooling for web-servers, Async-Await or Garbage Collection. If there are C-ABI libraries that fill the niche, Odin's foriegn binding system makes bindings generation and usage trivial. Additionally, Odin is perhaps not the best choice for scripting or glue code, simpler languages like Python are likely a better choice in those domains. Embedded Systems & Mobile support are nascent, they are not officially supported at this time, but may be in the future. Note that Odin supports _only_ 32 and 64 bit systems with no intention of ever supporting less than 32 bit systems.

### Where to Find More Information

Discord, reddit **what else?**

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

**TODO**

---

### move this

The language strives to offer fine-grained control over memory with strong assurances on type-safety as well as no undefined behavior on all officially supported platforms. There is not hidden control flow, there are no macros, the language is very conservative in its choices of features, taking the best knowledge of the past 50 years of language development. It is quite plain in this regard, everything is centered around solving real problems without having ponder advanced mathematical concepts to simply reason about basic programming. Because of this, there is a zen-like clarity that arises from Odin, making reading and reasoning about it clearer than other languages. The tagline of _Joy in Programming_ is the natural result.
