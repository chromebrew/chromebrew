require 'buildsystems/autotools'

class Less < Autotools
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '710'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url "https://www.greenwoodsoftware.com/less/less-#{version}.tar.gz"
  source_sha256 'd1008fb78dcae1323ddab664bcb352a61f022b1b131bd8018548e021d975ec7a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7075f9d940bca34f2923e9c95b69985620950bced035210743ba7496e891937e',
     armv7l: '7075f9d940bca34f2923e9c95b69985620950bced035210743ba7496e891937e',
       i686: 'e5f7e4c6b99ab02b1d00181ad99d1874d71c5ca1e8f1b89ab14d5f856adeeee5',
     x86_64: 'b3d650daf71db62ff8c0b3ffb0f01e925c9d8bd84bb0832028feb85083f6a3a7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :build
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable
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
