require 'buildsystems/cmake'

class Libheif < CMake
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  version '1.23.7'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/strukturag/libheif.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '342424adf87ffef3a01228242106ec8327fe9e1392c5cdc97aa5f26a68333a72',
     armv7l: '342424adf87ffef3a01228242106ec8327fe9e1392c5cdc97aa5f26a68333a72',
     x86_64: '55a1750240d7f2172ba3bc2f4ff62d1a061e2080ff5d4d2148bcd43800f18068'
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
