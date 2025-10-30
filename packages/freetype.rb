require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Freetype < Meson
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://freetype.org/'
  version '2.14.1' # Update freetype in harfbuzz when updating freetype
  license 'FTL or GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/freetype/freetype.git'
  git_hashtag "VER-#{version.split('-').first.tr('.', '-')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a4a2c88f5841abccd759c1a5868a82f58b9131c5d6db8f6d76cc371d423f4fb',
     armv7l: '2a4a2c88f5841abccd759c1a5868a82f58b9131c5d6db8f6d76cc371d423f4fb',
     x86_64: '8f4bc29413c19bf54e506f26b818856974d47051fc580de6c247ac0ed999b0d6'
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
