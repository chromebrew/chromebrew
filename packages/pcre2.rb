require 'package'

class Pcre2 < Package
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org/'
  version '10.35-2'
  compatibility 'all'
  source_url 'https://ftp.pcre.org/pub/pcre/pcre2-10.35.tar.gz'
  source_sha256 '8fdcef8c8f4cd735169dd0225fd010487970c1bcadd49e9b90e26c7250a33dc9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.35-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.35-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.35-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.35-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'df898210acbb0ebe0bb52bb4f8ea9b057343ccac899c70e9cef1f97cf41f4687',
     armv7l: 'df898210acbb0ebe0bb52bb4f8ea9b057343ccac899c70e9cef1f97cf41f4687',
       i686: '158cbb0f6b19c16a428c301abd134a8120c271908d47f0019c145942c84beecd',
     x86_64: '8937d09340235256c0ff4ccefb982a4898951b23ea1754fa1d318d784aff583c',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} \
           --enable-pcre2-16 \
           --enable-pcre2-32 \
           --enable-unicode \
           --enable-pcre2test-libreadline \
           --enable-jit \
           --disable-static"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
