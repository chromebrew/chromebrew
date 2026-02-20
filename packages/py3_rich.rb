# Adapted from Arch Linux python-rich PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-rich/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_rich < Pip
  description 'Render rich text, tables, progress bars, syntax highlighting, markdown and more to the terminal'
  homepage 'https://github.com/willmcgugan/rich'
  version "14.3.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '190a38d56a4a4b8db4a6682e7b59179eebf25b9f62da78fe2e25afc751990fa2',
     armv7l: '190a38d56a4a4b8db4a6682e7b59179eebf25b9f62da78fe2e25afc751990fa2',
       i686: 'e013f62a5e61ce02f7544781e682bd5f6952cdde0309c22c26738f0fb6416175',
     x86_64: '52c4c8a0c87204bc4964aad1a3db45395dc5015ab5b0513c62d6b4e57b6e71a0'
  })

  depends_on 'py3_colorama'
  depends_on 'py3_markdown_it_py'
  depends_on 'py3_pygments'
  depends_on 'python3' => :build

  no_source_build
end
