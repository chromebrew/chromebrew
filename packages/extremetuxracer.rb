require 'package'

class Extremetuxracer < Package
  description 'High speed arctic racing game based on Tux Racer'
  homepage 'https://sourceforge.net/projects/extremetuxracer/'
  version '0.8.4-1'
  compatibility 'aarch64 armv7l x86_64'
  license 'GPLv2'
  source_url({
    aarch64: "https://github.com/FinnBaltazar1111/extremetuxracer/releases/download/0.8.4/extremetuxracer_#{version}_armhf.deb",
    armv7l: "https://github.com/FinnBaltazar1111/extremetuxracer/releases/download/0.8.4/extremetuxracer_#{version}_armhf.deb",
    x86_64: "https://github.com/FinnBaltazar1111/extremetuxracer/releases/download/0.8.4/extremetuxracer_#{version}_amd64.deb"
  })
  source_sha256({
    aarch64: '94c7f0c9b13604ca9f6b314d5e3df54516346a7c0768d171f6350efeca19d913',
     armv7l: '94c7f0c9b13604ca9f6b314d5e3df54516346a7c0768d171f6350efeca19d913',
     x86_64: 'd081c1b4fcc8f4586f734c9c9f4c23a5f00909eda2596729d141328a637b99ea'
  })

  depends_on 'libsdl2'
  depends_on 'mesa'
  depends_on 'mesa_utils'
  depends_on 'tcl'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/"
    FileUtils.cp_r '.', CREW_DEST_PREFIX.to_s
  end

  def self.postinstall
    ExitMessage.add("\nExtreme Tux Racer installed! Run the game with \"etr\".\n")
  end
end
