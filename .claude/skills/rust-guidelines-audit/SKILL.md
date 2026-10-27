---
name: rust-guidelines-audit
description: Read-only audit of a Rust codebase against ~/github/.config/.claude/rust-guidelines.md. Runs Clippy for the lints the guidelines name, reviews the rest by reading the code, and reports each mismatch with a minimal before/after example. Never modifies files.
disable-model-invocation: true
context: fork
agent: rust-guidelines-auditor
argument-hint: "[path] [--no-clippy]"
---

Audit the Rust code at the path in `$ARGUMENTS` (default: the current directory) against the guidelines. Report only; change nothing.

## 1. Load the rules
Read `~/github/.config/.claude/rust-guidelines.md` in full. It is the only source of rules. Don't add rules from elsewhere, and don't enforce a rule the file doesn't contain.

## 2. Map the codebase
Use Glob to find every `Cargo.toml` and `.rs` file under the path. Skip `target/` and vendored or generated code.

## 3. Run Clippy for the mechanical rules
Skip this step if `$ARGUMENTS` contains `--no-clippy`, and say so in the report.

- Collect the lint names the guidelines mention, such as "Clippy lint `ptr_arg`" or "the `missing_docs` lint".
- For each workspace root (a `Cargo.toml` with a `Cargo.lock` next to it), run exactly this shape:

      CARGO_TARGET_DIR=~/.cache/rust-guidelines-audit/<crate-name> cargo clippy --frozen --all-targets --message-format=short --manifest-path <path>/Cargo.toml -- -W clippy::<lint> -W missing_docs

  Use `-W clippy::<name>` for Clippy lints and `-W <name>` for rustc lints such as `missing_docs`.
- If there's no `Cargo.lock`, or Clippy fails (e.g. crates aren't cached locally), don't retry in another form. Note it in the report and continue with step 4.
- Keep only the warnings for the lints you passed. Ignore all other Clippy output.

## 4. Review the judgment rules
Read the code and check the rules Clippy can't check, such as glob imports, `bool` parameters, `SAFETY:` comments, `.context()` before `?`, iterator chain complexity and naming. Go crate by crate. For each candidate, re-read the rule's exact wording before reporting it.

Mark each finding as one of:
- **violation**: the code clearly breaks the rule's wording.
- **review**: it might break the rule, but the rule calls for judgment or names exceptions that could apply.

## 5. Report
Return the full report as your final message, in Markdown:

1. **Summary**: counts per rule and per status, whether Clippy ran (and why not if it didn't), and anything you skipped.
2. **Findings**, grouped by rule. For each rule:
   - The rule's heading and part (Part 1 or Part 2), plus a one-line quote of the rule.
   - Each location as `path:line`, with its status and a one-line explanation of what doesn't match.
   - One very small before/after Rust example showing how to comply, based on the actual code but trimmed to the essentials.
3. **Not checked**: rules that you couldn't evaluate, and why.

If nothing breaks the guidelines, say so plainly. Don't invent findings to fill the report.
