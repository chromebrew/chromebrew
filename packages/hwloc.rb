# Adapted from Arch Linux hwloc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/hwloc/trunk/PKGBUILD

require 'buildsystems/autotools'

class Hwloc < Autotools
  description 'Portable Hardware Locality is a portable abstraction of hierarchical architectures'
  homepage 'https://www.open-mpi.org/projects/hwloc/'
  version '2.12.1'
  license 'BSD-3 Clause'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/open-mpi/hwloc.git'
  git_hashtag "hwloc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9eb5e5de24efc07604a7d1afcf6de7856c3ab10724456ba0699dc13e96fbb7b8',
     armv7l: '9eb5e5de24efc07604a7d1afcf6de7856c3ab10724456ba0699dc13e96fbb7b8',
     x86_64: '6809fd917519e0f9be4e3fc9d6a8f1e67da8ff80f6576d9ca2844a5599d6812c'
  })

  depends_on 'cairo' # R
  depends_on 'eudev' # R
  depends_on 'harfbuzz' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libpciaccess' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxml2' # R
  depends_on 'pciutils' => :build

  configure_options "--enable-plugins \
    --sysconfdir=#{CREW_PREFIX}/etc"
end
