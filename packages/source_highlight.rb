# Adapted from Arch Linux source-highlight PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/source-highlight/trunk/PKGBUILD

require 'buildsystems/autotools'

class Source_highlight < Autotools
  description 'Convert source code to syntax highlighted document'
  homepage 'https://www.gnu.org/software/src-highlite/'
  version "3.1.9-894cacd-#{CREW_BOOST_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/src-highlite.git'
  git_hashtag '894cacd0799ca60afa359a63782729dec76cbb79'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b878b6386da814ee198f8b5dc2509c69811df77d9cfd949caeb3c6ffec2b44fc',
     armv7l: 'b878b6386da814ee198f8b5dc2509c69811df77d9cfd949caeb3c6ffec2b44fc',
       i686: '683219ced9b15476bd33eed9490f3f7405690f9e839c6a3d6b73125aaeac4e45',
     x86_64: 'd265a58f2e9b960d79f8837e083d859957a324beebb6fadae39c0af9f3dc7399'
  })

  depends_on 'boost' => :library
  depends_on 'ctags' => :logical
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'texinfo' => :build

  autotools_configure_options "--sysconfdir=#{CREW_PREFIX}/etc \
    --with-bash-completion=#{CREW_PREFIX}/share/bash-completion/completions"

  autotools_install_extras do
    system "make prefix=#{CREW_DEST_PREFIX} bash_completiondir=#{CREW_DEST_PREFIX}/share/bash-completion/completions install"
  end
end
