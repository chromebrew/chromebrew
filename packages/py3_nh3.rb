# Adapted from Arch Linux python-nh3 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=python-nh3

require 'buildsystems/pip'

class Py3_nh3 < Pip
  description 'Ammonia HTML sanitizer Python binding'
  homepage 'https://pypi.org/project/nh3/'
  version '0.3.5'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8a633f0449ff094dc0a8ab7454f9963e78e9c810a75a5c4777cfe1c1c749ca2d',
     armv7l: '8a633f0449ff094dc0a8ab7454f9963e78e9c810a75a5c4777cfe1c1c749ca2d',
       i686: '56d4a6e8c8bea927002dfd286ed3fcdd29807fcb42b6cbfd9821c0a5715bf761',
     x86_64: 'e4a66ccee4979e16db3e7271558652672e0509a7f2c7fd73de94b44ca16f131c'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'py3_maturin' => :build
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
