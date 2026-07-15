{
  system ? builtins.currentSystem,
  pkgs ?
    import <nixpkgs> {
      inherit system;
    },
}:
pkgs.mkShell {
  venvDir = "./.venv";

  buildInputs = with pkgs; [
    python312
    python312Packages.venvShellHook
    python312Packages.pygobject3
    gtk3
    gobject-introspection
  ];

  packages = with pkgs; [
    python312
    python312Packages.tkinter
    python312Packages.python-lsp-server
  ];

  postVenvCreation = ''
    pip install -r ${./requirements.txt}
  '';

  shellHook = ''
    venvShellHook
  '';

  LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
  XDG_DATA_DIRS = "$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}";
}
