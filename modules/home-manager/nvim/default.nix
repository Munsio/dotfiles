#
# NeoVim - Terminal editor
#
{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.modules.nvim;
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in
{
  options.modules.nvim = { enable = mkEnableOption "nvim"; };

  config = mkIf cfg.enable {
    programs = {
      neovim = {
        enable = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        extraPackages = with pkgs; [
					lua-language-server
					nil
					stylua
					ripgrep
					zig
        ];

				plugins = with pkgs.vimPlugins; [
					
				];

      };
    };

    xdg.configFile.neovim = {
      enable = true;
      source = config.lib.meta.mkMutableSymlink ./config;
      target = "nvim";
    };
  };
}
