# Adapted from Arch Linux python-sphinx-rtd-theme PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-sphinx-rtd-theme

require 'buildsystems/pip'

class Py3_sphinx_rtd_theme < Pip
  description 'Sphinx theme for readthedocs.org'
  homepage 'https://github.com/readthedocs/sphinx_rtd_theme'
  version "3.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36b4758363dbd424d6912901d6073c0ba74ff6334213771c2eafdd84c0cf0c4d',
     armv7l: '36b4758363dbd424d6912901d6073c0ba74ff6334213771c2eafdd84c0cf0c4d',
       i686: '78977e941c575d23e9f72f0868e46f114181c5316d79fbd8f507c95f4dfcb4c8',
     x86_64: '136f7d4992a44abb2dbdb12682a708a4afaae559873b16bff43e5a73e49bfa65'
  })

  depends_on 'python3'
  depends_on 'sphinx' # R
  no_source_build
end
