require 'package'

class Quakespasm < Package
  description 'A modern, cross-platform Quake game engine based on FitzQuake.'
  homepage 'https://quakespasm.sourceforge.net/'
  version '0.97.0'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/sezero/quakespasm.git'
  git_hashtag "quakespasm-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '67f8a77193a1f335c1d9bf10d41eb91da573b2472c49e97b1ec0b27b56f933db',
     armv7l: '67f8a77193a1f335c1d9bf10d41eb91da573b2472c49e97b1ec0b27b56f933db',
     x86_64: '6c6cb9d2599172af49ceeb6a6f6e123e986a35c488c8f491cccb6d12d8fe1ddf'
  })

  depends_on 'freeglut' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libglu' => :executable
  depends_on 'libglvnd' => :executable
  depends_on 'libmad' => :executable
  depends_on 'libogg' => :executable
  depends_on 'libsdl' => :executable
  depends_on 'libvorbis' => :executable
  depends_on 'sdl2' => :executable

  def self.build
    Dir.chdir('Quake') do
      system 'USE_SDL2=1 make'
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/games/quake"
    Dir.chdir('Quake') do
      system "sed -i 's,/usr/local/games/quake,#{CREW_DEST_PREFIX}/share/games/quake,g' Makefile"
      system 'make install'
    end
    FileUtils.ln_s "#{CREW_PREFIX}/share/games/quake/quakespasm", "#{CREW_DEST_PREFIX}/bin/quakespasm"
    FileUtils.install 'Quake/quakespasm.pak', "#{CREW_DEST_PREFIX}/share/games/quake/quakespasm.pak", mode: 0o644
    FileUtils.install 'Misc/QuakeSpasm_512.png', "#{CREW_DEST_PREFIX}/share/icons/hicolor/512x512/net.sourceforge.quakespasm.Quakespasm.png", mode: 0o644
    FileUtils.install 'Linux/net.sourceforge.quakespasm.Quakespasm.desktop', "#{CREW_DEST_PREFIX}/share/applications/net.sourceforge.quakespasm.Quakespasm.desktop", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      Type 'quakespasm' to get started.

      Please make sure you have the proper .pak and/or .wad files to play Quake!

      By default, quakespasm uses the current directory but you can override with -basedir.
    EOM
  end
end
