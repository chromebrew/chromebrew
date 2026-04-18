# Adapted from Arch Linux source-highlight PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/source-highlight/trunk/PKGBUILD

require 'buildsystems/autotools'

class Source_highlight < Autotools
  description 'Convert source code to syntax highlighted document'
  homepage 'https://www.gnu.org/software/src-highlite/'
  version '3.1.9-894cacd-boost1.90'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://git.savannah.gnu.org/git/src-highlite.git'
  git_hashtag '894cacd0799ca60afa359a63782729dec76cbb79'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd5b38d39474082bee61f1ceec3c363e682d4d3ef5083e243ce286bc3693e0575',
     armv7l: 'd5b38d39474082bee61f1ceec3c363e682d4d3ef5083e243ce286bc3693e0575',
     x86_64: 'b1e536d72b7f4fca36732ffd404b8a5b8aafd68eb2c6789d6e3bb1a744aa2411'
  })

  depends_on 'boost' => :library
  depends_on 'ctags' => :logical
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'texinfo' => :build

  autotools_configure_options "--sysconfdir=#{CREW_PREFIX}/etc \
    --with-bash-completion=#{CREW_PREFIX}/share/bash-completion/completions"

  autotools_install_extras do
    system "make prefix=#{CREW_DEST_PREFIX} bash_completiondir=#{CREW_DEST_PREFIX}/share/bash-completion/completions install"
  end
end
