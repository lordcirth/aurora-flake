{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.03";

  outputs = { self, nixpkgs }: rec {

    defaultPackage.x86_64-linux =
      with import nixpkgs { config.allowUnfree = true; system = "x86_64-linux"; };
      stdenv.mkDerivation rec {
        name = "aurora-wine";
        version = "1.11"
        src = pkgs.fetchurl {
          curlOpts  = [ "--user-agent" "Wget" ];
          url       = "http://pentarch.org/steve/Aurora151Full.rar";
          sha256    = "aab11f817be1131cc32efebd2a02faf0bf0600a2af7ef971ff32f290a581ef3d";
        };

        src2 = pkgs.fetchurl {
          curlOpts  = [ "--user-agent" "Wget" ];
          url       = "http://pentarch.org/steve/Aurora1110.rar";
          sha256    = "61777018f5e39a536285e4cb86cc730d8df323539b1bf4c4e68736b786423bde";
        };

        buildInputs = [ unrar ];

        dontBuild = true;

        unpackPhase = ''
          mkdir src
          cd src
          unrar x ${src}
          # Overwrite with patch
          unrar -o+ x ${src2}
        '';

        installPhase = ''
          mkdir -p $out/aurora
          cp -r * $out/aurora/
        '';
      };
  };
}
