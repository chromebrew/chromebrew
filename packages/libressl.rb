require 'package'

class Libressl < Package
  description 'LibreSSL is a version of the TLS/crypto stack forked from OpenSSL in 2014, with goals of modernizing the codebase, improving security, and applying best practice development processes.'
  homepage 'https://www.libressl.org/'
  version '3.1.4-1'
  compatibility 'all'
  source_url 'https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.1.4.tar.gz'
  source_sha256 '414c149c9963983f805a081db5bd3aec146b5f82d529bb63875ac941b25dcbb6'


  def self.build
    system "./configure #{CREW_OPTIONS} --with-openssldir=/etc/ssl"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    # remove all files under /etc/ssl (use system's /etc/ssl as is)
    FileUtils.rm_rf "#{CREW_DEST_DIR}/etc/ssl"

    # add symlink to libcrypto.so.1.0.0
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libcrypto.so.46.0.1", "#{CREW_DEST_LIB_PREFIX}/libcrypto.so.1.0.0"

    # add symlink to libssl.so.1.0.0
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libssl.so.48.0.1", "#{CREW_DEST_LIB_PREFIX}/libssl.so.1.0.0"
  end
end
