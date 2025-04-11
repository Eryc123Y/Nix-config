{ config, pkgs, ... }:

{
  # Add Java packages to the user's environment
  home.packages = with pkgs; [
    # Java Development Kits
    jetbrains.jdk       # JetBrains JDK for IntelliJ IDEA
    bluej
    # Java Build Tools
    maven               # Apache Maven for project management
    gradle              # Gradle build automation tool

    # Java Utilities

    # Java Debugging Tools
    visualvm            # All-in-one troubleshooting tool
  ];
  
  # Environment variables for Java
  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jetbrains.jdk}";   # Set default JDK
    PATH = "${pkgs.jdk17}/bin:${pkgs.maven}/bin:${pkgs.gradle}/bin:$PATH";  # Include Java tools in PATH
  };
}

