# Adapted from Arch Linux gi-docgen PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gi-docgen/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_gi_docgen < Pip
  description 'Documentation generator for GObject-based libraries'
  homepage 'https://gnome.pages.gitlab.gnome.org/gi-docgen/'
  version "2025.5-#{CREW_PY_VER}"
  license 'Apache GPL3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d3fe2c8dc2298f3be378c5c302fff52fe7b8428068dcd8c1aae20b547815c43',
     armv7l: '6d3fe2c8dc2298f3be378c5c302fff52fe7b8428068dcd8c1aae20b547815c43',
       i686: '69c638abe28818abce19214e95eda847f0529498db0a07e0333ce1a0c4e9306f',
     x86_64: 'c174dd0b1ae8d7bea43c1e326ae93811270778904e30ac823759a77f7482a752'
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
