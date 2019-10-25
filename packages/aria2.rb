require 'package'

class Aria2 < Package
  description 'aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.'
  homepage 'https://aria2.github.io/'
  version '1.34.0'
  source_url 'https://github.com/aria2/aria2/releases/download/release-1.34.0/aria2-1.34.0.tar.xz'
  source_sha256 '3a44a802631606e138a9e172a3e9f5bcbaac43ce2895c1d8e2b46f30487e77a3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.34.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.34.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.34.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.34.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bc492c8c31baf9b8e90719f640196b720277343198d4e3b11e7c9a4acae2b5ce',
     armv7l: 'bc492c8c31baf9b8e90719f640196b720277343198d4e3b11e7c9a4acae2b5ce',
       i686: '85e56222a315543f6aedb0f744538f3969ed632cbb3aff2c67c8bcfbb341d580',
     x86_64: '17b8d40ca1a21416cff6fce22621e5720ee7c1643cad4e2822802926fa99ac5d',
  })

  depends_on 'c_ares'
  depends_on 'libgcrypt'
  depends_on 'libssh2'
  depends_on 'libxml2'
  depends_on 'sqlite'
  depends_on 'zlibpkg'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--without-libnettle',
      '--with-libgcrypt',
      '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
