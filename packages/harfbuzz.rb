require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  @_ver = '2.8.1'
  version @_ver
  license 'Old-MIT, ISC and icu'
  compatibility 'all'
  source_url "https://github.com/harfbuzz/harfbuzz/archive/#{@_ver}.tar.gz"
  source_sha256 'b3f17394c5bccee456172b2b30ddec0bb87e9c5df38b4559a973d14ccd04509d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/2.8.1_armv7l/harfbuzz-2.8.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/2.8.1_armv7l/harfbuzz-2.8.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/2.8.1_i686/harfbuzz-2.8.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/2.8.1_x86_64/harfbuzz-2.8.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f39e2aba4445d71c63a6602650590d8c5463a5c093b3ec26933e2963dc354dcc',
     armv7l: 'f39e2aba4445d71c63a6602650590d8c5463a5c093b3ec26933e2963dc354dcc',
       i686: '25e7c49b04e81fa61db4385d4033b6b2c633bdfe5ef2a5ab3606c970ad4b307d',
     x86_64: '801f46cbab0369087004aa3ce7952fc4d7754a85a0cb3c4b0648ce647fc87604'
  })

  depends_on 'cairo' => :build
  depends_on 'glib' => :build
  depends_on 'gobject_introspection'
  depends_on 'ragel' => :build
  depends_on 'freetype_sub'
  depends_on 'six' => :build
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
