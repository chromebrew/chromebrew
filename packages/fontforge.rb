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
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'cairo' # R
  depends_on 'freetype' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'giflib' # R
  depends_on 'glib' # R
  depends_on 'gtk3'
  depends_on 'gtkmm3'
  depends_on 'harfbuzz' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libspiro'
  depends_on 'libtiff' # R
  depends_on 'libxml2' # R
  depends_on 'pango'
  depends_on 'python3' # R
  depends_on 'readline' # R
  depends_on 'sommelier'
  depends_on 'zlib' # R

  run_tests
end
