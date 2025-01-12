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

# from any-nix-shell
if type -q any-nix-shell 
    any-nix-shell fish --info-right | source
end

set DOTNET_CLI_TELEMETRY_OPTOUT 'true'

source "$HOME/.cargo/env.fish"  # For fish

