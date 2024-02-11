# Implicit Context System

most people never need or use it, so offer to skip this chapter initially

**TODO: turn this + bills blog into a why it exists section**

1. Why an Implicit context vs Explicit like Zig uses?

    The implicit context I've written about in the overview and FAQ already, but most people really misunderstand it even when they read it. It's for intercepting third-party code because most people will not use custom allocators and only the defaults, but the context allows you to override it when others don't even use it.

    intercept 3rd party for log & alloc

    explicit alloc -> people get lazy and make it global. cant override custom;

## Structure

## Hidden Arg

## Scope-Tied Behavior
