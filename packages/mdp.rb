require 'package'

class Mdp < Package
  description 'A command-line based markdown presentation tool.'
  homepage 'https://github.com/visit1985/mdp'
  version '1.0.11'
  source_url 'https://github.com/visit1985/mdp/archive/1.0.11.tar.gz'
  source_sha256 '885660432d77dfce9f443c518e595b2a3780b5883a06cc21e593d13af1afcf4a'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw PREFIX=#{CREW_PREFIX} make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
