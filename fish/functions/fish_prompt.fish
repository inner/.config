function fish_prompt --description 'Powerlevel10k classic-inspired prompt'
    # Capture pipeline failures before styling commands overwrite status.
    set -l last_pipestatus $pipestatus
    set -l background 1c1c1c

    set_color --background $background white
    printf '  '
    set_color --background $background 6c6c6c
    printf ' '
    set_color --bold --background $background 00afff
    printf '%s ' (prompt_pwd)
    set_color normal

    # Let Fish handle repository state instead of duplicating Git parsing.
    set -lx __fish_git_prompt_showdirtystate 1
    set -lx __fish_git_prompt_showuntrackedfiles 1
    set -lx __fish_git_prompt_showupstream auto
    set -l git_info (fish_git_prompt '%s')
    if test -n "$git_info"
        set_color --background $background 6c6c6c
        printf ' '
        set_color --background $background 87d75f
        printf ' %s ' "$git_info"
    end

    # Include failures earlier in a pipeline, even if its final command succeeds.
    if string match -qr '[1-9]' -- $last_pipestatus
        set_color --background $background ff5f5f
        printf ' ✘ %s ' (string join '|' $last_pipestatus)
    end
    if fish_is_root_user
        set_color --background $background ff5f5f
        printf '# '
    end
    set_color normal
    set_color $background
    printf '▓▒░'
    set_color normal
    printf ' '
end
