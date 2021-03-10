require 'package'

class Libx264 < Package
  description 'x264 is a free software library and application for encoding video streams into the H.264/MPEG-4 AVC compression format.'
  homepage 'http://www.videolan.org/developers/x264.html'
  version 'b86a'
  compatibility 'all'
  source_url 'https://code.videolan.org/videolan/x264/-/archive/b86ae3c66f51ac9eab5ab7ad09a9d62e67961b8a/x264-b86ae3c66f51ac9eab5ab7ad09a9d62e67961b8a.tar.bz2'
  source_sha256 '6d4eacd1e735f1670a84f56802023fce9a68f19a6186440281fff7757810297d'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libx264-b86a-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libx264-b86a-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libx264-b86a-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libx264-b86a-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e212794830955a9f109c01000eae365580dc61568db24a4ae412f9f518932f3a',
     armv7l: 'e212794830955a9f109c01000eae365580dc61568db24a4ae412f9f518932f3a',
       i686: '57005b8eb98bbc08ddca26fcecce43ea58e7f489f493d89367512bdc0ffbbb30',
     x86_64: '280d34bcb68b0ddf87e747b7f21bb63c9a881f3de6bb91ab6fca6a9d191a16a5'
  })

  depends_on 'nasm' => :build
  depends_on 'l_smash'

  @archflags = ARCH == 'aarch64' || ARCH == 'armv7l' ? '-march=armv7-a -mfpu=neon' : ''

  def self.build
    system '[ -x configure ] || ./autogen.sh'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto #{@archflags}' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --enable-shared \
      --enable-static \
      --enable-pic \
      --enable-lto \
      --disable-avs"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
