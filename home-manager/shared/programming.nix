# Programming environment packages that work on both platforms
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Development tools
    git
    wget
    curl
    
    # Programming languages and runtimes
    nodejs
    yarn-berry
    (python3.withPackages (ps: with ps; [
      numpy
      pandas
      scipy
      matplotlib
      seaborn
      scikit-learn
      jupyterlab
      requests
      beautifulsoup4
    ]))
    
    # Java Development (OpenJDK for better cross-platform compatibility)
    jdk17
    jdk21
    maven
    gradle
    visualvm
    
    # C/C++ Development
    gcc
    cmake
    gdb
    # valgrind  # Not available on macOS
    ccache
    lldb
    pkg-config
    
    # R Development
    R
    
    # Documentation and text processing
    pandoc
    typst
    typstwriter
    quarto
    
    # Diagramming and planning
    d2
    plantuml
    graphviz
    
    # Hardware/embedded development
    iverilog
    
    # Shell utilities
    tldr
    neofetch
    micro
    
    # Compression utilities
    p7zip
    
    # Development environments
    docker
  ];
  
  # Programming environment variables
  home.sessionVariables = {
    EDITOR = "micro";
    JAVA_HOME = "${pkgs.jdk21}";
    CC = "${pkgs.gcc}/bin/gcc";
    CXX = "${pkgs.gcc}/bin/g++";
    R_PROFILE_USER = "${pkgs.R}/etc/Rprofile.site";
  };

  # Git configuration
  programs.git = {
    enable = true;
    # Add your git config here if needed
  };
}
