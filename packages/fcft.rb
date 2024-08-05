require 'buildsystems/meson'

class Fcft < Meson
  description 'Simple library for font loading and glyph rasterization using FontConfig, FreeType and pixman.'
  homepage 'https://codeberg.org/dnkl/fcft'
  version '3.1.8'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://codeberg.org/dnkl/fcft.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '10ec6f7c3f479908abeadc26c8793045f8da58660ffb79b687cd02130e0d72c4',
     armv7l: '10ec6f7c3f479908abeadc26c8793045f8da58660ffb79b687cd02130e0d72c4',
     x86_64: '9d2722efa27cbd6ff90e96d4571e2a0aba2204f060e3d237bd9823aa9719a96e'
  })

  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'harfbuzz'
  depends_on 'pixman'
  depends_on 'tllist' => :build
  depends_on 'utf8proc'

  def self.patch
    # threads.h was introduced in glibc 2.28. This is a workaround for pre-M92 systems.
    Downloader.download 'https://github.com/jtsiomb/c11threads/raw/19abeee43272002301ddece2f7d5df37394bb54f/c11threads.h', 'c945fd352449174d3b6107c715b622206ebb81694ac23239637439d78e33ee5a', 'threads.h' if LIBC_VERSION < '2.28'
  end

  meson_options '-Drun-shaping=enabled'
  run_tests
end
