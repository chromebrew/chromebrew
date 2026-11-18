require 'package'

class Uzdoom < Package
  description 'UZDoom is a feature centric port for all Doom engine games, based on GZDoom, adding an advanced renderer and powerful scripting capabilities'
  homepage 'http://zdoom.org/'
  version '5.0.3'
  license 'GPL-3'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/UZDoom/UZDoom/releases/download/#{version}/Linux-UZDoom-Release-x86_64.AppImage"
  source_sha256 '9c5166febc09cbf80c24612a78829037c953f38c4d986e36f8475ddd507e0228'

  no_compile_needed

  def self.install
    FileUtils.rm_rf 'usr/share/doc'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv 'usr/share/games', "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv 'usr/bin', "#{CREW_DEST_PREFIX}/share/games/uzdoom"
    FileUtils.mv 'usr/lib', "#{CREW_DEST_PREFIX}/share/games/uzdoom"
    FileUtils.mv Dir['usr/share/*'], "#{CREW_DEST_PREFIX}/share"
    FileUtils.ln_s "#{CREW_PREFIX}/share/games/uzdoom/bin/uzdoom", "#{CREW_DEST_PREFIX}/share/games/uzdoom/doom"
    FileUtils.ln_s "#{CREW_PREFIX}/share/games/uzdoom/doom", "#{CREW_DEST_PREFIX}/bin/doom"
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      Type 'doom' to get started.

      If you see errors, make sure the freedoom package is installed or add
      *.wad compatible files manually to #{CREW_PREFIX}/share/games/uzdoom.
    EOM
  end
end
