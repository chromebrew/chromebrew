# Adapted from Arch Linux source-highlight PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/source-highlight/trunk/PKGBUILD

require 'buildsystems/autotools'

class Source_highlight < Autotools
  description 'Convert source code to syntax highlighted document'
  homepage 'https://www.gnu.org/software/src-highlite/'
  version '3.1.9-e4cf32d-2'
  license 'GPL'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/cgit/src-highlite.git/snapshot/src-highlite-e4cf32db1ce3f0a7edb32caf131b2f45753cdf58.tar.gz'
  source_sha256 '98bcd3f8dceed4e4cf24dd9694163dce2b5bfc805e0ba7eb0b7b8d5a01f9154f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-e4cf32d-2_armv7l/source_highlight-3.1.9-e4cf32d-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-e4cf32d-2_armv7l/source_highlight-3.1.9-e4cf32d-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-e4cf32d-2_i686/source_highlight-3.1.9-e4cf32d-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-e4cf32d-2_x86_64/source_highlight-3.1.9-e4cf32d-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6dd0f34e63e8cb37dee3bd9da6fb921d5ab6086728946b5d9e234b43c24deae2',
     armv7l: '6dd0f34e63e8cb37dee3bd9da6fb921d5ab6086728946b5d9e234b43c24deae2',
       i686: '7fffd1fb10ba3c56e9ca522c8609a9cabb57e19a6ccc95ebcc4429e26ead90af',
     x86_64: '8ad3cb4c407f21ba2b3e593534c6b757331ea81360c1d2e90ce970445e315206'
  })

  depends_on 'boost' # R
  depends_on 'ctags' => :build
  depends_on 'texinfo' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  configure_options "--sysconfdir=#{CREW_PREFIX}/etc \
      --with-bash-completion=#{CREW_PREFIX}/share/bash-completion/completions"

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "make prefix=#{CREW_DEST_PREFIX} bash_completiondir=#{CREW_DEST_PREFIX}/share/bash-completion/completions install"
  end
end
