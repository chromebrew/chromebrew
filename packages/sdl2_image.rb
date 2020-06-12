require 'package'

class Sdl2_image < Package
  description 'SDL2_image is an image loading library that is used with the SDL2 library.'
  homepage 'https://www.libsdl.org/projects/SDL_image/'
  version '2.0.4'
  compatibility 'all'
  source_url 'https://www.libsdl.org/projects/SDL_image/release/SDL2_image-2.0.4.tar.gz'
  source_sha256 'e74ec49c2402eb242fbfa16f2f43a19582a74c2eabfbfb873f00d4250038ceac'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sdl2_image-2.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sdl2_image-2.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sdl2_image-2.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sdl2_image-2.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fa555b57c402a9dd9ff3b2cca24b173f443114b43c077b299ff1a6355bf8eb05',
     armv7l: 'fa555b57c402a9dd9ff3b2cca24b173f443114b43c077b299ff1a6355bf8eb05',
       i686: 'da49934960375538108cde608f94e2dee00e05438757ef9b8fb02e50f225a689',
     x86_64: '6e665aa5ddcff39d0d46e1b35cb698da8bbf2fb0a5523cec2028e67bd691c7a1',
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
