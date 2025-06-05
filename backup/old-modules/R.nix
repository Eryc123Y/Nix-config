{ config, pkgs, ... }:

{
  # Add Python packages to the user's environment
  home.packages = with pkgs; [
    R
  ];

# Set environment variables
home.sessionVariables = {
    R_PROFILE_USER = "${pkgs.R}/etc/Rprofile.site";  # Automatically load R startup script
    };

}