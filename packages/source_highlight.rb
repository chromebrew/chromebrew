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
    aarch64: 'c678485029181a81af5ff753941d377969c4a48faff13ae9b18b265cbab8bc46',
     armv7l: 'c678485029181a81af5ff753941d377969c4a48faff13ae9b18b265cbab8bc46',
       i686: 'f8e0891842693e1b20195661229e6003496cc6786a26c2c983c202ebcff375d2',
     x86_64: '7097637eea28626fdb0d0925f6e82298df51a17e8a1373d3169895c8a9c6df9b'
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
