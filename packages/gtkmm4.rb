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
    aarch64: 'e434093b7c637f2eb345a040fc96e963d50c4a6dae4f9880cc07c693b892b668',
     armv7l: 'e434093b7c637f2eb345a040fc96e963d50c4a6dae4f9880cc07c693b892b668',
     x86_64: 'f28c87e6d05d687f3c8f354ed7dca65d4bbfaf98fc45136b054e5bee47871ef3'
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
  depends_on 'mm_common' => :build
  depends_on 'vulkan_headers' => :build

  gnome
  no_upstream_update

  meson_options '-Dbuild-documentation=false'
end
