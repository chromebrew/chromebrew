# Adapted from Arch Linux python-rich PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-rich/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_rich < Pip
  description 'Render rich text, tables, progress bars, syntax highlighting, markdown and more to the terminal'
  homepage 'https://github.com/willmcgugan/rich'
  version "14.3.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c36364664162ad2a301a746ef8be2a1bc062d44a47f6fe35ef5c39facdfdf9f',
     armv7l: '7c36364664162ad2a301a746ef8be2a1bc062d44a47f6fe35ef5c39facdfdf9f',
       i686: '33f1549c670fc95f8b58da9f4c41cba94f2c5545c1ad18818328525e0c93a216',
     x86_64: '5a711dd33cf5ae14b814f323b13eb02a6241ba351b2e021f6e521a744f3fa1fa'
  })

  depends_on 'py3_colorama'
  depends_on 'py3_markdown_it_py'
  depends_on 'py3_pygments'
  depends_on 'python3' => :build

  no_source_build
end
