{ pkgs, ... }:

{
  home.username = "gabriel";
  home.homeDirectory = "/home/gabriel";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    brightnessctl
    curl
    dbeaver-bin
    discord
    lxqt.lxqt-policykit
    nixd
    nixfmt
    opencode
    pavucontrol
    playerctl
    rtk
    swaybg
    swayidle
    swayimg
    swaylock
    wayshot
    vim
    wl-clipboard
    wmenu
  ];

  programs = {
    alacritty = {
      enable = true;
      settings = {
        window.opacity = 0.8;
        colors.primary.background = "#000000";
        font.size = 16;
      };
    };
    firefox.enable = true;

    fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting
      '';
    };

    git.enable = true;

    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    swaylock = {
      enable = true;
      settings = {
        color = "808080";
        font-size = 24;
        indicator-idle-visible = false;
        indicator-radius = 100;
        line-color = "ffffff";
        show-failed-attempts = true;
      };
    };

    vscode.enable = true;

    waybar = {
      enable = true;

      settings = [
        {
          height = 24;
          spacing = 4;

          "modules-left" = [
            "sway/workspaces"
          ];

          "modules-center" = [
            "sway/window"
          ];

          "modules-right" = [
            "custom/weather"
            "pulseaudio"
            "clock"
            "tray"
          ];

          tray.spacing = 10;

          clock = {
            "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format = "{:%d-%m-%Y %H:%M}";
          };

          pulseaudio = {
            "scroll-step" = 5;
            format = "{volume}% {icon}";
            "format-icons" = {
              default = [
                ""
                ""
                ""
              ];
            };
            "on-click" = "pavucontrol";
          };

          "custom/weather" = {
            exec = "curl wttr.in/?format=1";
            interval = 1800;
          };
        }
      ];

      style = ''
        * {
            /* `otf-font-awesome` is required to be installed for icons */
            font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
            font-size: 13px;
        }

        window#waybar {
            background-color: rgba(0, 0, 0, 1);
            color: #ffffff;
            transition-property: background-color;
            transition-duration: .5s;
        }

        button {
            box-shadow: inset 0 -3px transparent;
            border: none;
            border-radius: 0;
        }

        button:hover {
            background: inherit;
            box-shadow: inset 0 -3px #ffffff;
        }

        #workspaces button {
            padding: 0 5px;
            color: #ffffff;
        }

        #workspaces button:hover {
            background: rgba(0, 0, 0, 0.2);
        }

        #workspaces button.focused, #workspaces button.active {
            background-color: #64727D;
            box-shadow: inset 0 -3px #ffffff;
        }

        #workspaces button.urgent {
            background-color: #eb4d4b;
        }

        #custom-weather,
        #clock,
        #pulseaudio,
        #tray {
            padding: 0 10px;
            color: #ffffff;
        }

        #window,
        #workspaces {
            margin: 0 4px;
        }

        #pulseaudio {
          margin-bottom: 1px;
        }

        .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
        }

        .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
        }
      '';
    };
  };

  services.gammastep = {
    enable = true;

    dawnTime = "06:00-08:00";
    duskTime = "18:00-20:00";

    temperature = {
      day = 5500;
      night = 3700;
    };

    tray = true;

    enableVerboseLogging = true;

    settings = {
      general = {
        adjustment-method = "wayland";
      };
    };
  };

  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";
    };

    style = ''
      .notification {
        border-radius: 0px;
      }
      .control-center {
        border-radius: 0px;
      }
    '';
  };

  services.swayidle = {
    enable = true;

    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.sway}/bin/swaymsg 'output * power off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    systemd.enable = true;

    config = {
      modifier = "Mod4";
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      terminal = "alacritty";
      menu = "wmenu-run -N 000000";

      output."DP-3".mode = "2560x1440@180Hz";

      input."type:keyboard" = {
        xkb_layout = "br";
        xkb_model = "abnt2";
      };

      window = {
        border = 0;
        titlebar = false;
      };

      floating = {
        border = 0;
        modifier = "Mod4";
        titlebar = false;
      };

      keybindings = {
        "Mod4+Return" = "exec $term";
        "Mod4+d" = "exec $menu";
        "Mod4+q" = "kill";

        "Mod4+Shift+c" = "reload";
        "Mod4+Shift+e" =
          "exec swaynag -t warning -m 'Do you really want to exit Sway?' -B 'Exit Sway' 'swaymsg exit'";

        "Mod4+h" = "focus left";
        "Mod4+j" = "focus down";
        "Mod4+k" = "focus up";
        "Mod4+l" = "focus right";
        "Mod4+Left" = "focus left";
        "Mod4+Down" = "focus down";
        "Mod4+Up" = "focus up";
        "Mod4+Right" = "focus right";

        "Mod4+Shift+h" = "move left";
        "Mod4+Shift+j" = "move down";
        "Mod4+Shift+k" = "move up";
        "Mod4+Shift+l" = "move right";
        "Mod4+Shift+Left" = "move left";
        "Mod4+Shift+Down" = "move down";
        "Mod4+Shift+Up" = "move up";
        "Mod4+Shift+Right" = "move right";

        "Mod4+1" = "workspace number 1";
        "Mod4+2" = "workspace number 2";
        "Mod4+3" = "workspace number 3";
        "Mod4+4" = "workspace number 4";
        "Mod4+5" = "workspace number 5";
        "Mod4+6" = "workspace number 6";
        "Mod4+7" = "workspace number 7";
        "Mod4+8" = "workspace number 8";
        "Mod4+9" = "workspace number 9";
        "Mod4+0" = "workspace number 10";

        "Mod4+Shift+1" = "move container to workspace number 1";
        "Mod4+Shift+2" = "move container to workspace number 2";
        "Mod4+Shift+3" = "move container to workspace number 3";
        "Mod4+Shift+4" = "move container to workspace number 4";
        "Mod4+Shift+5" = "move container to workspace number 5";
        "Mod4+Shift+6" = "move container to workspace number 6";
        "Mod4+Shift+7" = "move container to workspace number 7";
        "Mod4+Shift+8" = "move container to workspace number 8";
        "Mod4+Shift+9" = "move container to workspace number 9";
        "Mod4+Shift+0" = "move container to workspace number 10";

        "Mod4+b" = "splith";
        "Mod4+v" = "splitv";
        "Mod4+s" = "layout stacking";
        "Mod4+w" = "layout tabbed";
        "Mod4+e" = "layout toggle split";
        "Mod4+f" = "fullscreen";
        "Mod4+Shift+space" = "floating toggle";
        "Mod4+space" = "focus mode_toggle";
        "Mod4+a" = "focus parent";

        "Mod4+r" = "mode resize";
      };

      modes.resize = {
        h = "resize shrink width 10px";
        j = "resize grow height 10px";
        k = "resize shrink height 10px";
        l = "resize grow width 10px";
        Left = "resize shrink width 10px";
        Down = "resize grow height 10px";
        Up = "resize shrink height 10px";
        Right = "resize grow width 10px";
        Return = "mode default";
        Escape = "mode default";
      };

      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
          position = "top";
        }
      ];

      startup = [
        { command = "lxqt-policykit-agent"; }
      ];
    };

    extraConfigEarly = ''
      set $mod Mod4
      set $left h
      set $down j
      set $up k
      set $right l
      set $term alacritty
      set $menu wmenu-run -N 000000

      # Keep the system-provided Sway integration and portal settings.
      include /etc/sway/config.d/*

      exec dbus-update-activation-environment \
        --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
    '';

    extraConfig = ''
      bindsym --locked XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
      bindsym --locked XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
      bindsym --locked XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
      bindsym --locked XF86AudioMicMute exec pactl set-source-mute @DEFAULT_SOURCE@ toggle

      bindsym --locked XF86AudioPlay exec playerctl play-pause
      bindsym --locked XF86AudioPause exec playerctl play-pause
      bindsym --locked XF86AudioPrev exec playerctl previous
      bindsym --locked XF86AudioNext exec playerctl next
      bindsym --locked XF86AudioStop exec playerctl stop

      bindsym Print exec wayshot -g --clipboard
    '';
  };
}
