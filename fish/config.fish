if status is-interactive
	# Commands to run in interactive sessions
	source ~/.config/fish/alias.fish

	# Fish Greeting
	function fish_greeting
		echo Remember, speak to the (set_color green)Duck!
	end

	# Enable vi mode
	set fish_cursor_default block blink
	set fish_cursor_insert line blink
	set fish_cursor_replace_one underscore blink
	set fish_cursor_visual block
	fish_vi_key_bindings

	# Valid path
	set -g fish_color_valid_path --underline

	# Init Starship
	starship init fish | source
end

# Change editor to neovim
set -gx VISUAL nvim
set -gx EDITOR nvim

# Starship Config
set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"

# Volta
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# Created by `pipx` on 2025-05-12 21:41:00
set PATH $PATH /home/brbenham1/.local/bin
