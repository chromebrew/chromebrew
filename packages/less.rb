require 'package'

class Less < Package
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '563-1'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url 'http://www.greenwoodsoftware.com/less/less-563.tar.gz'
  source_sha256 'ce5b6d2b9fc4442d7a07c93ab128d2dff2ce09a1d4f2d055b95cf28dd0dc9a9a'

  depends_on 'ncursesw'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --with-regex=posix"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
