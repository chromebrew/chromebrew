# Adapted from Arch Linux gi-docgen PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gi-docgen/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_gi_docgen < Pip
  description 'Documentation generator for GObject-based libraries'
  homepage 'https://gnome.pages.gitlab.gnome.org/gi-docgen/'
  @_ver = '2024.1'
  version "#{@_ver}-py3.12"
  license 'Apache GPL3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_jinja2'
  depends_on 'py3_markdown'
  depends_on 'py3_markupsafe'
  depends_on 'py3_pygments'
  depends_on 'python3' => :build

  no_compile_needed
  depends_on 'py3_toml'
  depends_on 'py3_typogrify'
end
