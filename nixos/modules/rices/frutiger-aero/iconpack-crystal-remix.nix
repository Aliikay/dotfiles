{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gtk3,
  hicolor-icon-theme,
}:
stdenvNoCC.mkDerivation rec {
  pname = "iconpack-crystal-remix";
  version = "2.8";

  src = fetchFromGitHub {
    owner = "dangvd";
    repo = "crystal-remix-icon-theme";
    rev = "v${version}";
    sha256 = "sha256-UeJqGZx1K/KUjGYARWa55VzE2P0JeXiQPgp8uPkz1Mg=";
  };

  nativeBuildInputs = [gtk3];

  propagatedBuildInputs = [
    hicolor-icon-theme
  ];

  dontDropIconThemeCache = true;

  installPhase = ''
    mkdir -p $out/share/icons/Crystal-Remix
    cp -a * $out/share/icons/Crystal-Remix

    for theme in $out/share/icons/*; do
      echo $theme
      ls $theme
      echo "============================"
      gtk-update-icon-cache $theme
    done
  '';

  meta = {
    description = "A Crystal icon theme for modern Linux desktop environments";
    homepage = "https://github.com/dangvd/crystal-remix-icon-theme";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    # maintainers = [ lib.maintainers.romildo ];
  };
}
