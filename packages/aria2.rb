require 'package'

class Aria2 < Package
  description 'aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.'
  homepage 'https://aria2.github.io/'
  version '1.32.0'
  source_url 'https://github.com/aria2/aria2/releases/download/release-1.32.0/aria2-1.32.0.tar.xz'
  source_sha256 '546e9194a9135d665fce572cb93c88f30fb5601d113bfa19951107ced682dc50'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/aria2-1.32.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/aria2-1.32.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/aria2-1.32.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/aria2-1.32.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '428c55161bd2ac5250dc8572110e82b5d4264f4204d4a1ca274cd65991a94b24',
     armv7l: '428c55161bd2ac5250dc8572110e82b5d4264f4204d4a1ca274cd65991a94b24',
       i686: '0b32f8f5507083bfdb910e909be12857b2ef0df6fe1e715666ca84dd6caf23eb',
     x86_64: '4bc29a0d11c5308880764f36d637ac77ab0c6cb550b2e9dc293a603351af8199',
  })

  depends_on 'c_ares'
  depends_on 'libgcrypt'
  depends_on 'libssh2'
  depends_on 'libxml2'
  depends_on 'sqlite'
  depends_on 'zlibpkg'

  def self.build
    system './configure \
           --without-libnettle \
           --with-libgcrypt'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
