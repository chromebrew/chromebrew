require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Fontconfig < Meson
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/wiki/Software/fontconfig/'
  version '2.15.0-1'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/fontconfig/fontconfig.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db4ecc4a5e66ec68761a21f1112867d185712e337514928ca93dc40ba7e386e6',
     armv7l: 'db4ecc4a5e66ec68761a21f1112867d185712e337514928ca93dc40ba7e386e6',
     x86_64: '522fd2617e68a7fb67502c36b1accdf8ada922b895c8ab767a9fb36a69eb2585'
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
