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
    aarch64: '5f5821a40f03f5cbb6f5108391582cc1c62277538a75c18d4aae547d78a3e254',
     armv7l: '5f5821a40f03f5cbb6f5108391582cc1c62277538a75c18d4aae547d78a3e254',
       i686: 'd533ed4c7fe18be81011f286f03d283f61557fa2e7734c1d018391f2fd788b71',
     x86_64: 'be181d938568d79a67b08c1fd20bd961ada9659d3d963948154ee2bc18609a7a'
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
