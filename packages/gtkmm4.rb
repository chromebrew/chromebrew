require 'buildsystems/meson'

class Gtkmm4 < Meson
  description 'The Gtkmm4 package provides a C++ interface to GTK+ 4.'
  homepage 'https://www.gtkmm.org/'
  version '4.20.0'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gtkmm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36ff2166f8297a2f7e0e23a3a1add85a834c60ed1078eab3e9c555fcb2904685',
     armv7l: '36ff2166f8297a2f7e0e23a3a1add85a834c60ed1078eab3e9c555fcb2904685',
     x86_64: 'e20d34077a8f34d8d07c86c7a623d970a1c2b35a9bd71b8403a6a742d016c7fa'
  })

  depends_on 'cairo' # R
  depends_on 'cairomm_1_16' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_68' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'libsigcplusplus3' # R
  depends_on 'mm_common' => :build
  depends_on 'pangomm_2_48' # R
  depends_on 'vulkan_headers' => :build

  gnome
  no_upstream_update

  meson_options '-Dbuild-documentation=false'
end
