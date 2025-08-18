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
    aarch64: '4e738abc735d11890b892c9adb86bd98b48c470ac92debab6af4e1a3935670a4',
     armv7l: '4e738abc735d11890b892c9adb86bd98b48c470ac92debab6af4e1a3935670a4',
       i686: '92ec257f2e62c924d2af87a112da55f40789034fe5df4b972ba019161035d46e',
     x86_64: '8d7d457d829a312b1fe1cd93e45c229fed5296784e1f4e85bb435022df1ba6c3'
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
