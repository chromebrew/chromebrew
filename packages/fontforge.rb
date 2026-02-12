require 'buildsystems/cmake'

class Fontforge < CMake
  description 'Free (libre) font editor for Windows, Mac OS X and GNU+Linux'
  homepage 'https://fontforge.org/'
  version '20251009'
  license 'BSD and GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/fontforge/fontforge.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ffa77e0c1c8f686cd6d90a411cf840dad2e281a4b0befe64d969a36591ab70d8',
     armv7l: 'ffa77e0c1c8f686cd6d90a411cf840dad2e281a4b0befe64d969a36591ab70d8',
     x86_64: 'e7db3b302b3a2d83dbb51048a39f185a8e3d315147e8f9a9bd99dab9066b3ba1'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'atkmm16' # R
  depends_on 'cairo' # R
  depends_on 'cairomm_1_0' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'giflib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_4' # R
  depends_on 'gtk3'
  depends_on 'gtkmm3'
  depends_on 'harfbuzz' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libsigcplusplus2' # R
  depends_on 'libspiro'
  depends_on 'libtiff' # R
  depends_on 'libxml2' # R
  depends_on 'pango'
  depends_on 'pangomm_1_4' # R
  depends_on 'python3' # R
  depends_on 'readline' # R
  depends_on 'sommelier' => :logical
  depends_on 'zlib' # R

  run_tests
end
