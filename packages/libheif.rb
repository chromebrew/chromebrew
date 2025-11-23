require 'buildsystems/cmake'

class Libheif < CMake
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  version '1.20.2'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/strukturag/libheif.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '778d0b6b8ff7874c27dcc4dea52cd3bbd9b523e4a2dfdfbd9e514dcf37b9577c',
     armv7l: '778d0b6b8ff7874c27dcc4dea52cd3bbd9b523e4a2dfdfbd9e514dcf37b9577c',
     x86_64: '3ec223d5489a1624911f33efbaad79bcbef457c23272ccef60a6d7a7ca7cc47b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'graphviz' => :build # Only needed for dot.
  depends_on 'libaom' # R
  depends_on 'libde265' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # L
  depends_on 'libwebp' # R
  depends_on 'libx265' # R
  depends_on 'openh264' # R
  depends_on 'sdl2' # R
  depends_on 'zlib' # R

  gnome
end
