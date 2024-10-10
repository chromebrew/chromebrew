# Adapted from Arch Linux python-sphinx-rtd-theme PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-sphinx-rtd-theme

require 'buildsystems/pip'

class Py3_sphinx_rtd_theme < Pip
  description 'Sphinx theme for readthedocs.org'
  homepage 'https://github.com/readthedocs/sphinx_rtd_theme'
  version "2.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f87aa8f1a216478389857bc82d09aed4babfc4b6418486f72afee1e0901dfe6a',
     armv7l: 'f87aa8f1a216478389857bc82d09aed4babfc4b6418486f72afee1e0901dfe6a',
       i686: '0f050020796115bb22d7c17e88c015b12d098de398e43af12c3df9562c5113c7',
     x86_64: '10f945b71e2809b60a48de35348160abaa44e4a75efab35c86c488fae42b1c85'
  })

  depends_on 'python3'
  depends_on 'sphinx' # R
  no_source_build
end
