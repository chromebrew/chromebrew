require 'package'

class Libchamplain < Package
  description 'A map widget'
  homepage 'https://wiki.gnome.org/Projects/libchamplain'
  version '0.12.20'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/libchamplain/-/archive/LIBCHAMPLAIN_#{version.gsub(/[.]/, '_')}/libchamplain-LIBCHAMPLAIN_#{version.gsub(/[.]/, '_')}.tar.bz2"
  source_sha256 'e2bfa2179a5ecbdde7fe18a0472e3b04137cb0873b4fe2de29da4c09f0b6e58d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libchamplain/0.12.20_armv7l/libchamplain-0.12.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libchamplain/0.12.20_armv7l/libchamplain-0.12.20-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libchamplain/0.12.20_i686/libchamplain-0.12.20-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libchamplain/0.12.20_x86_64/libchamplain-0.12.20-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4caff5258f0036c19d68191bbe97b9a523842fec4d93e02ba8c06826f2f8d9d4',
     armv7l: '4caff5258f0036c19d68191bbe97b9a523842fec4d93e02ba8c06826f2f8d9d4',
       i686: '0406fdc8daf03c52124e68a5ff5fd0539251c5af27bce94fb04f4906a432c9c4',
     x86_64: 'd351e1dbd9d2dcf6632b6e7f4aca245e60a21ed96968f15a1a49bbe77cd4b9ad'
  })

  depends_on 'clutter_gtk'
  depends_on 'libsoup'
  depends_on 'cairo'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'vala' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
