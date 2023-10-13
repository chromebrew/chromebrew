require 'package'

class Amtk < Package
  description 'Actions, Menus and Toolbars Kit for GTK+ applications'
  homepage 'https://wiki.gnome.org/Projects/Amtk'
  version '5.2.0-33ec-1'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/GNOME/amtk/archive/33ec171156ebc49d6dad568e6ba39470edb272e1.zip'
  source_sha256 'fc9bad18bbd5421da52e0548f9e91eda180539bb568d1e7116ca65f4f73f4b67'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/amtk/5.2.0-33ec-1_armv7l/amtk-5.2.0-33ec-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/amtk/5.2.0-33ec-1_armv7l/amtk-5.2.0-33ec-1-chromeos-armv7l.tar.xz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/amtk/5.2.0-33ec-1_i686/amtk-5.2.0-33ec-1-chromeos-i686.tar.xz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/amtk/5.2.0-33ec-1_x86_64/amtk-5.2.0-33ec-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6d3c8ac190895b8065f94c54baa32c3407c474204a58ded15aa850a5a177a176',
      armv7l: '6d3c8ac190895b8065f94c54baa32c3407c474204a58ded15aa850a5a177a176',
        i686: '9df2871f1075f7129a7c6260ff7eae9b45b3fb5312fb2e5a56e3ec4269ac0e00',
      x86_64: '6528fb4e8fc817d21ae245563631eec51954a1b3f75cc5513accca67732452d1'
  })

  depends_on 'gtk3'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'llvm16_lib' => :build

  def self.build
    system "meson setup #{CREW_MESON_FNO_LTO_OPTIONS} \
    -Dc_args='-fuse-ld=lld' \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
