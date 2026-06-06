require 'buildsystems/meson'

class Gtk_vnc < Meson
  description 'VNC viewer widget for GTK'
  homepage 'https://wiki.gnome.org/Projects/gtk-vnc'
  version '1.5.0'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gtk-vnc.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'be916c19ee88d003a5285ee328751c71b9113e9966a14003409c450e096d8ee8',
     armv7l: 'be916c19ee88d003a5285ee328751c71b9113e9966a14003409c450e096d8ee8',
     x86_64: '17c2567f91c5a8625f5856d6bbfaa28f1864df8da41c21678ceb31cfac4c995e'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'gnutls' => :library
  depends_on 'gobject_introspection' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libcyrussasl' => :library
  depends_on 'libgcrypt' => :library
  depends_on 'libx11' => :library
  depends_on 'pulseaudio' => :library
  depends_on 'py3_gi_docgen' => :build
  depends_on 'zlib' => :library

  gnome
end
