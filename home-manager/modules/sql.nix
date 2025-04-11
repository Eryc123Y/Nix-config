{ config, pkgs, ... }:

let
  # Define the Oracle Instant Client package
  oracleInstantClient = pkgs.oracle-instantclient;
in
{
  # Add Oracle SQL tools to the user's environment
  home.packages = with pkgs; [
    oracleInstantClient
    sqlcl                      # Oracle SQL Developer Command Line
    # Add other SQL tools as needed
  ];

  # Set environment variables for Oracle SQL
  home.sessionVariables = {
    ORACLE_HOME = "${oracleInstantClient}";
    TNS_ADMIN = "${oracleInstantClient}/network/admin";  # Directory for Oracle Net Services configuration files
    LD_LIBRARY_PATH = "${oracleInstantClient}/lib";
    PATH = "${oracleInstantClient}/bin:${config.home.sessionVariables.PATH}";
  };

  # Ensure the TNS_ADMIN directory exists
  home.file = {
    "${oracleInstantClient}/network/admin/tnsnames.ora".text = ''
      # Add Oracle Net Service Names configurations here if needed
    '';
  };
}
