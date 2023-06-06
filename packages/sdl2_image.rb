require 'package'

class Sdl2_image < Package
  description 'SDL2_image is an image loading library that is used with the SDL2 library.'
  homepage 'https://github.com/libsdl-org/SDL_image'
  version '2.6.2'
  license 'ZLIB'
  compatibility 'all'
  source_url 'https://github.com/libsdl-org/SDL_image/archive/refs/tags/release-2.6.2.tar.gz'
  source_sha256 '5d91ea72b449a161821ef51464d0767efb6fedf7a773f923c43e483dc137e362'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sdl2_image/2.6.2_armv7l/sdl2_image-2.6.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sdl2_image/2.6.2_armv7l/sdl2_image-2.6.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sdl2_image/2.6.2_i686/sdl2_image-2.6.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sdl2_image/2.6.2_x86_64/sdl2_image-2.6.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '41f4269501f990749c1759f37bf688b241a2e8295108c430072382f89ab80a86',
     armv7l: '41f4269501f990749c1759f37bf688b241a2e8295108c430072382f89ab80a86',
       i686: '55d39cc29a50856122a01d476002287f0265269a69a8eaa5b8eda437138303ea',
     x86_64: '13ce3f7810f7c9969f5657e3dc74a171bd06211a5a02e5bcbdf7b7d70694c4f2'
  })

  depends_on 'libsdl2'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libwebp'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
