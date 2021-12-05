require 'package'

class Blender < Package
  description 'Blender is the free and open source 3D creation suite.'
  homepage 'https://www.blender.org/'
  version '3.0.0'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://mirror.clarkson.edu/blender/release/Blender3.0/blender-3.0.3-linux-x64.tar.xz'
  source_sha256 '19b09dfcf5d3f3a068827454f0a704a9aa9c826350f73016121afef5f4d287ce'

  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/blender"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/blender"
    FileUtils.ln_s "#{CREW_PREFIX}/share/blender/blender", "#{CREW_DEST_PREFIX}/bin/blender"
  end

  def self.postinstall
    puts "\nType 'blender' to get started.\n".lightblue
  end
end
