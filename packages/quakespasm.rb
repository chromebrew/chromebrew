require 'package'

class Quakespasm < Package
  description 'A modern, cross-platform Quake game engine based on FitzQuake.'
  homepage 'http://quakespasm.sourceforge.net'
  version '0.93.1-1'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/quakespasm/files/Source/quakespasm-0.93.1.tgz'
  source_sha256 'ed3ee6ba7e3d9454c7620757cc166e13d892f1167c7b74bef4f067e350d835ae'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/quakespasm-0.93.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/quakespasm-0.93.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/quakespasm-0.93.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/quakespasm-0.93.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a75901d94ad4475d297ddd09ec4f32b75c7b6d1120f5fdfb5d18e068d7517824',
     armv7l: 'a75901d94ad4475d297ddd09ec4f32b75c7b6d1120f5fdfb5d18e068d7517824',
       i686: '4f475052feca47e669afbd81d11882ca54143c2bffcd1765a8ab1c46b2a3f8ef',
     x86_64: '16afe97af889bd2c5c4f8e4c835fd044c3313f76e91bb584f27a44740c454e17',
  })

  depends_on 'libglu'
  depends_on 'libsdl'
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

  def self.postinstall
    puts "Please make sure you have the proper .pak and/or .wad files to play Quake!".lightblue
    puts "By default, quakespasm uses the current directory, but you can also specify the -basedir option.".lightblue
  end
end
