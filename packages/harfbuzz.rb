require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  @_ver = '2.8.2'
  version @_ver
  license 'Old-MIT, ISC and icu'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/harfbuzz/harfbuzz.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/2.8.2_armv7l/harfbuzz-2.8.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/2.8.2_armv7l/harfbuzz-2.8.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/2.8.2_x86_64/harfbuzz-2.8.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b5161044e1976ac2ed7fcc59c7ed1a1539530c6695cb84f1efdd33b1c7b55a97',
     armv7l: 'b5161044e1976ac2ed7fcc59c7ed1a1539530c6695cb84f1efdd33b1c7b55a97',
     x86_64: 'ab4f370493d031b21c1fbe58575096eb3616c84d824bbed5c7dfe9e3bdfd05f0'
  })

  depends_on 'cairo' => :build
  depends_on 'chafa' => :build
  depends_on 'glib' => :build
  depends_on 'gobject_introspection'
  depends_on 'ragel' => :build
  depends_on 'freetype_sub' => :build
  depends_on 'six' => :build
  depends_on 'graphite' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    --default-library=both \
    -Dfreetype=enabled \
    -Dintrospection=enabled \
    -Dbenchmark=disabled \
    -Dtests=disabled \
    -Dgraphite=enabled \
    -Ddocs=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja install -C builddir"
  end
end
