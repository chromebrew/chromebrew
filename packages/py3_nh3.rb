# Adapted from Arch Linux python-nh3 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-nh3

require 'buildsystems/pip'

class Py3_nh3 < Pip
  description 'Ammonia HTML sanitizer Python binding'
  homepage 'https://pypi.org/project/nh3/'
  version '0.3.8'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1062c136157ff4c4732b584343ad3fca59b6422526e38483d08876af9826bed7',
     armv7l: '1062c136157ff4c4732b584343ad3fca59b6422526e38483d08876af9826bed7',
       i686: '5751359afe399d2e32e50d992fb2c071508a5cc8519316283234b5bf76618a29',
     x86_64: 'd988c6fc3fc665644fa07fab51eb9c23be09d90f61666c1e4464f09988de9766'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'py3_maturin' => :build
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
