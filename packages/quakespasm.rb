require 'package'

class Quakespasm < Package
  description 'A modern, cross-platform Quake game engine based on FitzQuake.'
  homepage 'http://quakespasm.sourceforge.net'
  version '0.93.1'
  source_url 'https://sourceforge.net/projects/quakespasm/files/Source/quakespasm-0.93.1.tgz'
  source_sha256 'ed3ee6ba7e3d9454c7620757cc166e13d892f1167c7b74bef4f067e350d835ae'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libglu'
  depends_on 'libvorbis'
  depends_on 'libmad'
  depends_on 'freeglut'

  def self.build
    Dir.chdir ("Quake") do
      system 'make'
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir ("Quake") do
      system "sed -i 's,/usr/local/games/quake,#{CREW_DEST_PREFIX}/bin/,g' Makefile"
      system "make", "install"
    end
  end
end
