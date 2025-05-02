# unstable.nix
{ config, pkgs, pkgs-unstable, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs-unstable.ollama-cuda;
    acceleration = "cuda";
    environmentVariables = {
    CUDA_VISIBLE_DEVICES = "0";
    NVIDIA_VISIBLE_DEVICES = "all";
  };
  };

  services.open-webui = {
    enable = true;
    package = pkgs-unstable.open-webui;
    openFirewall = true;
    port = 3000;
  };
  environment.systemPackages = with pkgs-unstable; [
    #ollama-cuda open-webui
    vscode wechat-uos zoom-us obsidian
    anki-bin
    jetbrains-toolbox
    mathematica-cuda
  ];
}
