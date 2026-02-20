require 'buildsystems/autotools'

class Less < Autotools
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '692'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url "https://www.greenwoodsoftware.com/less/less-#{version.split('-').first}.tar.gz"
  source_sha256 '61300f603798ecf1d7786570789f0ff3f5a1acf075a6fb9f756837d166e37d14'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0a31e18bf77ce4a6e64dbda41740cc5fe157eef9e1b33905bbff55d797c8b17',
     armv7l: 'b0a31e18bf77ce4a6e64dbda41740cc5fe157eef9e1b33905bbff55d797c8b17',
       i686: 'aec31e2d7f3ca38797fadbcfafdae4f5c6a40692787273fde43ab1a125db3421',
     x86_64: 'dcf8cb37f27844c4010e3435aad894c0c715813afd8b1275f6dd9b4e455b47df'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :executable_only
  depends_on 'ncurses' => :executable_only
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
