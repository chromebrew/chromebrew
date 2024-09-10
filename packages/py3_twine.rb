# Adapted from Arch Linux python-twine PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-twine

require 'buildsystems/pip'

class Py3_twine < Pip
  description 'A utility for interacting with PyPI'
  homepage 'https://pypi.python.org/pypi/twine'
  version '5.1.1-py3.12'
  license 'APACHE'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ba74a04dfa37eeaf4e86605a53c68fb538dbac5fae6a353e6588e9515b7ca74',
     armv7l: '0ba74a04dfa37eeaf4e86605a53c68fb538dbac5fae6a353e6588e9515b7ca74',
       i686: '67b51aae5ad8b862b66f7ad48ece1ca4bcbe31a21e95466427a11d760e10f859',
     x86_64: '74adeccf2358a4f6d9bc4cb5cf26ac409419e775c4aa5af5ecb2aeee521e2842'
  })

  depends_on 'py3_setuptools'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
