# Adapted from Arch Linux appstream PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/appstream/trunk/PKGBUILD

require 'buildsystems/meson'

class Appstream < Meson
  description 'Provides a standard for creating app stores across distributions'
  homepage 'https://www.freedesktop.org/wiki/Distributions/AppStream/'
  version '1.1.1'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ximion/appstream.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd058391cf39a5a986273a8413c29ff466b3fb7541e2895853769a004efa62a81',
     armv7l: 'd058391cf39a5a986273a8413c29ff466b3fb7541e2895853769a004efa62a81',
     x86_64: '459bf98ba7d915107c9f42c07fbdd5e35b1f7847d4db0b4c9d637cc877104d01'
  })

  depends_on 'cairo' # R
  depends_on 'curl' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'libadwaita' # R
  depends_on 'libfyaml' # R
  depends_on 'librsvg' # R
  depends_on 'libstemmer' # R
  depends_on 'libxml2' # R
  depends_on 'libxmlb' # R
  depends_on 'libyaml' # R
  depends_on 'pango' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_itstool' => :build
  depends_on 'py3_libxml2' => :build
  depends_on 'vala' => :build
  depends_on 'xmlto' => :build
  depends_on 'zstd' # R

  meson_options '-Dcompose=true \
    -Dsystemd=false \
    -Dvapi=true'

  def self.postinstall
    ExitMessage.add "\nType 'appstreamcli --help' to get started.\n"
  end
end
