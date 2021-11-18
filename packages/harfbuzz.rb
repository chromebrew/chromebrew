require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  @_ver = '3.1.1'
  version @_ver
  license 'Old-MIT, ISC and icu'
  compatibility 'all'
  source_url 'https://github.com/harfbuzz/harfbuzz.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/3.1.1_armv7l/harfbuzz-3.1.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/3.1.1_armv7l/harfbuzz-3.1.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/3.1.1_i686/harfbuzz-3.1.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/3.1.1_x86_64/harfbuzz-3.1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '36fa3b23aa11ec3aee2cebef48edf3fc5b82b5c74bb56ec4889717c6981bde62',
     armv7l: '36fa3b23aa11ec3aee2cebef48edf3fc5b82b5c74bb56ec4889717c6981bde62',
       i686: 'd1419bdd44a8b7673a78b20c98fe5d454b464f59124e196af09f5e5e12d88959',
     x86_64: '06a8f9366cec6772f2a9d2ab3da03402f46e1fa768a9b60bc3fd0d5ac0c0e167'
  })

  depends_on 'cairo' => :build
  depends_on 'chafa' => :build
  depends_on 'glib' => :build
  depends_on 'gobject_introspection'
  depends_on 'ragel' => :build
  depends_on 'freetype_sub'
  depends_on 'py3_six' => :build
  depends_on 'graphite' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    --default-library=both \
    -Dintrospection=enabled \
    -Dbenchmark=disabled \
    -Dtests=disabled \
    -Dgraphite2=enabled \
    -Dfreetype=enabled \
    -Dragel_subproject=true \
    -Ddocs=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja install -C builddir"
  end
end
