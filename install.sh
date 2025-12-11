#!/bin/bash

# Define colors for output
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# Define directories
REPO_DIR="$(pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/ConfigBackup"
WALLPAPER_DEST="$HOME/Pictures/Catppuccin-Wallpapers"

# --- Step 1: Verification ---
clear
echo -e "${YELLOW}::: Mocha101 Installation Script :::${RESET}"
echo -e "${YELLOW}This script is designed specifically for Arch Linux.${RESET}"
echo -e "${YELLOW}It will install dependencies, backup existing configs, and set up the Mocha101 dotfiles.${RESET}"
echo ""
read -p "Are you running this on Arch Linux? (y/n): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo -e "${RED}Installation aborted. This script is intended for Arch Linux only.${RESET}"
    exit 1
fi

# --- Step 2: Install Yay (AUR Helper) ---
echo -e "${GREEN}==> Checking for AUR helper (yay)...${RESET}"
if ! command -v yay &> /dev/null; then
    echo -e "${YELLOW}yay not found. Installing yay...${RESET}"
    sudo pacman -S --needed git base-devel -y
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
    echo -e "${GREEN}yay installed successfully.${RESET}"
else
    echo -e "${GREEN}yay is already installed.${RESET}"
fi

# --- Step 3: Install Dependencies ---
echo -e "${GREEN}==> Installing required packages...${RESET}"

# List of packages based on your README + Font
PACKAGES=(
    hyprland
    waybar
    hyprpaper
    swaync
    kitty
    rofi-wayland
    hyprlock
    hypridle
    fastfetch
    zsh
    hyprshot
    ttf-jetbrains-mono-nerd
)

# Install packages using yay
yay -S --needed --noconfirm "${PACKAGES[@]}"

if [ $? -ne 0 ]; then
    echo -e "${RED}Error installing packages. Please check the logs.${RESET}"
    exit 1
fi
echo -e "${GREEN}All packages installed successfully.${RESET}"

# --- Step 4: Setup Wallpapers ---
echo -e "${GREEN}==> Setting up Wallpapers...${RESET}"
if [ ! -d "$WALLPAPER_DEST" ]; then
    echo -e "${YELLOW}Creating directory: $WALLPAPER_DEST${RESET}"
    mkdir -p "$WALLPAPER_DEST"
fi

# Copy contents of Wallpapers folder (not the folder itself)
if [ -d "$REPO_DIR/Wallpapers" ]; then
    cp -r "$REPO_DIR/Wallpapers/"* "$WALLPAPER_DEST/"
    echo -e "${GREEN}Wallpapers copied to $WALLPAPER_DEST${RESET}"
else
    echo -e "${RED}Warning: Wallpapers folder not found in current directory.${RESET}"
fi

# --- Step 5: Backup & Install Configs ---
echo -e "${GREEN}==> Setting up Configuration files...${RESET}"

# List of config folders to move
CONFIGS=("hypr" "waybar" "kitty" "rofi" "swaync" "customshscripts")

# Create Backup Directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    echo -e "${YELLOW}Created backup directory: $BACKUP_DIR${RESET}"
fi

for folder in "${CONFIGS[@]}"; do
    TARGET="$CONFIG_DIR/$folder"
    SOURCE="$REPO_DIR/$folder"

    # Check if the folder exists in the repo
    if [ -d "$SOURCE" ]; then
        # Check if the config already exists in ~/.config
        if [ -d "$TARGET" ]; then
            echo -e "${YELLOW}Existing configuration found for $folder. Backing up...${RESET}"
            mv "$TARGET" "$BACKUP_DIR/${folder}_$(date +%Y%m%d_%H%M%S)"
        fi
        
        # Copy the new config
        echo -e "${GREEN}Installing $folder config...${RESET}"
        cp -r "$SOURCE" "$CONFIG_DIR/"
    else
        echo -e "${RED}Warning: Source folder $folder not found in repo.${RESET}"
    fi
done

# --- Step 6: Setup walls.sh in Home ---
# This looks for walls.sh inside customshscripts (based on your repo structure)
# and places a copy in the Home directory.
echo -e "${GREEN}==> Setting up walls.sh...${RESET}"
if [ -f "$REPO_DIR/customshscripts/walls.sh" ]; then
    cp "$REPO_DIR/customshscripts/walls.sh" "$HOME/walls.sh"
    chmod +x "$HOME/walls.sh"
    echo -e "${GREEN}walls.sh copied to $HOME and made executable.${RESET}"
elif [ -f "$REPO_DIR/walls.sh" ]; then
    # Fallback if it was in the root
    cp "$REPO_DIR/walls.sh" "$HOME/walls.sh"
    chmod +x "$HOME/walls.sh"
    echo -e "${GREEN}walls.sh copied to $HOME and made executable.${RESET}"
else
    echo -e "${RED}Warning: walls.sh not found. Skipping.${RESET}"
fi

# --- Step 7: Oh My Zsh (Optional) ---
echo -e "${GREEN}==> Shell Setup${RESET}"
read -p "Do you want to install Oh My Zsh now? (y/n): " zsh_confirm
if [[ "$zsh_confirm" == "y" || "$zsh_confirm" == "Y" ]]; then
    echo -e "${YELLOW}Installing Oh My Zsh...${RESET}"
    # Using the unattended install
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    echo ""
    echo -e "${YELLOW}IMPORTANT: Oh My Zsh installed.${RESET}"
    echo -e "${YELLOW}You may need to manually change your shell to zsh by running: chsh -s \$(which zsh)${RESET}"
    echo ""
    read -p "Press [Enter] to acknowledge this step..." dummy_input
else
    echo -e "${YELLOW}Skipping Oh My Zsh installation.${RESET}"
fi

# --- Step 8: Reboot ---
echo -e "${GREEN}==> Installation Complete!${RESET}"
echo -e "${YELLOW}It is highly recommended to reboot your system to apply all changes.${RESET}"
read -p "Do you want to reboot now? (y/n): " reboot_confirm
if [[ "$reboot_confirm" == "y" || "$reboot_confirm" == "Y" ]]; then
    echo -e "${RED}Rebooting...${RESET}"
    sudo reboot
else
    echo -e "${GREEN}Please reboot manually when you are ready.${RESET}"
fi