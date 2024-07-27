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

set LESS -r

# from any-nix-shell
if type -q any-nix-shell 
    any-nix-shell fish --info-right | source
end
