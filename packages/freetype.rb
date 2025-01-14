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
    aarch64: '63afea47d59e5221772faf88a792d747b04b8400452662b6148048c8be665661',
     armv7l: '63afea47d59e5221772faf88a792d747b04b8400452662b6148048c8be665661',
     x86_64: 'f4ebde77f9bfd77c56a7a69e3bfd56d86482355b67b5043bd09b4aa8a2df3347'
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

  def self.postbuild
    # Remove freetype files that conflict with the harfbuzz package.
    FileUtils.rm_rf "#{CREW_DEST_LIB_PREFIX}/pkgconfig/freetype2.pc"
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/share/aclocal/freetype2.m4"
  end
end
