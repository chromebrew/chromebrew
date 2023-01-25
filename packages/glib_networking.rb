require 'package'

class Glib_networking < Package
  description 'Network extensions for GLib'
  homepage 'https://github.com/GNOME/glib-networking'
  version '2.68.0'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://download.gnome.org/core/40/40.rc/sources/glib-networking-2.68.rc.tar.xz'
  source_sha256 '5f2f62db8a75e2ec5462af12cb59157fb17500dca172c637a88c59053d52115b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib_networking/2.68.0_armv7l/glib_networking-2.68.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib_networking/2.68.0_armv7l/glib_networking-2.68.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib_networking/2.68.0_i686/glib_networking-2.68.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib_networking/2.68.0_x86_64/glib_networking-2.68.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8ce43fcc55b8b8dd2692e80a610741aa727307ab3bfdb34382271634727ac186',
     armv7l: '8ce43fcc55b8b8dd2692e80a610741aa727307ab3bfdb34382271634727ac186',
       i686: '1aff81fd94e89fdc9eb3186ad3d0397ec170a5c4902de753c1511efd0d96819a',
     x86_64: '5b3f9d3712f531356d0cada0b3abdfb97fe1b3679b5ba78ab99664a536ddbccc'
  })

  depends_on 'libproxy'
  depends_on 'gsettings_desktop_schemas'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dstatic_modules=true builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
