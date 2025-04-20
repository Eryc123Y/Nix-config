{ pkgs, ... }:

{
 
  home.packages = with pkgs; [
    d2 # Diagramming tool
    docker
    nodejs
    yarn-berry
    typst typstwriter
    texliveFull
    iverilog
    plantuml graphviz
    #logisim-evolution
    
  ];
}
