#!/bin/bash

set -ouex pipefail

log() {
  echo "=== $* ==="
}

####
#### Setup repos
####

log "Enabling Copr repos"
COPR_REPOS=(
    enmanuelmoreira/mapanare-labs       # for windsurf
    erikreider/SwayNotificationCenter   # for swaync
    errornointernet/packages
    heus-sueh/packages                  # for matugen/swww, needed by hyprpanel
    leloubil/wl-clip-persist
    # pgdev/ghostty
    solopasha/hyprland
    tofik/sway
    ulysg/xwayland-satellite
    yalter/niri
)
for repo in "${COPR_REPOS[@]}"; do
  dnf5 -y copr enable "$repo"
done

####
#### Install packages
####

log "Installing packages via dnf5"

PACKAGES=(

  # Key:
  # `#` - Commented out for an unknown reason
  # `#+` - already installed elsewhere

  ### fonts
  fira-code-fonts
  fontawesome-fonts-all
  google-noto-emoji-fonts

  ### Hyprland dependencies
  aquamarine
  aylurs-gtk-shell2
  blueman
  bluez
  bluez-tools
  brightnessctl
  btop
  cava
  cliphist
  # egl-wayland
  eog
  fuzzel
  gnome-bluetooth
  grim
  grimblast
  gvfs
  hyprpanel
  inxi
  kvantum
  # lib32-nvidia-utils
  libgtop2
  mako
  matugen
  mpv
  # mpv-mpris
  network-manager-applet
  nodejs
  # nvidia-dkms
  # nvidia-utils
  nwg-look
  pamixer
  pavucontrol
  playerctl
  # power-profiles-daemon
  python3-pyquery
  qalculate-gtk
  qt5ct
  qt6ct
  rofi-wayland
  slurp
  swappy
  swaync
  swww
  tumbler
  upower
  wallust
  waybar
  wget2
  wireplumber
  wl-clipboard
  wl-clip-persist
  wlogout
  wlr-randr
  xarchiver
  xdg-desktop-portal-gtk
  xdg-desktop-portal-hyprland
  xwayland-satellite
  yad

  ### Hyprland ecosystem packages
  hyprland
  hyprcursor
  hyprpaper
  hyprpicker
  hypridle
  hyprlock
  hyprshot
  xdg-desktop-portal-hyprland
  hyprsysteminfo
  hyprsunset
  hyprpolkitagent
  hyprland-qt-support
  hyprutils

  ### Niri seems interesting
  niri
  swaylock
  #+ alacritty
  #+ brightnessctl
  #+ fuzzel
  #+ mako
  #+ waybar
  #+ xwayland-satellite
  #+ gnome-keyring
  #+ wireplumber
  #+ xdg-desktop-portal-gnome
  #+ xdg-desktop-portal-gtk

  ### Misc.
  alacritty

  kitty
  kitty-terminfo
)


dnf5 install --setopt=install_weak_deps=False -y "${PACKAGES[@]}"

####
#### Cleanup
####

log "Disabling Copr repos"
for repo in "${COPR_REPOS[@]}"; do
  dnf5 -y copr disable "$repo"
done

# Apparent TODO:
# possibly setup SDDM 
# https://github.com/ashebanow/hyprblue/blob/main/build_files/build.sh