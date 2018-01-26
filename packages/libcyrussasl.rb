require 'package'

class Libcyrussasl < Package
  description 'Simple Authentication and Security Layer (SASL) is a specification that describes how authentication mechanisms can be plugged into an application protocol on the wire. Cyrus SASL is an implementation of SASL that makes it easy for application developers to integrate authentication mechanisms into their application in a generic way.'
  homepage 'https://www.cyrusimap.org/sasl'
  version '2.1.27-rc6'
  source_url 'ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-2.1.27-rc6.tar.gz'
  source_sha256 'ff14faa7119149873d9fc2de8c8816af6522d1eeaf4a50a6afe4c414c19bcc4c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-rc6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-rc6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-rc6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-rc6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b4f38f74eb007c893c6905cc07eff42c2ef579f7cda138eda4f3af53ab14f652',
     armv7l: 'b4f38f74eb007c893c6905cc07eff42c2ef579f7cda138eda4f3af53ab14f652',
       i686: '3cb1d9c8e2e77cb455e9a0c0e95f2d558f5dc3fefc6f19a1d4f6b999dbbf60dd',
     x86_64: '6805027f33905debcfc530f7342e184d6ed9b613b1c9c27f18aa557c47163438',
  })

  depends_on 'diffutils' => :build

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-shared',
           '--with-cxx-shared'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
