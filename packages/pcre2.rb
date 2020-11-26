require 'package'

class Pcre2 < Package
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org/'
  version '10.35-2'
  compatibility 'all'
  source_url 'https://ftp.pcre.org/pub/pcre/pcre2-10.35.tar.gz'
  source_sha256 '8fdcef8c8f4cd735169dd0225fd010487970c1bcadd49e9b90e26c7250a33dc9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.35-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.35-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.35-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.35-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '73b9d315438b67b8478fe64a13755f2e1f1fb817bd3462a08d28c4d2b8d8f478',
     armv7l: '73b9d315438b67b8478fe64a13755f2e1f1fb817bd3462a08d28c4d2b8d8f478',
       i686: '6322b0b2c26d8db0b4538eb2427b14733e30b2dc660ae151d6f97bcb1d3b0a70',
     x86_64: 'e792c0702d2c05ba5f19b6f4a7a89ba59b38a0bcf17144dcde3850a06009a727',
  })


  depends_on 'libtool' => :build

  def self.build
    system "./configure  #{CREW_OPTIONS} \
           --enable-pcre2-16 \
           --enable-pcre2-32 \
           --enable-unicode \
           --enable-pcre2test-libreadline \
           --enable-jit \
           --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
