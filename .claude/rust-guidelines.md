# Rust guidelines

Rust-specific rules. The global rules in `CLAUDE.md` still apply.

This file has two parts:
1. **Personal guidelines**: rules specific to my projects.
2. **Google Rust Style Guide**: rules from Google's published guide.

Where the two parts covered the same topic, only the Google version is kept, in Part 2. Those topics are API guidelines and `expect` vs. `unwrap`.

## Reporting guideline violations
- When asked to check Rust code against these guidelines, list each
  mismatch with:
  1. The rule it breaks and which part it comes from (Part 1 or Part 2).
  2. A one-line explanation of what doesn't match.
  3. A very small before/after Rust example showing how to comply.
- Don't edit the code unless asked; report only.

---

# Part 1: Personal guidelines

## Dependencies
- Add dependencies with `cargo add`.

## Error handling
- In code that uses `eyre` or `anyhow` `Result`s, add `.context()` before every `?` propagation.
- Write context messages in simple present tense, completing the sentence "while attempting to ...".

## Debugging
- For ad-hoc debugging, create a temporary example in `examples/`, run it with `cargo run --example <name>`, and remove it after use.

## Testing frameworks
- **`quickcheck`**: property-based testing when you have an obviously correct implementation to compare against.
- **`insta`**: snapshot testing for regression prevention. Run `cargo insta test` in place of `cargo test`.

## `compile_fail` tests
- Use `compile_fail` doctests to verify that certain code must not compile, e.g. type-state patterns or trait-based enforcement.
- Each test should target one specific error condition: the doctest only reports whether compilation failed, not why.
- Explain clearly exactly why the code should fail to compile.
- If there is no obvious item to attach the doctest to, create a private item with `#[allow(dead_code)]` for the tests, and document that this is its purpose.
- Before committing, create a temporary example for each `compile_fail` test, check that `cargo run --example <name>` fails for the correct reason, then remove the example.

---

# Part 2: Google Rust Style Guide

Source: <https://google.github.io/styleguide/rustguide.html>, fetched 2026-10-27. The page gives no version or last-updated date.

The rules are paraphrased from the page, not quoted. Rules that apply only to Chromium, Android or Fuchsia are left out on purpose, because they don't apply to my projects. These include `chromium::import!()`, the flat `rust_library` layout, the ban on `async`, the ban on `std` threads, `fuchsia_sync::Mutex`, and the per-codebase test frameworks.

## Principles
- Prioritize readability and maintainability over how easy the code is to write.
- Favor automation and stay consistent with the wider Rust ecosystem.

