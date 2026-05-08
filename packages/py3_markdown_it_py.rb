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
    aarch64: '47d67703bf7268ac584ee4b5c101216cbad6190935228d6d7cf5978599727fbd',
     armv7l: '47d67703bf7268ac584ee4b5c101216cbad6190935228d6d7cf5978599727fbd',
       i686: 'ef78880a092a9f1a5487daeb85f92693737b771f4864da9bc6ca3cadf90c7832',
     x86_64: 'a6056f777bf78c554637ceaf7af232be8eee416ca2da2908feae8e37bdf3f517'
  })

  depends_on 'py3_mdurl'
  depends_on 'python3' => :logical

  no_source_build
end
