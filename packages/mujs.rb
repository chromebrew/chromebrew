# Adapted from Arch Linux mujs PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mujs/trunk/PKGBUILD

require 'buildsystems/autotools'

class Mujs < Autotools
  description 'An embeddable Javascript interpreter in C'
  homepage 'https://mujs.com/'
  version '1.3.7'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/ccxvii/mujs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '317132f0f3783a7c708be9406d4d173c704e9b559eb8a56e442f28d0ab77e156',
     armv7l: '317132f0f3783a7c708be9406d4d173c704e9b559eb8a56e442f28d0ab77e156',
       i686: 'a8bf48dd9d384ea2c6a013d9755235173bc284b742b5d69e9526ae38a1a9ad95',
     x86_64: 'c6951672b9bc937e8c38a090c8102bc6c3050e9250a747636965e78a11caf0fe'
  })

  depends_on 'glibc' # R
  depends_on 'readline' => :executable_only

  autotools_skip_configure

  autotools_pre_make_options "XCFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
    XCPPFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto'"

  def self.install
    system "make \
      DESTDIR=#{CREW_DEST_DIR} \
      prefix=#{CREW_PREFIX} \
      libdir=#{CREW_LIB_PREFIX} \
      install-shared"
  end
end
