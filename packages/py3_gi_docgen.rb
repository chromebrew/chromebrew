# Adapted from Arch Linux gi-docgen PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gi-docgen/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_gi_docgen < Pip
  description 'Documentation generator for GObject-based libraries'
  homepage 'https://gnome.pages.gitlab.gnome.org/gi-docgen/'
  version "2024.1-#{CREW_PY_VER}"
  license 'Apache GPL3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '444fb83b04c965a93b8af4a87f6a699ba03ec69214b3c134989f8d3e21db6fd1',
     armv7l: '444fb83b04c965a93b8af4a87f6a699ba03ec69214b3c134989f8d3e21db6fd1',
       i686: 'd938d3f92f0691b0762cc842d5a7fa4e28c4b38853c64344808a51caf975085b',
     x86_64: '04e0e3ae8affa8f4c1e8d7490c53ef6312f2b0d77ab74821247fd9efe740a41d'
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
