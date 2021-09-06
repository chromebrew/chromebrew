require 'package'

class Blender < Package
  description 'Blender is the free and open source 3D creation suite.'
  homepage 'https://www.blender.org/'
  version '2.93.2'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://mirror.clarkson.edu/blender/release/Blender2.93/blender-2.93.2-linux-x64.tar.xz'
  source_sha256 '6eed646de2c0fb78b2d582584f7fddf84382284044db2fd4550f40d0aa9bc1c9'

  binary_url ({
  })
  binary_sha256 ({
  })

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
