require 'buildsystems/meson'

class Gtkmm4 < Meson
  description 'The Gtkmm4 package provides a C++ interface to GTK+ 4.'
  homepage 'https://www.gtkmm.org/'
  version '4.13.3'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gtkmm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '181cd9d9c4dca2a443121ed4fd82e9f5ba249423e1777f8842700dbe1afefe8e',
     armv7l: '181cd9d9c4dca2a443121ed4fd82e9f5ba249423e1777f8842700dbe1afefe8e',
     x86_64: 'eb407224748eef793e5bed1271239d23520e50f7e1112c1b5a429a81c6ad0af0'
  })

  depends_on 'cairomm_1_16' # R
  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_68' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'libsigcplusplus3' # R
  depends_on 'pangomm_2_48' # R
  depends_on 'vulkan_headers' => :build

  meson_options '-Dbuild-documentation=false'
end
