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
    aarch64: 'df8293190af66b494c81cb153b771a9dc12cc0fdd58535ec91cd3ac7f51417e5',
     armv7l: 'df8293190af66b494c81cb153b771a9dc12cc0fdd58535ec91cd3ac7f51417e5',
       i686: '84499375d718a19ad99f13e670ad4bca1d36749841a270feaa21b12da12d6f56',
     x86_64: 'f46650177fb99c94697a4533d5b97a7d962d2f5c75034b09f1896574c070ccad'
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