## Public Rust style rules and API design
- Follow the official Rust Style Guide and the Rust API Guidelines (<https://rust-lang.github.io/api-guidelines/checklist.html>), except where they conflict with this guide.
- Let rustfmt enforce formatting.
- **Library code:** the API design rules are binding.
- **Application code:** the API design rules are a strong recommendation. Favor simplicity and directness, and avoid premature generalization and abstraction.

## Code organization
- Prefer small crates focused on one abstraction. Consider crate boundaries before adding submodules.
- Name source files and leaf modules after their primary item: `Foo` lives in `mod foo` / `foo.rs`.
- Non-leaf modules should contain only module declarations and re-exports, plus at most a little code that ties things together.
- **No glob imports.** Exceptions:
  - `use super::*` in inline modules, such as tests.
  - `use MyEnum::*` inside functions that are mainly about that enum.
  - `pub use submodule::*` in non-leaf modules.
  - Third-party preludes, if reviewers approve. Don't define your own preludes.
- Each `use` statement imports from one module, with no `::` inside `{..}` (rustfmt `imports_granularity = Module`).
- Import traits locally, inside the function body, unless their methods are used throughout the file.
- Call top-level functions through their module: `mem::transmute(y)`, not `transmute(y)`.
- Import type names and use them unqualified: `Regex`, not `regex::Regex`. Exceptions:
  - Ambiguous names: `io::Error`, or a rename such as `IoError`.
  - Large groups of types.
  - Macros and generated code.

## Formatting
- Suggested rustfmt options (some need nightly): `max_width = 100`, `hex_literal_case = Lower`, `format_macro_matchers = true`.
- Use `#[rustfmt::skip]` only for manual alignment (e.g. matrices) or generated code, never for personal style.

## Ownership and borrowing
- Avoid `Rc`/`Arc`. Prefer unique ownership and borrowing unless the alternative would be unreasonably complex.
- Prefer borrowing over `.clone()`. Clone only when you need a deep copy, or when borrowing gets excessively complex.

## Function inputs and outputs
- Accept flexible references:
  - `&[T]` instead of `&Vec<T>`.
  - `&str` instead of `&String`.
  - `&T` instead of `&Box<T>`.
  - `Option<&T>` instead of `&Option<T>`.
  - Related Clippy lints: `ptr_arg`, `borrowed_box`.
- **Return types:** prefer a concrete iterator or `impl Iterator` over `Vec<T>`. Application code may return `Vec<T>` when that's simpler.
- **Parameters:** library code that only iterates should accept `impl IntoIterator`. Application code may accept `&[T]`.
- `impl Into<T>` parameters:
  - Library APIs: only when call-site ergonomics really matter.
  - Application code: almost never.
- Use an `enum` instead of `bool` when the parameter's meaning isn't obvious. If you keep a `bool`, label it with an inline comment at the call site.
- **Errors:**
  - `Option` for simple, obvious failures.
  - `Result` for recoverable failures where the caller needs to know the cause.
  - `panic!` only for bugs and broken invariants. Tests and developer-facing binaries may panic more freely.

## Types
- Use a newtype instead of a type alias when the type has different meaning or its own API, its underlying type may change, or you need type safety (e.g. separate `Day`/`Month`/`Year` types).
- Prefer named fields over tuples and tuple structs. Exceptions: single-field newtypes and very local code.

## Traits
- Implement standard traits instead of custom methods, e.g. `impl FromStr` rather than a standalone `fn from_str` (Clippy lint `should_implement_trait`).
- Use `#[derive(...)]` whenever it can express the impl.
- In libraries, prefer generics (`T: Trait` / `impl Trait`) over `dyn Trait`, unless code size matters.
- Define a trait only to enable generic code, to accept or return `impl Trait`/`dyn Trait`, or to create an extension trait. Otherwise use an inherent impl. Don't use traits just to organize code.
- **Extension traits:** name them `FooExt`, and don't use them in generic bounds or with `dyn`.
- **Application code:** add trait impls when they're needed. Low-level libraries should add likely impls up front.
- **Specific traits:**
  - `Copy`: implement when the type will clearly stay `Copy`. Error types should be `Copy` where possible.
  - `Clone`: implement for most types, except those that represent external resources.
  - `Default`: implement if the type has `new()` or a natural default state (Clippy lint `new_without_default`).
  - `PartialEq`/`Eq` and `PartialOrd`/`Ord`: implement them when users should use `==` or `<`. `Eq` must be reflexive, and `Ord` must be a total order.
  - Likely map keys: implement `Hash` and `Eq`, plus `Ord` if there's a clear total order.
- Pair important `From` impls with explicit constructors (`new`, `from_foo`).
- Structs that are bags of public options should implement `Default`, so callers can use struct update syntax.

## Concurrency
- Never reach inside a poisoned mutex.

## Macros
- Order of preference for expressing an API:
  1. Plain functions, types, traits and modules.
  2. `macro_rules!`.
  3. Other code generation.
  4. Proc macros.
- Macros make IDE support and large refactors harder.

## Naming
- Follow the standard library's `as_` / `to_` / `into_` conventions for methods and their `self` types (Clippy lint `wrong_self_convention`).
- **Lifetimes:** use descriptive names. Exceptions:
  - `'_` where it works.
  - Single letters for simple input/output relationships or `for<'a>` bounds, at most two per signature.
  - Very generic abstractions.
- **Generic parameters:** use short names that hint at the main trait bound. `T`/`U` are fine when the parameter is unbounded.
- **Constructors:**
  - `new()`, or `new_with_foo()` when there are several.
  - `try_new()` when the constructor returns `Result`.
  - `from_foo()` for conversions, backed by a `From` impl.
- Don't use obscure abbreviations or drop letters from words. Widely known abbreviations such as `IpAddr` are fine.

## Documentation
- Add doc comments to public APIs (consider the `missing_docs` lint). Include examples somewhere in the crate.
- Always document when a function panics on bad input.
- Document the invariants of `unsafe` functions and traits.
- Use full sentences with capitalization and punctuation. Don't explain basic language concepts or repeat the item's name.
- Use `///` for items, `//!` at the top of a module or crate, and `//` for other comments. Write doc comments in Markdown.
- Prefer plain doc comments over documentation generated by macros.

## Other language features
- **`unsafe`:**
  - Use it only when no safe implementation is possible.
  - Wrap it in a small safe abstraction, kept apart from business logic.
  - Explain every use in a `SAFETY:` comment.
  - Back performance-motivated `unsafe` with benchmarks.
- No unstable (nightly) features.
- **Getters and setters:**
  - `foo()` returns `&T`, or `T` if `T: Copy`.
  - `foo_mut()` returns `&mut T`.
  - `set_foo(T)` sets the value.
  - `take_foo()` clears the value and returns the old one.
  - `replace_foo()` sets the value and returns the old one.
  - `with_foo(|v| ...)` gives closure-based access, e.g. for `Mutex` or `RefCell` wrappers.
- Implement expected API sets together, e.g. `len()` with `is_empty()` (Clippy lint `len_without_is_empty`).
- Don't use `#[doc(hidden)]` items you don't own.
- Mark a public `fn` as `const` only if it will stay `const`.
- Overload operators only for their mathematical or logical meaning.
- **`#[non_exhaustive]`:** apply it to public enums, and to public structs with public fields, that are used across team boundaries. Skip it when the type will never change.
- **`#[must_use]`:**
  - On functions where ignoring the result is a bug, including pure getters such as `HashMap::get`. Not needed when the return type is already `#[must_use]`, as `Result` is.
  - On error types and lazily evaluated computations.
- Don't run code before `main()`, e.g. through the `ctor` crate.

## Implementation
- **Type annotations:** add explicit types where a reader would struggle to infer them, such as the results of `.into()`, `.parse()` and complex iterator chains. Prefer annotating the variable over turbofish.
- Use `if let` / `match` / `let ... else` instead of `is_some()` followed by `unwrap()`.
- **Prefer `expect()` over `unwrap()`**, and make the message explain why the panic can't happen. *(This replaces my earlier personal rule on the same topic.)*
- **Matching `#[non_exhaustive]` enums:** list every variant, putting the ones you don't need in an explicit wildcard arm. If you only care about some variants, use `if let` / `let ... else`.
- Give `assert!` a message that explains why the condition holds or shows the values involved. Don't just repeat the condition.
- **Iterator chains:**
  - Prefer a plain `for` loop over a long or complex chain.
  - Don't build chains inside a `for` header. Assign the chain to a variable first.
  - Avoid `Iterator::for_each`.
- Don't call `panic::catch_unwind`.
- Use `format!` / `write!` to join more than two strings, and instead of `str::replace` on literals.
