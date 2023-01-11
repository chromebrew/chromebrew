# Adapted from Arch Linux nftables PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nftables/trunk/PKGBUILD

require 'package'

class Nftables < Package
  description 'Netfilter tables userspace tools'
  homepage 'https://netfilter.org/projects/nftables/'
  version '1.0.6'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://netfilter.org/projects/nftables/files/nftables-1.0.6.tar.xz'
  source_sha256 '2407430ddd82987670e48dc2fda9e280baa8307abec04ab18d609df3db005e4c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nftables/1.0.6_armv7l/nftables-1.0.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nftables/1.0.6_armv7l/nftables-1.0.6-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nftables/1.0.6_x86_64/nftables-1.0.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '729a1969245334e36de1b6a3b43284e418de245e9cd1f59bdaa5846a694584d6',
     armv7l: '729a1969245334e36de1b6a3b43284e418de245e9cd1f59bdaa5846a694584d6',
     x86_64: 'b9069b7d5528cf7a9f2aafc452f8d2e895e841b4a51c21769f4e336d76b915dc'
  })

  depends_on 'asciidoc' => :build
  depends_on 'glibc' # R
  depends_on 'jansson' # R
  depends_on 'libmnl' # R
  depends_on 'libnftnl' # R
  depends_on 'readline' # R

  def self.build
    system 'autoreconf -fiv'
    system "./configure \
           --prefix=#{CREW_PREFIX} \
           --libdir=#{CREW_LIB_PREFIX} \
           --sbindir=#{CREW_PREFIX}/bin \
           --sysconfdir=#{CREW_PREFIX}/etc \
           --with-json \
           --with-cli=readline \
           --with-mini-gmp \
           --disable-debug"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
