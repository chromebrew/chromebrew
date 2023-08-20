require 'buildsystems/autotools'

class Less < Autotools
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '643'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url 'https://greenwoodsoftware.com/less/less-643.tar.gz'
  source_sha256 '2911b5432c836fa084c8a2e68f6cd6312372c026a58faaa98862731c8b6052e8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/643_armv7l/less-643-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/643_armv7l/less-643-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/643_i686/less-643-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/643_x86_64/less-643-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6e958b939677a30fd4347e8db4e7f46e3447ef2a2f463ebb41c52bee1928638d',
     armv7l: '6e958b939677a30fd4347e8db4e7f46e3447ef2a2f463ebb41c52bee1928638d',
       i686: '4de79c5cd2cb1fa4e14c6cb66773feae644304bade9116b69ade4ceac3ba9d31',
     x86_64: '85503b71e6e29572bda314befb6c06f8ee451dd0373d28a47cbbf2773fcef3ef'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'gcc_lib' # R
  depends_on 'patch' => :build

  configure_options '--with-regex=posix'

  def self.patch
    downloader 'https://patch-diff.githubusercontent.com/raw/gwsw/less/pull/412.diff',
               'feb65b74b27a58e4acdf4efa27d65ab4f79cb5e8a02b9ddffb33b3571828c131'
    system 'patch -Np1 -i 412.diff'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/less", <<~LESS_ENV_EOF
      LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4 --use-color'
    LESS_ENV_EOF
  end
end
