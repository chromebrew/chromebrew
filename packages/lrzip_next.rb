# Adapted from Arch Linux lrzip-next PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=lrzip-next

require 'buildsystems/autotools'

class Lrzip_next < Autotools
  description 'Next generation multi-threaded compression with rzip'
  homepage 'https://github.com/pete4abw/lrzip-next'
  version '0.14.1'
  license 'GPL-2.0-or-later'
  compatibility 'x86_64'
  source_url 'https://github.com/pete4abw/lrzip-next.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '272ee5ebd46b39262931c9fa922f8d0eeabcef3a250fa84badae9104a088fd60'
  })

  depends_on 'nasm' => :build
  depends_on 'bzip2' # R
  depends_on 'bzip3' # R
  depends_on 'gcc_lib' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpg_error' # R
  depends_on 'lz4' # R
  depends_on 'lzo' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  git_fetchtags

  autotools_configure_options '--enable-asm'
end
