require 'package'

class Geany_plugins < Package
  description 'Geany plugins.'
  homepage 'https://www.geany.org/'
  version '1.38-3ac62e2'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/geany/geany-plugins.git'
  git_hashtag '3ac62e2c81cba1fe59d7fae1db8ea910367cd589'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/1.38-3ac62e2_armv7l/geany_plugins-1.38-3ac62e2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/1.38-3ac62e2_armv7l/geany_plugins-1.38-3ac62e2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/1.38-3ac62e2_x86_64/geany_plugins-1.38-3ac62e2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e43377ce7d8d200eb58350772e7d2132edbe84d9d10390a1ba95ae04d037cd40',
     armv7l: 'e43377ce7d8d200eb58350772e7d2132edbe84d9d10390a1ba95ae04d037cd40',
     x86_64: '4aa9fbe81d1d637979a6b112c4f3eedf23170fa4f78f2aed3f7a7a17d3625ef2'
  })

  depends_on 'aspell' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' => :build
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

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "mold -run ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
