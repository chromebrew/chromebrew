require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  version '2.7.2-1'
  compatibility 'all'
  source_url 'https://github.com/harfbuzz/harfbuzz/releases/download/2.7.2/harfbuzz-2.7.2.tar.xz'
  source_sha256 'b8c048d7c2964a12f2c80deb6634dfc836b603dd12bf0d0a3df1627698e220ce'


#  depends_on 'cairo' => ':build'
  depends_on 'glib' => :build
  depends_on 'gobject_introspection' => ':build'
  depends_on 'ragel' => :build
  depends_on 'freetype_sub'
  depends_on 'six' => :build
  depends_on 'graphite' => :build

  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "meson",
      "-Dintrospection=enabled",
      "-Dbenchmark=disabled",
      "-Dtests=disabled",
      "-Dgraphite=enabled",
      "-Ddocs=disabled",
      "-Dprefix=#{CREW_PREFIX}",
      "-Dlibdir=#{CREW_LIB_PREFIX}",
      "-DLIB_INSTALL_DIR=#{CREW_LIB_PREFIX}",
      "-Dmandir=#{CREW_MAN_PREFIX}",
      "-DSYSCONFDIR=#{CREW_PREFIX}/etc",
      "-Ddatadir=#{CREW_LIB_PREFIX}",
      '-Dbuildtype=release',
      "builddir"
    system "meson compile -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} meson install -C builddir"
  end
end
