require 'package'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/wiki/Software/fontconfig/'
  @_ver = '2.14.2'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/fontconfig/fontconfig.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9be6e2ad2bae395de354b1a1daad812a60bf0706fe429aa6eb3c50ac16de4001',
     armv7l: '9be6e2ad2bae395de354b1a1daad812a60bf0706fe429aa6eb3c50ac16de4001',
     x86_64: '312be51a3f24e688489a30efaf61027d257998814be2fd670d403b0a88d5e818'
  })

  depends_on 'expat' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'graphite' => :build
  depends_on 'harfbuzz' # R
  depends_on 'jsonc' => :build
  depends_on 'libpng' => :build
  depends_on 'util_linux' => :build

  no_fhs

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
      --wrap-mode=default \
      -Dlocalstatedir=#{CREW_PREFIX}/cache \
      -Dtests=disabled \
      builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    # The following are included in the libpng package.
    FileUtils.rm Dir["#{CREW_DEST_LIB_PREFIX}/libpng*"]
    FileUtils.rm Dir["#{CREW_DEST_PREFIX}/include/libpng16/png*"]
    FileUtils.rm Dir["#{CREW_DEST_LIB_PREFIX}/pkgconfig/libpng*"]
  end
end
