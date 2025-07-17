require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Fontconfig < Meson
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/wiki/Software/fontconfig/'
  version '2.17.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/fontconfig/fontconfig.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8d53e4f93e3a6a3df19d6cdcbc8199f2d4369e34114f086f37c6e1ba7f5e57a9',
     armv7l: '8d53e4f93e3a6a3df19d6cdcbc8199f2d4369e34114f086f37c6e1ba7f5e57a9',
     x86_64: 'c24d54ab1773584d35a1b459872ca93122e8c24e87f4c19e61849afa2ce407c3'
  })

  depends_on 'expat' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'graphite' => :build
  depends_on 'harfbuzz' # R
  depends_on 'json_c' => :build
  depends_on 'libpng' => :build
  depends_on 'util_linux' => :build

  no_fhs

  meson_options "--wrap-mode=default \
      -Dlocalstatedir=#{CREW_PREFIX}/cache \
      -Dtests=disabled"

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    # The following are included in the libpng package.
    FileUtils.rm Dir["#{CREW_DEST_LIB_PREFIX}/libpng*"]
    FileUtils.rm Dir["#{CREW_DEST_PREFIX}/include/libpng16/png*"]
    FileUtils.rm Dir["#{CREW_DEST_LIB_PREFIX}/pkgconfig/libpng*"]
  end
end
