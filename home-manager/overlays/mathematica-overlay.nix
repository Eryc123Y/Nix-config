self: super:
let
  mathematicaPackage = super.callPackage (
    { pkgs, lib, stdenv, makeWrapper, coreutils, ... }:
    stdenv.mkDerivation rec {
      pname = "mathematica";
      version = "14.2.0";

      src = /home/eric/.config/home-manager/overlays/Wolfram_14.2.0_LIN_Bndl.sh;

      dontUnpack = true;

      nativeBuildInputs = [ makeWrapper ];
      buildInputs = [ coreutils ];

      buildPhase = ''
        # Create a unique temporary target directory using mktemp.
        TARGET=$(mktemp -d "$TMPDIR/target-XXXX")
        echo "Using TEMP_TARGET: $TARGET"
        # Save TARGET for later phases.
        echo "$TARGET" > $TMPDIR/targetpath

        # Prepare the installer.
        mkdir -p $TMPDIR/installer
        cp ${src} $TMPDIR/installer/Wolfram_14.2.0_LIN_Bndl.sh
        chmod +x $TMPDIR/installer/Wolfram_14.2.0_LIN_Bndl.sh

        # Define the installer path inside TARGET.
        INSTALLER_PATH="$TARGET/Unix/Installer/WolframInstaller"
        echo "Installer path: $INSTALLER_PATH"
        ls -la "$TARGET" || true

        # Run the installer targeting the unique temporary directory.
        $TMPDIR/installer/Wolfram_14.2.0_LIN_Bndl.sh --target "$TARGET" -- "$INSTALLER_PATH" --auto --accept-eula || true

        echo "Contents of TEMP_TARGET after installer:"
        ls -la "$TARGET" || true
      '';

      installPhase = ''
        # Retrieve the target directory from buildPhase.
        TARGET=$(cat $TMPDIR/targetpath)
        echo "Reading TEMP_TARGET: $TARGET"
        mkdir -p $out

        # Copy everything from TARGET to $out.
        cp -r "$TARGET"/* $out/ || true

        # Optionally reorganize files into an Applications directory.
        mkdir -p $out/Applications
        if [ -d "$out/MathKernel" ]; then
          mv "$out/MathKernel" $out/Applications/
        else
          echo "Warning: MathKernel directory not found."
        fi
        if [ -d "$out/Mathematica" ]; then
          mv "$out/Mathematica" $out/Applications/
        else
          echo "Warning: Mathematica directory not found."
        fi

        # Wrap executables if they exist.
        if [ -f "$out/Applications/Mathematica/Executables/mathematica" ]; then
          wrapProgram "$out/Applications/Mathematica/Executables/mathematica" \
            --prefix PATH : ${lib.makeBinPath [ pkgs.jetbrains.jdk ]}
        else
          echo "Warning: Mathematica executable not found."
        fi
        if [ -f "$out/Applications/MathKernel/Executables/math" ]; then
          wrapProgram "$out/Applications/MathKernel/Executables/math" \
            --prefix PATH : ${lib.makeBinPath [ pkgs.jetbrains.jdk ]}
        else
          echo "Warning: MathKernel executable not found."
        fi
      '';

      sha256 = "c18e9a706a1473bcb6d9e9d28bb46b71114bbef3c669e613b5ae32584c655e1a";

      meta = with lib; {
        description = "Mathematica";
        homepage = "https://www.wolfram.com/mathematica/";
        license = licenses.unfree;
        platforms = platforms.linux;
      };
    }
  ) {};
in {
  mathematica = mathematicaPackage;
}
