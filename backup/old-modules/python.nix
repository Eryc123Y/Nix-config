{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pandoc
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