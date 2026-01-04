require 'buildsystems/meson'

class Fcft < Meson
  description 'Simple library for font loading and glyph rasterization using FontConfig, FreeType and pixman.'
  homepage 'https://codeberg.org/dnkl/fcft'
  version '3.3.3'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://codeberg.org/dnkl/fcft.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0b74dcc7e12e4bb04bf05605460cd12b965db3a65c812db143407d96a2ef9326',
     armv7l: '0b74dcc7e12e4bb04bf05605460cd12b965db3a65c812db143407d96a2ef9326',
     x86_64: '162af7bdfc86bf20825894a8c81ccfa3fcfdd32ed763747ba15f24d255376667'
  })

  depends_on 'check' => :build
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'pixman' # R
  depends_on 'scdoc' => :build
  depends_on 'tllist' => :build
  depends_on 'utf8proc' # R

  def self.patch
    # threads.h was introduced in glibc 2.28. This is a workaround for pre-M92 systems.
    downloader 'https://github.com/jtsiomb/c11threads/raw/19abeee43272002301ddece2f7d5df37394bb54f/c11threads.h', 'c945fd352449174d3b6107c715b622206ebb81694ac23239637439d78e33ee5a', 'threads.h' if LIBC_VERSION < '2.28'
  end

  meson_options '-Drun-shaping=enabled'
  run_tests
end
