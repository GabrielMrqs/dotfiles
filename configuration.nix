{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    <home-manager/nixos>
    ./home-manager.nix
  ];

  # Nixpkgs
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Boot
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Networking
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # Privilege authentication
  security.polkit.enable = true;

  # Localization
  time.timeZone = "America/Sao_Paulo";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };

  console.keyMap = "br-abnt2";

  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # User
  users.users.gabriel = {
    isNormalUser = true;
    description = "Gabriel";
    shell = pkgs.fish;

    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Display manager and desktop services
  services.displayManager.ly.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Shell
  programs.fish.enable = true;

  # Sway system integration
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Screen sharing
  xdg.portal.wlr.settings.screencast = {
    max_fps = 60;
    chooser_type = "dmenu";
    chooser_cmd = "${pkgs.wmenu}/bin/wmenu -N 000000 -i -l 10 -p 'Share: '";
  };

  # System packages
  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
  ];

  virtualisation.docker = {
    enable = false;

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  system.stateVersion = "26.05";
}
