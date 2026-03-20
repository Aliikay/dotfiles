{
  config,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  pkgs-pinned,
  inputs,
  lib,
  ...
}: {
  # SearXNG is a meta search engine
  services.searx = {
    enable = true;
    #redisCreateLocally = true;
    environmentFile = "/home/alikay/.searxng.env";
    settings = {
      server = {
        bind_address = "127.0.0.1";
        port = 6767;
        # WARNING: setting secret_key here might expose it to the nix cache
        # see below for the sops or environment file instructions to prevent this
        # secret_key =
      };

      general = {
        debug = false;
      };

      ui = {
        query_in_title = true;
      };

      engines = lib.mapAttrsToList (name: value: {inherit name;} // value) {
        "duckduckgo".disabled = true;
        "brave".disabled = true;
        "bing".disabled = false;
        "mojeek".disabled = true;
        "mwmbl".disabled = false;
        "mwmbl".weight = 0.4;
        "qwant".disabled = true;
        "crowdview".disabled = false;
        "crowdview".weight = 0.5;
        "curlie".disabled = true;
        "ddg definitions".disabled = false;
        "ddg definitions".weight = 2;
        "wikibooks".disabled = false;
        "wikidata".disabled = false;
        "wikiquote".disabled = true;
        "wikisource".disabled = true;
        "wikispecies".disabled = false;
        "wikispecies".weight = 0.5;
        "wikiversity".disabled = false;
        "wikiversity".weight = 0.5;
        "wikivoyage".disabled = false;
        "wikivoyage".weight = 0.5;
        "currency".disabled = true;
        "dictzone".disabled = true;
        "lingva".disabled = true;
        "bing images".disabled = false;
        "brave.images".disabled = true;
        "duckduckgo images".disabled = true;
        "google images".disabled = false;
        "qwant images".disabled = true;
        "1x".disabled = false;
        "artic".disabled = false;
        "deviantart".disabled = false;
        "flickr".disabled = false;
        "imgur".disabled = false;
        "library of congress".disabled = false;
        "material icons".disabled = false;
        "material icons".weight = 0.2;
        "openverse".disabled = false;
        "pinterest".disabled = false;
        "svgrepo".disabled = false;
        "unsplash".disabled = false;
        "wallhaven".disabled = false;
        "wikicommons.images".disabled = false;
        "yacy images".disabled = false;
        "bing videos".disabled = false;
        "brave.videos".disabled = true;
        "duckduckgo videos".disabled = true;
        "google videos".disabled = false;
        "qwant videos".disabled = false;
        "dailymotion".disabled = false;
        "google play movies".disabled = false;
        "invidious".disabled = false;
        "odysee".disabled = false;
        "peertube".disabled = false;
        "piped".disabled = false;
        "rumble".disabled = false;
        "sepiasearch".disabled = false;
        "vimeo".disabled = false;
        "youtube".disabled = false;
        "brave.news".disabled = true;
        "google news".disabled = false;
      };
    };
  };
}
