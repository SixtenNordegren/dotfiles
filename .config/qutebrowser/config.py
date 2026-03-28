config.load_autoconfig(False)
config.bind('pw', 'spawn -m --userscript qute-pass --always-show-selection')


c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = 'dark'
c.fonts.default_family = 'sans-serif'
c.fonts.default_size = '12pt'
c.fonts.web.family.standard = 'sans-serif'
c.fonts.web.family.fixed = 'monospace'
c.url.searchengines= {"DEFAULT": "http://www.google.com/search?q={}"}
