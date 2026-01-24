config.load_autoconfig(False)

# enable dark‑mode on sites that support it
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = 'dark'  # prefer dark colour scheme
c.fonts.default_family = 'sans-serif'            # default font family
c.fonts.default_size = '12pt'                    # default font size
c.fonts.web.family.standard = 'sans-serif'       # standard web font
c.fonts.web.family.fixed = 'monospace'           # fixed‑width font
# c.terminal = 'xterm'

config.bind('pw', 'spawn -m --userscript qute-pass --always-show-selection')
