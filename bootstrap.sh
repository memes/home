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

[ -n "${TARGET_DIR}" ] || error "Target directory does not exist"
[ -d "${TARGET_DIR}" ] || error "Target is not a directory: ${TARGET_DIR}"

rsync -avh \
    --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude "bootstrap.sh" \
    --exclude "LICENSE" \
    --exclude "README.md" \
    --exclude "cloudshell.md" \
    --exclude ".gitignore" \
    --exclude ".pre-commit-config.yaml" \
    --exclude ".talismanrc" \
    "${SOURCE_DIR}/" "${TARGET_DIR}/"

if ! grep -q .zshrc_memes "${TARGET_DIR}/.zshrc" 2>/dev/null; then
        echo "Updating ${TARGET_DIR}/.zshrc"
    cat <<'ZSHRC' >>"${TARGET_DIR}/.zshrc"

# Load memes customisations
[[ -f ~/.zshrc_memes ]] && source ~/.zshrc_memes
ZSHRC
fi

if ! grep -q .profile_memes "${TARGET_DIR}/.profile" 2>/dev/null; then
    echo "Updating ${TARGET_DIR}/.profile"
    cat <<'PROFILE' >>"${TARGET_DIR}/.profile"

# Load memes customisations
if [ -f "${HOME}/.profile_memes" ]; then
    . "${HOME}/.profile_memes"
fi
PROFILE

    if [ "$(uname)" = "Darwin" ] && ! grep -q .bashrc "${TARGET_DIR}/.profile" 2>/dev/null; then
        echo "Sourcing .bashrc in OSX .profile"
        cat <<'PROFILEOSX' >>"${TARGET_DIR}/.profile"
# Source .bashrc when shell is bash - needed on OSX
[ -n "${BASH_VERSION}" ] && [ -f "${HOME}/.bashrc" ] && . "${HOME}/.bashrc"
PROFILEOSX

    fi
fi

if ! grep -q .bashrc_memes "${TARGET_DIR}/.bashrc" 2>/dev/null; then
        echo "Updating ${TARGET_DIR}/.bashrc"
    cat <<'BASHRC' >>"${TARGET_DIR}/.bashrc"

# Load memes customisations
[ -f "${HOME}/.bashrc_memes" ] && . "${HOME}/.bashrc_memes"
BASHRC
fi

if printenv | grep -q VSCODE; then
    echo "Skipping git credential helper in devcontainer"
else
    case "$(uname)" in
        Darwin)
            git config --file "${TARGET_DIR}/.gitconfig.private" credential.helper osxkeychain
            ;;
        Linux)
            git config --file "${TARGET_DIR}/.gitconfig.private" credential.helper store
            ;;
        *)
            echo "Unrecognised OS; not setting a default git credential helper"
            ;;
    esac
fi
