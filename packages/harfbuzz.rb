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
    aarch64: 'fd912abd074e585e83fd13ae01cc5b816be8571bac45e0a3b026788456fae979',
     armv7l: 'fd912abd074e585e83fd13ae01cc5b816be8571bac45e0a3b026788456fae979',
       i686: '090fb8f6bac5538b809c64c49a1b57c39f14ad958f222899f5201e93f9d85271',
     x86_64: '41222eb56ead7816f86ed6bb70f710c78799f140c699604d3385cc8b970f79d0'
  })

  # provides libpng, freetype (sans harfbuzz), and ragel
  # depends_on 'cairo' => :build (cairo is only needed for tests and tools)
  depends_on 'chafa' => :build
  depends_on 'glib' => :build
  depends_on 'gobject_introspection'
  depends_on 'py3_six' => :build
  depends_on 'graphite' => :build
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
