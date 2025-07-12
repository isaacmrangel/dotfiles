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

    activation.make-zsh-default-shell = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      # if zsh is not the current shell
        PATH="/usr/bin:/bin:$PATH"
        ZSH_PATH="/home/${user}/.nix-profile/bin/zsh"
        echo 'eval "$(zellij setup --generate-auto-start zsh)"' >> ~/.zshrc
        if [[ $(getent passwd ${user}) != *"$ZSH_PATH" ]]; then
          echo "setting zsh as default shell (using chsh). password might be necessay."
          echo "adding zsh to /etc/shells"
          run echo "$ZSH_PATH" | sudo tee -a /etc/shells
          echo "running chsh to make zsh the default shell"
          run chsh -s $ZSH_PATH ${user}
          echo "zsh is now set as default shell !"
        fi
    '';

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
    source = ./.local/bin/zellij_sessionizer;
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
