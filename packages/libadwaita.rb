require 'package'

class Libadwaita < Package
  description 'Library full of GTK+ widgets for mobile phones'
  homepage 'https://gitlab.gnome.org/exalm/libadwaita'
  version '1.1.0-73c1'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/exalm/libadwaita/-/archive/73c17e0b36ad882d1a25e90926fe648e326e6b41/libadwaita-73c17e0b36ad882d1a25e90926fe648e326e6b41.tar.bz2'
  source_sha256 '99730e57870ffc0f5e801ae5dac074e1a5b6f7d8e622f837b4f6a8439a328604'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libadwaita-1.1.0-73c1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libadwaita-1.1.0-73c1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libadwaita-1.1.0-73c1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libadwaita-1.1.0-73c1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '22ea80100a4e12c031c09f62abbf54341950fa80801f458676e7d0146f11be11',
     armv7l: '22ea80100a4e12c031c09f62abbf54341950fa80801f458676e7d0146f11be11',
       i686: '63712e4bb09455822116e346132b6b64ab660b212c48a600bb611025e1b3fc2d',
     x86_64: 'daaa26d53f8c8b3e3f15724eaa16122e4b3358185342df7a66160c229caf4d0c'
  })

  depends_on 'cairo'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene'
  depends_on 'gtk4'
  depends_on 'pango'
  depends_on 'vala' => :build

  def self.patch
    system "sed -i 's/-fstack-protector-strong/-flto/g' meson.build"
  end

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      -Drequire_all_tests=false \
      -Duser_documentation=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
