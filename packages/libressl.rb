require 'package'

class Libressl < Package
  description 'LibreSSL is a version of the TLS/crypto stack forked from OpenSSL in 2014, with goals of modernizing the codebase, improving security, and applying best practice development processes.'
  homepage 'https://www.libressl.org/'
  version '3.1.4'
  compatibility 'all'
  source_url 'https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.1.4.tar.gz'
  source_sha256 '414c149c9963983f805a081db5bd3aec146b5f82d529bb63875ac941b25dcbb6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.1.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.1.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.1.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.1.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0b3da102fede122f12ec32a44cd3e543d72184cd90c9937f6fd32dea6d71c121',
     armv7l: '0b3da102fede122f12ec32a44cd3e543d72184cd90c9937f6fd32dea6d71c121',
       i686: '0e3e4d7be5575212286e5cc26c60b7473f448436abda50208a252afd53a1d694',
     x86_64: '5744988a28dc957ddabd49244c203a4cc43cba5332459669a9a5928628e841e4',
  })

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
