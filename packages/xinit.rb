require 'buildsystems/autotools'

class Xinit < Autotools
  description 'The xinit package contains a usable script to start the xserver.'
  homepage 'https://www.x.org/wiki/'
  version '1.4.4'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.x.org/archive/individual/app/xinit-#{version}.tar.gz"
  source_sha256 '45cca1b0f3a963105f43cecc24e9cc4db0d14faa87bd9860b9ec563e8c73fc47'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7da85c40d91efc08a1e02b2e71d3eee68823585ff95724a2099f0afaf42c715c',
     armv7l: '7da85c40d91efc08a1e02b2e71d3eee68823585ff95724a2099f0afaf42c715c',
     x86_64: '3d6994af43d5ed2cc3501b40f16033a572667ccbf378b20a003b8a61b9559d57'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libx11' => :executable
  depends_on 'xauth' => :logical
  depends_on 'xorg_server' => :logical
  depends_on 'xterm' => :logical
end
