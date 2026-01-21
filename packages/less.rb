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
    aarch64: 'ae5952e0c67c0d762796244762d3d2cf024868844f3f72494f330659a111637f',
     armv7l: 'ae5952e0c67c0d762796244762d3d2cf024868844f3f72494f330659a111637f',
       i686: '85d5471136724c9bda0582d8193244ac32978d08ad60c13d1057b21cb4211442',
     x86_64: 'cc62e55d6cce9c59f9a85206fdf81274b5864829d44d7060ec2fb3f12ab4f648'
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
