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
    aarch64: '6244532cb9c96dab0ef73f4fc45b5e94a45662759c5afb2b85ea4e0a8e2d56fb',
     armv7l: '6244532cb9c96dab0ef73f4fc45b5e94a45662759c5afb2b85ea4e0a8e2d56fb',
     x86_64: '5c6932296deea1924fb65aeaf475e68df020df6484cc42371627491e4c47bc16'
  })

  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'gjs' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphite' => :build
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'pygobject' => :build
  depends_on 'python3' # R

  gnome

  pre_meson_options "CFLAGS='-fuse-ld=lld' CXXFLAGS='-fuse-ld=lld'"
  meson_options '-Dgtk_doc=false -Dman=false'
end
