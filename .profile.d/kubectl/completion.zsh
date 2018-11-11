#-*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# If kubectl is installed, enable completion

# Load kubectl completion
command -v kubectl >/dev/null 2>/dev/null && \
    source <(kubectl completion zsh)
