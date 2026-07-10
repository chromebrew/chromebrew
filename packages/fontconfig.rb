require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Fontconfig < Meson
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/wiki/Software/fontconfig/'
  version '2.18.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/fontconfig/fontconfig.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '39e74151fdbc777eab1583743e52e2f12562a6522c22d8b9d9a6b6021cdee704',
     armv7l: '39e74151fdbc777eab1583743e52e2f12562a6522c22d8b9d9a6b6021cdee704',
     x86_64: '763e629ff7d07cd811dc276ff1c06e859a7547312f3066b8da620745818281dc'
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
