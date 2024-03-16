require 'buildsystems/meson'

class Glade < Meson
  description 'User Interface Builder for GTK+ applications'
  homepage 'https://wiki.gnome.org/Apps/Glade'
  version '3.40.0'
  license 'GPL-2+ and LDF-1.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/glade.git'
  git_hashtag "GLADE_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2cd59ac4b9b4fc83e227471d8134cf16953b910d54741469a35c8633e015c76e',
     armv7l: '2cd59ac4b9b4fc83e227471d8134cf16953b910d54741469a35c8633e015c76e',
     x86_64: 'dbcb4a1241c37e8b0efeee2df19e3beb4e7f4ff8e980ba05ee5dbd1f4cd7d282'
  })

  depends_on 'gtk3'
  depends_on 'libxml2'
  depends_on 'gobject_introspection'
  depends_on 'pygobject'
  depends_on 'graphite'

  gnome

  pre_meson_options "CFLAGS='-fuse-ld=lld' CXXFLAGS='-fuse-ld=lld'"
  meson_options '-Dgtk_doc=false -Dman=false'
end
