{ pkgs ? import <nixpkgs> {} }:

{
  # Custom signon packages for authentication
  signond = pkgs.callPackage ./signon/signond.nix { 
    withOAuth2 = true;
    signon-plugin-oauth2 = pkgs.callPackage ./signon/signon-plugin-oauth2.nix {};
    withKWallet = true;
    signon-kwallet-extension = pkgs.libsForQt5.signon-kwallet-extension;
  };
  
  signon-ui = pkgs.callPackage ./signon/signon-ui.nix {};
}
