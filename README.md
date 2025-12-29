[<img align="right" src="./_assets/png/logo-black.png" width="100" alt="Rafael Zuquim" />](https://rzuquim.com)

# rzuquim’s dotfiles

## Installation

These configuration scripts target [arch linux](https://archlinux.org/).

> **Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and
> remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own
> risk!

After booting on the live environment, setup the [internet connection](https://wiki.archlinux.org/title/Iwd#iwctl):

Install curl (`pacman -Sy curl`), run the boot script and hope for the best.

```bash
bash <(curl -sL https://boot.rzuquim.com/install.sh)
```

> If the domain is not available use the raw file on the
> [GitHub](https://raw.githubusercontent.com/rzuquim/dotfiles/master/install.sh) repository.

> [!WARNING]
> These scripts aim to be [idempotent](https://en.wikipedia.org/wiki/Idempotence) so if any network error occur, try to
> run it again. It should continue where it started.

## FAQ

- When running `sync_setup` on a installed environment, `pacman` might find a conflict and exit the script with an error
  since we are always installing stuff with `--no-confirm` and the default option would be not to remove the old
  version. Just temporarily remove the flag `--no-confirm` and rollback the change after you are done.

## Thanks to…

- [dt](https://www.youtube.com/channel/UCVls1GmFKf6WlTraIb_IaJg) and his [dotfiles](https://gitlab.com/dwt1/dotfiles)
- [Bread on Penguins](https://www.youtube.com/watch?v=5DHz23VQJxk&list=PL97nvoRkKCvkoyZUCeB59AMgqhkuEvXU3)
- [mischa](https://www.youtube.com/watch?v=qboMuv9vSpQ&list=PL_JVnPgp2IRcFnHqZdmQwWdv8n49vGHqp)
- [typecraft](https://www.youtube.com/@typecraft_dev) and his [dotfiles](https://github.com/typecraft-dev/dotfiles)
- [Mathias Bynens](https://mathiasbynens.be/) and his [dotfiles](https://github.com/mathiasbynens/dotfiles)
