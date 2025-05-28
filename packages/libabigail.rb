# Adapted from Arch Linux libabigail PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libabigail

require 'buildsystems/autotools'

class Libabigail < Autotools
  description 'ABI Generic Analysis and Instrumentation Library'
  homepage 'https://sourceware.org/libabigail/'
  version "2.5-#{CREW_PY_VER}"
  license 'Apache'
  compatibility 'all'
  source_url 'https://sourceware.org/git/libabigail.git'
  git_hashtag "libabigail-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82d98b316dfbe648d0a8dbeb0fe09875609d53c3ecb3cfe5457eea84f5d2e3b7',
     armv7l: '82d98b316dfbe648d0a8dbeb0fe09875609d53c3ecb3cfe5457eea84f5d2e3b7',
       i686: '87a2d7f4db11ddecbe6a49447ca127c34c9ffe3e0dd076808870892de66176bd',
     x86_64: '465573c101658eb095fa1442bf7ae16531aaa783c345ca12930e2d7365977f47'
  })

  depends_on 'binutils' # R
  depends_on 'elfutils' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'python3' => :build
  depends_on 'sphinx' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R
  depends_on 'gdb' # R

  autotools_configure_options '--enable-bash-completion \
    --disable-manual \
    --disable-apidoc \
    --disable-static'
end
