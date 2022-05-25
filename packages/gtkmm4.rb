require 'buildsystems/meson'

class Gtkmm4 < Meson
  description 'The Gtkmm4 package provides a C++ interface to GTK+ 4.'
  homepage 'https://www.gtkmm.org/'
  version '4.0.2'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.gnome.org/sources/gtkmm/4.0/gtkmm-4.0.2.tar.xz'
  source_sha256 '0c836e8daffd836ef469499b7a733afda3a5260ea0e4d81c552f688ae384bd97'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtkmm4/4.0.2_armv7l/gtkmm4-4.0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtkmm4/4.0.2_armv7l/gtkmm4-4.0.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtkmm4/4.0.2_x86_64/gtkmm4-4.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9769d2f5e99b80ee126723b0614a2a5cad5298a6c14176644c9d7c7408fceb43',
     armv7l: '9769d2f5e99b80ee126723b0614a2a5cad5298a6c14176644c9d7c7408fceb43',
     x86_64: 'cb5053d74804b963f9fab9e9f97b336776cad30d6b38df277386e800b755c6b3'
  })

  depends_on 'atkmm'
  depends_on 'gtk4'
  depends_on 'pangomm'
  depends_on 'cairomm'
  depends_on 'vulkan_headers'
  depends_on 'gobject_introspection'
end
