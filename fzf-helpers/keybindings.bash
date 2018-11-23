SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$SCRIPT_DIR/fzf_git.sh"
source "$SCRIPT_DIR/fzf_helpers.sh"

bind '"\er": redraw-current-line'
bind '"\C-g\C-f": "$(gf)\e\C-e\er"'
bind '"\C-g\C-b": "$(gb)\e\C-e\er"'
bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
bind '"\C-g\C-i": "$(gi)\e\C-e\er"'
bind '"\C-g\C-r": "$(gr)\e\C-e\er"'
