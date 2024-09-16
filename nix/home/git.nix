{
  config,
  pkgs,
  ...
} : {
  enable = true;
  lfs.enable = true;
  userName = "jassuwu";
  userEmail = "karthickprnv@gmail.com";
  extraConfig = {
    pull = {
      rebase = true;
    };
    init = {
      defaultBranch = "main";
    };
  };
}
