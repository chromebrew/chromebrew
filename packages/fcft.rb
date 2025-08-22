require 'buildsystems/meson'

class Fcft < Meson
  description 'Simple library for font loading and glyph rasterization using FontConfig, FreeType and pixman.'
  homepage 'https://codeberg.org/dnkl/fcft'
  version '3.3.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://codeberg.org/dnkl/fcft.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6937b8eebd922e2447aa1d6f76a1ec53b68617fed21674b2edfedddc6765ef8e',
     armv7l: '6937b8eebd922e2447aa1d6f76a1ec53b68617fed21674b2edfedddc6765ef8e',
     x86_64: '3a9fd4e0d4a64e2203cc059ecbfa0049a332eb2174b83b63df2344ef0369bb1e'
  })

  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'glibc' # R
  depends_on 'harfbuzz'
  depends_on 'pixman'
  depends_on 'tllist' => :build
  depends_on 'utf8proc'

  def self.patch
    # threads.h was introduced in glibc 2.28. This is a workaround for pre-M92 systems.
    downloader 'https://github.com/jtsiomb/c11threads/raw/19abeee43272002301ddece2f7d5df37394bb54f/c11threads.h', 'c945fd352449174d3b6107c715b622206ebb81694ac23239637439d78e33ee5a', 'threads.h' if LIBC_VERSION < '2.28'
  end

  meson_options '-Drun-shaping=enabled'
  run_tests
end
