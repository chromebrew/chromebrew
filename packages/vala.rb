require 'buildsystems/autotools'

class Vala < Autotools
  description 'Vala is a programming language that aims to bring modern programming language features to GNOME developers.'
  homepage 'https://wiki.gnome.org/Projects/Vala'
  version '0.56.19'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/vala.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c8eddb4171dd65fc5e32078bece8f3fe92722e57f3d039eb8b5365b1cd39722',
     armv7l: '6c8eddb4171dd65fc5e32078bece8f3fe92722e57f3d039eb8b5365b1cd39722',
     x86_64: 'fdf00195f4762f76bc242e0680f06e0fc56f07148089c98fff27919260961b15'
  })

  depends_on 'autoconf213' => :build
  depends_on 'autoconf_archive' => :build
  depends_on 'dbus' => :build
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
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
