require 'package'

class Gfbgraph < Package
  description 'GLib/GObject wrapper for the Facebook Graph API'
  homepage 'https://wiki.gnome.org/Projects/GFBGraph'
  @_ver = '0.2.4'
  @_ver_ = @_ver.gsub(/[.]/, '_')
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/libgfbgraph/-/archive/v_#{@_ver_}/libgfbgraph-v_#{@_ver_}.tar.bz2"
  source_sha256 'e55bb497daabfcd7e68e216ac5c695f03319f660ff524d0b6659e42089853516'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gfbgraph-0.2.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gfbgraph-0.2.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gfbgraph-0.2.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gfbgraph-0.2.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '883a3eb50bf0fd391333759913e20c4211f5f31a1a3002b7b900019b234b211d',
     armv7l: '883a3eb50bf0fd391333759913e20c4211f5f31a1a3002b7b900019b234b211d',
       i686: 'd24bf537935fc54b130db1b13ea113c24370553b82dc26dcadc323a8a8193113',
     x86_64: '560bd5f25612d861a0daea31a7547a0d8d18e42a9d21bcd7960dceef1b3ca7b5'
  })

  depends_on 'gnome_online_accounts'
  depends_on 'rest' => ':build'
  depends_on 'json_glib' => ':build'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system './configure --help'
    system "env CFLAGS='-pipe -flto=auto' \
    CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
    ./configure #{CREW_OPTIONS} \
    --enable-gtk-doc \
    --enable-introspection"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install \
    libgfbgraphdocdir=#{CREW_PREFIX}/share/doc/gfbgraph"
  end
end
