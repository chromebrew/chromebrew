# Adapted from Arch Linux python-sphinx-rtd-theme PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-sphinx-rtd-theme

require 'buildsystems/pip'

class Py3_sphinx_rtd_theme < Pip
  description 'Sphinx theme for readthedocs.org'
  homepage 'https://github.com/readthedocs/sphinx_rtd_theme'
  version '2.0.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3'
  depends_on 'sphinx' # R
  no_compile_needed
end
