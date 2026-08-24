# Adapted from Arch Linux python-nh3 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-nh3

require 'buildsystems/pip'

class Py3_nh3 < Pip
  description 'Ammonia HTML sanitizer Python binding'
  homepage 'https://pypi.org/project/nh3/'
  version '0.3.7'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '70663ec305b3b4538a1642072d96b91a08bc5b07b47bfbc0d51594ad15e64a05',
     armv7l: '70663ec305b3b4538a1642072d96b91a08bc5b07b47bfbc0d51594ad15e64a05',
       i686: 'ac0c1ec88315fc9f33221593e8627549b9ac22a9bf48be3150096339e7bc3c65',
     x86_64: '046071c727b662c021c04dd71c2d91ad6093a70cd63d62886f3bd892233bad19'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'py3_maturin' => :build
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
