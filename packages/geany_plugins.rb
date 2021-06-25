require 'package'

class Geany_plugins < Package
  description 'Geany plugins.'
  homepage 'https://www.geany.org/'
  version '1.37-7c54'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/geany/geany-plugins.git'
  git_hashtag '7c540bf347d0f0c6f6ab5123fa8f226b2f9152ee'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/1.37-7c54_armv7l/geany_plugins-1.37-7c54-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/1.37-7c54_armv7l/geany_plugins-1.37-7c54-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany_plugins/1.37-7c54_x86_64/geany_plugins-1.37-7c54-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '746ecbc8c162e5407a43f64998b5d60f03555b2335d7c626ffc8a59152b9c394',
     armv7l: '746ecbc8c162e5407a43f64998b5d60f03555b2335d7c626ffc8a59152b9c394',
     x86_64: '99640a4c250c27ff315ce2184bdd6b6608f9109bc9df80868f5a0fb586ecc0b2'
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

  # def self.check
  #   system 'make', 'check'
  # end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
