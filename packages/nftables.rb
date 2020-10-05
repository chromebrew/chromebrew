require 'package'

class Nftables < Package
  description 'nftables replaces the popular {ip,ip6,arp,eb}tables.'
  homepage 'https://netfilter.org/projects/nftables/'
  compatibility 'all'
  version '0.9.6-1'
  source_url 'https://netfilter.org/projects/nftables/files/nftables-0.9.6.tar.bz2'
  source_sha256 '68d6fdfe8ab02303e6b1f13968a4022da5b0120110eaee3233d806857937b66e'

  depends_on 'help2man'
  depends_on 'jansson'
  depends_on 'libmnl'
  depends_on 'libnftnl'
  depends_on 'readline'

  def self.build
    system "LIBS=\"-lncurses\" ./configure \
           --prefix=#{CREW_PREFIX} \
           --libdir=#{CREW_LIB_PREFIX} \
           --disable-man-doc \
           --with-json \
           --with-mini-gmp"
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/man/man1"
    system "touch #{CREW_DEST_PREFIX}/man/man1/nft.1.gz"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    system "help2man -n 'userspace command line tool for nftables' -s 1 -N --no-discard-stderr '#{CREW_PREFIX}/sbin/nft -h' > nft.1"
    system "sed -i 's,Usage:,nft,g' nft.1"
    system "sed -i 's,USAGE:,NFT,g' nft.1"
    system "gzip -9 nft.1"
    system "install -m644 nft.1.gz #{CREW_PREFIX}/man/man1/nft.1.gz"
  end
end
