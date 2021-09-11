require 'package'

class Less < Package
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '590'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/less/less-590.tar.gz'
  source_sha256 '6aadf54be8bf57d0e2999a3c5d67b1de63808bb90deb8f77b028eafae3a08e10'

  depends_on 'ncurses'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} --with-regex=posix"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
