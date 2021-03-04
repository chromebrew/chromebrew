require 'package'

class Gnome_autoar < Package
  description 'Automatic archives creating and extracting library'
  homepage 'https://wiki.gnome.org/TingweiLan/GSoC2013Final'
  @_ver = '0.3.0'
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gnome-autoar/-/archive/#{@_ver}/gnome-autoar-#{@_ver}.tar.bz2"
  source_sha256 '6cf0cd7ce7f3ba959d1501701fdb65eeb8c90f6b3a194456df59c3488bb44ef3'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_autoar-0.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_autoar-0.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_autoar-0.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_autoar-0.3.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '54fc0dafb5bba4b0adf454950630ac94cb32e2fad75eabf464db127cd87316ba',
     armv7l: '54fc0dafb5bba4b0adf454950630ac94cb32e2fad75eabf464db127cd87316ba',
       i686: '3473a340cea842e11769920aa126dca0176d387b4a1222759c4255f129f11556',
     x86_64: '90bf2079ba631bebdcd3a27c2ba0229c47a3413359c9fa24aabf7fa3c39c1e82'
  })

  depends_on 'libarchive'
  depends_on 'gtk3'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'vala' => ':build'
  depends_on 'autoconf_archive' => ':build'

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
