{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.nvim.types) mkGrammarOption;

  cfg = config.vim.languages.just;
in {
  options.vim.languages.just = {
    enable = mkEnableOption "Just (Justfile) language support";

    treesitter = {
      enable = mkEnableOption "Just treesitter" // {default = config.vim.languages.enableTreesitter;};

      package = mkGrammarOption pkgs "just";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.treesitter.enable {
      vim.treesitter.enable = true;
      vim.treesitter.grammars = [cfg.treesitter.package];
    })
  ]);
}
