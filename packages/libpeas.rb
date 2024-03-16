require 'buildsystems/meson'

class Libpeas < Meson
  description 'A GObject plugins library'
  homepage 'https://gitlab.gnome.org/GNOME/libpeas'
  version '1.36.0'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libpeas.git'
  git_hashtag "libpeas-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a2a3c23c38fbf26fee2163da96a67377bd8b1cd4c93d3ece0f29a8d85de9f75e',
     armv7l: 'a2a3c23c38fbf26fee2163da96a67377bd8b1cd4c93d3ece0f29a8d85de9f75e',
     x86_64: 'ee094d10ed5ce027d6ae6858b7a19978463b0c37386ac2c07b6b019f394272ea'
  })

  depends_on 'gcc_lib' => :build
  depends_on 'gjs' => :build
  depends_on 'glade' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' # R
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'luajit' => :build
  depends_on 'luajit_lgi' => :build
  depends_on 'luajit' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'pygobject' => :build
  depends_on 'python3' => :build
  depends_on 'python3' # R
  depends_on 'vala' => :build

  gnome
end
