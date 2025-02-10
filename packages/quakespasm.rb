require 'package'

class Quakespasm < Package
  description 'A modern, cross-platform Quake game engine based on FitzQuake.'
  homepage 'https://quakespasm.sourceforge.net/'
  version '0.96.3'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/sezero/quakespasm.git'
  git_hashtag "quakespasm-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e46794e2cb5bfef0891dda236c6e75c55618f2c45ed3c40ef5a3fd95b042ebeb',
     armv7l: 'e46794e2cb5bfef0891dda236c6e75c55618f2c45ed3c40ef5a3fd95b042ebeb',
     x86_64: 'bef7e500ee5a3aaf21e943740987f88855ca07daad51b652f50141d3a423bd4f'
  })

  depends_on 'freeglut'
  depends_on 'libglu'
  depends_on 'libglvnd' # R
  depends_on 'libmad'
  depends_on 'libogg' # R
  depends_on 'libsdl'
  depends_on 'libvorbis'

  def self.build
    Dir.chdir('Quake') do
      system 'make'
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir('Quake') do
      system "sed -i 's,/usr/local/games/quake,#{CREW_DEST_PREFIX}/bin/,g' Makefile"
      system 'make', 'install'
    end
  end

  def self.postinstall
    puts 'Please make sure you have the proper .pak and/or .wad files to play Quake!'.lightblue
    puts 'By default, quakespasm uses the current directory, but you can also specify the -basedir option.'.lightblue
  end
end
