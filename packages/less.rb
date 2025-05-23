require 'buildsystems/autotools'

class Less < Autotools
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '668'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url "https://www.greenwoodsoftware.com/less/less-#{version}.tar.gz"
  source_sha256 '2819f55564d86d542abbecafd82ff61e819a3eec967faa36cd3e68f1596a44b8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b83aeaa88a4efb9f11f8adb5003c2f74ccc1f86a26ec87987106385bf1216b46',
     armv7l: 'b83aeaa88a4efb9f11f8adb5003c2f74ccc1f86a26ec87987106385bf1216b46',
       i686: '3a09e33e0e0f02ac98b4eb4e36ebece968f3f9b3f2eda0a0659f018e252cafdc',
     x86_64: 'a0a9254cb229835653abaaae2b8f14991b97051affb2fa060161eb8b39c9832e'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'gcc_lib' # R
  depends_on 'patch' => :build

  autotools_configure_options '--with-regex=posix'

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
