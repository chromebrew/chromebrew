require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  @_ver = '3.0.0'
  version @_ver
  license 'Old-MIT, ISC and icu'
  compatibility 'all'
  source_url 'https://github.com/harfbuzz/harfbuzz.git'
  git_hashtag @_ver

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/3.0.0_x86_64/harfbuzz-3.0.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    x86_64: '3e087664cdf7d74ffcccff126c8b37f922168f2d25a5807bd8ac2e809028965d'
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
