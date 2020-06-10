require 'package'

class Nftables < Package
  description 'nftables replaces the popular {ip,ip6,arp,eb}tables.'
  homepage 'https://netfilter.org/projects/nftables/'
  version '0.9.0'
  compatibility 'all'
  source_url 'https://netfilter.org/projects/nftables/files/nftables-0.9.0.tar.bz2'
  source_sha256 'ad8181b5fcb9ca572f444bed54018749588522ee97e4c21922648bb78d7e7e91'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nftables-0.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nftables-0.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nftables-0.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nftables-0.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5245548bfb5081d7a25291d3cc82052ace323d235eba1a73638cff83152e5a06',
     armv7l: '5245548bfb5081d7a25291d3cc82052ace323d235eba1a73638cff83152e5a06',
       i686: '5129603a7f40d072f8746430f6b1b14e0f77b50b3495154de7408c49ca891c87',
     x86_64: '60cb68a70ecc066d7c6b92617db9f38593692f056c3620a3a42c7df0dd6a2ae7',
  })

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
