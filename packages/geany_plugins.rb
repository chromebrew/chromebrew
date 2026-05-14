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
    aarch64: '84e76998715b2cbbe913617fda49fd58858aa543a534ae72d88392c9b37a0a39',
     armv7l: '84e76998715b2cbbe913617fda49fd58858aa543a534ae72d88392c9b37a0a39',
     x86_64: '2da60bcbe8f83b1efb8c6ba7e99ea3224c4dac8f352a7893d8061105c4c4e892'
  })

  depends_on 'aspell' => :library
  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'enchant' => :library
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :library
  depends_on 'geany' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libgit2' => :library
  depends_on 'libsoup' => :library
  depends_on 'libsoup2' # R
  depends_on 'libxml2' => :library
  depends_on 'ncurses' # R
  depends_on 'pango' => :library
  depends_on 'valgrind' => :build
  depends_on 'vte' => :library
  depends_on 'webkit2gtk_4' # R
  depends_on 'webkit2gtk_4_1' => :library
  depends_on 'zlib' => :library
end
