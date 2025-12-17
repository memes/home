#!/bin/sh
#
# Install configs into home directory
#
SOURCE_DIR="$(readlink -f "$(dirname "$0")")"
TARGET_DIR="$(readlink -f "${1:-"${HOME}"}")"

error()
{
    echo "$0: ERROR: $*" >&2
    exit 1
}

info()
{
    echo "$0: INFO: $*" >&2
}

[ -n "${TARGET_DIR}" ] || error "Target directory does not exist"
[ -d "${TARGET_DIR}" ] || error "Target is not a directory: ${TARGET_DIR}"

info "Copying/updating files in ${TARGET_DIR}"
rsync -avh \
        --exclude ".devcontainer" \
        --exclude ".git" \
        --exclude ".github" \
        --exclude ".DS_Store" \
        --exclude ".venv" \
        --exclude ".vscode" \
        --exclude "bootstrap.sh" \
        --exclude "CODEOWNERS" \
        --exclude "LICENSE" \
        --exclude "README.md" \
        --exclude "cloudshell.md" \
        --exclude ".gitignore" \
        --exclude ".markdownlint-cli2.yaml" \
        --exclude ".pre-commit-config.yaml" \
        --exclude ".python-version" \
        --exclude ".talismanrc" \
        --exclude ".yamllint.yaml" \
        --exclude "requirements*.txt" \
        --exclude "pyproject.toml" \
        --exclude "uv.lock" \
        "${SOURCE_DIR}/" "${TARGET_DIR}/" || \
    error "Failed to copy/update files in ${TARGET_DIR}: exit code: $?"

[ -d "${TARGET_DIR}/.gnupg" ] && chmod 0700 "${TARGET_DIR}/.gnupg"

if ! grep -q .zshrc_memes "${TARGET_DIR}/.zshrc" 2>/dev/null; then
        info "Updating ${TARGET_DIR}/.zshrc"
    cat <<'ZSHRC' >>"${TARGET_DIR}/.zshrc" || error "Failed to update ${TARGET_DIR}/.zshrc: exit code: $?"

# Load memes customizations
[[ -f ~/.zshrc_memes ]] && source ~/.zshrc_memes
ZSHRC
fi

if ! grep -q .profile_memes "${TARGET_DIR}/.profile" 2>/dev/null; then
    info "Updating ${TARGET_DIR}/.profile"
    cat <<'PROFILE' >>"${TARGET_DIR}/.profile" || error "Failed to update ${TARGET_DIR}/.profile: exit code: $?"

# Load memes customizations
if [ -f "${HOME}/.profile_memes" ]; then
    . "${HOME}/.profile_memes"
fi
PROFILE
    if [ "$(uname)" = "Darwin" ] && ! grep -q .bashrc "${TARGET_DIR}/.profile" 2>/dev/null; then
        info "Sourcing .bashrc in OSX .profile"
        cat <<'PROFILEOSX' >>"${TARGET_DIR}/.profile" || error "Failed to update ${TARGET_DIR}/.profile: exit code: $?"
# Source .bashrc when shell is bash - needed on OSX
[ -n "${BASH_VERSION}" ] && [ -f "${HOME}/.bashrc" ] && . "${HOME}/.bashrc"
PROFILEOSX
    fi
fi

if ! grep -q .bashrc_memes "${TARGET_DIR}/.bashrc" 2>/dev/null; then
        info "Updating ${TARGET_DIR}/.bashrc"
    cat <<'BASHRC' >>"${TARGET_DIR}/.bashrc" || error "Failed to update ${TARGET_DIR}/.bashrc: exit code: $?"

# Load memes customizations
[ -f "${HOME}/.bashrc_memes" ] && . "${HOME}/.bashrc_memes"
BASHRC
fi

# Try to customize for specific environments
if [ -f /usr/local/etc/vscode-dev-containers/meta.env ] || [ -f /usr/local/etc/dev-containers/meta.env ]; then
    info "Disabling oh-my-zsh in devcontainer"
    # shellcheck disable=SC2016
    sed -i.dotfiles \
            -e 's/^export ZSH=/# export ZSH=/g' \
            -e 's/^ZSH_THEME/# ZSH_THEME/g' \
            -e "s/^zstyle ':omz:/# zstyle ':omz:/g" \
            -e 's/^ZSH_CUSTOM=/# ZSH_CUSTOM=/g' \
            -e 's/^plugins=/# plugins=/g' \
            -e 's/^source $ZSH\//# source $ZSH\//g' \
        "${TARGET_DIR}/.zshrc"
else
    # Is go binary installed?
    if command -v go >/dev/null 2>/dev/null && go version | grep -Eq 'go version go1(\.[[:digit:]]+){1,2}' 2>/dev/null; then
        sh ~/bin/go_refresh.sh
    fi
    info "Installing default git credential.helper"
    case "$(uname)" in
        Darwin)
            git config --file "${TARGET_DIR}/.gitconfig.private" credential.helper osxkeychain || \
                error "Failed to update ${TARGET_DIR}/.gitconfig.private: exit code: $?"
            ;;
        Linux)
            git config --file "${TARGET_DIR}/.gitconfig.private" credential.helper store || \
                error "Failed to update ${TARGET_DIR}/.gitconfig.private: exit code: $?"
            ;;
        *)
            info "Unrecognized OS; not setting a default git credential helper"
            ;;
    esac
fi
