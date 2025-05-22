# Adapted from Arch Linux libbacktrace-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libbacktrace-git

require 'buildsystems/autotools'

class Libbacktrace < Autotools
  description 'Library to produce symbolic backtraces'
  homepage 'https://github.com/ianlancetaylor/libbacktrace'
  @_ver = '86885d14049fab06ef8a33aac51664230ca09200'
  version "1.0-#{@_ver[0..6]}"
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/ianlancetaylor/libbacktrace.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f9490d8a645de5704cc4b721ec0882d058e000c2e3606a0a502549888712f79',
     armv7l: '4f9490d8a645de5704cc4b721ec0882d058e000c2e3606a0a502549888712f79',
       i686: 'de19d4c80932fd0f989c12019bdde4a6c90550875e27dca51d811227312f3edc',
     x86_64: 'a5f708982f6d649c002397bd581b326ae68ee3223104df29c8d2f48c771d58fc'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  autotools_configure_options '--enable-shared'
end
