require 'buildsystems/autotools'

class Less < Autotools
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '685-1'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url "https://www.greenwoodsoftware.com/less/less-#{version.split('-').first}.tar.gz"
  source_sha256 '2701041e767e697ee420ce0825641cedc8f20b51576abe99d92c1666d332e9dc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c3648861726618382f1edcc0cba3dbb3cd5ee57b452f14a52861675de00ed78d',
     armv7l: 'c3648861726618382f1edcc0cba3dbb3cd5ee57b452f14a52861675de00ed78d',
       i686: '50e28365da12770ca40cb815241595915ec2b87ec934b925ac3654b051a6fed3',
     x86_64: 'fc8be64255387f93738095fedd850e92744117a8cff2d7be6b8a06606a530d4c'
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
