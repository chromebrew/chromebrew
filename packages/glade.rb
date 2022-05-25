require 'package'

class Glade < Package
  description 'User Interface Builder for GTK+ applications'
  homepage 'https://wiki.gnome.org/Apps/Glade'
  version '3.38.2'
  license 'GPL-2+ and LDF-1.1+'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/glade/3.38/glade-3.38.2.tar.xz'
  source_sha256 '98fc87647d88505c97dd2f30f2db2d3e9527515b3af11694787d62a8d28fbab7'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glade/3.38.2_armv7l/glade-3.38.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glade/3.38.2_armv7l/glade-3.38.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glade/3.38.2_i686/glade-3.38.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glade/3.38.2_x86_64/glade-3.38.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2cd59ac4b9b4fc83e227471d8134cf16953b910d54741469a35c8633e015c76e',
     armv7l: '2cd59ac4b9b4fc83e227471d8134cf16953b910d54741469a35c8633e015c76e',
       i686: '4c4720309e6b12cc729f1646a9d39a86e1a5bdde68dd2544aca8540c7d0c1f6b',
     x86_64: 'dbcb4a1241c37e8b0efeee2df19e3beb4e7f4ff8e980ba05ee5dbd1f4cd7d282'
  })

  depends_on 'gtk3'
  depends_on 'libxml2'
  depends_on 'gobject_introspection'
  depends_on 'pygobject'
  depends_on 'graphite'

  def self.build
    ENV['CFLAGS'] = '-fuse-ld=lld'
    ENV['CXXFLAGS'] = '-fuse-ld=lld'
    system "meson setup #{CREW_MESON_FNO_LTO_OPTIONS} -Dgtk_doc=false -Dman=false build"
    system 'meson configure build'
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
