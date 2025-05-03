.PHONY: update
update:
	home-manager switch --flake .

.PHONE: clean
clean:
	nix-collect-garbage -d
