require 'buildsystems/autotools'

class Less < Autotools
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '661'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url "https://www.greenwoodsoftware.com/less/less-#{version}.tar.gz"
  source_sha256 '2b5f0167216e3ef0ffcb0c31c374e287eb035e4e223d5dae315c2783b6e738ed'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cc47f3475913c840176e6bf4a68d67420b1cb60b346bd90c7ad01db7f9964cf9',
     armv7l: 'cc47f3475913c840176e6bf4a68d67420b1cb60b346bd90c7ad01db7f9964cf9',
       i686: 'd48932d5080e30c00d60ec209b3de6fb28fa97126191689ece9594bcb10b1182',
     x86_64: 'b02b9c1fc6e87f6d78c19a0d0fc50bd905fa14dff1c78d0dc6ac4e0b00b3d2d8'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'gcc_lib' # R
  depends_on 'patch' => :build

  configure_options '--with-regex=posix'

  def self.patch
    Downloader.download 'https://patch-diff.githubusercontent.com/raw/gwsw/less/pull/412.diff',
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
