require 'package'
# build order: harfbuzz => freetype => fontconfig => pango

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/wiki/Software/fontconfig/'
  version '2.14.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/fontconfig/fontconfig.git'
  git_hashtag version

  depends_on 'expat'
  depends_on 'jsonc'
  depends_on 'gperf'
  depends_on 'freetype'
  depends_on 'libpng'
  depends_on 'util_linux'
  depends_on 'graphite'

  no_fhs
  conflicts_ok # allowed to overwrite harfbuzz

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      --wrap-mode=default \
      -Dlocalstatedir=#{CREW_PREFIX}/cache \
      -Dtests=disabled \
      builddir"
    system 'meson configure builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    # The following are included the libpng package.
    FileUtils.rm Dir["#{CREW_DEST_LIB_PREFIX}/libpng*"]
    FileUtils.rm Dir["#{CREW_DEST_PREFIX}/include/libpng16/png*"]
    FileUtils.rm Dir["#{CREW_DEST_LIB_PREFIX}/pkgconfig/libpng*"]
  end
end
