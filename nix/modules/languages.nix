{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    elixir
    gcc
    unstable.go_1_22
    nodejs
    bun
    rustup
    yarn
    gofumpt
    golines
    goimports-reviser
    air
    gnumake
    unstable.templ
    tailwindcss
    tailwindcss-language-server
  ];
}
