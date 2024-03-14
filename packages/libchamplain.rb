require 'buildsystems/meson'

class Libchamplain < Meson
  description 'A map widget'
  homepage 'https://wiki.gnome.org/Projects/libchamplain'
  version '0.12.20'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/libchamplain/-/archive/LIBCHAMPLAIN_#{version.gsub(/[.]/, '_')}/libchamplain-LIBCHAMPLAIN_#{version.gsub(/[.]/, '_')}.tar.bz2"
  source_sha256 'e2bfa2179a5ecbdde7fe18a0472e3b04137cb0873b4fe2de29da4c09f0b6e58d'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '4caff5258f0036c19d68191bbe97b9a523842fec4d93e02ba8c06826f2f8d9d4',
     armv7l: '4caff5258f0036c19d68191bbe97b9a523842fec4d93e02ba8c06826f2f8d9d4',
     x86_64: 'd351e1dbd9d2dcf6632b6e7f4aca245e60a21ed96968f15a1a49bbe77cd4b9ad'
  })

  depends_on 'clutter_gtk'
  depends_on 'libsoup'
  depends_on 'cairo'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'vala' => :build

  gnome
end
