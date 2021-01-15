require 'package'

class Nettle < Package
  description 'Nettle is a cryptographic library that is designed to fit easily in more or less any context: In crypto toolkits for object-oriented languages (C++, Python, Pike, ...), in applications like LSH or GNUPG, or even in kernel space.'
  homepage 'http://www.lysator.liu.se/~nisse/nettle/'
  @_ver = '3.7'
  version @_ver
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/nettle/nettle-#{@_ver}.tar.gz"
  source_sha256 'f001f64eb444bf13dd91bceccbc20acbc60c4311d6e2b20878452eb9a9cec75a'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.7-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.7-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.7-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'ac62f7cd94b7047e87d413a8d6e338ebaeadbac613458b0a46290b9332ac647f',
      armv7l: 'ac62f7cd94b7047e87d413a8d6e338ebaeadbac613458b0a46290b9332ac647f',
        i686: '21eb9162bced72c824cdfa392bcb4b783ca6c7a5a7487134258027c8662c484f',
      x86_64: '2ea16fff4808cfa8105c8a7f1f6eab83157979aeb2b0cce06da8f8b6ab3bdd02',
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
