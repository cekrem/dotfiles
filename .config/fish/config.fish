/opt/homebrew/bin/brew shellenv | source

set -gx EDITOR nvim
set -gx VISUAL nvim

if status is-interactive
    abbr vi nvim
    abbr vim nvim

    # make !! work
    function last_history_item
        echo $history[1]
    end
    abbr -a !! --position anywhere --function last_history_item

    starship init fish | source
    zoxide init fish | source
end
