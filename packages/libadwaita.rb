require 'package'

class Libadwaita < Package
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  @_ver = '1.0.3'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.0.3_armv7l/libadwaita-1.0.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.0.3_armv7l/libadwaita-1.0.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.0.3_i686/libadwaita-1.0.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.0.3_x86_64/libadwaita-1.0.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '009e5ef5d3adcfde46a4b7e671f707680c46d9817c031732eec13aee1c0d170f',
     armv7l: '009e5ef5d3adcfde46a4b7e671f707680c46d9817c031732eec13aee1c0d170f',
       i686: '3e7139dea2d70fbc714594070bfa6316024413200815bafb1d860b5d99c3c291',
     x86_64: 'd828e672cbf543de90112d024cf2db87ac2d38f68ccbab2d970f01059189b057'
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
  depends_on 'vulkan_headers' => :build
  gnome

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
            -Dintrospection=enabled \
            -Dgtk_doc=false builddir"
    system 'meson configure builddir'
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    system 'samu -C builddir test || true'
  end
end
