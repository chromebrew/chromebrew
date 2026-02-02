# Adapted from Arch Linux python-rich PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-rich/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_rich < Pip
  description 'Render rich text, tables, progress bars, syntax highlighting, markdown and more to the terminal'
  homepage 'https://github.com/willmcgugan/rich'
  version "14.3.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1347674c4e532b9de319aa7803da574599a0faecb31820383498a49dc8c052d4',
     armv7l: '1347674c4e532b9de319aa7803da574599a0faecb31820383498a49dc8c052d4',
       i686: 'c482d54bc1a66cd871a0443edd1efdf46ed523544b1f39711e2e7410a680d758',
     x86_64: 'eed0f38d915b379a6c6b9947321426fa6c3b4c93d695aa4f5337389e329cbbe1'
  })

  depends_on 'py3_colorama'
  depends_on 'py3_markdown_it_py'
  depends_on 'py3_pygments'
  depends_on 'python3' => :build

  no_source_build
end
