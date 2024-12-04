# HM config

## https://nix-community.github.io/home-manager/index.xhtml#ch-nix-flakes

`~/.config/nix/nix.conf`

```nix
nix = {
  package = pkgs.nixFlakes;
  extraOptions = ''
    experimental-features = nix-command flakes
  '';
};
```
