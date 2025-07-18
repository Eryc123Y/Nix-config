# Programming environment packages that work on both platforms
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Development tools
    git
    wget
    curl
    gemini-cli
    direnv # Environment variable management

    # Academic and Math Formatting
    # quarto  # Disabled - has heavy TexLive dependencies that conflict with overlay
    
    # Programming languages and runtimes
    nodejs
    yarn-berry
    pnpm
    typescript
    
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
      flask
    ]))
    
    # Java Development (OpenJDK for better cross-platform compatibility)
    jdk21  # Primary JDK
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

    # parallel programming
    mpi

    # OpenMP support
    llvmPackages.openmp  # Cross-platform OpenMP implementation
    
    # OpenCL support
    opencl-headers       # OpenCL headers for development
    opencl-clhpp        # C++ bindings for OpenCL
    ocl-icd             # OpenCL ICD loader (works on both platforms)
    
    # OpenCL development tools
    clinfo              # OpenCL platform/device info utility

    
    # R Development
    # R  # Temporarily disabled - TeX dependencies still causing issues despite overlay
    
    # Documentation and text processing
    pandoc       # ✅ No TeX dependencies, safe to use
    typst        # ✅ Modern typesetting, no TeX dependencies  
    # quarto     # Disabled - has heavy TexLive dependencies that conflict with overlay
    
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
    # EDITOR is set per-platform: kate on Linux, micro on macOS
    JAVA_HOME = "${pkgs.jdk21}";
    CC = "${pkgs.gcc}/bin/gcc";
    CXX = "${pkgs.gcc}/bin/g++";
    # R_PROFILE_USER = "${pkgs.R}/etc/Rprofile.site";  # Disabled while R is commented out
  };

  # Git configuration
  programs.git = {
    enable = true;
  };
}
