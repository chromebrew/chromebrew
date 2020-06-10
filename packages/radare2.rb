require 'package'

class Radare2 < Package
  description 'unix-like reverse engineering framework and commandline tools'
  homepage 'http://www.radare.org/r/'
  version '2.4.0'
  compatibility 'all'
  source_url 'https://github.com/radare/radare2/archive/2.4.0.tar.gz'
  source_sha256 'e2edef4d70c7bbbb47d04002ce9d384eb2fc9c0cd4cbfde77cda8c10cae9ff24'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/radare2-2.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/radare2-2.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/radare2-2.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/radare2-2.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7f1625aa3bbeea13de76bf122eab70130df32da119585cb0e46cea523f3e07ab',
     armv7l: '7f1625aa3bbeea13de76bf122eab70130df32da119585cb0e46cea523f3e07ab',
       i686: '81f78367ade45bc48632a1cfe4ebaebd9d6c549abfe3ff26a7d32116b79329ee',
     x86_64: 'fcde3ae52954bf875ecbc650d0e0392ef80175f3df4c7b7f560aeb0535ed1969',
  })

  depends_on 'openssl'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-openssl'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
