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
    aarch64: '899cb077294eb9c9bc9d233caa890b9dd966a6937daf60b28286e835bd1598b4',
     armv7l: '899cb077294eb9c9bc9d233caa890b9dd966a6937daf60b28286e835bd1598b4',
       i686: '2777ba47bafc40fd8de02bfdb9eded2c0bfeb2045c2f0411f91af8f5d206d143',
     x86_64: 'f20bc9afa436db6a469c9c8b5db58d88d587adb952a881d46ac82a53c3818a1d'
  })

  depends_on 'py3_colorama'
  depends_on 'py3_markdown_it_py'
  depends_on 'py3_pygments'
  depends_on 'python3' => :logical

  no_source_build
end
