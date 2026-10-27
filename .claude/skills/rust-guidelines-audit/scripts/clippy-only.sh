#!/usr/bin/env bash
# PreToolUse hook for the `rust-guidelines-auditor` subagent.
#
# The auditor must stay read-only, but it needs Bash to run Clippy. This hook
# narrows Bash down to exactly one command shape:
#
#   CARGO_TARGET_DIR=~/.cache/rust-guidelines-audit/<name> cargo clippy --frozen [args]
#
# - CARGO_TARGET_DIR keeps build output out of the audited project.
# - `--frozen` stops Cargo from using the network or writing Cargo.lock.
# - Shell metacharacters are rejected by the character whitelist, so nothing
#   can be chained, piped, redirected or substituted onto the command.
#
# Exit 2 blocks the call and sends stderr back to the subagent as the error.
set -euo pipefail

command=$(jq -r '.tool_input.command // empty')

block() {
  echo "Blocked by rust-guidelines-audit: $1" >&2
  echo "Only allowed: CARGO_TARGET_DIR=~/.cache/rust-guidelines-audit/<name> cargo clippy --frozen [args]" >&2
  exit 2
}

# The target dir name may not start with `.`, which rules out `..` escapes.
allowed_shape='^CARGO_TARGET_DIR=~/\.cache/rust-guidelines-audit/[A-Za-z0-9_-][A-Za-z0-9._-]* cargo clippy( [A-Za-z0-9_.,:/=+-]+)+$'
if [[ ! "$command" =~ $allowed_shape ]]; then
  block "command does not match the allowed shape"
fi

# The shape check passes any flag, so reject the flags that would let Clippy
# change files or override `--frozen`.
has_frozen=false
read -r -a words <<<"$command"
for word in "${words[@]}"; do
  case "$word" in
    --frozen) has_frozen=true ;;
    --fix | --fix=* | --allow-dirty | --allow-staged | --allow-no-vcs)
      block "'$word' would modify source files" ;;
    --config | --config=* | -Z*)
      block "'$word' could override the read-only settings" ;;
  esac
done

if [[ "$has_frozen" != true ]]; then
  block "'--frozen' is required"
fi

exit 0
