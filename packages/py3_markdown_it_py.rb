# Adapted from Arch Linux python-markdown-it-py PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-markdown-it-py/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_markdown_it_py < Pip
  description 'Python port of markdown-it. Markdown parsing, done right!'
  homepage 'https://github.com/executablebooks/markdown-it-py'
  version '4.0.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a75e4a66ae155dd2add2e25efc1f1a0b5d901e4ae8f7667e08f6c56e0fa4f0a4',
     armv7l: 'a75e4a66ae155dd2add2e25efc1f1a0b5d901e4ae8f7667e08f6c56e0fa4f0a4',
       i686: '860d100be6377f1f40c54009f114480e3da7822bd6cd7fdebef7829f40b1b107',
     x86_64: '11f42d89684e6d6a0d06eadf61bbf6c048aa7afb79b838ae91de91c11df66c90'
  })

  depends_on 'py3_mdurl'
  depends_on 'python3' => :build

  no_source_build
end
