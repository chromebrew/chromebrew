# Adapted from Arch Linux gi-docgen PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gi-docgen/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_gi_docgen < Pip
  description 'Documentation generator for GObject-based libraries'
  homepage 'https://gnome.pages.gitlab.gnome.org/gi-docgen/'
  version "2025.4-#{CREW_PY_VER}"
  license 'Apache GPL3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b11dd08170f7425a6c0bb4a0296a98f2a50eac039a17894cad9755354ffc8fc',
     armv7l: '3b11dd08170f7425a6c0bb4a0296a98f2a50eac039a17894cad9755354ffc8fc',
       i686: '80b1ea4d9be56caab398fdf14cc32f58ed574ee808f8221b3b5074fa01a2c84b',
     x86_64: '96591a9fb5e108fe2e76ee6699962cd606b38655c9b6c48f87d85f19a321565e'
  })

  depends_on 'py3_jinja2'
  depends_on 'py3_markdown'
  depends_on 'py3_markupsafe'
  depends_on 'py3_pygments'
  depends_on 'python3' => :build

  no_source_build
  depends_on 'py3_toml'
  depends_on 'py3_typogrify'
end
