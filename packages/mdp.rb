require 'package'

class Mdp < Package
  description 'A command-line based markdown presentation tool.'
  homepage 'https://github.com/visit1985/mdp'
  version '1.0.10'
  compatibility 'all'
  source_url 'https://github.com/visit1985/mdp/archive/1.0.10.tar.gz'
  source_sha256 '7384c1ba32bd8e4b11342570d2144165a60682499b4cb54e50c8eb3164cfabc5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mdp-1.0.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mdp-1.0.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mdp-1.0.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mdp-1.0.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2478dbee17514f83d0340c0ac6eb2ccf957aa000e48a0b0d2c614df523f98315',
     armv7l: '2478dbee17514f83d0340c0ac6eb2ccf957aa000e48a0b0d2c614df523f98315',
       i686: 'f3a418a1ab54584b5f6ec1e6ada44075e982c86274edb009ba031199af591984',
     x86_64: 'a444f58edb9b973d4274e99e31c9e339fe1c88cf0641c55bb7d7f10413f761a4',
  })

  depends_on 'ncurses'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw PREFIX=#{CREW_PREFIX} make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
