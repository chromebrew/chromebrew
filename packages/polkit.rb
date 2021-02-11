require 'package'

class Polkit < Package
  description 'Application development toolkit for controlling system-wide privileges'
  homepage 'https://www.freedesktop.org/wiki/Software/polkit/'
  version '0.118-265f'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/polkit/polkit/-/archive/265f0d54b83f0c9f0d66c88f132ef385117e1b97/polkit-265f0d54b83f0c9f0d66c88f132ef385117e1b97.tar.bz2'
  source_sha256 '48cf39b1113f22a79a2ad3c901aa5d495b1ead780ca9be99ca4d4bb39cc25619'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/polkit-0.118-265f-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/polkit-0.118-265f-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/polkit-0.118-265f-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/polkit-0.118-265f-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6144024125f13a854cf48dce3d567a562beeeb6bfce82d01ae2309110a6ceaba',
     armv7l: '6144024125f13a854cf48dce3d567a562beeeb6bfce82d01ae2309110a6ceaba',
       i686: '6a3f46969a0ca97cd96ba1882ccc2adefe90e5dd31cd7020b0c4001c1af9137f',
     x86_64: '3dd185d450d343bb6c4c1a073497fe50cd2afd1b380b8f682ee50ab7030177f5'
  })

  depends_on 'expat'
  depends_on 'js78'
  depends_on 'intltool' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'gobject_introspection' => ':build'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dsystemd=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
