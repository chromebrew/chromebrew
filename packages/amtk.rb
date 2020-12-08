require 'package'

class Amtk < Package
  description 'Actions, Menus and Toolbars Kit for GTK+ applications'
  homepage 'https://wiki.gnome.org/Projects/Amtk'
  version '5.2.0-33ec'
  compatibility 'all'
  source_url 'https://github.com/GNOME/amtk/archive/33ec171156ebc49d6dad568e6ba39470edb272e1.zip'
  source_sha256 'fc9bad18bbd5421da52e0548f9e91eda180539bb568d1e7116ca65f4f73f4b67'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/amtk-5.2.0-33ec-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/amtk-5.2.0-33ec-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/amtk-5.2.0-33ec-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/amtk-5.2.0-33ec-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4605dcc0d4505562e1201ec13471d4afa2ad3be9b1a9685190bd3b9f595cb3cf',
     armv7l: '4605dcc0d4505562e1201ec13471d4afa2ad3be9b1a9685190bd3b9f595cb3cf',
       i686: '9a358303f926ef725cf4532df5812304024915af13e90f0bfc12d8f58f77fbad',
     x86_64: 'f15f58b2e32128bcafffc180fddbce945c70be6bb12241bbf0207cac69a3572e',
  })

  depends_on 'gtk3'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'llvm' => :build

  ENV['CC'] = 'clang'
  ENV['CXX'] = 'clang'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
