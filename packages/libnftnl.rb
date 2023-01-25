require 'package'

class Libnftnl < Package
  description 'libnftnl is a userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem.'
  homepage 'https://netfilter.org/projects/libnftnl/'
  license 'GPL-2'
  version '1.2.4'
  compatibility 'all'
  source_url 'https://netfilter.org/projects/libnftnl/files/libnftnl-1.2.4.tar.bz2'
  source_sha256 'c0fe233be4cdfd703e7d5977ef8eb63fcbf1d0052b6044e1b23d47ca3562477f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnftnl/1.2.4_armv7l/libnftnl-1.2.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnftnl/1.2.4_armv7l/libnftnl-1.2.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnftnl/1.2.4_i686/libnftnl-1.2.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnftnl/1.2.4_x86_64/libnftnl-1.2.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ad098ec7999d05bbe18c08c31e456e5b1fad46f0168b6f2bf16313044a403378',
     armv7l: 'ad098ec7999d05bbe18c08c31e456e5b1fad46f0168b6f2bf16313044a403378',
       i686: '1337220cb856de42777e6fdb1d4cc85140bd5e00dcfb5cd171ac3f316d9b590b',
     x86_64: '791461abdbe8e7aea50998a783844c30ba323c2827e013c9017d555600b13b5d'
  })

  depends_on 'libmnl' # R
  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
