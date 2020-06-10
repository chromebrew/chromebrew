require 'package'

class Libxres < Package
  description 'X.org X-Resource extension client library'
  homepage 'http://www.x.org'
  version '1.2.0-0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXres-1.2.0.tar.gz'
  source_sha256 '5b62feee09f276d74054787df030fceb41034de84174abec6d81c591145e043a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxres-1.2.0-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxres-1.2.0-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxres-1.2.0-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxres-1.2.0-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd6de2abe84e9f020add008da76bdb2e35e98438d799f64c3f8cf93df39a0319c',
     armv7l: 'd6de2abe84e9f020add008da76bdb2e35e98438d799f64c3f8cf93df39a0319c',
       i686: '042a57a7fbc0ce1c3f07c76f2a0a3bd3009f8f8e5b3c8c346fa87eed38fa051e',
     x86_64: '4c765244df508377ed52517cb56a572a76b319b68e9bb88074870f1530f922d1',
  })

  depends_on 'libxext'
  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
