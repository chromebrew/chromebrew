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
    aarch64: '9769d2f5e99b80ee126723b0614a2a5cad5298a6c14176644c9d7c7408fceb43',
     armv7l: '9769d2f5e99b80ee126723b0614a2a5cad5298a6c14176644c9d7c7408fceb43',
     x86_64: 'cb5053d74804b963f9fab9e9f97b336776cad30d6b38df277386e800b755c6b3'
  })

  depends_on 'atkmm' => :build
  depends_on 'gtk4' => :build
  depends_on 'pangomm' => :build
  depends_on 'cairomm' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'gobject_introspection' => :build
end
