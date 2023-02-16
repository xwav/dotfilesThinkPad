# Setup fzf
# ---------
if [[ ! "$PATH" == */home/xwav/.config/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/xwav/.config/fzf/bin"
fi

# Auto-completion
# ---------------
# [[ $- == *i* ]] && source "/home/xwav/.config/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/xwav/.config/fzf/shell/key-bindings.bash"
