require 'package'

class Libressl < Package
  description 'LibreSSL is a version of the TLS/crypto stack forked from OpenSSL in 2014, with goals of modernizing the codebase, improving security, and applying best practice development processes.'
  homepage 'https://www.libressl.org/'
  version '3.2.3'
  compatibility 'all'
  source_url 'https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.2.3.tar.gz'
  source_sha256 '412dc2baa739228c7779e93eb07cd645d5c964d2f2d837a9fd56db7498463d73'


  def self.build
    system "./configure --help"
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
