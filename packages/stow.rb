require 'package'

class Stow < Package
  description 'Manage installation of multiple softwares in the same directory tree'
  homepage 'https://www.gnu.org/software/stow/'
  version '2.2.2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/stow/stow-2.2.2.tar.gz'
  source_sha256 'e2f77649301b215b9adbc2f074523bedebad366812690b9dc94457af5cf273df'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/stow-2.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/stow-2.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/stow-2.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/stow-2.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3ea38b90ba0477578caa6a01326587f3826d5829a01f1725a781588fead751bc',
     armv7l: '3ea38b90ba0477578caa6a01326587f3826d5829a01f1725a781588fead751bc',
       i686: 'e53ad50ae437b0dd709ba44c91a02aa5b8b9ec8ce2255565690ffce58ec59753',
     x86_64: '0c51e9d9c4963fd53d93ba87facd08812ad204414df888f14564a420f9f2f664',
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
