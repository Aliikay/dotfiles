function fish_prompt
	set -l nix_shell_info (
		if test -n "$IN_NIX_SHELL"
		  echo -n "<nix-shell> "
		end
	)
end
