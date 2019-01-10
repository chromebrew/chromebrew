require 'package'

class Eudev < Package
  description 'Gentoo standalone udev'
  homepage 'https://wiki.gentoo.org/wiki/Project:Eudev'
  version '3.2.7'
  source_url 'https://github.com/gentoo/eudev/archive/v3.2.7.tar.gz'
  source_sha256 'ce2fda4dea129bbcf824c947aab23504bcd26911481b47dbaf10646f723083a4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/eudev-3.2.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/eudev-3.2.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/eudev-3.2.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/eudev-3.2.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '27be58c328302b73da3627c3415515be0cc592fbabce38bcff5f5da6ccdf1837',
     armv7l: '27be58c328302b73da3627c3415515be0cc592fbabce38bcff5f5da6ccdf1837',
       i686: '20a8f053b84bce5fa389a0a1cca5648fd34ab92f06cbe440aecdea2ef4dbc0ab',
     x86_64: 'ad95ed97aedd8939ed8c06c5773d923de025544d10e41627758a82cd5ee0d1cc',
  })

  depends_on 'libxslt'
  depends_on 'gperf'
  depends_on 'util_linux'

  def self.build
    system 'sed -i s,/usr/bin/xsltproc,xsltproc,g man/make.sh'
    system './autogen.sh'
    system "./configure",
           "--enable-hwdb",
           "--enable-rule-generator",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-rootprefix=#{CREW_PREFIX}",
           "--with-rootlibdir=#{CREW_LIB_PREFIX}",
           "--with-rootrundir=#{CREW_PREFIX}/run",
           "--with-rootlibexecdir=#{CREW_PREFIX}/libexec"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
