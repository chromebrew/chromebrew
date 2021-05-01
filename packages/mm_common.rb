require 'package'

class Mm_common < Package
  description 'Common build files of the C++ bindings'
  homepage 'http://www.gtkmm.org/'
  @_ver = '1.0.2'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/GNOME/mm-common/archive/#{@_ver}.tar.gz"
  source_sha256 'd4a85f5bc4ec160c6f4120fd31bcf37041271d7a699b506bc368df57b0e2434c'

  binary_url ({
     aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mm_common/1.0.2_armv7l/mm_common-1.0.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mm_common/1.0.2_armv7l/mm_common-1.0.2-chromeos-armv7l.tar.xz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mm_common/1.0.2_i686/mm_common-1.0.2-chromeos-i686.tar.xz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mm_common/1.0.2_x86_64/mm_common-1.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'e8e8af7702962dac7efce6fa23945b47133906ad80fef928956fe986cf097508',
      armv7l: 'e8e8af7702962dac7efce6fa23945b47133906ad80fef928956fe986cf097508',
        i686: '9fdbcdebb0e44bfbafcb507b8ee86500d0d6a35b670e3ccb90ce5c98bc177d22',
      x86_64: 'cd1e88142f873f2f514fba24aa4cade988a4bf754d1e0a5b25c2c3833898714a',
  })

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Duse-network=true \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
