#
# VSCode - Microsoft Editor
#

{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.vscode;
in
{
  options.modules.vscode = { enable = mkEnableOption "vscode"; };

  config = mkIf cfg.enable {
    programs = {
      vscode = {
        enable = true;
        enableUpdateCheck = false;
        package = pkgs.unstable.vscode;
        extensions = with pkgs.vscode-marketplace; [
          # Not all extensions are available
          github.vscode-github-actions
          golang.go
          redhat.vscode-yaml
          jnoortheen.nix-ide
          symflower.symflower
        ];
        userSettings = {
          "workbench.startupEditor" = "none";
          "editor.fontFamily" = "'Fira Code'; 'Font Awesome 6 Free'; 'Font Awesome 6 Free Solid'; 'Font Awesome 6 Brands'; 'Droid Sans Mono'; 'monospace'; monospace";
          "workbench.editor.enablePreview" = false;
          "workbench.colorTheme" = "Default Dark+";
          "window.titleBarStyle" = "custom";
          "git.autofetch" = true;
          "[yaml;yml]" = {
            "editor.insertSpaces" = true;
            "editor.tabSize" = 2;
            "editor.autoIndent" = "advanced";
            "diffEditor.ignoreTrimWhitespace" = false;
          };
          "[nix]" = {
            "editor.tabSize" = 2;
          };
          "redhat.telemetry.enabled" = false;
          "editor.formatOnSave" = true;
          "go.lintTool" = "golangci-lint";
          "makefile.configureOnOpen" = false;
          "makefile.configureOnEdit" = false;
          "makefile.configureAfterCommand" = false;
          "editor.minimap.enabled" = false;
          "workbench.iconTheme" = "material-icon-theme";
          "files.insertFinalNewline" = true;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.serverSettings" = {
            "nixd" = {
              "formatting" = {
                "command" = ["nixpkgs-fmt"];
              };
              "diagnostic" = {
                "suppress" = [
                  "sema-escaping-with"
                ];
              };
            };
          };
        };
      };
    };
  };
}
