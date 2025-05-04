{ lib, config, pkgs, inputs, ... }:

{
  home = {
    packages = with pkgs; [
        git
        htop
        helix
        monaspace
        ghostty
        zsh
        zinit
        starship
        mise
        gh
    ];

    username = "isaac";
    homeDirectory = "/home/isaac";

    stateVersion = "24.11";

    sessionVariables = {
      EDITOR = "hx";
    };
  };

  home.file.".config/ghostty/config" = {
    source = ./ghostty/config;
  };

  home.file.".config/helix/themes/kanabox_default.toml" = {
    source = ./helix/themes/kanabox_default.toml;
  };

  home.file.".config/helix/config.toml" = {
    source = ./helix/config.toml;
  };

  home.file.".config/helix/languages.toml" = {
    source = ./helix/languages.toml;
  };

  programs.zsh = {
    enable = true;

    initExtra = ''
      source ${./zsh_config/zinit_setup.zsh}
      source ${./zsh_config/plugins.zsh}
      source ${./zsh_config/misc.zsh}
    '';

    shellAliases = {
      ls = "exa --git --icons -a --group-directories-first --sort=modified";
      lsz = "exa -l -h --git --icons -a --group-directories-first --sort=modified -r --no-permissions --no-user --no-time";
    };
   };

  programs.starship = {
    enable = true;

    enableZshIntegration = false;
    settings = pkgs.lib.importTOML ./starship.toml;
  };

  programs.git = {
    enable = true;
    userName = "Gadiel Rangel";
    userEmail = "github@gadiel.dev";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.home-manager.enable = true;
}
