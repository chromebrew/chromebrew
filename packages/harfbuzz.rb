require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  @_ver = '3.0.0'
  version "#{@_ver}-1"
  license 'Old-MIT, ISC and icu'
  compatibility 'all'
  source_url 'https://github.com/harfbuzz/harfbuzz.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/3.0.0-1_armv7l/harfbuzz-3.0.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/3.0.0-1_armv7l/harfbuzz-3.0.0-1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/3.0.0-1_x86_64/harfbuzz-3.0.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1b8e95215f5147d297389f81831f27d33eb10d3bc8ef31e6efa4588b477d9d04',
     armv7l: '1b8e95215f5147d297389f81831f27d33eb10d3bc8ef31e6efa4588b477d9d04',
     x86_64: 'cd44acac570c86213ccb02a4da7ff4c2f60c26e12ca7e531e8210334a08166c2'
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
