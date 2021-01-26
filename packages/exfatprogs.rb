require 'package'

class Exfatprogs < Package
  description 'exFAT filesystem userspace utilities for the Linux Kernel exfat driver'
  homepage 'https://github.com/exfatprogs/exfatprogs'
  @_ver = '1.0.4'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/exfatprogs/exfatprogs/archive/#{@_ver}/exfatprogs-#{@_ver}.tar.gz"
  source_sha256 '3f755d35785a74138348b3a22dfcda5afc8a69e66a6a0c79be48225e6ca321ce'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/exfatprogs-1.0.4-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/exfatprogs-1.0.4-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/exfatprogs-1.0.4-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/exfatprogs-1.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '2f40e8d171a80311e0014353e33795df9fa60fd11927a0a1f389e44277d31fa7',
      armv7l: '2f40e8d171a80311e0014353e33795df9fa60fd11927a0a1f389e44277d31fa7',
        i686: '5ad356044174e945904cdafef8a35cc73c9e88ba51a4680354adadcbfa6cde8c',
      x86_64: '8638c0b4e22145481c3d9431ac5d9534c9f41595736662cde8423ce4a685b856',
  })
  
  def self.build
    system './autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure #{CREW_OPTIONS} --sbindir=#{CREW_PREFIX}/bin"
    system "make"
  end
  
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    system "install -Dm644 -t #{CREW_DEST_DIR}/usr/share/man/man8 */*.8"
  end
end
