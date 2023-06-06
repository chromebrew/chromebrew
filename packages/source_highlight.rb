# Adapted from Arch Linux source-highlight PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/source-highlight/trunk/PKGBUILD

require 'package'

class Source_highlight < Package
  description 'Convert source code to syntax highlighted document'
  homepage 'https://www.gnu.org/software/src-highlite/'
  version '3.1.9-e4cf32d'
  license 'GPL'
  compatibility 'all'
  source_url 'http://git.savannah.gnu.org/cgit/src-highlite.git/snapshot/src-highlite-e4cf32db1ce3f0a7edb32caf131b2f45753cdf58.tar.gz'
  source_sha256 '98bcd3f8dceed4e4cf24dd9694163dce2b5bfc805e0ba7eb0b7b8d5a01f9154f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-e4cf32d_armv7l/source_highlight-3.1.9-e4cf32d-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-e4cf32d_armv7l/source_highlight-3.1.9-e4cf32d-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-e4cf32d_i686/source_highlight-3.1.9-e4cf32d-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-e4cf32d_x86_64/source_highlight-3.1.9-e4cf32d-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0e051a4e57afc918238ca62c194270bc5d6ba74461ea45965f2f2e561fbc3413',
     armv7l: '0e051a4e57afc918238ca62c194270bc5d6ba74461ea45965f2f2e561fbc3413',
       i686: '81cd2ef95f8a19d3d2e5c6ccf1ddc619bf7d9eedb4f37877988817927c1894d8',
     x86_64: '0b627edbed9d0c8d1dce51f30f2e4963d5610740941a18fdb977fe40a6573dc1'
  })

  depends_on 'boost' # R
  depends_on 'ctags' => :build
  depends_on 'texinfo' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system 'autoupdate'
    system 'NOCONFIGURE=1 autoreconf -iv'
    system 'filefix'
    system "./configure #{CREW_OPTIONS} \
      --sysconfdir=#{CREW_PREFIX}/etc \
      --with-bash-completion=#{CREW_PREFIX}/share/bash-completion/completions"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "make prefix=#{CREW_DEST_PREFIX} bash_completiondir=#{CREW_DEST_PREFIX}/share/bash-completion/completions install"
  end
end
