require 'buildsystems/cmake'

class Fontforge < CMake
  description 'Free (libre) font editor for Windows, Mac OS X and GNU+Linux'
  homepage 'https://fontforge.org/'
  version '20230101'
  license 'BSD and GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/fontforge/fontforge.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f507e5c55da931b9d29865c522c7beea91bb906f15b4a354cee23bb89c60d16',
     armv7l: '5f507e5c55da931b9d29865c522c7beea91bb906f15b4a354cee23bb89c60d16',
     x86_64: '0c38cb948b509b784a32e1bf6de083f4f95982e7ca067e9d1397ddc978ea43b6'
  })

  # https://github.com/fontforge/fontforge/issues/5251
  def self.patch
    # Fix errors in French and Italian translations
    downloader 'https://patch-diff.githubusercontent.com/raw/fontforge/fontforge/pull/5257.patch', '91a2836b4ae8a572ad0cc9b867cf9313b64adbb094d416e8ba17535fc8b839b3'
    system 'git apply 5257.patch'
  end

  depends_on 'cairo' # R
  depends_on 'freetype' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'giflib' # R
  depends_on 'glib' # R
  depends_on 'gtk3'
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
