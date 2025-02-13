require 'package'

class Extremetuxracer < Package
  description 'High speed arctic racing game based on Tux Racer'
  homepage 'https://sourceforge.net/projects/extremetuxracer/'
  version "0.8.4-1"
  compatibility 'x86_64 armv7l'
  license 'GPLv2'
  source_url "https://github.com/FinnBaltazar1111/extremetuxracer/releases/latest/download/extremetuxracer_#{version}_#{ARCH}.deb"
  source_sha256 'SKIP'
  
  depends_on 'libsdl2'
  depends_on 'mesa'
  depends_on 'mesa_utils'
  depends_on 'tcl'
  

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/"
    FileUtils.cp_r ".", "#{CREW_DEST_PREFIX}"
  end

  def self.postinstall
    ExitMessage.add("\nExtreme Tux Racer installed! Run the game with \"etr\".\n")
  end
end