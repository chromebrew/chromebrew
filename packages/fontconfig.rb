require 'package'
# build order: harfbuzz => freetype => fontconfig => pango

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/wiki/Software/fontconfig/'
  @_ver = '2.14.2'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/fontconfig/fontconfig.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.2-1_armv7l/fontconfig-2.14.2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.2-1_armv7l/fontconfig-2.14.2-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.2-1_x86_64/fontconfig-2.14.2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '068ccfd54a46300954f2a2039de20aead107667687ca3a81ae91b01f70d0de16',
     armv7l: '068ccfd54a46300954f2a2039de20aead107667687ca3a81ae91b01f70d0de16',
     x86_64: '2730435746090bf3504d79ad00cd923707902e0253a2ba5c203154d411e35d0d'
  })

  depends_on 'expat' # R
  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'graphite' => :build
  depends_on 'harfbuzz' # R
  depends_on 'jsonc' => :build
  depends_on 'libpng' => :build
  depends_on 'util_linux' => :build

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
    # The following are included in the libpng package.
    FileUtils.rm Dir["#{CREW_DEST_LIB_PREFIX}/libpng*"]
    FileUtils.rm Dir["#{CREW_DEST_PREFIX}/include/libpng16/png*"]
    FileUtils.rm Dir["#{CREW_DEST_LIB_PREFIX}/pkgconfig/libpng*"]
  end
end
