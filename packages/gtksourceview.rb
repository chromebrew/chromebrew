require 'package'

class Gtksourceview < Package
  description 'Source code editing widget'
  homepage 'https://wiki.gnome.org/Projects/GtkSourceView'
  @_ver = '4.8.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/GNOME/gtksourceview/archive/#{@_ver}.tar.gz"
  source_sha256 'dade8ff4ee6e0574af518cddbcde752739e73d346178baf4381e4d9d422b420a'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview-4.8.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview-4.8.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview-4.8.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview-4.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '8f730dc093a598c27fcff1967eb22e1ca0a9e57cf352d00c28570224decd5be6',
      armv7l: '8f730dc093a598c27fcff1967eb22e1ca0a9e57cf352d00c28570224decd5be6',
        i686: 'c43453cd39857420d5d0f3fc7b14e54e3a9231bb546f4a65a530bd25d93e39af',
      x86_64: 'dec3b93f94494360f8d1011c595f1dec98c5359a28dc557a5da1014acf4c2e71',
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
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
