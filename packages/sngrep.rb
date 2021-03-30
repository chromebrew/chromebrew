require 'package'

class Sngrep < Package
  description 'An Ncurses SIP Messages flow viewer'
  homepage 'https://github.com/irontec/sngrep'
  version '1.4.6-2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/irontec/sngrep/archive/v1.4.6.tar.gz'
  source_sha256 '638d6557dc68db401b07d73b2e7f8276800281f021fe0c942992566d6b59a48a'

  depends_on 'libpcap'
  depends_on 'pcre'

  def self.build
    system './bootstrap.sh'
    system "env CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw -I#{CREW_PREFIX}/include/pcap' \
          ./configure #{CREW_OPTIONS} \
            --with-openssl \
            --with-pcre \
            --disable-logo \
            --enable-ipv6"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
