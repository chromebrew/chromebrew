require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Fontconfig < Meson
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/wiki/Software/fontconfig/'
  version '2.18.4'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/fontconfig/fontconfig.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ba38e333086fa265dc45483a7c0af0ecd15a369e534972301c04605e6818d341',
     armv7l: 'ba38e333086fa265dc45483a7c0af0ecd15a369e534972301c04605e6818d341',
     x86_64: '676e91bd09e7a7271c715237b98be2d39d7c3bd52b928d5f2f6b58e2b3cec291'
  })

  depends_on 'expat' => :library
  depends_on 'freetype' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gperf' => :build
  depends_on 'graphite' => :build
  depends_on 'harfbuzz' => :executable
  depends_on 'json_c' => :build
  depends_on 'libpng' => :build
  depends_on 'util_linux' => :build

  conflicts_ok # Allow overwriting harfbuzz files.
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
