{ pkgs ? import <nixpkgs> {} }:

{
  signond = pkgs.callPackage ./signond.nix { 
    withOAuth2 = true;
    signon-plugin-oauth2 = pkgs.callPackage ./signon-plugin-oauth2.nix {};
    withKWallet = true;
    signon-kwallet-extension = pkgs.libsForQt5.signon-kwallet-extension;
  };
  
  signon-ui = pkgs.callPackage ./signon-ui.nix {};
  
  # Create a patch file for signon-ui
  # You'll need to create this file with appropriate content
  # for the fake-user-agent.patch referenced in signon-ui.nix
}
