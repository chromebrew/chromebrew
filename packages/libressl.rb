require 'package'

class Libressl < Package
  description 'LibreSSL is a version of the TLS/crypto stack forked from OpenSSL in 2014, with goals of modernizing the codebase, improving security, and applying best practice development processes.'
  homepage 'https://www.libressl.org/'
  version '3.0.2-1'
  compatibility 'all'
  source_url 'https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.0.2.tar.gz'
  source_sha256 'df7b172bf79b957dd27ef36dcaa1fb162562c0e8999e194aa8c1a3df2f15398e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.0.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.0.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.0.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.0.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd75da64edc43b1a48013e175ecb0264c991ae89af0a830577318e44e1f76c9ab',
     armv7l: 'd75da64edc43b1a48013e175ecb0264c991ae89af0a830577318e44e1f76c9ab',
       i686: 'e60f92481e20edb9399eb0329c29f30036fd1d47806b5cdc51f56ed8eb43516b',
     x86_64: 'fb489cd49f4d61616970c8a19767975bfd67c0828433d0cf7880646f2d723035',
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
  end
end
