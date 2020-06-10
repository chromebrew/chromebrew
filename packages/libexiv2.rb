require 'package'

class Libexiv2 < Package
  description 'Exiv2 is a Cross-platform C++ library and a command line utility to manage image metadata.'
  homepage 'http://exiv2.org/'
  version '0.26'
  compatibility 'all'
  source_url 'http://www.exiv2.org/builds/exiv2-0.26-trunk.tar.gz'
  source_sha256 'c75e3c4a0811bf700d92c82319373b7a825a2331c12b8b37d41eb58e4f18eafb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libexiv2-0.26-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libexiv2-0.26-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libexiv2-0.26-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libexiv2-0.26-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0b53cffbe725a525c6d76d9fb1ab331c362ad3dd5efb927f99dcb5f9a886060e',
     armv7l: '0b53cffbe725a525c6d76d9fb1ab331c362ad3dd5efb927f99dcb5f9a886060e',
       i686: '3134164696ecd93e2547198bd578a502e0a9ae648397a945bdbb3479362b1a96',
     x86_64: '69e5df22bbc44b8adc08b8260a49087f787e517472e1472be9783d5e424a4713',
  })

  depends_on 'curl'
  depends_on 'libssh'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-curl=#{CREW_PREFIX}/include/curl",
           "--with-ssh=#{CREW_PREFIX}/include/libssh",
           '--enable-webready',
           '--enable-video'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
