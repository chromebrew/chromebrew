require 'package'

class Totem_pl_parser < Package
  description 'Totem playlist parsing library'
  homepage 'https://gitlab.gnome.org/GNOME/totem-pl-parser'
  version '3.26.6'
  license 'LGPL GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://download.gnome.org/sources/totem-pl-parser/3.26/totem-pl-parser-3.26.6.tar.xz'
  source_sha256 'c0df0f68d5cf9d7da43c81c7f13f11158358368f98c22d47722f3bd04bd3ac1c'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/totem_pl_parser/3.26.6_armv7l/totem_pl_parser-3.26.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/totem_pl_parser/3.26.6_armv7l/totem_pl_parser-3.26.6-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/totem_pl_parser/3.26.6_x86_64/totem_pl_parser-3.26.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0b5ddaa9e3078bf36f0f6c86047ac03c23df75cc31bf098191a269e9c978c1c9',
     armv7l: '0b5ddaa9e3078bf36f0f6c86047ac03c23df75cc31bf098191a269e9c978c1c9',
     x86_64: 'd940b25706611415e4fe0d8e7d090d55b3b7b44d02a6884f9b5386a0a3555175'
  })

  depends_on 'gobject_introspection'
  depends_on 'libarchive'
  depends_on 'libgcrypt'
  depends_on 'libsoup'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} build"
    system 'meson configure build'
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
