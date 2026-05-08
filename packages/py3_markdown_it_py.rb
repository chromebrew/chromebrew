# Adapted from Arch Linux python-markdown-it-py PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-markdown-it-py/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_markdown_it_py < Pip
  description 'Python port of markdown-it. Markdown parsing, done right!'
  homepage 'https://github.com/executablebooks/markdown-it-py'
  version '4.2.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5be2c7aead62266b8c250b8ac1ccf67b6844ac90a432ca132e11f1c6eaa8b24e',
     armv7l: '5be2c7aead62266b8c250b8ac1ccf67b6844ac90a432ca132e11f1c6eaa8b24e',
       i686: 'd6d123239a3fab9f180975dae10a333eb75d0de84fa03e570f1b933987e70e4e',
     x86_64: '6a313b56f05037868e30bc06c97ec3568caf80bd1285d14b0ff9076cdcbcbead'
  })

  depends_on 'py3_mdurl'
  depends_on 'python3' => :logical

  no_source_build
end
