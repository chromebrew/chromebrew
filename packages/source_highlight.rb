# Adapted from Arch Linux source-highlight PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/source-highlight/trunk/PKGBUILD

require 'buildsystems/autotools'

class Source_highlight < Autotools
  description 'Convert source code to syntax highlighted document'
  homepage 'https://www.gnu.org/software/src-highlite/'
  version '3.1.9-894cacd'
  license 'GPL'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/src-highlite.git'
  git_hashtag '894cacd0799ca60afa359a63782729dec76cbb79'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c69bf620d5d9b59a871da92d9ce34d42d8dc02a94b99ddc02cfcbc5c3a7a457d',
     armv7l: 'c69bf620d5d9b59a871da92d9ce34d42d8dc02a94b99ddc02cfcbc5c3a7a457d',
       i686: '30942176c3fc26ee0159b526d937694fa2e1087676ffec828e25fdcef2bd5cf8',
     x86_64: 'c286b1c7a1000b678e14cbd4127bd0290384a4e3a36f3b228e642691c116cda1'
  })

  depends_on 'boost' # R
  depends_on 'ctags' # L
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'texinfo' => :build

  configure_options "--sysconfdir=#{CREW_PREFIX}/etc \
      --with-bash-completion=#{CREW_PREFIX}/share/bash-completion/completions"

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "make prefix=#{CREW_DEST_PREFIX} bash_completiondir=#{CREW_DEST_PREFIX}/share/bash-completion/completions install"
  end
end
