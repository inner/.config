function tree --description 'Show a tree with a default depth of 2'
    set -l depth 2
    set -l ignored_paths '.git|.hg|.svn|.DS_Store|.cache|node_modules|bower_components|vendor|target|dist|build|coverage|.next|.nuxt|.vite'
    set -l tree_args

    if test (count $argv) -gt 0
        if string match --quiet --regex '^[0-9]+$' -- $argv[1]
            set depth $argv[1]
            set tree_args $argv[2..-1]
        else
            set tree_args $argv
        end
    end

    if test (count $tree_args) -eq 0
        set tree_args .
    end

    command tree -a -I $ignored_paths -L $depth $tree_args
end
