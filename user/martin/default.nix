{ ... }:
{
  # User configuration
  users.users.martin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "dialout"];
  };

  # Userspecific overrides
  programs.nh.flake = "/home/martin/.setup";
}
