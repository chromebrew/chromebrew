# Adapted from Arch Linux fig2dev PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/fig2dev/trunk/PKGBUILD

require 'buildsystems/autotools'

class Fig2dev < Autotools
  description 'Format conversion utility that can be used with xfig'
  homepage 'http://mcj.sourceforge.net/'
  version '3.2.9'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://downloads.sourceforge.net/mcj/fig2dev-#{version}.tar.xz"
  source_sha256 '15e246c8d13cc72de25e08314038ad50ce7d2defa9cf1afc172fd7f5932090b1'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fig2dev/3.2.9_armv7l/fig2dev-3.2.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fig2dev/3.2.9_armv7l/fig2dev-3.2.9-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fig2dev/3.2.9_x86_64/fig2dev-3.2.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2c33988219b2126531fe03fcdae6141ff718fb0787a90f60dc976c7d830d9606',
     armv7l: '2c33988219b2126531fe03fcdae6141ff718fb0787a90f60dc976c7d830d9606',
     x86_64: '292bf3bdbb1d20b043bf6978ce8a94cf7bd35e609a159ce577bedc0cdd9c47c6'
  })

  depends_on 'libpng' => :build
  depends_on 'libxpm' => :build
  depends_on 'bc' => :build
  depends_on 'netpbm' => :build
  depends_on 'ghostscript' => :build

  configure_options '--enable-transfig'
  pre_configure_options "FIG2DEV_LIBDIR=#{CREW_PREFIX}/share/fig2dev \
      XFIGLIBDIR=#{CREW_PREFIX}/share/xfig"
end
