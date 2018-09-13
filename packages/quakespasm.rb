require 'package'

class Quakespasm < Package
  description 'A modern, cross-platform Quake game engine based on FitzQuake.'
  homepage 'http://quakespasm.sourceforge.net'
  version '0.93.1'
  source_url 'https://sourceforge.net/projects/quakespasm/files/Source/quakespasm-0.93.1.tgz'
  source_sha256 'ed3ee6ba7e3d9454c7620757cc166e13d892f1167c7b74bef4f067e350d835ae'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/quakespasm-0.93.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/quakespasm-0.93.1-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/quakespasm-0.93.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a9886d9da1595439d73b5c3df1e4501e7bbea3a3d0d1875a093dea17d0674e88',
     armv7l: 'a9886d9da1595439d73b5c3df1e4501e7bbea3a3d0d1875a093dea17d0674e88',
     x86_64: 'dae60b0d600c04df0ed8bc5b18c3b00b17a21129f8ae386d4f19e726377af230',
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
