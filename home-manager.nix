{ ... }:

{
  home-manager = {
    backupFileExtension = "hm-backup";
    useGlobalPkgs = true;
    useUserPackages = true;

    users."gabriel" = import ./home.nix;
  };
}
