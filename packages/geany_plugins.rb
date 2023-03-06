require 'package'

class Geany_plugins < Package
  description 'Geany plugins.'
  homepage 'https://www.geany.org/'
  version 'a76f728'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/geany/geany-plugins.git'
  git_hashtag 'a76f728f52fe7d277f1c226a255c87a2cf6d8fe8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/a76f728_armv7l/geany_plugins-a76f728-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/a76f728_armv7l/geany_plugins-a76f728-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/a76f728_i686/geany_plugins-a76f728-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/a76f728_x86_64/geany_plugins-a76f728-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a0a8ec98c39432edcf7d17369b410e48878a45ac58206cf2e5cfd6da13946893',
     armv7l: 'a0a8ec98c39432edcf7d17369b410e48878a45ac58206cf2e5cfd6da13946893',
       i686: 'cb4786fcb33463aacee5c377fb5c9e2cb864408323fef68610c311c5c28ef4d9',
     x86_64: '410488ee35fefbd1e502ead3a67fde697ac48ee8a8ecd6de1217951db382e08a'
  })

  depends_on 'atk_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'enchant' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'geany' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libgit2' => :build
  depends_on 'libsoup2' # R
  depends_on 'pango' # R
  depends_on 'valgrind' => :build
  depends_on 'vte' # R
  depends_on 'webkit2gtk_4' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
