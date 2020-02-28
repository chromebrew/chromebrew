require 'package'

class Sngrep < Package
  description 'An Ncurses SIP Messages flow viewer'
  homepage 'https://github.com/irontec/sngrep'
  version '1.4.6'
  source_url 'https://github.com/irontec/sngrep/releases/download/v1.4.6/sngrep-1.4.6.tar.gz'
  source_sha256 '638d6557dc68db401b07d73b2e7f8276800281f021fe0c942992566d6b59a48a'

  depends_on 'libpcap'
  depends_on 'pcre'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'AUTOCONF_VERSION=2.69 AUTOMAKE_VERSION=1.16 ./bootstrap.sh'
    system "./configure CPPFLAGS=\"-I#{CREW_PREFIX}/include/ncursesw -I#{CREW_PREFIX}/include/libpcap\" \
          --prefix=#{CREW_PREFIX} \
          --libdir=#{CREW_LIB_PREFIX} \
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
