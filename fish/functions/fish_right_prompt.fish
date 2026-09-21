function fish_right_prompt --description 'Classic shaded clock and command duration'
    set_color 1c1c1c
    printf '░▒▓'
    set_color --background 1c1c1c d0d0d0
    if set -q CMD_DURATION; and test "$CMD_DURATION" -ge 3000
        printf '  %ss ' (math --scale=1 "$CMD_DURATION / 1000")
    end
    printf '  %s ' (date +%H:%M:%S)
    set_color normal
end
