require 'package'

class Blender < Package
  description 'Blender is the free and open source 3D creation suite.'
  homepage 'https://www.blender.org/'
  version '4.0.2'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://mirror.clarkson.edu/blender/release/Blender4.0/blender-4.0.2-linux-x64.tar.xz'
  source_sha256 '5583a5588736da8858c522ef17fff5d73be59c47a6fe91ad29c6f3263e22086a'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '2ef554553a2f40d3fc4a68de2389502b087a0f79c0421acb2e3445dea3224f50'
  })

  depends_on 'sommelier' # L
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'libice' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxrender' # R
  depends_on 'libxt' # R
  depends_on 'libxxf86vm' # R
  depends_on 'mesa' # R
  depends_on 'ncurses' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/blender"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/blender"
    FileUtils.ln_s "#{CREW_PREFIX}/share/blender/blender", "#{CREW_DEST_PREFIX}/bin/blender"
  end

  def self.postinstall
    puts
    puts "Type 'blender' to get started.".lightblue
    puts
  end
end
