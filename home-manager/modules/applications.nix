{ config, pkgs, ... }:

{
  
  home.packages = with pkgs; [
    open-webui
    telegram-desktop
    clash-verge-rev
    ollama-cuda
    baidupcs-go
    v2ray
    haruna
    kdePackages.okular
    sunshine
    deskreen arc_unpacker
    zotero
    calibre
    teams-for-linux
    lutris 
    bottles
    microsoft-edge
    texliveFull
    discord
    mathpix-snipping-tool
    figma-linux
    rnote
    xournalpp
    discord
    lmstudio
    eudic # dictionary
    wechat-uos zoom-us obsidian
    anki-bin
    #mathematica-cuda
  ];
}
