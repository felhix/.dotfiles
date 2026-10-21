{ pkgs, ... }:
{
  home.username = "felix";
  home.homeDirectory = "/home/felix";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    zsh
    fzf
    eza
    bat
    btop
    tldr
    delta
    gh
    starship
    direnv
    uv
  ];
}
