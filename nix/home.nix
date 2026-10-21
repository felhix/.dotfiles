{ pkgs, ... }:
{
  home.username = "fgaude";
  home.homeDirectory = "/home/fgaude";
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
