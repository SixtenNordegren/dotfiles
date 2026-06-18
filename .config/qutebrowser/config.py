config.load_autoconfig(False)
config.bind('pw', 'spawn --userscript qute-bitwarden')


c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = 'dark'
c.fonts.default_family = 'sans-serif'
c.fonts.default_size = '14pt'
c.fonts.web.family.standard = 'sans-serif'
c.fonts.web.family.fixed = 'monospace'
c.url.searchengines= {"DEFAULT": "http://www.google.com/search?q={}"}
