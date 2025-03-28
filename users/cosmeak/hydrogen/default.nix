{ inputs, pkgs, ...}:
{
  imports = [ ../common ];

  users.users."cosmeak" = {
    isNormalUser = true;
    description = "cosmeak";
    extraGroups = [ "networkmanager" "wheel" ];

    # User wide packages
    packages = with pkgs; [
      discord
      obs-studio
      prismlauncher
      obsidian
      spotify
      zed-editor
      _1password-gui
    ];
  };
}
