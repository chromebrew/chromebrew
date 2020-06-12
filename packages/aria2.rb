require 'package'

class Aria2 < Package
  description 'aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.'
  homepage 'https://aria2.github.io/'
  version '1.35.0'
  compatibility 'all'
  source_url 'https://github.com/aria2/aria2/releases/download/release-1.35.0/aria2-1.35.0.tar.xz'
  source_sha256 '1e2b7fd08d6af228856e51c07173cfcf987528f1ac97e04c5af4a47642617dfd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.35.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.35.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.35.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.35.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '96165af26f6187b56c2c96f7b40b7ec9ad21a96bc5799f216b1d285ef4936991',
     armv7l: '96165af26f6187b56c2c96f7b40b7ec9ad21a96bc5799f216b1d285ef4936991',
       i686: '76e9f7fff4da28c97c2706445486fa7559b76654c129ba229b00379b75d4ae1a',
     x86_64: '60bbe750f1d5442d1fe0bee0644d70d4855a7cdd55c9e960c970d4817de5ed1b',
  })

  depends_on 'c_ares'
  depends_on 'libgcrypt'
  depends_on 'libssh2'
  depends_on 'libxml2'
  depends_on 'sqlite'
  depends_on 'zlibpkg'
  depends_on 'ld_default' => :build

  def self.build
    # Use the gold linker.
    old_ld = `ld_default g`.chomp
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--without-libnettle',
      '--with-libgcrypt',
      '--disable-dependency-tracking'
    system 'make'
    # Restore the original linker.
    system 'ld_default', "#{old_ld}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
