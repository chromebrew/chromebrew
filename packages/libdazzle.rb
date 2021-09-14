require 'package'

class Libdazzle < Package
  description 'The libdazzle library is a companion library to GObject and Gtk+.'
  homepage 'https://gitlab.gnome.org/GNOME/libdazzle/'
  version '3.42.0'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libdazzle.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdazzle/3.42.0_armv7l/libdazzle-3.42.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdazzle/3.42.0_armv7l/libdazzle-3.42.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdazzle/3.42.0_i686/libdazzle-3.42.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdazzle/3.42.0_x86_64/libdazzle-3.42.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '73220246b614627588ea66c5c34a534aad824c6cd23c36a84195126f0c535e81',
     armv7l: '73220246b614627588ea66c5c34a534aad824c6cd23c36a84195126f0c535e81',
       i686: 'aad003a9c452e18a2b895a9da0700f3c4c0147ccc2630a79aba1f1b373f54b5c',
     x86_64: '38c0d450cd7aacacb4f556f328d87e3b110189914906fff6e814e6d4cc5cacec'
  })

  depends_on 'cairo'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'pango'
  depends_on 'vala' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
