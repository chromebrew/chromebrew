# Adapted from Arch Linux source-highlight PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/source-highlight/trunk/PKGBUILD

require 'buildsystems/autotools'

class Source_highlight < Autotools
  description 'Convert source code to syntax highlighted document'
  homepage 'https://www.gnu.org/software/src-highlite/'
  version '3.1.9-894cacd-boost1.85'
  license 'GPL'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/src-highlite.git'
  git_hashtag '894cacd0799ca60afa359a63782729dec76cbb79'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '244749f21be5f01c11309e77959f4da2b47936a7cdd047321a06a066c8203a06',
     armv7l: '244749f21be5f01c11309e77959f4da2b47936a7cdd047321a06a066c8203a06',
       i686: '1f1ccc4f04308bb23c465b6f59e6d1f3f01baed828d3eb5847922754a56bb2b8',
     x86_64: '7fbb5ac63a8225cf47824a54965b2faffd7059384fbd1a349fc68135f173b17e'
  })

  depends_on 'boost' # R
  depends_on 'ctags' # L
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'texinfo' => :build

  autotools_configure_options "--sysconfdir=#{CREW_PREFIX}/etc \
      --with-bash-completion=#{CREW_PREFIX}/share/bash-completion/completions"

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "make prefix=#{CREW_DEST_PREFIX} bash_completiondir=#{CREW_DEST_PREFIX}/share/bash-completion/completions install"
  end
end
