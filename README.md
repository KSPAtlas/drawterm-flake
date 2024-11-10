# drawterm-flake

Flake that provides the 9front fork of drawterm, which adds DP9IK authentication, rcpu, and other features.

## "I just want to get this running!"

With `flakes` and `nix-command` features enabled, run `nix run github:KSPAtlas/drawterm-flake`.

## "I want to put this in my NixOS/home-manager configuration"

In your flake, put
```nix
inputs = {
  drawterm.url = "github:KSPAtlas/drawterm-flake";
  ...
}
```

and wherever you want to put the package, put `inputs.drawterm.packages."${system}".default`. For example,
```nix
environment.systemPackages = with pkgs; [
  inputs.drawterm.packages."${system}".default
];
```
