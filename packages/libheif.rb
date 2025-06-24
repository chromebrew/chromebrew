require 'buildsystems/cmake'

class Libheif < CMake
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  version '1.19.8'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/strukturag/libheif.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c116b6ac1b5da63aa2917a80a7b76c30b6409a32c77644271bc1b038dfa1842',
     armv7l: '9c116b6ac1b5da63aa2917a80a7b76c30b6409a32c77644271bc1b038dfa1842',
     x86_64: 'adef3f8f972c6d2b32da90648530e093f4ba67f872673cfdfffae094610ebcc2'
  })

  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'graphviz' => :build # Only needed for dot.
  depends_on 'libaom' # R
  depends_on 'libde265' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # L
  depends_on 'libwebp' # R
  depends_on 'libx265' # R
  depends_on 'zlib' # R
  depends_on 'openh264' # R

  gnome
end
