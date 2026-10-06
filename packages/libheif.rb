require 'buildsystems/cmake'

class Libheif < CMake
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  version '1.23.6'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/strukturag/libheif.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f24d69232f1b7678ecc381a8b76bc8e828617293413b38b99ea58c222ab7af78',
     armv7l: 'f24d69232f1b7678ecc381a8b76bc8e828617293413b38b99ea58c222ab7af78',
     x86_64: 'ebf5ed11f00593eb033aa171cbacd376d1be2aac1ce550a15df8a4553ec20f7a'
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
