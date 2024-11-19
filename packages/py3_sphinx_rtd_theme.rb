# Adapted from Arch Linux python-sphinx-rtd-theme PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-sphinx-rtd-theme

require 'buildsystems/pip'

class Py3_sphinx_rtd_theme < Pip
  description 'Sphinx theme for readthedocs.org'
  homepage 'https://github.com/readthedocs/sphinx_rtd_theme'
  version "3.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3be0cd0438adbb5cc5f3e6686d06f02ad7f2e13a3a221c42c7dc735b55dd8ca9',
     armv7l: '3be0cd0438adbb5cc5f3e6686d06f02ad7f2e13a3a221c42c7dc735b55dd8ca9',
       i686: 'b538202e01c70be5904ef647f8b2b873cefaeed1cfb8009a4902388de135df64',
     x86_64: '899cfeaf4e4ab6383db9e15c160e0ee103ec632d46013abdf105c0a5b3a7fe72'
  })

  depends_on 'python3'
  depends_on 'sphinx' # R
  no_source_build
end
