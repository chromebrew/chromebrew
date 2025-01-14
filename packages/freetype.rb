require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Freetype < Meson
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://freetype.org/'
  version '2.13.3-1' # Update freetype in harfbuzz when updating freetype
  license 'FTL or GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/freetype/freetype.git'
  git_hashtag "VER-#{version.split('-').first.tr('.', '-')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cfe640869c0b399adc091b60da318e829f5df9f73c2b8b50f839459704aa401f',
     armv7l: 'cfe640869c0b399adc091b60da318e829f5df9f73c2b8b50f839459704aa401f',
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
