{
  config,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  pkgs-pinned,
  inputs,
  ...
}: {
  # Music Production tweaks
  musnix = {
    enable = true;
    # kernel.realtime = true;
  };

  environment.systemPackages = with pkgs; [
    # DAWs
    #ardour
    klystrack
    milkytracker
    musescore
    audacity
    reaper
    schismtracker
    lmms
    inputs.secrets.packages.x86_64-linux.renoise

    # Tooling
    yabridge
    yabridgectl
  ];
}
