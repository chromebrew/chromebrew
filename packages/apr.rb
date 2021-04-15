require 'package'

class Apr < Package
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'https://apr.apache.org/'
  version '1.7.0-1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://apache.claz.org/apr/apr-1.7.0.tar.bz2'
  source_sha256 'e2e148f0b2e99b8e5c6caa09f6d4fb4dd3e83f744aa72a952f94f5a14436f7ea'

  binary_url ({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/apr-1.7.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/apr-1.7.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/apr-1.7.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/apr-1.7.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7fc184ada04656888e38392e3641567208a48b40f120b02441ff5d624bfc0e1b',
     armv7l: '7fc184ada04656888e38392e3641567208a48b40f120b02441ff5d624bfc0e1b',
       i686: 'fd53cb7eb00a40a08ba534f132ca23c2668f774bc6550b018ace4a0a57fb8b74',
     x86_64: '348443a210ccd3bf15a307e81cd9173b0a09f120eedf7e751381f07fb04e12c3',
  })

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --disable-maintainer-mode \
            --with-devrandom \
            --without-sendfile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/build-1" # Seems residual from build and isn't needed
  end
end
