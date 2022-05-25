require 'package'

class Sngrep < Package
  description 'An Ncurses SIP Messages flow viewer'
  homepage 'https://github.com/irontec/sngrep'
  version '1.4.6-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/irontec/sngrep/archive/v1.4.6.tar.gz'
  source_sha256 '638d6557dc68db401b07d73b2e7f8276800281f021fe0c942992566d6b59a48a'
  binary_compression 'tar.xz'

  depends_on 'libpcap'
  depends_on 'pcre'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sngrep/1.4.6-1_armv7l/sngrep-1.4.6-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sngrep/1.4.6-1_armv7l/sngrep-1.4.6-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sngrep/1.4.6-1_i686/sngrep-1.4.6-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sngrep/1.4.6-1_x86_64/sngrep-1.4.6-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '09a6ad001c63ce4ac435c148e5bb6df64908b3e06f95520e268510aa89f8c13f',
     armv7l: '09a6ad001c63ce4ac435c148e5bb6df64908b3e06f95520e268510aa89f8c13f',
       i686: '9791803d412c9b0f3b25da9fc5c80483aa18262c6411f2eb1b7e636c1ca4c585',
     x86_64: 'd370d8913abea954dc6420e2dae3d83373917e26935f58c66c38c59809fa275f'
  })

  def self.build
    system './bootstrap.sh'
    system "./configure CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw -I#{CREW_PREFIX}/include/pcap' \
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
