/* # */
#  Home-manager configuration for User "martin"
#

{ config, lib, pkgs, ... }: with lib;
let

  toggleSonyHeadphones = pkgs.writeShellScriptBin "toggleSonyHeadphones" ''
    # Toggle connection to bluetooth device

    mac="AC:80:0A:FF:2D:CB" # Sony WF-1000XM5

    if bluetoothctl info "$mac" | grep -q 'Connected: yes'; then
        echo "Turning off $mac"
        bluetoothctl disconnect || echo "Error $?"
    else
        echo "Turning on $mac"
        # turn on bluetooth in case it's off
        rfkill unblock bluetooth

        bluetoothctl power on
        bluetoothctl connect "$mac"
        sink=$(pactl list short sinks | grep bluez | awk '{print $2}')

        if [ -n "$sink" ]; then
            pacmd set-default-sink "$sink" && echo "OK default sink : $sink"
        else
            echo could not find bluetooth sink
            exit 1
        fi
    fi

  '';

in
{
  imports = [
    ../common.nix
  ];


  programs = {
    git = mkIf config.modules.git.enable {
      userEmail = "git@treml.dev";
      userName = "Martin Treml";
    };

		direnv = {
			enable = true;
		};
  };

  home = {
    username = "martin";
    homeDirectory = "/home/martin";

    sessionVariables = {
      TERMINAL = "ghostty";
      EDITOR = "vim";
    };

    packages = with pkgs; [
			android-tools
			autofs5
			chromium
			cilium-cli
			dnsutils
			jq
			nfs-utils
			nmap
			rustdesk
			smartmontools
			talosctl
			unstable.ghostty
			vlc
			yq
		  argocd
      toggleSonyHeadphones
    ];
  };


}
