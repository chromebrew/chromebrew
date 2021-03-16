require 'package'

class Rest < Package
  description 'Helper library for RESTful services'
  homepage 'https://wiki.gnome.org/Projects/Librest'
  @_ver = '0.8.1'
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/librest/-/archive/#{@_ver}/librest-#{@_ver}.tar.bz2"
  source_sha256 '9063b9906c3a4684bef6ccaad9462e8409e1025fe37b7c9596fcf2f5f7507904'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rest-0.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rest-0.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rest-0.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rest-0.8.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9e9f407b296703cce2260663f12a127624f902a8fa7067c1ea83d7f715212568',
     armv7l: '9e9f407b296703cce2260663f12a127624f902a8fa7067c1ea83d7f715212568',
       i686: '757861d1fd4858d29ca86e22c1ae8bacfcecc4bc59aecd736ae0045bc656bafa',
     x86_64: '237b71fe2489903b4305728e922bdd1756d80d76629a4c37ae039ced34b1f0c0'
  })

  depends_on 'glib'
  depends_on 'libsoup'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' \
      CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --sysconfdir=#{CREW_PREFIX}/etc \
      --enable-gtk-doc"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
