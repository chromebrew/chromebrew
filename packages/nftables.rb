# Adapted from Arch Linux nftables PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nftables/trunk/PKGBUILD

require 'package'

class Nftables < Package
  description 'Netfilter tables userspace tools'
  homepage 'https://netfilter.org/projects/nftables/'
  version '1.0.7'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://netfilter.org/projects/nftables/files/nftables-1.0.7.tar.xz'
  source_sha256 'c12ac941fff9adaedf17367d5ce213789b98a0d314277bc22b3d71e10891f412'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nftables/1.0.7_armv7l/nftables-1.0.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nftables/1.0.7_armv7l/nftables-1.0.7-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nftables/1.0.7_x86_64/nftables-1.0.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f3f13ae9973a69553bfc0105a4437f5ff049331f1323a1839e5e7a522f6d00f8',
     armv7l: 'f3f13ae9973a69553bfc0105a4437f5ff049331f1323a1839e5e7a522f6d00f8',
     x86_64: 'ea7b3b864f346788e228516ee5a170ec37ad5f798e977df045b46673995704cb'
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
