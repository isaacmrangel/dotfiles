{ lib, pkgs, user, ... }:

{
  home = {
    packages = with pkgs; [
        htop
        helix
        zsh
        zinit
        zellij
        gnumake
        starship
        mise
        gh
        monaspace
    ];

    username = user;
    homeDirectory = "/home/isaac";

    stateVersion = "24.11";

    sessionVariables = {
      EDITOR = "hx";
    };

   activation.refresh-font-cache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        fc-cache -f
    '';
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

  home.file.".local/bin/zellij_sessionizer" = {
    source = ./zellij_sessionizer;
    executable = true;
  };

  programs.zsh = {
    enable = true;

    initContent = ''
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
    userEmail = "ig-grangel@totalwine.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.home-manager.enable = true;
}
