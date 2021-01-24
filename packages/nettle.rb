require 'package'

class Nettle < Package
  description 'Nettle is a cryptographic library that is designed to fit easily in more or less any context: In crypto toolkits for object-oriented languages (C++, Python, Pike, ...), in applications like LSH or GNUPG, or even in kernel space.'
  homepage 'http://www.lysator.liu.se/~nisse/nettle/'
  @_ver = '3.7'
  version @_ver + '-1'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/nettle/nettle-#{@_ver}.tar.gz"
  source_sha256 'f001f64eb444bf13dd91bceccbc20acbc60c4311d6e2b20878452eb9a9cec75a'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.7-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.7-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.7-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.7-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '5b39e94078c6b414dbab4bc39d3930cea06cda4fae8ac00ae8070d398cc66427',
      armv7l: '5b39e94078c6b414dbab4bc39d3930cea06cda4fae8ac00ae8070d398cc66427',
        i686: '22cc6881f5df8c0e0a6d77154156ab74efb3ec9866208cde5c71a5935bad839b',
      x86_64: '713dbccd1a267bac1cd71856ab6f68dd897ae32a005d2c9439f9d31d31597481',
  })

  depends_on 'm4'
  depends_on 'openssl'

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
