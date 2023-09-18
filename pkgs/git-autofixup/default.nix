{ lib, stdenv, pkgs, }:
let
  version = "0.004005";
in
stdenv.mkDerivation {
  src = pkgs.fetchurl {
    url = "https://github.com/torbiak/git-autofixup/releases/download/v${version}/git-autofixup";
    sha256 = "1s2bi9ch2wlwrvw776k13rfjjd7vmssaf0qcmxhrmsy813py6fzk";
  };
  phases = [ "installPhase" "patchPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/git-autofixup
    chmod +x $out/bin/git-autofixup
  '';
}
