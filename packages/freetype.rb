require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Freetype < Meson
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://freetype.org/'
  version '2.13.3-3' # Update freetype in harfbuzz when updating freetype
  license 'FTL or GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/freetype/freetype.git'
  git_hashtag "VER-#{version.split('-').first.tr('.', '-')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ba402f56625c658a74924fffbbe29df25e1b284855f5aaaab5de44590d99ed9',
     armv7l: '6ba402f56625c658a74924fffbbe29df25e1b284855f5aaaab5de44590d99ed9',
     x86_64: '7ec4b3693b46646e123728e0e199d1e793e4fdd92e93e8348bfaf10a898b6084'
  })

  depends_on 'brotli' # R
  depends_on 'bzip2' # R
  depends_on 'expat' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :build
  depends_on 'glibc' # R
  depends_on 'graphite' => :build
  depends_on 'harfbuzz' # R
  depends_on 'libpng' # R
  depends_on 'pcre' => :build
  depends_on 'py3_docwriter' => :build
  depends_on 'zlib' # R

  conflicts_ok # Allow overwriting of harfbuzz freetype files.

  meson_options '-Dharfbuzz=enabled'
end
