{ config, pkgs, ... }:


{
  
  home.packages = with pkgs; [
    telegram-desktop
    #clash-verge-rev
    v2ray
    haruna
    kdePackages.okular
    sunshine
    deskreen arc_unpacker
    zotero
    calibre
    teams-for-linux
    #lutris 
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
    goldendict-ng # dictionary
    wechat-uos zoom-us obsidian
    anki-bin
    mathematica-cuda
  ];
}
