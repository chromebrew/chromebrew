# Adapted from Arch Linux gi-docgen PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gi-docgen/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_gi_docgen < Pip
  description 'Documentation generator for GObject-based libraries'
  homepage 'https://gnome.pages.gitlab.gnome.org/gi-docgen/'
  version "2025.3-#{CREW_PY_VER}"
  license 'Apache GPL3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5fd49cc13d1d61c8187e0797d772739581df1e403a7cc8676fdedc4cb2038c32',
     armv7l: '5fd49cc13d1d61c8187e0797d772739581df1e403a7cc8676fdedc4cb2038c32',
       i686: '84499375d718a19ad99f13e670ad4bca1d36749841a270feaa21b12da12d6f56',
     x86_64: '9a68e82076b1a68c6b4b87f3ddd183c802b4ee73d49fa6064dea78e8a10ba04c'
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
