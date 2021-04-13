require 'package'

class Leptonica < Package
  description 'Software that is broadly useful for image processing and image analysis applications'
  homepage 'http://www.leptonica.com/'
  @_ver = '1.80.0'
  version "#{@_ver}-1"
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/DanBloomberg/leptonica/archive/#{@_ver}.tar.gz"
  source_sha256 '3952b974ec057d24267aae48c54bca68ead8275604bf084a73a4b953ff79196e'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/leptonica-1.80.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/leptonica-1.80.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/leptonica-1.80.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/leptonica-1.80.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd4ae243ebd485e3bc061701f07bdd031f02916c79e6e7c0bc4353321c79ec66b',
     armv7l: 'd4ae243ebd485e3bc061701f07bdd031f02916c79e6e7c0bc4353321c79ec66b',
       i686: 'b7bc070a1fc98059cdb24339f7bc1dd5bbcacbc0c90a67ec5f35b20f8330a2d2',
     x86_64: 'b9ab621fe8a76d9b38cc21af0f4ba4f3818b0be7af471baf1995064d20428496'
  })

  depends_on 'giflib'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libwebp'
  depends_on 'openjpeg'

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
