require 'package'

class Xf86dgaproto < Package
  description 'X.org XF86DGA protocol headers'
  homepage 'http://www.x.org'
  version '2.1'
  source_url 'https://www.x.org/archive/individual/proto/xf86dgaproto-2.1.tar.gz'
  source_sha256 '73bc6fc830cce5a0ec9c750d4702601fc0fca12d6353ede8b4c0092c9c4ca2af'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xf86dgaproto-2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xf86dgaproto-2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xf86dgaproto-2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xf86dgaproto-2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8fecb3e91b6d1552a2ef34065b76f97e8f1c883a8769744d64650d9286038ff3',
     armv7l: '8fecb3e91b6d1552a2ef34065b76f97e8f1c883a8769744d64650d9286038ff3',
       i686: '2036db3c69c6ae2d47d57995f19d08758c37250adc89b178d19ed06292eff389',
     x86_64: '4b96e894e37d768666811fb9c04dfd4f121c55e5f6efc115e8a2d1105cf75039',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
