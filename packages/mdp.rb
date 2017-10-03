require 'package'

class Mdp < Package
  description 'A command-line based markdown presentation tool.'
  homepage 'https://github.com/visit1985/mdp'
  version '1.0.10'
  source_url 'https://github.com/visit1985/mdp/archive/1.0.10.tar.gz'
  source_sha256 '7384c1ba32bd8e4b11342570d2144165a60682499b4cb54e50c8eb3164cfabc5'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
