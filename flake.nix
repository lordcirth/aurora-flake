{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-20.03;

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
    with import nixpkgs { system = "x86_64-linux"; };
    stdenv.mkDerivation {
      name = "aurora-wine";
      # version = "1.11"
      src = nixpkgs.lib.fetchurl {
        url = "http://www.pentarch.org/steve/Aurora151Full.rar";
      };
  };
}
