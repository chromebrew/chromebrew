require 'package'

class Freedoom < Package
  description 'Freedoom is an entirely free software game based on the Doom engine.'
  homepage 'https://freedoom.github.io/'
  version '0.13.0'
  license 'Copyright © 2001-2024 Contributors to the Freedoom project.'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/freedoom/freedoom/releases/download/v#{version}/freedoom-#{version}.zip"
  source_sha256 '3f9b264f3e3ce503b4fb7f6bdcb1f419d93c7b546f4df3e874dd878db9688f59'

  depends_on 'uzdoom'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/games/uzdoom"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/games/uzdoom"
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      Type 'doom' to get started.

      If you have trouble with sound, try 'doom -nosound' to disable.
    EOM
  end
end
