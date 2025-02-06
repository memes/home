# Collection of dotfiles and other common files for home

My files that should be semi-portable between systems. Can be
directly checked out to ``$HOME`` if feeling adventurous.

## New machine instructions

### Moving to HTTPS authentication
For new installs, prefer use of HTTPS authentication over SSH where possible. Need to use a persistent keystore where safe to do so.

### Dotfiles in devcontainer

Should be automatic; just source this repo as a dotfiles repo and it should be
bootstrapped automatically via `bootstrap.sh`.

### Manual installation

#### Linux

Only use on encrypted filesystems

```shell
$ git config --file ~/.gitconfig.private credential.helper store
```

#### OS X

Use Keychain integration

```shell
$ git config --file ~/.gitconfig.private credential.helper osxkeychain
```

### Pull into current home

```shell
cd
git init
git remote add origin https://github.com/memes/home.git
git fetch origin
git checkout -b main --track origin/main
```
