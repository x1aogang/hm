{ username, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(ps --no-header --pid=$PPID --format=cmd) != "fish" && -z $BASH_EXECUTION_STRING ]]
      then
        exec env SHELL=${pkgs.fish}/bin/fish ${pkgs.fish}/bin/fish
      fi
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # disable greeting
    '';
    #interactiveShellInit = ''
          shellInit = ''
            fish_add_path ~/.local/bin
            # set -Ua fish_user_paths /home/cole/code/nixcfg
          '';
          shellAliases = {
            "ls" = "lsd";
            "l" = "lsd -l";
            "la" = "lsd -a";
            "lt" = "lsd --tree --depth 3";
            "g" = "git";
          };
    plugins = [];
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins;
      [
        # TODO:
        # LazyVim
      ];
  };

  programs.direnv = {
    enable = true;
    # enableFishIntegration = true;
    nix-direnv = { enable = true; };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    fastfetch
    just
    nixd
    ruff
    lsd
    starship
    zoxide
    atuin

    tmux
    gitmux
    sesh

    fzf
    ripgrep
    watchexec
    nix-your-shell
    nodejs
    uv

    # fine-tune a package
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # a new script
    (pkgs.writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # ".config/tmux" = {
    #   source = ./config/tmux;
    #   recursive = true;
    # };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/x/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
