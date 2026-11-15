# Adapted from Arch Linux python-markdown-it-py PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-markdown-it-py/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_markdown_it_py < Pip
  description 'Python port of markdown-it. Markdown parsing, done right!'
  homepage 'https://github.com/executablebooks/markdown-it-py'
  version '4.3.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5e451107eda99a5620eef1cb35fd6c9caa1f6475061fa27c7e75198ea852401c',
     armv7l: '5e451107eda99a5620eef1cb35fd6c9caa1f6475061fa27c7e75198ea852401c',
       i686: '6f8372e785c3424bd932d161d61809d5f4ef0c72f4219f53ddfff61ceeb0efc2',
     x86_64: 'c8ae9072a4fb2271c3e4234281222ad8a6a5d10b20673f644bdb8ab6346b54df'
  })

  depends_on 'py3_mdurl'
  depends_on 'python3' => :logical

  no_source_build
end
