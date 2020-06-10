require 'package'

class Ncftp < Package
  description 'NcFTP Client (also known as just NcFTP) is a set of FREE application programs implementing the File Transfer Protocol (FTP).'
  homepage 'http://ncftp.com/ncftp/'
  version '3.2.6'
  compatibility 'all'
  source_url 'ftp://ftp.ncftp.com/ncftp/ncftp-3.2.6-src.tar.gz'
  source_sha256 '129e5954850290da98af012559e6743de193de0012e972ff939df9b604f81c23'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ncftp-3.2.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ncftp-3.2.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ncftp-3.2.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ncftp-3.2.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3321010fccdc0fc30a11c7deb914f4c9b6ce606f3e3dd191b87a9266a7ed6afc',
     armv7l: '3321010fccdc0fc30a11c7deb914f4c9b6ce606f3e3dd191b87a9266a7ed6afc',
       i686: 'a634b1f53908bcd6e0e5d161b1a66508124d63aa8e519db69e72ef05dea5890f',
     x86_64: 'ca72890ad514201b5e70d071055d5f50afcf7a3fb32ce7e3410b38550d64cdfa',
  })

  depends_on 'buildessential'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
