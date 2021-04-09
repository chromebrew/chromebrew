require 'package'

class Gnome_autoar < Package
  description 'Automatic archives creating and extracting library'
  homepage 'https://wiki.gnome.org/TingweiLan/GSoC2013Final'
  @_ver = '0.3.1'
  version "#{@_ver}-1"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gnome-autoar/-/archive/#{@_ver}/gnome-autoar-#{@_ver}.tar.bz2"
  source_sha256 '22a69b610697386a2c0edaa7aa64cc3b45e655d7fd5fe14f71d4d196c5747eab'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_autoar-0.3.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_autoar-0.3.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_autoar-0.3.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_autoar-0.3.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd39da19ad4e07e32fdd631512d9be881b1b3d35169db87c681b20ae56ba027af',
     armv7l: 'd39da19ad4e07e32fdd631512d9be881b1b3d35169db87c681b20ae56ba027af',
       i686: 'b688460904880b84c9ccecab6f2affe9ee07674110ce92d5f66c2c44fa0f766c',
     x86_64: '4908f3bbfd1ab6145428752bbb69d67a7b4921810d52a73e09732423e2c52ddd'
  })

  depends_on 'atk'
  depends_on 'autoconf_archive' => :build
  depends_on 'cairo'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3'
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz'
  depends_on 'libarchive'
  depends_on 'libjpeg'
  depends_on 'pango'
  depends_on 'vala' => :build

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-flto=auto' \
    CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
    ./configure \
    #{CREW_OPTIONS} \
    --enable-gtk-doc"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
