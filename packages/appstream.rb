# Adapted from Arch Linux appstream PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/appstream/trunk/PKGBUILD

require 'buildsystems/meson'

class Appstream < Meson
  description 'Provides a standard for creating app stores across distributions'
  homepage 'https://distributions.freedesktop.org/wiki/AppStream'
  version '1.0.0'
  license 'GPL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/ximion/appstream.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '017b4de148d1ccedfff97aedea78d3a617dc5809a4c3820a30f2aaa4b05faf43',
     armv7l: '017b4de148d1ccedfff97aedea78d3a617dc5809a4c3820a30f2aaa4b05faf43',
     x86_64: 'c3e52d6995ef14ef1f99a687a5c1338cca02dc5496bd075894cbe862ced637b7'
  })

  depends_on 'cairo' # R
  depends_on 'curl' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'itstool' => :build
  depends_on 'librsvg' # R
  depends_on 'libstemmer' # R
  depends_on 'libxml2' # R
  depends_on 'libxmlb' # R
  depends_on 'libyaml' # R
  depends_on 'pango' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_libxml2' => :build
  depends_on 'qt5_base' # R
  depends_on 'qt5_tools' => :build
  depends_on 'vala' => :build
  depends_on 'xmlto' => :build
  depends_on 'zstd' # R

  meson_options '-Dcompose=true \
    -Dqt5=true \
    -Dsystemd=false \
    -Dvapi=true'
end
