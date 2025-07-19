{ lib, pkgs, user, ... }:

let
  # Fetch the harpoon plugin with a known SHA256 hash for purity
  harpoon-plugin = pkgs.fetchurl {
    url = "https://github.com/Nacho114/harpoon/releases/download/v0.1.0/harpoon.wasm";
    sha256 = "00ln03gjpf6xdfq1d3z84pcvmyrk1n1ddi1nkfxsmnqxldyzinfa";
  };

  # Read the layout file and substitute the plugin path
  zellij-layout = pkgs.runCommand "default.kdl" {} ''
    substitute ${./zellij/layouts/default.kdl} $out \
      --replace "__PLUGIN_PATH__" "${harpoon-plugin}"
  '';

in
{
  # Core home-manager configuration
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "24.11";

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
      fontconfig
      nixfmt-rfc-style
    ];

    sessionVariables = {
      EDITOR = "hx";
    };

    activation.refresh-font-cache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      echo "Refreshing font cache..."
      ${pkgs.fontconfig}/bin/fc-cache -f
    '';
  };

  # Symlinked configuration files
  home.file = {
    ".config/ghostty/config".source = ./ghostty/config;
    ".config/helix/themes/kanabox_default.toml".source = ./helix/themes/kanabox_default.toml;
    ".config/helix/config.toml".source = ./helix/config.toml;
    ".config/helix/languages.toml".source = ./helix/languages.toml;
    ".local/bin/zellij_sessionizer" = {
      source = ./zellij_sessionizer;
      executable = true;
    };
    # Link the processed Zellij layout
    ".config/zellij/layouts/default.kdl".source = zellij-layout;
  };

  programs = {
    zsh = {
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

    starship = {
      enable = true;
      enableZshIntegration = false;
      settings = pkgs.lib.importTOML ./starship.toml;
    };

    git = {
      enable = true;
      userName = "Gadiel Rangel";
      userEmail = "machadogadiel@icloud.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    zellij = {
      enable = true;
      settings = {
        pane_frames = false;
        theme = "kanagawa";
        # Use the layout file we just linked
        default_layout = "default";
      };
    };

    home-manager.enable = true;
  };
}
