require 'buildsystems/meson'

class Rhythmbox < Meson
  description 'Rhythmbox is a music playing application for GNOME.'
  homepage 'https://wiki.gnome.org/Apps/Rhythmbox'
  version '3.4.7'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.29'
  source_url 'https://gitlab.gnome.org/GNOME/rhythmbox.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5475faf35fc7ae052c92442cf6b7fd1382764b8807b2cef9d77ee98c0abac8f3',
     armv7l: '5475faf35fc7ae052c92442cf6b7fd1382764b8807b2cef9d77ee98c0abac8f3'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc_lib' # R
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
  depends_on 'tdb' # R
  depends_on 'totem_pl_parser' # R

  gnome

  def self.postinstall
    ExitMessage.add "Type 'rhythmbox' to get started.".lightblue
  end
end
