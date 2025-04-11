{
  homebrew.casks = [
    "beekeeper-studio" # find a better alternative
    "insomnia"
    "orbstack" # replace with simple docker desktop
    "figma"
    "obsidian"
    "zen-browser"
    "eloston-chromium" # needed a chromium based browser for testing purpose in web development
    "amethyst" # Window manager
    "sf-symbols"
    "font-hack-nerd-font" # move this to nix installation
    "1password"
    "discord" # use this one since nixpkgs doesn't have krisp
    "modrinth"
    "github"
  ];
}
