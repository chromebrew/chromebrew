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
    aarch64: '126719a3825fe827bf771905be58e987c1f1c3df3b1f8beb1c8123965a59fb88',
     armv7l: '126719a3825fe827bf771905be58e987c1f1c3df3b1f8beb1c8123965a59fb88',
     x86_64: 'd8752eb82047e2324a2b5c430577ab3fa6f54951106bcac11f925df6e46cbaba'
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
