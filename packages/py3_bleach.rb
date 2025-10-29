# Adapted from Arch Linux python-bleach PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-bleach/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_bleach < Pip
  description 'An easy whitelist-based HTML-sanitizing tool'
  homepage 'https://pypi.org/project/bleach/'
  version '6.3.0'
  license 'Apache'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '700eeecda3253d6ea586846641f98451e59d279d231fa683c0eccc3cb4c39c8e',
     armv7l: '700eeecda3253d6ea586846641f98451e59d279d231fa683c0eccc3cb4c39c8e',
       i686: 'fe5eb26e3973fc223051bfde8643a3a96fb4890c4420e8bbe6cf1780a530cfe2',
     x86_64: '70616348cd5e4b243bcbaaf74d4e3c13998ee9f92a66d864d5530d7c58105f41'
  })

  depends_on 'python3' # R

  no_source_build
end
