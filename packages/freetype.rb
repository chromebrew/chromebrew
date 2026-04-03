require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Freetype < Meson
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://freetype.org/'
  version '2.14.3' # Update freetype in harfbuzz when updating freetype
  license 'FTL or GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/freetype/freetype.git'
  git_hashtag "VER-#{version.split('-').first.tr('.', '-')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '377dbd0b0817a7fc2bf4c15274f25568f14458bf53fe28c5e2b47a21eebee0df',
     armv7l: '377dbd0b0817a7fc2bf4c15274f25568f14458bf53fe28c5e2b47a21eebee0df',
     x86_64: 'ba3713b19ac36215e5c251796b80b971163d11806d01ec382937d2445d8faae2'
  })

  depends_on 'brotli' => :library
  depends_on 'bzip2' => :library
  depends_on 'expat' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :build
  depends_on 'glibc' => :library
  depends_on 'graphite' => :build
  depends_on 'harfbuzz' => :logical
  depends_on 'libpng' => :library
  depends_on 'pcre' => :build
  depends_on 'py3_docwriter' => :build
  depends_on 'zlib' => :library

  conflicts_ok # Allow overwriting of harfbuzz freetype files.

  meson_options '-Dharfbuzz=dynamic'
end
