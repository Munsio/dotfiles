{ inputs, lib, ... }: {
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  flake-wezterm = final: _prev: {
    wezterm = if (lib.hasAttr "wezterm" inputs) then
          inputs.wezterm.packages.${_prev.system}.default
        else
          _prev.wezterm; 
  };

}



    