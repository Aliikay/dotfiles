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
    python3Packages.venvShellHook
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
}
