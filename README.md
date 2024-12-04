# HM config

## nix quick installation

[DeterminateSystems/nix-installer](https://github.com/DeterminateSystems/nix-installer)

```shell
# install the installer
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# or
curl -sL -o nix-installer https://install.determinate.systems/nix/nix-installer-x86_64-linux
chmod +x nix-installer

./nix-installer install linux --no-confirm -v
```

uninstall: `/nix/nix-installer uninstall`

I use `just`: `curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to ~/.local/bin`

## [doc](https://nix-community.github.io/home-manager/index.xhtml#ch-nix-flakes)

Add the following configuration.

`~/.config/nix/nix.conf`

```nix
nix = {
  package = pkgs.nixFlakes;
  extraOptions = ''
    experimental-features = nix-command flakes
  '';
};
```
