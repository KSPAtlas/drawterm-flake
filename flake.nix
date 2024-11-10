{
  description = "Flake for the 9Front version of drawterm";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages."${system}" = {
      drawterm = pkgs.stdenv.mkDerivation {
        pname = "drawterm";
        version = "1";

        src = pkgs.fetchgit {
          url = "git://git.9front.org/plan9front/drawterm";
          rev = "d7620e8d528a87a3d6cf7285a839d52d4f705771";
          hash = "sha256-v84kvlLKUGR6SY+DPD9fVUivkE56txrMU0dlph2c7bM=";
        };

        strictDeps = true;

        buildInputs = with pkgs; [
          xorg.libX11
          xorg.libXt
        ];

        buildPhase = ''
          CONF=unix make
        '';
  
        installPhase = ''
          mkdir -p $out/bin
          cp drawterm $out/bin
        '';
  
          meta = with pkgs.lib; {
          homepage = "https://drawterm.9front.org/";
          description = "Fork of Russ Cox's drawterm to incorporate features from Plan9front (http://9front.org), most importantly DP9IK authentication support (see authsrv(6)) and the TLS based rcpu(1) protocol.";
          license = licenses.mit;
          maintainers = [ ];
          platforms = platforms.linux;
        };
      };
      default = self.packages."${system}".drawterm;
    };
  };
}
