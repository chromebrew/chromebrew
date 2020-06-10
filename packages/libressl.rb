require 'package'

class Libressl < Package
  description 'LibreSSL is a version of the TLS/crypto stack forked from OpenSSL in 2014, with goals of modernizing the codebase, improving security, and applying best practice development processes.'
  homepage 'https://www.libressl.org/'
  version '3.0.2'
  compatibility 'all'
  source_url 'https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.0.2.tar.gz'
  source_sha256 'df7b172bf79b957dd27ef36dcaa1fb162562c0e8999e194aa8c1a3df2f15398e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libressl-3.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '42bcf153de5343a4c131424d4e09ca7f4f8e1749a0fc2e0f632f7992ba2351b3',
     armv7l: '42bcf153de5343a4c131424d4e09ca7f4f8e1749a0fc2e0f632f7992ba2351b3',
       i686: 'f613572c9f9c91b79b09d008fa387ecb393be9b60d37f837ea6cdc74cdf9633b',
     x86_64: 'a2fce2036a54b1b3ca597d4fb3ee358c9fb7b3b54ea1e3a944fc7eb35a6f8e81',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-openssldir=/etc/ssl'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    # remove all files under /etc/ssl (use system's /etc/ssl as is)
    FileUtils.rm_rf "#{CREW_DEST_DIR}/etc/ssl"
  end

  def self.check
    system "make", "check"
  end
end
