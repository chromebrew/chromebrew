require 'package'

class Less < Package
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '563'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url 'http://www.greenwoodsoftware.com/less/less-563.tar.gz'
  source_sha256 'ce5b6d2b9fc4442d7a07c93ab128d2dff2ce09a1d4f2d055b95cf28dd0dc9a9a'

  binary_url ({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/less-563-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/less-563-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/less-563-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/less-563-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7cb60d2d83031342ee8b5bfc57291e4a8e140a14635760034a38d96fa7f085ab',
     armv7l: '7cb60d2d83031342ee8b5bfc57291e4a8e140a14635760034a38d96fa7f085ab',
       i686: '586086877e087bfb5577d8283b90e6bca71212b03c2286997a9dfa67d7638bb9',
     x86_64: '0136439b108a87c3b1fbf0a05a89dbbccc4aaf740a2fce5dee9f1a46fe2ef363',
  })

  depends_on 'ncurses'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-regex=posix"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
