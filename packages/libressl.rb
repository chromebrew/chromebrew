require 'package'

class Libressl < Package
  description 'LibreSSL is a version of the TLS/crypto stack forked from OpenSSL in 2014, with goals of modernizing the codebase, improving security, and applying best practice development processes.'
  homepage 'https://www.libressl.org/'
  version '3.2.2'
  compatibility 'all'
  source_url 'https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.2.2.tar.gz'
  source_sha256 'a9d1e1d030b8bcc67bf6428b8c0fff14a5602e2236257b9e3d77acaf12e2a7a1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '36a493288d8d24cdb4c52866d37fcc47530417158717819443b4a087fd035d08',
     armv7l: '36a493288d8d24cdb4c52866d37fcc47530417158717819443b4a087fd035d08',
       i686: 'f900f8674e63a71e2206f8458d94c039e375af3be7027047818fd680fb78aa78',
     x86_64: '2995523debedf84f763b79fb73b7958656c6d8e1a20628220e4b3d45b3dfa25a',
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
