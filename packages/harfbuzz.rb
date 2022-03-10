require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  @_ver = '4.0.0'
  version @_ver
  license 'Old-MIT, ISC and icu'
  compatibility 'all'
  source_url 'https://github.com/harfbuzz/harfbuzz.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.0.0_armv7l/harfbuzz-4.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.0.0_armv7l/harfbuzz-4.0.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.0.0_i686/harfbuzz-4.0.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.0.0_x86_64/harfbuzz-4.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '45c23425ee8a671df2f26dd8db51962b5a9de734042ae54431a6504339ffc049',
     armv7l: '45c23425ee8a671df2f26dd8db51962b5a9de734042ae54431a6504339ffc049',
       i686: 'fe23c57f63f0fd9d03cd8679076d0aa6aeb0db9880efd1099814385fe53c878f',
     x86_64: 'c9ad1d2c137cfa65efcfbc855fc6b2a616130653d18ff730b53ece6676513a44'
  })

  # provides libpng, freetype (sans harfbuzz), and ragel
  # depends_on 'cairo' => :build (cairo is only needed for tests and tools)
  depends_on 'brotli'
  depends_on 'bz2'
  depends_on 'chafa'
  depends_on 'gcc11'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'graphite'
  depends_on 'icu4c'
  depends_on 'libffi'
  depends_on 'pcre'
  depends_on 'py3_six' => :build
  depends_on 'zlibpkg'
  no_env_options

  def self.patch
    # Update to new versions of freetype as they come out.
    system "sed -i 's,revision=VER-2-11-0,revision=VER-2-11-1,g' subprojects/freetype2.wrap"
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      --wrap-mode=default \
      --default-library=both \
      -Dbenchmark=disabled \
      -Dcairo=disabled \
      -Ddocs=disabled \
      -Dfreetype=enabled \
      -Dgraphite2=enabled \
      -Dintrospection=enabled \
      -Dragel_subproject=true \
      -Dtests=disabled \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja install -C builddir"
  end
end
