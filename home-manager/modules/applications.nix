{ config, pkgs, ... }:


{
  nixpkgs.config = {
    allowUnfree = true;
  };
  
  home.packages = with pkgs; [
    eudic drawio
    telegram-desktop
    clash-verge-rev v2ray
    mpv 
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
  ];
}
