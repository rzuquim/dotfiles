[<img align="right" src="./_assets/svg/logo.svg" width="100" alt="Rafael Zuquim" />](https://rzuquim.com)

# rzuquim’s dotfiles

## Installation

> **Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and
> remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own
> risk!

### [arch](https://archlinux.org/)

After booting on the live environment, setup the [internet connection](https://wiki.archlinux.org/title/Iwd#iwctl):

Install curl (`pacman -Sy curl`), run the boot script and hope for the best.

```bash
bash <(curl -sL https://boot.rzuquim.com/install.sh)
```

> If the domain is not available use the raw file on the
> [GitHub](https://raw.githubusercontent.com/rzuquim/dotfiles/master/install.sh) repository.

> [!WARNING]
> These scripts aim to be [idempotent](https://en.wikipedia.org/wiki/Idempotence) so if any network error occur, try
> to run it again. It should continue where it started.

## Thanks to…

- [dt](https://www.youtube.com/channel/UCVls1GmFKf6WlTraIb_IaJg) and his
  [dotfiles](https://gitlab.com/dwt1/dotfiles)
- [Bread on Penguins](https://www.youtube.com/watch?v=5DHz23VQJxk&list=PL97nvoRkKCvkoyZUCeB59AMgqhkuEvXU3)
- [mischa](https://www.youtube.com/watch?v=qboMuv9vSpQ&list=PL_JVnPgp2IRcFnHqZdmQwWdv8n49vGHqp)
- [typecraft](https://www.youtube.com/@typecraft_dev) and his [dotfiles](https://github.com/typecraft-dev/dotfiles)
- [Mathias Bynens](https://mathiasbynens.be/) and his [dotfiles](https://github.com/mathiasbynens/dotfiles)
