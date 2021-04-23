require 'package'

class Libhandy < Package
  description 'The aim of the handy library is to help with developing UI for mobile devices using GTK/GNOME.'
  homepage 'https://gitlab.gnome.org/GNOME/libhandy/'
  @_ver = '1.2.0'
  version "#{@_ver}-1"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/libhandy/-/archive/#{@_ver}/libhandy-#{@_ver}.tar.bz2"
  source_sha256 'b2e08210a6b0c6b08e6c46848024cbcf44973e40377a1373d7cbb0bde7131b56'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/libhandy-1.2.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/libhandy-1.2.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/libhandy-1.2.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/libhandy-1.2.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '3bd22e6101caa76c8f89fc4ef8aeb046e85c7969b42003f1835e81c13df7180d',
     armv7l: '3bd22e6101caa76c8f89fc4ef8aeb046e85c7969b42003f1835e81c13df7180d',
       i686: 'f1e76dc3fdc785113360060a6813c971008a3961667abef92bed7a27fc386e1d',
     x86_64: '3519270c70aec8aedfd6afbd9f286920f148d6377a8e30512c020ff166959684'
  })

  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'libjpeg'
  depends_on 'pango'
  depends_on 'vala'

  def self.prebuild
    system "sed -i 's,-fstack-protector-strong,-fno-stack-protector,' meson.build"
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
