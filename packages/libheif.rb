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
    aarch64: 'f71ace9de54bfea3e7836aeb326c9ec5927da95f0775484007421fb25d654fba',
     armv7l: 'f71ace9de54bfea3e7836aeb326c9ec5927da95f0775484007421fb25d654fba',
     x86_64: '2f355db32c6791bd8f22ccc06474bb59de0886cd75c2fb5950d28d51beb1e5c0'
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
