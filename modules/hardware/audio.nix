#
#  A standard audio configuration module
#
{ pkgs, ... }:

{
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    alsa-utils
    pavucontrol
    playerctl
  ];
}
