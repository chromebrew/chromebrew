require 'package'

class Zimg < Package
  description 'Scaling, colorspace conversion, and dithering library'
  homepage 'https://github.com/sekrit-twc/zimg'
  @_ver = '3.0.1'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/sekrit-twc/zimg/archive/release-#{@_ver}.tar.gz"
  source_sha256 'c50a0922f4adac4efad77427d13520ed89b8366eef0ef2fa379572951afcc73f'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zimg-3.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zimg-3.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zimg-3.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zimg-3.0.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c126a5ad58d44627a05e02677fcfb008ce2872eef683610b3a8a57ca5f422cbb',
     armv7l: 'c126a5ad58d44627a05e02677fcfb008ce2872eef683610b3a8a57ca5f422cbb',
       i686: '0f4e5dd4c3c1c0c3e7298a92cf2c2cd5680840bd9f9b79b417255cdf4c79011a',
     x86_64: '4f23cf56015009519e5d1692ea17aa71c785a38df99b5a8895dec305d3db223d'
  })

  @lto = ARCH == 'i686' || ARCH == 'x86_64' ? '-flto=auto' : ''

  def self.build
    system '[ -x configure ] || ./autogen.sh'
    system "[ -f Makefile ] || env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE #{@lto}' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE #{@lto}' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE  #{@lto}' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
