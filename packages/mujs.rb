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
    aarch64: '6e35d13ccbbf048b85406b5edf5a9ff1965359bcace8a7c53ca9a293691bc09c',
     armv7l: '6e35d13ccbbf048b85406b5edf5a9ff1965359bcace8a7c53ca9a293691bc09c',
       i686: '164594e24f4fe2cf051593ab8d8f1d540c0ed3b2322b8a29ce223fec56837b8a',
     x86_64: '016d3bcc9608929db4bcb55b7449151200557c4407187a1f6cd806cfdd8a42ad'
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
