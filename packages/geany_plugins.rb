require 'buildsystems/autotools'

class Geany_plugins < Autotools
  description 'Geany plugins.'
  homepage 'https://www.geany.org/'
  version "2.1.0-#{CREW_ICU_VER}"
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/geany/geany-plugins.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1647d8aa292289c0602385b5a36248724e752dabc28f8a86a37390692655ce3',
     armv7l: 'c1647d8aa292289c0602385b5a36248724e752dabc28f8a86a37390692655ce3',
     x86_64: '22b60f0b4fc73648c93d0807630b338eb3fcaa644f304314d10ad8269c29d4cf'
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
  depends_on 'libgit2' # R
  depends_on 'libsoup' # R
  depends_on 'libsoup2' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'pango' # R
  depends_on 'valgrind' => :build
  depends_on 'vte' # R
  depends_on 'webkit2gtk_4' # R
  depends_on 'zlib' # R

  # try to avoid gcc14 issues.
  # autotools_configure_options '--disable-projectorganizer'
end
