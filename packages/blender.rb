require 'package'

class Blender < Package
  description 'Blender is the free and open source 3D creation suite.'
  homepage 'https://www.blender.org/'
  version '3.0.1'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://mirror.clarkson.edu/blender/release/Blender3.0/blender-3.0.1-linux-x64.tar.xz'
  source_sha256 '4f17aa3d10ed6e13e6a75479f1a506f58998b8c007812a0886d9254c953e2ae5'

  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/blender"
    FileUtils.mv '*', "#{CREW_DEST_PREFIX}/share/blender"
    FileUtils.ln_s "#{CREW_PREFIX}/share/blender/blender", "#{CREW_DEST_PREFIX}/bin/blender"
  end

  def self.postinstall
    puts "\nType 'blender' to get started.\n".lightblue
  end
end
