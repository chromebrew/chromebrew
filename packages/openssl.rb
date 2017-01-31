require 'package'

class Openssl < Package
  version '1.0.2k'

  source_url 'ftp://openssl.org/source/openssl-1.0.2k.tar.gz'
  source_sha1 '5f26a624479c51847ebd2f22bb9f84b3b44dcb44'

  depends_on 'perl'
  depends_on 'zlibpkg'

  def self.build
    system "./config", "--prefix=/usr/local", "--openssldir=/etc/ssl", "shared", "zlib-dynamic"
    system "make"
  end

  def self.install
    system "make", "INSTALL_PREFIX=#{CREW_DEST_DIR}", "install"

    # remove all files pretended to install /etc/ssl (use system's /etc/ssl as is)
    system "rm", "-rf", "#{CREW_DEST_DIR}/etc"
  end

end
