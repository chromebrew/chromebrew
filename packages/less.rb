require 'buildsystems/autotools'

class Less < Autotools
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '704'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url "https://www.greenwoodsoftware.com/less/less-#{version}.tar.gz"
  source_sha256 '20a0b0a2bb2525fa53c7eee9beb854b4c9cf172eabb209af7020743547bfe9fb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '580c0f4bbfe3e40996d55cf67cdb0d1e7ace7cd41f656681aea1a2dac56354cb',
     armv7l: '580c0f4bbfe3e40996d55cf67cdb0d1e7ace7cd41f656681aea1a2dac56354cb',
       i686: 'f773175cf1add339eb9324c5d9f173da787fc1d7d24dc4405ee56c1786cb7338',
     x86_64: '0567105c3962e72215185d8e638dc7036de7dd1b57de0b7f870e14df7a1a657f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :executable
  depends_on 'glibc_lib' => :library
  depends_on 'ncurses' => :executable
  depends_on 'ncurses' => :library
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
