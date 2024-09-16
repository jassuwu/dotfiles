{
  config,
  pkgs,
  ...
} : {
  enable = true;
  lfs.enable = true;
  userName = "jassuwu";
  userEmail = "karthickprnv@gmail.com";
  signing.key = null;
  signing.signByDefault = true;

  extraConfig = {
    pull = {
      rebase = true;
    };
    init = {
      defaultBranch = "main";
    };
  };
}
