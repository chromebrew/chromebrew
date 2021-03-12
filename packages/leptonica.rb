require 'package'

class Leptonica < Package
  description 'Software that is broadly useful for image processing and image analysis applications'
  homepage 'http://www.leptonica.com/'
  @_ver = '1.80.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/DanBloomberg/leptonica/archive/#{@_ver}.tar.gz"
  source_sha256 '3952b974ec057d24267aae48c54bca68ead8275604bf084a73a4b953ff79196e'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/leptonica-1.80.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/leptonica-1.80.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/leptonica-1.80.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/leptonica-1.80.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '92169fedf2fdf6eeecfbcf91046c672827a14293e25eb4529b305fca5e844100',
     armv7l: '92169fedf2fdf6eeecfbcf91046c672827a14293e25eb4529b305fca5e844100',
       i686: '0983780d91e159289d9c0efc81390cf7b3b8f666c62848744d7c327005b3d080',
     x86_64: '9125c52e3bd232009858d406bf37099e0089a543900246f7710b34dbc6b1d7a1'
  })

  depends_on 'giflib'
  depends_on 'libjpeg_turbo'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libwebp'

  def self.build
    system '[ -x configure ] || ./autogen.sh'
    system "[ -f Makefile ] || env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
