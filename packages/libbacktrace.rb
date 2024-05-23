# Adapted from Arch Linux libbacktrace-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libbacktrace-git

require 'buildsystems/autotools'

class Libbacktrace < Autotools
  description 'Library to produce symbolic backtraces'
  homepage 'https://github.com/ianlancetaylor/libbacktrace'
  version '11427f31a64b11583fec94b4c2a265c7dafb1ab3'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/ianlancetaylor/libbacktrace.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb445bca3969abf2eba6d08db797d184c9dad392f15c46a6da011f7a5b8af0b1',
     armv7l: 'cb445bca3969abf2eba6d08db797d184c9dad392f15c46a6da011f7a5b8af0b1',
       i686: '9c11d9d2255fd8c430ddb15fa303f016c0968e1744831d259712d62035f13314',
     x86_64: 'f0d7c6dafc7530d0e447f4b3cae715c1d82988ef7eb5745614b5ead57e21e648'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  configure_options '--enable-shared'
end
