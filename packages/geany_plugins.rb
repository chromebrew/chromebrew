require 'buildsystems/autotools'

class Geany_plugins < Autotools
  description 'Geany plugins.'
  homepage 'https://www.geany.org/'
  version '2.0.0'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/geany/geany-plugins.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/2.0.0_armv7l/geany_plugins-2.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/2.0.0_armv7l/geany_plugins-2.0.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/2.0.0_x86_64/geany_plugins-2.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '712ed5e1737c8ae1bae903a36c182433ab01d829ec809e292d506fb1d9b2483f',
     armv7l: '712ed5e1737c8ae1bae903a36c182433ab01d829ec809e292d506fb1d9b2483f',
     x86_64: 'bd9e2dafbefab9bab849b93243ecc1e39174f0914267d3db55b7f1be5eda70cd'
  })

  depends_on 'aspell' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' => :build
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
  depends_on 'zlibpkg' # R
end
