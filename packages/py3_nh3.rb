# Adapted from Arch Linux python-nh3 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-nh3

require 'buildsystems/pip'

class Py3_nh3 < Pip
  description 'Ammonia HTML sanitizer Python binding'
  homepage 'https://pypi.org/project/nh3/'
  version '0.3.4'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '70a63588ab44ca84ba404d82e2a57d142dd42104da60c7506b007734a5971c50',
     armv7l: '70a63588ab44ca84ba404d82e2a57d142dd42104da60c7506b007734a5971c50',
       i686: 'b162f7ca523048096ffde12d6e0d11cb62fbfb07376ccf68c8ffa5fe66fbe681',
     x86_64: '0138fb19b0bce63824583a6b9f6017ba8fd17a6985ff89a628010ab17e537e2e'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'py3_maturin' => :build
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
