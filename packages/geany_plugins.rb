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
    aarch64: 'bfc23b06fab6e5ae40b1953fa97a3dad60fdb68b39d831f1fa81e66aa6881bde',
     armv7l: 'bfc23b06fab6e5ae40b1953fa97a3dad60fdb68b39d831f1fa81e66aa6881bde',
     x86_64: 'cc817de7a91b6a145e94c9699ecfd18cb5c8fdd10f03a0fe04a555d3a8792339'
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
end
