# Adapted from Arch Linux ethtool PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ethtool/trunk/PKGBUILD

require 'buildsystems/autotools'

class Ethtool < Autotools
  description 'Utility for controlling network drivers and hardware'
  homepage 'https://www.kernel.org/pub/software/network/ethtool/'
  version '7.0'
  license 'LGPL2.1'
  compatibility 'all'
  source_url "https://www.kernel.org/pub/software/network/ethtool/ethtool-#{version}.tar.xz"
  source_sha256 '660bf9725a7871343a0d232068a7634fbcfb69b6c2f8eff455827faefb0cd162'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9bd4247a1327f5bff2086059b05dc651ef57e7e9ebb68320d53afa4c42b5d643',
     armv7l: '9bd4247a1327f5bff2086059b05dc651ef57e7e9ebb68320d53afa4c42b5d643',
       i686: 'e837069d04e0451e35fac0822f95e7ab5edaf25b03581b5142ac26afe5f1847c',
     x86_64: '975f5bb6cb23a229f71bd5b1dd50af40e5cfbe506466dfabe716e29390493d5b'
  })

  depends_on 'glibc' => :executable
  depends_on 'libmnl' => :executable

  # Tests fail for arm builds.
  run_tests

  autotools_configure_options "--sbindir=#{CREW_PREFIX}/bin"
end
