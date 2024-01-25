# Adapted from Arch Linux hwloc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/hwloc/trunk/PKGBUILD

require 'package'

class Hwloc < Package
  description 'Portable Hardware Locality is a portable abstraction of hierarchical architectures'
  homepage 'https://www.open-mpi.org/projects/hwloc/'
  version '2.7.0'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/open-mpi/hwloc.git'
  git_hashtag "hwloc-#{version}"
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'd08caff4ec00dcb51f41b021341619aa1c4739fffcab3c6f106eb18682542c33',
     armv7l: 'd08caff4ec00dcb51f41b021341619aa1c4739fffcab3c6f106eb18682542c33',
       i686: 'e2def1fa639efd0e9cafaba06662cc7adc82b3234f148617314b768c77035565',
     x86_64: 'f565d3fd29a314c2bbebffee5d993b28b2c918e70d37bf4dbc38638628ded810'
  })

  depends_on 'libtool'
  depends_on 'libpciaccess'
  depends_on 'cairo' => :build
  depends_on 'libxml2' => :build
  depends_on 'pciutils' => :build

  def self.build
    system './autogen.sh'
    system 'filefix'
    system "#{CREW_ENV_OPTIONS} ./configure \
      #{CREW_OPTIONS} \
      --enable-plugins \
      --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
