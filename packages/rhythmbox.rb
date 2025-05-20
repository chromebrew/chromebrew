require 'buildsystems/meson'

class Rhythmbox < Meson
  description 'Rhythmbox is a music playing application for GNOME.'
  homepage 'https://wiki.gnome.org/Apps/Rhythmbox'
  version '3.4.8'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.29'
  source_url 'https://gitlab.gnome.org/GNOME/rhythmbox.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3e0c1bc99067da738d8b193ae61c0b1b8296a9b856cb4d7d9c764c2aa159d32',
     armv7l: 'f3e0c1bc99067da738d8b193ae61c0b1b8296a9b856cb4d7d9c764c2aa159d32',
     x86_64: '09045b8d107c88fa7c42540850906e4df4d645a9b5325bf20c663aadf25b6799'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' # R
  depends_on 'libgudev' # R
  depends_on 'libpeas' # R
  depends_on 'libsecret' => :build
  depends_on 'libsoup' # R
  depends_on 'libx11' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'py3_itstool' => :build
  depends_on 'tdb' # R
  depends_on 'totem_pl_parser' # R
  depends_on 'zlib' # R

  gnome

  def self.postinstall
    ExitMessage.add "Type 'rhythmbox' to get started.".lightblue
  end
end
