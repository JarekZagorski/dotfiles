if status is-interactive
    # Commands to run in interactive sessions can go here
  set fish_greeting  
end

function ..
  cd ..
end

alias vim "nvim"
set TEMPL_EXPERIMENT rawgo 

set LESS -r
set EDITOR vim

# from any-nix-shell
if type -q any-nix-shell 
    any-nix-shell fish --info-right | source
end

set DOTNET_CLI_TELEMETRY_OPTOUT 'true'

# source "$HOME/.cargo/env.fish"  # For fish

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/jakub/.opam/opam-init/init.fish' && source '/home/jakub/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
