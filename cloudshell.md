# Installing to Google Cloud Shell

## Pull from GitHub

```shell
git init .
git remote add origin https://github.com/memes/home.git
git fetch --all
git checkout main
```

## Update `.bashrc`

```shell
echo '[ -f "${HOME}/.bashrc_memes" ] && . "${HOME}/.bashrc_memes"' >> ~/.bashrc
```

Make sure my `.profile_memes` is sourced before `.bashrc`; add this line to `.profile`

```shell
[ -f "${HOME}/.profile_memes" ] && . "${HOME}/.profile_memes"
```

## Install binaries to `~/bin`

```shell
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes --bin-dir ${HOME}/bin
curl -sL --output - https://github.com/junegunn/fzf/releases/download/0.34.0/fzf-0.34.0-linux_amd64.tar.gz | tar xzf - -C ~/bin
curl -sfL https://direnv.net/install.sh | bash
curl -sL --output - https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-linux-amd64.tar.gz | tar xzf - -C ~/bin
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
exit
```

## Install asdf plugins

Relaunch shell

```shell
for p in direnv python ruby terraform terraform-docs; do asdf plugin add ${p}; done
asdf install direnv latest
asdf global direnv latest
echo 'use asdf' > .envrc
asdf exec direnv allow
```
