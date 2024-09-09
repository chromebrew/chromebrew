# Adapted from Arch Linux python-twine PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-twine

require 'buildsystems/pip'

class Py3_twine < Pip
  description 'A utility for interacting with PyPI'
  homepage 'https://pypi.python.org/pypi/twine'
  version '5.1.1'
  license 'APACHE'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '08a9cb1c7f484bab924489f61cb50cb610826262f897c60cc555a6d1401ed6b7',
     armv7l: '08a9cb1c7f484bab924489f61cb50cb610826262f897c60cc555a6d1401ed6b7',
       i686: '31c26546a99b1170f6dba14c1587b997f2d6e28be1cd5a23669eccc4b6667804',
     x86_64: 'd6e44d3be15c216dbab3323b73244def145cdcc9e3b85b811977512fe4de219b'
  })

  depends_on 'py3_setuptools'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
