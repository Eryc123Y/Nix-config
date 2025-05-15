{ pkgs, ... }:

{
 
  home.packages = with pkgs; [
    jetbrains-toolbox vscode
    d2 # Diagramming tool
    docker
    nodejs
    yarn-berry
    typst typstwriter
    texliveFull
    iverilog
    plantuml graphviz
    #logisim-evolution
    code-cursor
    quarto
    
  ];
}
