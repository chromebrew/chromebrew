# Adapted from Arch Linux appstream PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/appstream/trunk/PKGBUILD

require 'buildsystems/meson'

class Appstream < Meson
  description 'Provides a standard for creating app stores across distributions'
  homepage 'https://distributions.freedesktop.org/wiki/AppStream'
  version '1.0.2'
  license 'GPL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/ximion/appstream.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '72b90361542d1439be11816b6cc5f1b2259d3ab873a863499539b0cf65fd721a',
     armv7l: '72b90361542d1439be11816b6cc5f1b2259d3ab873a863499539b0cf65fd721a',
     x86_64: 'ed9f5df75ed2f6cda18c1a104ab2242dd83306f262d35cfd3808ce4661ca63e7'
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
  depends_on 'itstool' => :build
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
