require 'buildsystems/meson'

class Gtk_vnc < Meson
  description 'VNC viewer widget for GTK'
  homepage 'https://wiki.gnome.org/Projects/gtk-vnc'
  version '1.6.0'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gtk-vnc.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e6ea7a95ef8a9181af1b00715563d5f348dd09f69590d9301894317e9c3e49b5',
     armv7l: 'e6ea7a95ef8a9181af1b00715563d5f348dd09f69590d9301894317e9c3e49b5',
     x86_64: '719a740ed6702d99710723797a40a82a69a8e157f89cad3b8f4b037d810ba77c'
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
