# Installing to Google Cloud Shell

## Pull from GitHub

```shell
git init .
git remote add origin https://github.com/memes/home.git
git fetch --all
git checkout main
```

## Update `.profile` and `.bashrc`

```shell
echo '[ -n "${BASH_VERSION}" ] && [ -f "${HOME}/.bashrc" ] && . "${HOME}/.bashrc' >> ~/.profile
echo '[ -f "${HOME}/.bashrc_memes" ] && . "${HOME}/.bashrc_memes"' >> ~/.bashrc
```

Make sure my `.profile_memes` is sourced before `.bashrc`; add this line to `.profile`

```shell
[ -f "${HOME}/.profile_memes" ] && . "${HOME}/.profile_memes"
```

## Install binaries to `~/bin`

```shell
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes --bin-dir ${HOME}/bin
curl -sL --output - https://github.com/junegunn/fzf/releases/download/0.27.3/fzf-0.27.3-linux_amd64.tar.gz | tar xzf - -C ~/bin
curl -sfL https://direnv.net/install.sh | bash
curl -sL --output - https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-linux-amd64.tar.gz | tar xzf - -C ~/bin
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
ln -s ~/.tfenv/bin/* ~/bin
```