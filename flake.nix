{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.03";

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation rec {
        name = "aurora-wine";
        # version = "1.11"
        src = pkgs.fetchurl {
          curlOpts  = [ "--user-agent" "Wget" ];
          url       = "http://pentarch.org/steve/Aurora151Full.rar";
          sha256    = "aab11f817be1131cc32efebd2a02faf0bf0600a2af7ef971ff32f290a581ef3d";
        };

        setup-hooks = [ unrar ];

#        unpackPhase = ''
#          mkdir src && cd src
#          unar ${src}
#        '';
        installPhase = ''
          cp -r src $out
        '';
      };
  };
}
