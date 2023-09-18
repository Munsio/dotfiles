{ pkgs ? import <nixpkgs> { }, ... }: rec {
  git-autofixup = pkgs.callPackage ./git-autofixup { };
}
