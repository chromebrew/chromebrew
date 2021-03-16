require 'package'

class Gtksourceview < Package
  description 'Source code editing widget'
  homepage 'https://wiki.gnome.org/Projects/GtkSourceView'
  @_ver = '4.8.1'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/GNOME/gtksourceview/archive/#{@_ver}.tar.gz"
  source_sha256 'cbfde42161662525805be4a38102b085db5e991fe1263171a28a78c7da253760'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview-4.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview-4.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview-4.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview-4.8.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8847fb32a4b6b814dbe1f58cdc0487ab75c781daffca97ee1b965da1786b498b',
     armv7l: '8847fb32a4b6b814dbe1f58cdc0487ab75c781daffca97ee1b965da1786b498b',
       i686: '409401c64604dfd3f827cef4345c53415c3ff1c7af5f19b720ed5fb5bb3bdd11',
     x86_64: '8839be6b737b4555bddb5b6a9aaba47da81b7432c672b6b3b5c7ccf7a7a80ddb'
  })

  depends_on 'setuptools' => :build
  depends_on 'vala'
  depends_on 'gtk3'
  depends_on 'libsoup'
  depends_on 'glib'

  def self.build
    system "env CC=clang CXX=clang++ \
    meson #{CREW_MESON_OPTIONS} \
    -Db_asneeded=false \
    -Dc_args='-fno-stack-protector -flto=thin -fuse-ld=lld' \
    -Dc_link_args='-fno-stack-protector -flto=thin -fuse-ld=lld' \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
