# Adapted from Arch Linux appstream PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/appstream/trunk/PKGBUILD

require 'buildsystems/meson'

class Appstream < Meson
  description 'Provides a standard for creating app stores across distributions'
  homepage 'https://www.freedesktop.org/wiki/Distributions/AppStream/'
  version '1.0.3'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ximion/appstream.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1b507f791833e4d60dd494cf1fbea2cffe203373aed8063383956361e7f0f1d1',
     armv7l: '1b507f791833e4d60dd494cf1fbea2cffe203373aed8063383956361e7f0f1d1',
     x86_64: '23f37368bd8055286db5ff9dd7b1d7acd538896fc24a6bc0ef90ebb469b52c7e'
  })

  depends_on 'cairo' # R
  depends_on 'curl' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'py3_itstool' => :build
  depends_on 'libadwaita' # R
  depends_on 'librsvg' # R
  depends_on 'libstemmer' # R
  depends_on 'libxml2' # R
  depends_on 'libxmlb' # R
  depends_on 'libyaml' # R
  depends_on 'pango' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_libxml2' => :build
  depends_on 'vala' => :build
  depends_on 'xmlto' => :build
  depends_on 'zstd' # R

  meson_options '-Dcompose=true \
    -Dsystemd=false \
    -Dvapi=true'
end
