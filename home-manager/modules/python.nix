{ config, pkgs, ... }:

{
# other package management tools and python utilities
home.packages = with pkgs; [
  conda
  uv
  pandoc
];

# global python environment with basic dependencies
home.packages = with pkgs; [
  (python3.withPackages (ps: with ps; [
    numpy
    pandas
    scipy
    matplotlib
    seaborn
    scikit-learn
    jupyterlab
  ]))
];

}