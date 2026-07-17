fish_add_path ~/.local/bin
set -g fish_greeting

# Keep the `push` abbreviation ergonomic while allowing an optional
# commit message. Without arguments it preserves the current `+upd`
# commit message.
function __abbr_git_push
    set -l message "+upd"

    if test (count $argv) -gt 0
        set message (string join ' ' -- $argv)
    end

    git add .
    and git commit -m "$message"
    and git push
end

if status is-interactive
    abbr dpsa 'docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Ports}}\t{{.Names}}"'
    abbr dps 'docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Ports}}\t{{.Names}}"'
    abbr push '__abbr_git_push'
    abbr ollama 'ollama run gemma4:latest --verbose'
    alias vim "nvim"
    alias plz "sudo"
    alias u "sudo dnf update"
    alias uy "sudo dnf update -y"
    alias i "sudo dnf install"
    alias s "sudo dnf search"
    alias iy "sudo dnf install -y"
    alias r "sudo dnf remove"
    alias ry "sudo dnf remove -y"
    alias repos "sudo dnf repolist --all"
    alias wget "wget2"
    alias ls "ls -lahS --color=auto --group-directories-first"
    alias o "xdg-open"
    alias c "codex"
    alias v "vibe --trust --yolo"
    alias ai "vibe --trust --yolo"
    alias g "cd ~/github"
    alias k "~/github/talos-k8s/kubectl --kubeconfig=$HOME/github/talos-k8s/kubeconfig"
    alias kubectl "~/github/talos-k8s/kubectl --kubeconfig=$HOME/github/talos-k8s/kubeconfig"
    alias curl "curl -v"
end


# Added by Antigravity CLI installer
set -gx PATH "/home/inner/.local/bin" $PATH
