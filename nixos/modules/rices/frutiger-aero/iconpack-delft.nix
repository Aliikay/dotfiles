{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gtk3,
  hicolor-icon-theme,
}:
stdenvNoCC.mkDerivation rec {
  pname = "iconpack-crystal-remix";
  version = "1.15";

  src = fetchFromGitHub {
    owner = "madmaxms";
    repo = "iconpack-delft";
    tag = "v${version}";
    hash = "sha256-fluSh2TR1CdIW54wkUp1QRB0m9akFKnSn4d+0z6gkLA=";
  };

  nativeBuildInputs = [gtk3];

  propagatedBuildInputs = [
    hicolor-icon-theme
  ];

  dontDropIconThemeCache = true;

  installPhase = ''
    mkdir -p $out/share/icons/
    cp -a Delft* $out/share/icons/

    for theme in $out/share/icons/*; do
      echo $theme
      ls $theme
      echo "============================"
      gtk-update-icon-cache $theme
    done
  '';

  meta = {
    description = "Continuation of Faenza icon theme with up to date app icons";
    homepage = "https://github.com/madmaxms/iconpack-delft";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    # maintainers = [ lib.maintainers.romildo ];
  };
}
