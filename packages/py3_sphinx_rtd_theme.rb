# Adapted from Arch Linux python-sphinx-rtd-theme PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-sphinx-rtd-theme

require 'buildsystems/pip'

class Py3_sphinx_rtd_theme < Pip
  description 'Sphinx theme for readthedocs.org'
  homepage 'https://github.com/readthedocs/sphinx_rtd_theme'
  version "3.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36b4758363dbd424d6912901d6073c0ba74ff6334213771c2eafdd84c0cf0c4d',
     armv7l: '36b4758363dbd424d6912901d6073c0ba74ff6334213771c2eafdd84c0cf0c4d',
       i686: '2cb3259fccb44f0e954b0c324a22a7bc478d40cfb4c663ba1dd7e0abc6a358f2',
     x86_64: 'd102197d10167aab634c7b34679a9d3232a831e24754ef4bacbf41fe5d6bc439'
  })

  depends_on 'python3'
  depends_on 'sphinx' # R
  no_source_build
end
