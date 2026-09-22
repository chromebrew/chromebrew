require 'buildsystems/cmake'

class Libheif < CMake
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  version '1.23.5'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/strukturag/libheif.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd082093a0f1a9d2d35eb3c6fe801c857251b751bcbb67b5b22866f524d8edb2',
     armv7l: 'bd082093a0f1a9d2d35eb3c6fe801c857251b751bcbb67b5b22866f524d8edb2',
     x86_64: '8108f35e885364720176e567b5fa2c22a1b2a67295566d614fb0c99404f9a176'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphviz' => :build # Only needed for dot.
  depends_on 'libaom' => :library
  depends_on 'libde265' => :library
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'libpng' => :executable
  depends_on 'libtiff' => :executable
  depends_on 'libtiff' => :logical
  depends_on 'libwebp' => :library
  depends_on 'libx265' => :library
  depends_on 'openh264' => :library
  depends_on 'sdl2' => :executable
  depends_on 'sdl2_compat' => :executable
  depends_on 'zlib' => :executable

  gnome
end
