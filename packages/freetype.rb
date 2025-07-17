require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Freetype < Meson
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://freetype.org/'
  version '2.13.3-2' # Update freetype in harfbuzz when updating freetype
  license 'FTL or GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/freetype/freetype.git'
  git_hashtag "VER-#{version.split('-').first.tr('.', '-')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '409963301f95f91375396561a7c0a53168ea911b353d8cf45a4ff31bef951afd',
     armv7l: '409963301f95f91375396561a7c0a53168ea911b353d8cf45a4ff31bef951afd',
     x86_64: '2d36d487c1a768c3e808c15cc9ab277bde512ae66828b8db0a3a817e7267332c'
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

  meson_options '-Dharfbuzz=enabled'
end
