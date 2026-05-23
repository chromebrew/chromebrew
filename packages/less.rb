require 'buildsystems/autotools'

class Less < Autotools
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '702'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url "https://www.greenwoodsoftware.com/less/less-#{version}.tar.gz"
  source_sha256 '242a64c00f02d96f8ee208cf638ae1728b727c7f5fdf82a7d4f4cae32fb084e2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8e1f59a74d88b4d7252fff7c0d1a67207166114f101566da4e61f2e24846f631',
     armv7l: '8e1f59a74d88b4d7252fff7c0d1a67207166114f101566da4e61f2e24846f631',
       i686: '3f232a854176431f1305e63aad0f479a520f6db1a4444f071c0e87e580d87405',
     x86_64: '66637d896e36f3cd26c77604c576b3d8834d0df99aad52aacd6c8e3fdfd5fd3b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
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
