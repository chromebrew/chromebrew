require 'package'

class Libressl < Package
  description 'LibreSSL is a version of the TLS/crypto stack forked from OpenSSL in 2014, with goals of modernizing the codebase, improving security, and applying best practice development processes.'
  homepage 'https://www.libressl.org/'
  version '3.0.2-2'
  compatibility 'all'
  source_url 'https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.0.2.tar.gz'
  source_sha256 'df7b172bf79b957dd27ef36dcaa1fb162562c0e8999e194aa8c1a3df2f15398e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.0.2-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.0.2-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.0.2-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.0.2-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3fa0ddc595f4973667126e09db28fe6bb2dd78e7a6a7952967adc88fc15bcbcb',
     armv7l: '3fa0ddc595f4973667126e09db28fe6bb2dd78e7a6a7952967adc88fc15bcbcb',
       i686: '71187f8e35218a94809de75caecb458c356e2800b0366a2833e04071b9fc5dec',
     x86_64: 'ac5d4d2aea9c58a107a1f0e954c7ccbb5e6347292c655ed3f378d92a950499e1',
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
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libcrypto.so.45.0.5", "#{CREW_DEST_LIB_PREFIX}/libcrypto.so.1.0.0"

    # add symlink to libssl.so.1.0.0
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libssl.so.47.0.6", "#{CREW_DEST_LIB_PREFIX}/libssl.so.1.0.0"
  end
end
