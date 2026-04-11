# Adapted from Arch Linux python-rich PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-rich/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_rich < Pip
  description 'Render rich text, tables, progress bars, syntax highlighting, markdown and more to the terminal'
  homepage 'https://github.com/willmcgugan/rich'
  version "14.3.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e36e1ea199deb83ef98263a1c3990cfa48520004b22e1ed135fe17a5b59379a0',
     armv7l: 'e36e1ea199deb83ef98263a1c3990cfa48520004b22e1ed135fe17a5b59379a0',
       i686: '56b0ab2d4f3e8cd17fc6490c433ecebee29fcf5844152231af857a0530ae7c8a',
     x86_64: '3f567350ca06b8bcfefb3ad46c37f526fd63059737d2249d3c41e66989e7d9ea'
  })

  depends_on 'py3_colorama'
  depends_on 'py3_markdown_it_py'
  depends_on 'py3_pygments'
  depends_on 'python3' => :logical

  no_source_build
end
