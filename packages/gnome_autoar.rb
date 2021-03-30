require 'package'

class Gnome_autoar < Package
  description 'Automatic archives creating and extracting library'
  homepage 'https://wiki.gnome.org/TingweiLan/GSoC2013Final'
  @_ver = '0.3.1'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gnome-autoar/-/archive/#{@_ver}/gnome-autoar-#{@_ver}.tar.bz2"
  source_sha256 '22a69b610697386a2c0edaa7aa64cc3b45e655d7fd5fe14f71d4d196c5747eab'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_autoar-0.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_autoar-0.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_autoar-0.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_autoar-0.3.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '945d1e7823c361578872527f943b5cab274cb912ecaee7470915b29b533d8056',
     armv7l: '945d1e7823c361578872527f943b5cab274cb912ecaee7470915b29b533d8056',
       i686: 'a013ceb4e222b9033defd9aca3a81aff1ba167f7a0ec2bcf805e3ea34d0c81d1',
     x86_64: 'd50fd612eceffa4124a67bb5018b3360712d33b2c981d557c0aacab951b89c01'
  })

  depends_on 'libarchive'
  depends_on 'gtk3'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'vala' => :build
  depends_on 'autoconf_archive' => :build

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
