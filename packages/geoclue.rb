require 'package'

class Geoclue < Package
  description 'Modular geoinformation service built on the D-Bus messaging system'
  homepage 'https://www.freedesktop.org/wiki/Software/GeoClue/'
  @_ver = '2.5.7'
  version "#{@_ver}-1"
  license 'LGPL-2.1 and GPL-2+'
  compatibility 'all'
  source_url "https://gitlab.freedesktop.org/geoclue/geoclue/-/archive/#{@_ver}/geoclue-#{@_ver}.tar.bz2"
  source_sha256 '6cc7dbe4177b4e7f3532f7fe42262049789a3cd6c55afe60a3564d7394119c27'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '8208222a9240c0d90afaac07a4111ad27e5b02f9ea3ba55211278440f065dad2',
     armv7l: '8208222a9240c0d90afaac07a4111ad27e5b02f9ea3ba55211278440f065dad2',
       i686: '17377ae86e1205882121acc6fd1beee159ff0a4d090b2081dfa6582d73248ba2',
     x86_64: '214403eb81cd51b173365be83577e79b3f30266941f54f8ceec7659565d3cba8'
  })

  depends_on 'libsoup'
  depends_on 'json_glib'
  depends_on 'avahi'
  depends_on 'geocode_glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libnotify' => :build
  depends_on 'modemmanager'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dsystemd=disabled \
      -Ddbus-sys-dir=#{CREW_PREFIX}/share/dbus-1 \
      -D3g-source=true \
      -Dcdma-source=false \
      -Dmodem-gps-source=true \
      builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
