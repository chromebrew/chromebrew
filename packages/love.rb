require 'buildsystems/autotools'

class Love < Autotools
  description 'LÖVE is an awesome 2D game framework for Lua.'
  homepage 'https://www.love2d.org/'
  version '11.5'
  license 'zlib'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/love2d/love/releases/download/#{version}/love-#{version}-linux-src.tar.gz"
  binary_compression 'tar.zst'

  binary_sha256({
   aarch64: '772f1a95a42d7be26c944809b7dcffae5e6b63280df8c6fa0a4056bb70ebeaf8',
    armv7l: '772f1a95a42d7be26c944809b7dcffae5e6b63280df8c6fa0a4056bb70ebeaf8',
    x86_64: 'bc29e0b27e1de069d1612b9dab4eb62486207e7eaf94773c55e4a080e64aad1a'
  })

  depends_on 'freetype'
  depends_on 'libmodplug'
  depends_on 'libsdl2'
  depends_on 'libvorbis'
  depends_on 'libtheora'
  depends_on 'luajit'
  depends_on 'mpg123'
  depends_on 'openal'
end
