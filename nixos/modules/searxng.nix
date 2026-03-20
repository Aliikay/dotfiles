{
  config,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  pkgs-pinned,
  inputs,
  ...
}: {
  # SearXNG is a meta search engine
  services.searx = {
    enable = true;
    #redisCreateLocally = true;
    environmentFile = "/home/alikay/.searxng.env";
    settings = {
      server = {
        bind_address = "::1";
        #port = 6767;
        # WARNING: setting secret_key here might expose it to the nix cache
        # see below for the sops or environment file instructions to prevent this
        # secret_key =
      };

      general = {
        #debug = false;
      };
    };
  };
}
