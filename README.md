# Dotfiles

Mis dotfiles. Clonar y enlazar.

## Estructura

```
├── .bashrc
├── .p10k.zsh
├── .zshrc
├── config/
│   ├── alacritty/
│   ├── bspwm/
│   ├── cava/
│   ├── dunst/
│   ├── eww/
│   ├── fastfetch/
│   ├── gtk-3.0/
│   ├── i3/
│   ├── icewm/
│   ├── kitty/
│   ├── nvim/
│   ├── picom/
│   ├── polybar/
│   ├── qtile/
│   ├── ranger/
│   ├── rofi/
│   ├── sxhkd/
│   └── xfce4/
└── scripts/
    └── backup-server.sh
```

## Instalación

```bash
git clone https://github.com/CarlosRD02/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow -t "$HOME/.config" config
ln -sf "$PWD/.zshrc" ~/.zshrc
ln -sf "$PWD/.bashrc" ~/.bashrc
ln -sf "$PWD/.p10k.zsh" ~/.p10k.zsh
```
