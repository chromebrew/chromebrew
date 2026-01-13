# Adapted from Arch Linux python-sphinx-rtd-theme PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-sphinx-rtd-theme

require 'buildsystems/pip'

class Py3_sphinx_rtd_theme < Pip
  description 'Sphinx theme for readthedocs.org'
  homepage 'https://github.com/readthedocs/sphinx_rtd_theme'
  version "3.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18c8deeb1d90043d4bf866dbdbff416863c0f727ff5d733e3362f9b729c47a8d',
     armv7l: '18c8deeb1d90043d4bf866dbdbff416863c0f727ff5d733e3362f9b729c47a8d',
       i686: 'c83bf0de3b6b41ef52a6cc3c79526db29a63d52b1c7169f5d04da3f4b5418fce',
     x86_64: '7503f8caa0122317f97cc2eeb471797f4a30620021eadf4f3f627923d147a69f'
  })

  depends_on 'python3'
  depends_on 'sphinx' # R
  no_source_build
end
