# Adapted from Arch Linux python-rich PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-rich/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_rich < Pip
  description 'Render rich text, tables, progress bars, syntax highlighting, markdown and more to the terminal'
  homepage 'https://github.com/willmcgugan/rich'
  version '14.2.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '179426866af5ba62fc2f9e09d25c317715dd87aba740c5f3358722405f6ecc61',
     armv7l: '179426866af5ba62fc2f9e09d25c317715dd87aba740c5f3358722405f6ecc61',
       i686: '04c6b5763db73e992c1f60a6059cfecf859c31821db642e6c13ba3f3905960bc',
     x86_64: '0ac2e02b222eb64107c8ecb4b966e3781045d83ad2dcc48de8bc9a8d5f258d75'
  })

  depends_on 'py3_colorama'
  depends_on 'py3_markdown_it_py'
  depends_on 'py3_pygments'
  depends_on 'python3' => :build

  no_source_build
end
