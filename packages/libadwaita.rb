require 'package'

class Libadwaita < Package
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  @_ver = '1.2.0'
  version "#{@_ver}-1"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.2.0-1_armv7l/libadwaita-1.2.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.2.0-1_armv7l/libadwaita-1.2.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.2.0-1_i686/libadwaita-1.2.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.2.0-1_x86_64/libadwaita-1.2.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c554162f65773ba5b814131091279d803bd1960b1907e27ab195f9cc324b74ed',
     armv7l: 'c554162f65773ba5b814131091279d803bd1960b1907e27ab195f9cc324b74ed',
       i686: '0f519fa0b42782fa36fd3bec21e4aba8b1afcf89e38c2066c9c5a90881b71ab5',
     x86_64: 'eca2ddef9d0e97b70dc3dde07b1bdb2c712f40430bb0609b13c409384db75d02'
  })

  depends_on 'cairo'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene'
  depends_on 'gtk4'
  depends_on 'libjpeg'
  depends_on 'pango'
  depends_on 'py3_gi_docgen' => :build
  depends_on 'libsass' => :build
  depends_on 'sassc' => :build
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  gnome

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
            -Dintrospection=enabled \
            -Dexamples=false \
            -Dgtk_doc=false \
            -Dtests=false \
            builddir"
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    system 'samu -C builddir test || true'
  end
end
