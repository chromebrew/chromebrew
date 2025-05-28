require 'buildsystems/autotools'

class Geany_plugins < Autotools
  description 'Geany plugins.'
  homepage 'https://www.geany.org/'
  version "2.0.0-#{CREW_ICU_VER}"
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/geany/geany-plugins.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59df5d161cebaef8831a1147adfdef7c28580d2c6cb0201ec3f9fe24141d8b27',
     armv7l: '59df5d161cebaef8831a1147adfdef7c28580d2c6cb0201ec3f9fe24141d8b27',
     x86_64: 'a1e96bedcad6e4417dc2dbe3086688ff6ff1532ce2d799dcd83212c23c8fddb5'
  })

  depends_on 'aspell' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'enchant' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'geany' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'libgit2' # R
  depends_on 'libsoup2' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'pango' # R
  depends_on 'valgrind' => :build
  depends_on 'vte' # R
  depends_on 'webkit2gtk_4' # R
  depends_on 'zlib' # R

  # try to avoid gcc14 issues.
  autotools_configure_options '--disable-projectorganizer'
end
