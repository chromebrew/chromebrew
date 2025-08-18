require 'buildsystems/autotools'

class Less < Autotools
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '679'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url "https://www.greenwoodsoftware.com/less/less-#{version}.tar.gz"
  source_sha256 '9b68820c34fa8a0af6b0e01b74f0298bcdd40a0489c61649b47058908a153d78'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5dfafc18d4e38ed36f87f8e58a1203e8e7e91aa38f706d8440ba7a46b9e103c0',
     armv7l: '5dfafc18d4e38ed36f87f8e58a1203e8e7e91aa38f706d8440ba7a46b9e103c0',
       i686: '2d8081377113c05240aa8142be8420faf8ebdfc4aecbfd9eb3332416cd1658c4',
     x86_64: 'cacc7cae985e67d78c35aa7b51e1d98612b57fa9b83e36e52220d6ab07e84d00'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'patch' => :build

  autotools_configure_options '--with-regex=posix'

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/less", <<~LESS_ENV_EOF
      LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4 --use-color'
    LESS_ENV_EOF
  end
end
