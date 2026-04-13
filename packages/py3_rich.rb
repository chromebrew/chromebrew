# Adapted from Arch Linux python-rich PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-rich/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_rich < Pip
  description 'Render rich text, tables, progress bars, syntax highlighting, markdown and more to the terminal'
  homepage 'https://github.com/willmcgugan/rich'
  version "15.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3a362932ac7f55582b412615d8c80a5059208df6879ed64fb7821d67bf9e4d66',
     armv7l: '3a362932ac7f55582b412615d8c80a5059208df6879ed64fb7821d67bf9e4d66',
       i686: '5305fc2f66f0e97ceda02aaa7a245c326d489921fc27d5d578491902956d596e',
     x86_64: '819fc9f29dce74e67fe07f55156a6ce452aae1135e20c00a46b19bbff008fc07'
  })

  depends_on 'py3_colorama'
  depends_on 'py3_markdown_it_py'
  depends_on 'py3_pygments'
  depends_on 'python3' => :logical

  no_source_build
end
