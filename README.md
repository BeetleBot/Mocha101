<div align="center">

<img width="256" height="256" alt="Mocha 101 Icon" src="https://github.com/user-attachments/assets/ba428934-8c72-4dd8-946e-2c1abbfff1e1" />

# Mocha 101

*A sharp-edged Hyprland experience wrapped in Catppuccin Mocha*

[![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=flat&logo=arch-linux&logoColor1FF?style=flat&logo=wayland&logoColor=black

</div>

***

### Philosophy

Mocha 101 embraces a zero border-radius design language—crisp angles, sharp edges, and uncompromising precision. Built on the elegant Catppuccin Mocha palette, this configuration prioritizes performance and visual cohesion across your entire workflow.

**Core Palette**
- **Base** `#1e1e2e` — Deep, focused backgrounds
- **Lavender** `#b4befe` — Primary accents
- **Mauve** `#cba6f7` — Secondary highlights

### Features

- **Dynamic Wallpapers** — Automated rotation via custom `walls.sh` script
- **Unified Theming** — Catppuccin Mocha across all applications
- **Custom Rofi** — Modified adi1090x Type 1/Style 3 launcher
- **Notification Center** — Styled Swaync with custom CSS
- **Integrated Lock Screen** — Hyprlock and Hypridle configuration
- **Performance First** — Lightweight and responsive compositor setup

### Quick Start

**Requirements:** Arch Linux with `yay` access

```bash
git clone https://github.com/BeetleBot/Mocha101.git
cd Mocha101
chmod +x install.sh
./install.sh
```

The installer will automatically:
- Verify system compatibility and install `yay` if needed
- Install all required dependencies from official and AUR repositories
- Backup existing configurations to `~/ConfigBackup/`
- Deploy dotfiles to `~/.config/`
- Copy wallpaper script to your home directory
- Offer Oh My Zsh installation
- Prompt for reboot to finalize changes

### Stack

| Component | Application | Purpose |
|-----------|-------------|---------|
| Compositor | Hyprland | Window management |
| Panel | Waybar | Status bar |
| Wallpapers | Hyprpaper | Background handler |
| Notifications | Swaync | Notification daemon |
| Terminal | Kitty | Terminal emulator |
| Screenshots | Hyprshot | Capture utility |
| Launcher | rofi-wayland | Application finder |
| Lock Screen | Hyprlock + Hypridle | Session security |
| System Info | Fastfetch | Hardware display |
| Shell | ZSH + Oh My Zsh | Command line |
| Display Manager | SDDM | Login screen |
| Font | JetBrains Mono Nerd | Typography |

**Recommended Additions**
- File Manager: Dolphin
- Browser: Zen Browser
- DE Integration: KDE Plasma (for global theming)

### Theming Details

All applications follow the Catppuccin Mocha specification:

- **Zen Browser** — [catppuccin/zen-browser](https://github.com/catppuccin/zen-browser)
- **VS Code** — [catppuccin/vscode](https://github.com/catppuccin/vscode)
- **Kitty** — Modified Catppuccin Mocha (included)
- **Rofi** — [adi1090x/rofi](https://github.com/adi1090x/rofi) Type 1/Style 3 with custom colors
- **SDDM** — [catppuccin/sddm](https://github.com/catppuccin/sddm)
- **Swaync** — Custom CSS (included in repository)

**Terminal Configuration**

The ZSH environment uses Powerlevel10k with a custom prompt calibrated to the Mocha palette, ensuring visual consistency from compositor to command line.

**KDE Integration Note**

For optimal Dolphin integration and system-wide theme consistency, consider installing KDE Plasma as a secondary environment. This enables proper Qt theming and global settings management.
