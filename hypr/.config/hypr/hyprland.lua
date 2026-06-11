----------------
--- MONITORS ---
----------------

local monitorsLoaded = pcall(require, "monitors")
if not monitorsLoaded then
    hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
end


-------------------
--- MY PROGRAMS ---
-------------------

local ipc = "qs -c noctalia-shell ipc call"

local terminal = "kitty"
local fileManager = "nautilus"
local browser = "brave"
local browserIncognito = "brave --incognito"
local code = "code"
local menu = ipc .. " launcher toggle"
local sessionMenu = ipc .. " sessionMenu toggle"
local notifycmd = "notify-send -t 1000"
local lockcmd = "hyprlock"


-----------------
--- AUTOSTART ---
-----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("qs -c noctalia-shell --no-duplicate")
    hl.exec_cmd("/usr/lib/mate-polkit/polkit-mate-authentication-agent-1")

    -- Clipboard manager
    hl.exec_cmd("wl-clipboard-history -t")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Solaar for MX Master
    hl.exec_cmd("solaar --window hide")
end)

-- Keep the old `exec =` reload behavior for theme defaults.
hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'")


-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland")


---------------------
--- LOOK AND FEEL ---
---------------------

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 4,
        border_size = 1,

        col = {
            active_border = "rgb(b4befe)",
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 4,
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = false,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        enable_swallow = true,
        swallow_regex = "^(Alacritty)$",
    },

    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = 0.25,

        touchpad = {
            disable_while_typing = true,
            natural_scroll = true,
            clickfinger_behavior = true,
        },
    },

    xwayland = {
        force_zero_scaling = true,
    },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "default" })

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })


-------------------
--- KEYBINDINGS ---
-------------------

local mainMod = "SUPER"

-- Menu
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(ipc .. " plugin:assistant-panel toggle"))
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd(ipc .. " settings toggle"))

-- Terminal
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))

-- Hyprland
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(sessionMenu))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(lockcmd))
hl.bind(mainMod .. " + F", function()
    hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen" }))
    hl.exec_cmd(notifycmd .. " 'Fullscreen Mode'")
end)
hl.bind(mainMod .. " + S", function()
    hl.dispatch(hl.dsp.window.pseudo())
    hl.exec_cmd(notifycmd .. " 'Pseudo Mode'")
    hl.dispatch(hl.dsp.workspace.toggle_special("magic"))
end)
hl.bind(mainMod .. " + Space", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.window.center())
end)

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move active window with mainMod + SHIFT + arrow keys
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Resize active window
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + CTRL + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume increase"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume decrease"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. " volume muteOutput"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. " brightness increase"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. " brightness decrease"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(ipc .. " media next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(ipc .. " media previous"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(ipc .. " media playPause"))

-- Application shortcuts
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(browserIncognito))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(code))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("notion-app"))

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd('grim - | wl-copy && notify-send "Full screen captured"'))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy && notify-send "Region captured"'))


------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

hl.window_rule({ match = { class = "blueman-manager" }, float = true })
hl.window_rule({ match = { class = "org.kde.kmix" }, float = true })
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- No gaps when only one window
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0, rounding = 0 })
