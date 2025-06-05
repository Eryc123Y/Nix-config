{ config, pkgs, ... }:

{
  # Define the packages to be included in the environment
  home.packages = with pkgs; [
    gcc                   # GNU Compiler Collection for C/C++
    #clang                 # Clang compiler
    cmake                 # Build system generator
    gdb                   # GNU Debugger
    valgrind              # Memory debugging tool
    ccache                # Compiler cache to speed up recompilation
    lldb                  # LLVM Debugger
    pkg-config            # Helper tool for compiling applications
    # Add any additional libraries or tools as needed
  ];

  # Optional: Set environment variables
  home.sessionVariables = {
    CC = "${pkgs.gcc}/bin/gcc";       # Set default C compiler
    CXX = "${pkgs.gcc}/bin/g++";      # Set default C++ compiler
    # Add other environment variables if necessary
  };
}

