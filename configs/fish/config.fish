if status is-interactive
    # Commands to run in interactive sessions can go here
  set fish_greeting  
end

function ..
  cd ..
end

alias vim "nvim"
alias exercism "~/programs/exercism/bin/exercism"
set TEMPL_EXPERIMENT rawgo 

# meaningless comment
set LESS -r

# opam configuration
source /home/jakub/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# from any-nix-shell
if type -q any-nix-shell 
    any-nix-shell fish --info-right | source
end

# for .dotnet completions
complete -f -c dotnet -a "(dotnet complete (commandline -cp))"
# fuck telemetry
set -U DOTNET_CLI_TELEMETRY_OPTOUT 1
