# Adapted from Arch Linux libdbusmenu PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libdbusmenu/trunk/PKGBUILD

require 'package'

class Libdbusmenu_gtk3 < Package
  description 'Library for passing menus over DBus'
  homepage 'https://launchpad.net/libdbusmenu'
  version '16.04.0'
  license 'GPL3 LGPL2.1 LGPL3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'git://git.launchpad.net/ubuntu/+source/libdbusmenu'
  git_hashtag 'a3658f1208c31b1fb03b71af6e49c01119ba52fd'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '1b83ca1cf073b97d68d5f3a69dc587b7bb9019ed85c64c3186a66586f943eb7d',
     armv7l: '1b83ca1cf073b97d68d5f3a69dc587b7bb9019ed85c64c3186a66586f943eb7d',
     x86_64: '15883cf528411d88b1ddfed31cc34432ef405fb0ebaedd436861ccc70a3510ec'
  })

  depends_on 'gnome_common'
  depends_on 'gobject_introspection'
  depends_on 'gtk2'
  depends_on 'gtk3'
  depends_on 'intltool'
  depends_on 'vala'

  def self.patch
    system 'NOCONFIGURE=1 ./autogen.sh'
  end

  def self.build
    system "#{CREW_ENV_OPTIONS.sub("CFLAGS='", "CFLAGS='-Wno-deprecated-declarations ")} \
    ./configure \
    #{CREW_OPTIONS} \
    --localstatedir=#{CREW_PREFIX}/var \
    --sysconfdir=#{CREW_PREFIX}/etc \
    --with-gtk=3"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
