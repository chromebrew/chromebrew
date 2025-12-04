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
    aarch64: 'fccd0a4c8a3e1d40e2bb6fe7cb61b3ad1a2ddc2013e2a477c23c995ed9357068',
     armv7l: 'fccd0a4c8a3e1d40e2bb6fe7cb61b3ad1a2ddc2013e2a477c23c995ed9357068',
       i686: '5c227698370fa311c3d800e3a9d78496799880678af02b989609b918007332ec',
     x86_64: '014c0909ee3510e41797d682ee0dec9339eeba1c46153dc268c6dd7bd7b2f439'
  })

  depends_on 'binutils' # R
  depends_on 'elfutils' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdb' # R
  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'python3' => :build
  depends_on 'sphinx' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  autotools_configure_options '--enable-bash-completion \
    --disable-manual \
    --disable-apidoc \
    --disable-static'
end
