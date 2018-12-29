require 'package'

class Sdl2_image < Package
  description 'SDL2_image is an image loading library that is used with the SDL2 library.'
  homepage 'https://www.libsdl.org/projects/SDL_image/'
  version '2.0.4'
  source_url 'https://www.libsdl.org/projects/SDL_image/release/SDL2_image-2.0.4.tar.gz'
  source_sha256 'e74ec49c2402eb242fbfa16f2f43a19582a74c2eabfbfb873f00d4250038ceac'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libsdl2'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libwebp'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
