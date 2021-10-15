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

## Starship to ~/bin/

```shell
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes --bin-dir ${HOME}/bin
```
