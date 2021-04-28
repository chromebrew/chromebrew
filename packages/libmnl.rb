require 'package'

class Libmnl < Package
  description 'libmnl is a minimalistic user-space library oriented to Netlink developers.'
  homepage 'https://www.netfilter.org/projects/libmnl/'
  version '1.0.4'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://www.netfilter.org/projects/libmnl/files/libmnl-1.0.4.tar.bz2'
  source_sha256 '171f89699f286a5854b72b91d06e8f8e3683064c5901fb09d954a9ab6f551f81'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmnl/1.0.4_armv7l/libmnl-1.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmnl/1.0.4_armv7l/libmnl-1.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmnl/1.0.4_i686/libmnl-1.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmnl/1.0.4_x86_64/libmnl-1.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dc5154a2d9bfcb43967639fc79097831dfb2668895c8b61ae889b8277536de0a',
     armv7l: 'dc5154a2d9bfcb43967639fc79097831dfb2668895c8b61ae889b8277536de0a',
       i686: 'a40aabf83e469e6e8fe8fa3a36d644f44dd23d86a83338b1c040029569b830bd',
     x86_64: 'a67ed03507bb290ce861336a7cfd7f1a45a16b25b4c1a9abef1262b6ede7f0b8',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
