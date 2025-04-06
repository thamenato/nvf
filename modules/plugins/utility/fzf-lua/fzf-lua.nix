{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.types) enum package;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.nvim.types) mkPluginSetupOption borderType;
in {
  options.vim.fzf-lua = {
    enable = mkEnableOption "fzf-lua";
    setupOpts = mkPluginSetupOption "fzf-lua" {
      fzf_bin = mkOption {
        type = package;
        default = "${lib.getExe pkgs.fzf}";
        description = "fzf package to use";
      };
      winopts.border = mkOption {
        type = borderType;
        default = config.vim.ui.borders.globalStyle;
        description = "Border type for the fzf-lua picker window";
      };
    };
    profile = mkOption {
      type = enum [
        "default"
        "default-title"
        "fzf-native"
        "fzf-tmux"
        "fzf-vim"
        "max-perf"
        "telescope"
        "skim"
        "borderless"
        "borderless-full"
        "border-fused"
      ];
      default = "default";
      description = "The configuration profile to use";
    };
  };
}
