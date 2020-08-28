{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.03";

  outputs = { self, nixpkgs }: rec {

    defaultPackage.x86_64-linux =
      with import nixpkgs { config.allowUnfree = true; system = "x86_64-linux"; };
      stdenv.mkDerivation rec {
        name = "aurora-wine";
        version = "1.11";
        baseSrc = pkgs.fetchurl {
          curlOpts  = [ "--user-agent" "Wget" ];
          url       = "http://pentarch.org/steve/Aurora151Full.rar";
          sha256    = "aab11f817be1131cc32efebd2a02faf0bf0600a2af7ef971ff32f290a581ef3d";
        };

        patchSrc = pkgs.fetchurl {
          curlOpts  = [ "--user-agent" "Wget" ];
          url       = "http://pentarch.org/steve/Aurora1110.rar";
          sha256    = "61777018f5e39a536285e4cb86cc730d8df323539b1bf4c4e68736b786423bde";
        };

        launcher = ./aurora-launcher;
        copier = ./aurora-copy;

        buildInputs = [ unrar wine ];

        dontBuild = true;

        unpackPhase = ''
          mkdir src
          cd src
          unrar x ${baseSrc}
          # Overwrite with patch
          unrar -o+ x ${patchSrc}
        '';

        installPhase = ''
          mkdir -p $out/aurora $out/bin
          cp -r * $out/aurora/
          echo "WINE=${wine}/bin/wine"  >>  $out/aurora/aurora-launcher
          echo "STORE=$out"             >>  $out/bin/aurora-copy

          cat ${launcher}               >>  $out/aurora/aurora-launcher
          cat ${copier}                 >>  $out/aurora/aurora-copy

          chmod +x                          $out/aurora/aurora-launcher
        '';
      };
  };
}
