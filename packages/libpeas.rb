require 'buildsystems/meson'

class Libpeas < Meson
  description 'A GObject plugins library'
  homepage 'https://gitlab.gnome.org/GNOME/libpeas'
  version '2.0.1'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libpeas.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '78ceca9000c59442db18d1b1702822f479296bff42b047019dea40fae8e314d0',
     armv7l: '78ceca9000c59442db18d1b1702822f479296bff42b047019dea40fae8e314d0',
     x86_64: '44fbfaef5fdbc51964688bc0971ce65aa5424db58615a1a688b872f0f4755625'
  })

  depends_on 'gjs' => :build
  depends_on 'glade' => :build
  depends_on 'glib' => :build
  depends_on 'glibc' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'luajit' => :build
  depends_on 'py3_gi_docgen' => :build
  depends_on 'pygobject' => :build
  depends_on 'python3' => :build
  depends_on 'vala' => :build
end
