# Dotfiles

Configuración personal de mi entorno Linux. Repo para clonar, enlazar y replicar el setup en cualquier máquina.

## Contenido

| Dotfiles |
|----------|
| `.bashrc` |
| `.p10k.zsh` |
| `.zshrc` |
| alacritty |
| backup-server.sh |
| bspwm |
| cava |
| dunst |
| eww |
| fastfetch |
| gtk-3.0 |
| i3 |
| icewm |
| kitty |
| nvim |
| picom |
| polybar |
| qtile |
| ranger |
| rofi |
| sxhkd |
| xfce4 |

## Instalación

```bash
git clone https://github.com/CarlosRD02/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Enlaza config/* hacia ~/.config (requiere GNU Stow)
stow -t "$HOME/.config" config

# Enlaza los archivos de shell
ln -sf "$PWD/.zshrc" ~/.zshrc
ln -sf "$PWD/.bashrc" ~/.bashrc
ln -sf "$PWD/.p10k.zsh" ~/.p10k.zsh
```

## Agregar un dotfile nuevo

1. Agregá la carpeta o archivo dentro de `config/` (o en la raíz si es un archivo de shell).
2. Actualizá la tabla de contenido.
3. `git add` y commit.
