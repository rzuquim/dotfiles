# rzuquim’s dotfiles

## Installation

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Setup Windows env

Install chocolatey
```
https://chocolatey.org/install
```

Then clone the repository wherever you want and run **bootstrap.ps1**

```powershell
git clone git@github.com:rzuquim/dotfiles.git; cd dotfiles; ./bootstrap.ps1
```

### Setup Linux env

You can clone the repository wherever you want. (I like to keep it in `~/dev/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone git@github.com:rzuquim/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
```

### Refreshing Powershell Profile

```powershell
./update-shell.ps1
```

## Python dev env

Install poetry with

```bash
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
```

and then add bash auto-completion with

```bash
poetry completions bash | sudo tee /etc/bash_completion.d/poetry.bash-completion
```


## Thanks to…

* [Mathias Bynens](https://mathiasbynens.be/) and his [dotfiles repository](https://github.com/mathiasbynens/dotfiles)
