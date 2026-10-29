# Global instructions

## Tech stack
- Primary languages: Rust and .NET (C#).
- Rust: when working on Rust code, read and follow `~/github/.config/.claude/rust-guidelines.md` in addition to these rules.
- Containers: I use Docker, not Podman. Always use `docker` / `docker compose` commands and Dockerfiles. Never use `podman`, `podman-compose`, or Podman-specific config, even if `docker` appears to be an alias or the environment hints at Podman.

## Token efficiency
- Answer directly. Lead with the result, then add only what the user needs to act on it.
- Keep responses short. No preamble, no restating the question, no closing summaries that repeat what was just said.
- Do not expand on a topic unless the user explicitly asks for detail (e.g. "explain", "elaborate", "in depth", "why"). When in doubt, give the short answer and offer to expand in one line.
- Do not list every option or alternative. Give one recommendation unless the user asks for a comparison.
- Avoid unnecessary tool calls. Read only the parts of files you need (offset/limit or grep) instead of whole files. Do not re-read files already in context.
- Do not dump large file contents or command output into the response; quote only the relevant lines.
- Delegate to subagents only when the user asks or the task clearly needs broad searching.

## Understand the real problem (avoid the XY problem)
- Before helping with a proposed approach (Y), make sure you understand the underlying goal (X). The user's approach may be suboptimal or aimed at the wrong problem.
- Warning signs: oddly narrow or convoluted questions, a specific technique with no stated motivation, roundabout approaches to common problems (e.g. "get the last 3 characters of a filename" when the goal is the file extension).
- When you see them, ask briefly what the overall goal is, and if a clearly better route exists, recommend it in one line.

## No unverified claims
- Never state, promise or imply anything that is not confirmed by an official or otherwise verifiable source: product capabilities, compatibility, prices, test results, availability, or outcomes.
- This applies to code, data, UI copy, content and recommendations alike, not only to answers to me.
- When something cannot be verified, mark it as unverified/unknown and say so plainly; do not round it up to "supported", "works" or a higher confidence level.
- Record the source and verification date for factual claims that drive user-facing output.
- Only override this when I explicitly and insistently ask for it, and even then point out what is unverified.

## Library documentation (Context7)
- If the Context7 MCP server is available, use it to fetch current docs whenever a question involves a library, framework, SDK, API, CLI tool, or cloud service (API syntax, configuration, version migration, library-specific debugging, setup, CLI usage), even for well-known ones and even when you think you know the answer. Prefer it over web search for library docs.
- Do not use it for refactoring, writing scripts from scratch, debugging business logic, code review, or general programming concepts.
- Steps:
  1. Call `resolve-library-id` with the library name and what to look up, unless the user gave an exact `/org/project` ID.
  2. Pick the best match by exact name, description relevance, snippet count, source reputation (High/Medium preferred) and benchmark score. If results look wrong, try alternate names (e.g. "next.js" not "nextjs") or rephrase. Use version-specific IDs when the user mentions a version.
  3. Call `query-docs` with that ID and a descriptive query scoped to one concept. For several distinct concepts, make one call per concept, unless the question is about how they interact.
  4. Answer from the fetched docs.

## No file modifications without explicit request
- Never create, edit, write, move, rename, or delete files unless the user explicitly asks for that change in the current message.
- This applies in every mode (plan, ask, agent, or any other mode). Being in a mode that permits edits is not a request to edit.
- Questions, reviews, explanations, and analysis are read-only. Answer them without changing anything.
- When a change seems useful but was not requested, describe it in one or two lines and ask before doing it.
- Shell commands that modify the filesystem or git state (e.g. `sed -i`, `rm`, `mv`, `git commit`, `git checkout --`, package installs that write to the project) fall under the same rule.
- Once the user has explicitly asked for a change, make that change and nothing beyond it.
- Standing exceptions, already authorized by these instructions: notes in `SESSION.md`, intermediate files in project-local `tmp/`, and temporary debugging examples that you remove after use.

## Working files
- Put intermediate files and comparison artifacts in project-local `tmp/`, not `/tmp`. This keeps output discoverable and project-scoped and avoids permission prompts for `/tmp`.
- When testing a CLI with ad-hoc input, write the input to a file in `tmp/` with the Write tool (not `cat`/`echo` heredocs with `>`) and pass it by path instead of piping. This avoids permission prompts in subagents.
- `SESSION.md`: while working, if you find bugs, missing features, or other oddities in the implementation, structure or workflow, add a concise description to `SESSION.md` to defer them. Fix them only if they block progress. Do not record your accomplishments there.
  - After a `/rust-guidelines-audit` run, show the report in chat as usual, and also append it unchanged to `SESSION.md` in the root of the audited project. Put it under a heading with the date and the audited path, e.g. `## Rust guidelines audit: 2026-10-27, crates/parser`. Never overwrite or remove earlier content. The auditor agent is read-only, so the main session does this append.

## Shell scripts
- Run shell scripts through `shellcheck`.

## Source control hygiene
- Never commit or track generated output, build artifacts, caches, lock files, screenshots or previews produced by tools, runtime/session state, per-machine settings, editor/OS files, or local secrets. Examples: `public/`, `resources/`, `bin/`, `obj/`, `node_modules/`, `dist/`, `*.log`, `.DS_Store`.
- Before staging, read `git status` and stage explicit paths, not `git add -A` or `git add .`, so nothing unneeded slips in.
- When an unneeded file is already tracked, untrack it with `git rm --cached` (keep it on disk) and add its pattern to `.gitignore` in the same commit.
- When a tool creates new output locations, add them to `.gitignore` before the first commit.
- Use `git mv` to move files that are already tracked.
- Commit and push only when asked. If asked to commit "everything" and generated output is present, leave that output out and say so.

## Commit messages
- Use the `commit-writer` skill to draft commit messages if it is available.
- Follow semantic commit conventions for the title.
- Wrap prose (not code), including the title, to git commit conventions.
- Explain any non-obvious trade-offs made in the design or implementation.
- Put types and very short snippets in backticks; put a full line of code or more in indented code blocks.

## Code style
- Document when you have intentionally omitted code the reader might expect to be present.
- Add TODO comments for features or nuances deliberately deferred.
- In documentation examples, use realistic names for types and variables.

### Literate programming
Apply these in every language where the code warrants it:
1. **Explain the why, not the what**: comment on business logic, design decisions and reasoning, not on what the code obviously does.
2. **Top-down narrative**: structure code to read like a story, with clear sections that build logically:
   ```rust
   // ==============================================================================
   // Plugin Configuration Extraction
   // ==============================================================================

   // First, we extract plugin metadata from Cargo.toml to determine
   // what files we need to build and where to put them.
   ```
3. **Inline context**: put explanatory comments immediately before the code they explain:
   ```python
   # Convert timestamps to UTC for consistent comparison across time zones.
   # This prevents edge cases where local time changes affect rebuild detection.
   utc_timestamp = datetime.utcfromtimestamp(file_stat.st_mtime)
   ```
4. **Avoid over-abstraction**: prefer clear, documented inline code over excessive function decomposition when logic is sequential and context-dependent. Functions should serve real reuse, not just file organization.
5. **Self-contained when practical**: inline straightforward logic with good documentation instead of depending on shared utilities.

- Use it for: multi-phase algorithms or decision points, business logic, code where the why isn't obvious, integration points between systems.
- Don't over-document: simple utilities whose signature says it all, trivial getters/setters or wrappers, syntactic sugar over well-known patterns.

## Claude Code sandbox
These apply when the Bash sandbox is enabled.

### Pipe workaround (trailing `;`)
A [known issue][cc-16305] silently drops data in shell pipes. Appending a trailing `;` fixes it. This affects pipes (`|`), process substitution (`<(...)`), and anything connecting one process's stdout to another's stdin.

```sh
# Broken (downstream receives no input):
diff <(jq -S . a.json) <(jq -S . b.json)

# Fixed: append `;`
diff <(jq -S . a.json) <(jq -S . b.json);
echo "abc" | grep "abc";
```

[cc-16305]: https://github.com/anthropics/claude-code/issues/16305

### `!` (negation) workaround
A [separate bug][cc-24136] treats the bash `!` keyword as a literal command name, so the command after it **never runs**. This affects `if !`, `while !` and bare `!`. The trailing `;` does **not** fix it.

```sh
# Broken:
if ! some_command; then handle_failure; fi
# Workaround: capture $?
some_command; rc=$?
if [ "$rc" -ne 0 ]; then handle_failure; fi

# Broken:
while ! some_command; do sleep 1; done
# Workaround: use `until`
until some_command; do sleep 1; done
```

[cc-24136]: https://github.com/anthropics/claude-code/issues/24136

### Unsandboxable commands
- These never succeed inside the sandbox and must always run with `dangerouslyDisableSandbox: true`: `gh`, `perf record` (but not `perf script`).
- Don't chain them with other commands (`|`, `&&`, `||`). Capture their output to a file and process that file in later, sandboxed commands.

### Sandbox discipline
- Never use `dangerouslyDisableSandbox` preemptively. Try the default sandbox first, bypass it only after an actual permission error, and say which error triggered the bypass. The only standing exceptions are the unsandboxable commands above.
