- tmux config load checks cannot open a tmux socket inside the sandbox, even with
  `TMUX_TMPDIR` pointed at project-local `tmp/`; rerun with escalated permissions.
- `shellcheck` is not installed, so shell helper scripts cannot be linted locally.
