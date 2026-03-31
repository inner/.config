fish_add_path ~/.local/bin

if status is-interactive
    abbr dps 'docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Created}}\t{{.Ports}}\t{{.Names}}"'
    abbr push 'git add . && git commit -m "+upd" && git push'

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
    alias docker "podman"
    alias o "xdg-open"
    alias c "claude"
    alias g "cd ~/github"
end
