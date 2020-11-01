require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  version '2.7.2-1'
  compatibility 'all'
  source_url 'https://github.com/harfbuzz/harfbuzz/releases/download/2.7.2/harfbuzz-2.7.2.tar.xz'
  source_sha256 'b8c048d7c2964a12f2c80deb6634dfc836b603dd12bf0d0a3df1627698e220ce'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-2.7.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-2.7.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-2.7.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-2.7.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '693c5d740740dd7d0f6fa8c4174e9e88bda3a78dfab5d337c697085d06845c02',
     armv7l: '693c5d740740dd7d0f6fa8c4174e9e88bda3a78dfab5d337c697085d06845c02',
       i686: '7a839ce95a8cec41dda138b3545b189c558c34a6a96e1a8b3b65850e23b557e0',
     x86_64: '4e22014938782e9ea806d73580a2d31c75acfd69d6c2302795e034545003ffc9',
  })

  depends_on 'cairo' => ':build'
  depends_on 'glib' => :build
  depends_on 'gobject_introspection'
  depends_on 'ragel' => :build
  depends_on 'freetype_sub'
  depends_on 'six' => :build
  depends_on 'graphite' => :build

  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "meson #{CREW_MESON_OPTIONS} -Dintrospection=enabled -Dbenchmark=disabled -Dtests=disabled -Dgraphite=enabled -Ddocs=disabled builddir"
    system "meson compile -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} meson install -C builddir"
  end
end
