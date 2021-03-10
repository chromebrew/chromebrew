require 'package'

class Libmodplug < Package
  description 'A MOD playing library'
  homepage 'http://modplug-xmms.sourceforge.net/'
  version '0.8.9.0'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/modplug-xmms/libmodplug-0.8.9.0.tar.gz'
  source_sha256 '457ca5a6c179656d66c01505c0d95fafaead4329b9dbaa0f997d00a3508ad9de'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libmodplug-0.8.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libmodplug-0.8.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmodplug-0.8.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmodplug-0.8.9.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'bc64a7b24b9d2fbfb92026b77566d8c8f2bb404ee5a2afefa808891f878e1760',
     armv7l: 'bc64a7b24b9d2fbfb92026b77566d8c8f2bb404ee5a2afefa808891f878e1760',
       i686: '6958758b7981730fe6f1fc9bc1f257b73364902d44322fc987de8f29180fe07a',
     x86_64: '382325c8131ba25044af340d04d136c98cf101cffd2aa4dccc015b01afe84c38'
  })

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
