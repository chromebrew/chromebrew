# Adapted from Arch Linux gi-docgen PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gi-docgen/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_gi_docgen < Pip
  description 'Documentation generator for GObject-based libraries'
  homepage 'https://gnome.pages.gitlab.gnome.org/gi-docgen/'
  version "2026.1-#{CREW_PY_VER}"
  license 'Apache GPL3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '694ab15610911f184689c37d5e1d64b14c72f35f348c70f8ec67a2d996520a43',
     armv7l: '694ab15610911f184689c37d5e1d64b14c72f35f348c70f8ec67a2d996520a43',
       i686: '33500ec9bfd4706539de9014b745e1bc3daf32a23b829c604ebab1e16d20dbd6',
     x86_64: 'a81ab3a68ea6d8b45cc69b2885c8f25053672fb738903a6411532ef9ac8338c9'
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
