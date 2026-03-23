require 'buildsystems/meson'

class Gucharmap < Meson
  description 'GNOME Character Map, based on the Unicode Character Database.'
  homepage 'https://wiki.gnome.org/Apps/Gucharmap'
  version '17.0.2'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gucharmap.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1fcecfcdd1e2fded21736ade552c989549cd4fa964a84ce863c89f1a6e6bdb94',
     armv7l: '1fcecfcdd1e2fded21736ade552c989549cd4fa964a84ce863c89f1a6e6bdb94',
     x86_64: 'f3194a73da3f43e620b286fe80dadcd80dd5d05a63082f93f56305af9dcc6ecf'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'desktop_file_utilities' => :build
  depends_on 'gobject_introspection'
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'py3_itstool' => :build
  depends_on 'unicode_character_database'
  depends_on 'vala' => :build

  gnome
  no_lto # Build fails with meson.build:146:0: ERROR: Assert failed: LTO not supported

  meson_options "-Ddocs=false -Ducd_path=#{CREW_PREFIX}/share/unicode"
end
