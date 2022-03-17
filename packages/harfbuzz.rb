require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  @_ver = '4.0.0'
  version "#{@_ver}-2"
  license 'Old-MIT, ISC and icu'
  compatibility 'all'
  source_url 'https://github.com/harfbuzz/harfbuzz.git'
  git_hashtag @_ver

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
  depends_on 'libpng'
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
