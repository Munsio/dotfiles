{ ... }:
{
  # User configuration
  users.users.martin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "dialout" "adbusers"];
  };

	

  # Userspecific overrides
  programs.nh.flake = "/home/martin/.setup";

	programs.adb.enable = true;

	# Virtualization stuff
	virtualisation.podman.enable = true;
}
