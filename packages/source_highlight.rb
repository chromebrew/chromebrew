# Adapted from Arch Linux source-highlight PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/source-highlight/trunk/PKGBUILD

require 'package'

class Source_highlight < Package
  description 'Convert source code to syntax highlighted document'
  homepage 'https://www.gnu.org/software/src-highlite/'
  version '3.1.9-e4cf32d-1'
  license 'GPL'
  compatibility 'all'
  source_url 'http://git.savannah.gnu.org/cgit/src-highlite.git/snapshot/src-highlite-e4cf32db1ce3f0a7edb32caf131b2f45753cdf58.tar.gz'
  source_sha256 '98bcd3f8dceed4e4cf24dd9694163dce2b5bfc805e0ba7eb0b7b8d5a01f9154f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-e4cf32d-1_armv7l/source_highlight-3.1.9-e4cf32d-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-e4cf32d-1_armv7l/source_highlight-3.1.9-e4cf32d-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-e4cf32d-1_i686/source_highlight-3.1.9-e4cf32d-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-e4cf32d-1_x86_64/source_highlight-3.1.9-e4cf32d-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f76212e9e9211745a8a46bb68e320ee96673f04638b35b4bbd4e553f678fcd3f',
     armv7l: 'f76212e9e9211745a8a46bb68e320ee96673f04638b35b4bbd4e553f678fcd3f',
       i686: '9dc3a8f4f8452b133f6075fca1260d38831bc1762a6ac0443023df1437790dc4',
     x86_64: '194477622f81de242ec459a9073f092b98127c5212426a12540caa9cfc9856ff'
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
