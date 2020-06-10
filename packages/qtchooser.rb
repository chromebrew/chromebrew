require 'package'

class Qtchooser < Package
  description 'a wrapper used to select between Qt development binary versions'
  homepage 'https://www.qt.io/'
  version '66'
  compatibility 'all'
  source_url 'http://download.qt.io/official_releases/qtchooser/qtchooser-66.tar.xz'
  source_sha256 'b22c21df135d48fc775d26d771170c2c70555704d4625605383be2cd149c7cea'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qtchooser-66-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qtchooser-66-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qtchooser-66-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qtchooser-66-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7dcd1b8095c0f9cba9b10c2ffbaf3fa9c633dd00342acce2070a06fe4df991e0',
     armv7l: '7dcd1b8095c0f9cba9b10c2ffbaf3fa9c633dd00342acce2070a06fe4df991e0',
       i686: 'be579452bceef673e4563576451f05d1b94e6ee622841181d33e8e28e1f827d9',
     x86_64: 'ddcf92c0c4e7ced912f58b42948a205cd90575567248ae33f16a64bafe402553',
  })

  def self.build
    system 'make'
  end

  def self.install
    Dir.chdir 'src/qtchooser' do
      system "make", "prefix=#{CREW_PREFIX}", "INSTALL_ROOT=#{CREW_DEST_DIR}", "install"
    end
    system "install -Dm644 doc/qtchooser.1 #{CREW_DEST_PREFIX}/share/man/man1/qtchooser.1"
  end
end
