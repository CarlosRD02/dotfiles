# Dotfiles

Configuración personal de mi entorno Linux: shell, gestores de ventanas, terminales y herramientas del día a día. Todo en un solo repo para clonar y volver a montar el setup en cualquier máquina.

## Contenido

### Shell

| Archivo | Descripción |
| --- | --- |
| `.zshrc` | Zsh con Oh My Zsh, Powerlevel10k, autosugerencias, resaltado de sintaxis, Starship, zoxide y variables de entorno (JAVA, Bun, NVM, pnpm). |
| `.p10k.zsh` | Tema personalizado de Powerlevel10k. |
| `.bashrc` | Bash con historial mejorado, colores y accesos rápidos. |

### Gestores de ventanas y escritorio

| Directorio | Descripción |
| --- | --- |
| `config/bspwm/` | BSPWM (tiling por árbol binario) con reglas, panel y autostart. |
| `config/i3/` | i3 con i3blocks y script para workspaces. |
| `config/qtile/` | Qtile (tiling en Python) con tema, paleta de colores y autostart. |
| `config/icewm/` | IceWM con iconos. |
| `config/xfce4/` | XFCE (desktop, panel, helpers, notas). |

### Status bars y notificaciones

| Directorio | Descripción |
| --- | --- |
| `config/polybar/` | Polybar (config, colores, launch y módulo de paquetes). |
| `config/eww/` | Eww (widgets hechos con `eww.yuck` + `eww.scss`). |
| `config/dunst/` | Notificaciones con Dunst. |

### Terminales

| Directorio | Descripción |
| --- | --- |
| `config/alacritty/` | Alacritty (TOML) con temas. |
| `config/kitty/` | Kitty con tema y `current-theme.conf`. |

### Herramientas

| Directorio | Descripción |
| --- | --- |
| `config/nvim/` | Neovim con lazy.nvim (opciones, keymaps, comandos y plugins). |
| `config/ranger/` | Ranger (file manager) con plugins. |
| `config/rofi/` | Rofi (lanzador). |
| `config/fastfetch/` | Fastfetch (info del sistema). |
| `config/sxhkd/` | Atajos de teclado (hotkeys daemon). |
| `config/picom/` | Compositor (con archivo `.old` de respaldo). |
| `config/cava/` | Cava (visualizador de audio) con shaders. |
| `config/gtk-3.0/` | Ajustes de GTK. |

### Scripts

| Archivo | Descripción |
| --- | --- |
| `scripts/backup-server.sh` | Backup de proyectos a Google Drive con `rclone`: comprime solo código fuente, excluye `node_modules`, `.venv`, `.git`, etc., y conserva los últimos 3 backups locales. |

## Instalación

```bash
git clone https://github.com/CarlosRD02/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Para enlazar los archivos a tu `$HOME` puedes usar [GNU Stow](https://www.gnu.org/software/stow/):

```bash
# Enlaza los archivos de config en ~/.config (config/* -> ~/.config/*)
stow -t "$HOME/.config" config

# Enlaza los archivos de shell en el home
ln -sf "$PWD/.zshrc" ~/.zshrc
ln -sf "$PWD/.bashrc" ~/.bashrc
ln -sf "$PWD/.p10k.zsh" ~/.p10k.zsh
```

O simplemente copia manualmente los directorios que necesites.

## Notas

- Los ajustes de `scripts/backup-server.sh` se editan al inicio del archivo (`USER`, rutas y carpeta de Google Drive).
- El setup asume un sistema tipo Debian/Ubuntu (aliases de `apt`) con X11.
- Algunos atajos de teclado viven en `config/sxhkd/`.
