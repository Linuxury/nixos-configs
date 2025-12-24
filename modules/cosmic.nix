{ pkgs, ... }:

{
  # Cosmic Desktop Environment + native greeter
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # Required for Wayland/desktop in general
  services.xserver.enable = true;

  # Sound (PipeWire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Nice default fonts (all valid package names in unstable)
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji   # ← Fixed: was noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    # Add more later if needed (e.g., nerdfonts, jetbrains-mono)
  ];
}
