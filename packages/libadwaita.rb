require 'package'

class Libadwaita < Package
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  @_ver = '1.2.0'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.2.0_armv7l/libadwaita-1.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.2.0_armv7l/libadwaita-1.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.2.0_i686/libadwaita-1.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.2.0_x86_64/libadwaita-1.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8fafff9cafac5e7b44668c80192c392cde6837894a084d5f7ea21bf183d048d8',
     armv7l: '8fafff9cafac5e7b44668c80192c392cde6837894a084d5f7ea21bf183d048d8',
       i686: '32d94aab8c421bcc1375528a16d1a643e9879b163ec3903d25527ee377e74c77',
     x86_64: '02445f3204282fdb1c151acdfd042be5f2dc85b07e5fb06a38cfa8d7ee37137b'
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
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    system 'samu -C builddir test || true'
  end
end
