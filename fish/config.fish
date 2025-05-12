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

	# Kanagawa Fish shell theme
	set -l foreground DCD7BA normal
	set -l selection 2D4F67 brcyan
	set -l comment 727169 brblack
	set -l red C34043 red
	set -l orange FF9E64 brred
	set -l yellow C0A36E yellow
	set -l green 76946A green
	set -l purple 957FB8 magenta
	set -l cyan 7AA89F cyan
	set -l pink D27E99 brmagenta

	# Syntax Highlighting Colors
	set -g fish_color_normal $foreground
	set -g fish_color_command $cyan
	set -g fish_color_keyword $pink
	set -g fish_color_quote $yellow
	set -g fish_color_redirection $foreground
	set -g fish_color_end $orange
	set -g fish_color_error $red
	set -g fish_color_param $purple
	set -g fish_color_comment $comment
	set -g fish_color_selection --background=$selection
	set -g fish_color_search_match --background=$selection
	set -g fish_color_operator $green
	set -g fish_color_escape $pink
	set -g fish_color_autosuggestion $comment

	# Completion Pager Colors
	set -g fish_pager_color_progress $comment
	set -g fish_pager_color_prefix $cyan
	set -g fish_pager_color_completion $foreground
	set -g fish_pager_color_description $comment

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
