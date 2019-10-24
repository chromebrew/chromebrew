require 'package'

class Libressl < Package
  description 'LibreSSL is a version of the TLS/crypto stack forked from OpenSSL in 2014, with goals of modernizing the codebase, improving security, and applying best practice development processes.'
  homepage 'https://www.libressl.org/'
  version '3.0.2'
  source_url 'https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.0.2.tar.gz'
  source_sha256 'df7b172bf79b957dd27ef36dcaa1fb162562c0e8999e194aa8c1a3df2f15398e'

  binary_url ({
  })
  binary_sha256 ({
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
