# dotfiles

User-level shell configurations and application settings for Artix Linux. Deployed via GNU Stow as a submodule of [sysconf](https://github.com/SixtenNordegren/sysconf).

## Structure

- **`.bashrc`** / **`.bash_profile`** – Shell initialization, sources `.config/bash/bashrc`
- **`.bash_logout`** – Shell cleanup on logout
- **`.gitconfig`** – Git user configuration with Neovim as diff tool
- **`.xinitrc`** – X11 initialization (keyboard layout, browser defaults, WM startup)
- **`.config/`** – Application configurations (organized by tool)
- **`.ssh/`** – SSH configuration (keys excluded via `.gitignore`)

## Deployment

These files are deployed via `stowit.sh` in the parent sysconf repository using GNU Stow:

```bash
cd /path/to/sysconf
./stowit.sh
```

Stow symlinks each file/directory into `$HOME`, preserving the directory structure. For example:
- `dotfiles/.bashrc` → `~/.bashrc`
- `dotfiles/.config/nvim/` → `~/.config/nvim/`

## Ignored Files

The `.gitignore` excludes:
- SSH keys (`~/.ssh/id*`, `~/.ssh/*hosts*`)
- Editor swap/backup files
- Application cache and lock files
- Sensitive configs (e.g., neomutt credentials)

## Notes

- All scripts assume a runit-based Artix installation with i3 window manager and qutebrowser
- Keyboard layout is set to Colemak in `.xinitrc`
- Neovim is configured as the default editor
