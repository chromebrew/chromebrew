require 'buildsystems/autotools'

class Vala < Autotools
  description 'Vala is a programming language that aims to bring modern programming language features to GNOME developers.'
  homepage 'https://wiki.gnome.org/Projects/Vala'
  version '0.56.18'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/vala.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0780c098de6f9a613c2c963e390bcebb5bea73222c345874e62fb4f761bafad',
     armv7l: 'b0780c098de6f9a613c2c963e390bcebb5bea73222c345874e62fb4f761bafad',
     x86_64: '98bf8c5cf34f6f564c90ed01b3a64218e48856aa6a853a3d9f161e1fd14ff3a9'
  })

  depends_on 'autoconf213' => :build
  depends_on 'autoconf_archive' => :build
  depends_on 'dbus' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphviz' => :build
  depends_on 'libxslt' => :build
  depends_on 'vala_bootstrap' => :build

  conflicts_ok # Overwrites vala_bootstrap
  git_fetchtags
  gnome

  autotools_configure_options '--disable-maintainer-mode \
      --disable-valadoc'
end
