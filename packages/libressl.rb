require 'package'

class Libressl < Package
  description 'LibreSSL is a version of the TLS/crypto stack forked from OpenSSL in 2014, with goals of modernizing the codebase, improving security, and applying best practice development processes.'
  homepage 'https://www.libressl.org/'
  version '3.2.3'
  compatibility 'all'
  source_url 'https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.2.3.tar.gz'
  source_sha256 '412dc2baa739228c7779e93eb07cd645d5c964d2f2d837a9fd56db7498463d73'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.2.3-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.2.3-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.2.3-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '59a8e3c3cf6bd97210f04882c2b0ce94566311f360536d1174d7e04e8f9884ab',
      armv7l: '59a8e3c3cf6bd97210f04882c2b0ce94566311f360536d1174d7e04e8f9884ab',
        i686: 'd6962728e73894df3382ad17035b838f213f246edb6dc4aa54522c3bc5c59dd8',
      x86_64: 'be499bd46626d26ed6c333dc1a74df423537053e6afbf2a14e542c5ceec796ef',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --with-openssldir=#{CREW_PREFIX}/etc/ssl"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
