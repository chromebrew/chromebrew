require 'package'

class Libgudev < Package
  description 'libgudev is a library with GObject bindings to libudev'
  homepage 'https://wiki.gnome.org/Projects/libgudev'
  version '237'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libgudev/-/archive/237/libgudev-237.tar.bz2'
  source_sha256 '1cec460f8afaa0e613f92202699b31b5560843a4a86e019ebb1ef437675b74d8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgudev/237_armv7l/libgudev-237-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgudev/237_armv7l/libgudev-237-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgudev/237_i686/libgudev-237-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgudev/237_x86_64/libgudev-237-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '53a0853639519ec1fe743c1fa028f2e578842da85a29b95b6cc232131b0e1f4c',
     armv7l: '53a0853639519ec1fe743c1fa028f2e578842da85a29b95b6cc232131b0e1f4c',
       i686: 'e413696ccf4a59228a8df4ebd6c227cb6726bc6b4aec07df021d8a3ea68f94c8',
     x86_64: '0fcf9a8d0f001ab2f549d81b1465126a9fbe88642ac1b9e50285202cece8448b'
  })

  depends_on 'gobject_introspection'
  depends_on 'eudev' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R

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
