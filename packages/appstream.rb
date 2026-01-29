# Adapted from Arch Linux appstream PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/appstream/trunk/PKGBUILD

require 'buildsystems/meson'

class Appstream < Meson
  description 'Provides a standard for creating app stores across distributions'
  homepage 'https://www.freedesktop.org/wiki/Distributions/AppStream/'
  version '1.1.2'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ximion/appstream.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dee51c1b27694ff7d25e4bfcf989086f695b7e3768eb79e1bf5efa0231904bfd',
     armv7l: 'dee51c1b27694ff7d25e4bfcf989086f695b7e3768eb79e1bf5efa0231904bfd',
     x86_64: '427e4bfd8fb8b29503dd42641c023a694e96ba86fdf6af366995479e1f99cfdc'
  })

  # depends_on 'libadwaita' # R
  # depends_on 'libfyaml' # R
  depends_on 'cairo' # R
  depends_on 'curl' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'libfyaml' # R
  depends_on 'librsvg' # R
  depends_on 'libstemmer' # R
  depends_on 'libxml2' # R
  depends_on 'libxmlb' # R
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
