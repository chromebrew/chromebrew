require 'package'

class Libnftnl < Package
  description 'libnftnl is a userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem.'
  homepage 'https://netfilter.org/projects/libnftnl/'
  license 'GPL-2'
  version '1.2.6'
  compatibility 'all'
  source_url 'https://netfilter.org/projects/libnftnl/files/libnftnl-1.2.6.tar.xz'
  source_sha256 'ceeaea2cd92147da19f13a35a7f1a4bc2767ff897e838e4b479cf54b59c777f4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnftnl/1.2.6_armv7l/libnftnl-1.2.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnftnl/1.2.6_armv7l/libnftnl-1.2.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnftnl/1.2.6_i686/libnftnl-1.2.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnftnl/1.2.6_x86_64/libnftnl-1.2.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a6204eb6297868215b0d507ac2310274b42630094769208dc700d14acb42212e',
     armv7l: 'a6204eb6297868215b0d507ac2310274b42630094769208dc700d14acb42212e',
       i686: 'a4ec348f1766bd0936db67cb453c6ffb12a91ae357e2ad73e7f43cd27fb8d8c1',
     x86_64: 'dcd8bf4815118628357e5c92f5638992976d826cc9b66c2aa6886c29c0eb4774'
  })

  depends_on 'libmnl' # R
  depends_on 'glibc' # R

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
