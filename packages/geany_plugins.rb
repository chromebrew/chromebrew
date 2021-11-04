require 'package'

class Geany_plugins < Package
  description 'Geany plugins.'
  homepage 'https://www.geany.org/'
  version '1.38.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/geany/geany-plugins.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/1.38.0_armv7l/geany_plugins-1.38.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/1.38.0_armv7l/geany_plugins-1.38.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/1.38.0_x86_64/geany_plugins-1.38.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '61dafd4420585ddbf5678f27444a816a8f2fd1b0b88fb3ebc8bd2948758a05c9',
     armv7l: '61dafd4420585ddbf5678f27444a816a8f2fd1b0b88fb3ebc8bd2948758a05c9',
     x86_64: 'bba7bc28ddf7d47e8ccb0a071adca60528231f253a84a3e5650a4322b4815f88'
  })

  depends_on 'libgit2' => :build
  depends_on 'valgrind' => :build
  depends_on 'enchant' # R
  depends_on 'geany' # R
  depends_on 'libsoup2' # R
  depends_on 'webkit2gtk_4' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system " #{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
