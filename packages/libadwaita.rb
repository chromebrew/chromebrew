require 'package'

class Libadwaita < Package
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  version '1.0.0-alpha.2'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita.git'
  git_hashtag version

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.1.0-aab6_i686/libadwaita-1.1.0-aab6-chromeos-i686.tar.xz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.0.0-alpha.2_armv7l/libadwaita-1.0.0-alpha.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.0.0-alpha.2_armv7l/libadwaita-1.0.0-alpha.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.0.0-alpha.2_x86_64/libadwaita-1.0.0-alpha.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
       i686: 'd68dd1fb68393dbeed3f7537a81d5812cc3cdff659dc74dfd07592a1cacad297',
    aarch64: '64fa0c4373eb849fbb139e8fd1fcd2f9f6b64f4ccf373ef17c58a0130a77ae54',
     armv7l: '64fa0c4373eb849fbb139e8fd1fcd2f9f6b64f4ccf373ef17c58a0130a77ae54',
     x86_64: '39da23ece24e4872fc0519d499e9f6306d6dbb6e5de11a7220f18e8f9b7c95e3'
  })

  depends_on 'cairo'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene'
  depends_on 'gtk4'
  depends_on 'libjpeg'
  depends_on 'pango'
  depends_on 'vala' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
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
