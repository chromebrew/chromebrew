require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  @_ver = '2.7.4'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/harfbuzz/harfbuzz/archive/#{@_ver}.tar.gz"
  source_sha256 'daff8a4003ac420a8550760ed303ce33b310c8ea17b7f15b307d1969cabcebcb'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-2.7.4-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-2.7.4-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-2.7.4-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-2.7.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'a2cc6f26453bc9077dde0d549ea92e30a8847d9c9d49ceebc681b090056d69fc',
      armv7l: 'a2cc6f26453bc9077dde0d549ea92e30a8847d9c9d49ceebc681b090056d69fc',
        i686: 'a98df51edf04334872597256379d041389fce9bf3b020c5700ee4d0b8771967d',
      x86_64: 'bdcb5b9ab85752b8f8ce46b919e6739754e369fd807a5f52d85afb43ca815153',
  })

  depends_on 'cairo' => ':build'
  depends_on 'glib' => :build
  depends_on 'gobject_introspection'
  depends_on 'ragel' => :build
  depends_on 'freetype_sub'
  depends_on 'six' => :build
  depends_on 'graphite' => :build

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    --default-library=both \
    -Dintrospection=enabled \
    -Dbenchmark=disabled \
    -Dtests=disabled \
    -Dgraphite=enabled \
    -Ddocs=disabled \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja install -C builddir"
  end
end
