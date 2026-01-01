source /usr/share/cachyos-fish-config/cachyos-config.fish

function fish_greeting
end

set -gx DOTNET_ROOT $HOME/.dotnet
fish_add_path -g $DOTNET_ROOT $DOTNET_ROOT/tools
