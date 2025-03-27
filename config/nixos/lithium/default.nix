{ config, pkgs, inputs, lib, hostname,... }:
{
  imports = [
    # Raspberry Pi 3 hardware module
    inputs.hardware.nixosModules.raspberry-pi-3
  ];

  # Disable some modules
  disabledModules = [ "profiles/base.nix" ];

  # Used to build image/version
  nixpkgs.hostPlatform.system = "aarch64-linux";

  # Allow licensed firmware to be update
  hardware.enableRedistributableFirmware = true;

  # Early boot
  boot.initrd.kernelModules = [ "vc4" "bcm2835_dma" "i2c_bcm2835" ];

  # Network
  networking.hostName = hostname;

  # Time
  time.timeZone = "Europe/Paris";

  # Enable ssh
  services.openssh.enable = true;


  # Auto login to magnetis user on startup
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "magnetis";
  services.getty.autologinUser = "magnetis";

  # Environment wide packages
  environment.systemPackages = with pkgs; [
    libraspberrypi
    git
  ];

  # Configure users
  users.mutableUsers = true;
  users.users.cosmeak = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ]; # wheel = admin
  };

  # Nix settings
  nix.settings.experimental-features = "nix-command flakes";

  # Perform garbage collection weekly to maintain low disk usage
  gems.system.garbageCollector.enable = true;
  gems.system.autoUpdate.enable = false;

  # Optimize storage
  nix.settings.auto-optimise-store = true;

  # Minecraft Server
  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true; # Opens the port the server is running on (by default 25565)
    declarative = true;
    serverProperties = {
      difficulty = 3;
      gamemode = 1;
      max-players = 5;
      motd = "NixOS Minecraft server!";
      white-list = false;
    };
  };

  # Swap file
  swapDevices = [{
    device = "/swapfile";
    size = 1024; # 1GB
  }];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
