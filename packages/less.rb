require 'buildsystems/autotools'

class Less < Autotools
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '691'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url "https://www.greenwoodsoftware.com/less/less-#{version.split('-').first}.tar.gz"
  source_sha256 '88b480eda1bb4f92009f7968b23189eaf1329211f5a3515869e133d286154d25'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99332e568aa71f0d63fc654e931eb93fc9e4bc2b00f1502232d2617ab57e6742',
     armv7l: '99332e568aa71f0d63fc654e931eb93fc9e4bc2b00f1502232d2617ab57e6742',
       i686: '9e894ee3a69b3e2876b19b4988809e989fc14ef188974454abaffdeb1712b86d',
     x86_64: '6917d7ed0e028cdf3c30dc2e7e568269f573e7be9ae9ea7396ebf7186d135caf'
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
