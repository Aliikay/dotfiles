{
  pkgs,
  stdenv,
  emacs-pgtk,
  ...
}: pkgs.emacs-pgtk.overrideAttrs (old: {
  buildInputs = with pkgs; [
    # Basic Dependancies
    libgccjit
    libtinfo
    gnutls
    
    discount # Markdown support

    # Treesitter support
    tree-sitter
    tree-sitter-grammars.tree-sitter-python
    tree-sitter-grammars.tree-sitter-typescript
    tree-sitter-grammars.tree-sitter-dockerfile
    tree-sitter-grammars.tree-sitter-nix
    tree-sitter-grammars.tree-sitter-bash
    tree-sitter-grammars.tree-sitter-css
    tree-sitter-grammars.tree-sitter-elisp
    tree-sitter-grammars.tree-sitter-html
    tree-sitter-grammars.tree-sitter-javascript
    tree-sitter-grammars.tree-sitter-json
    tree-sitter-grammars.tree-sitter-rust
    tree-sitter-grammars.tree-sitter-toml
    tree-sitter-grammars.tree-sitter-tsx
    tree-sitter-grammars.tree-sitter-yaml
    tree-sitter-grammars.tree-sitter-kdl
    tree-sitter-grammars.tree-sitter-c-sharp
  ];
})
