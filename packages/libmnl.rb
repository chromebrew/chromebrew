require 'package'

class Libmnl < Package
  description 'libmnl is a minimalistic user-space library oriented to Netlink developers.'
  homepage 'https://www.netfilter.org/projects/libmnl/'
  version '1.0.4'
  source_url 'https://www.netfilter.org/projects/libmnl/files/libmnl-1.0.4.tar.bz2'
  source_sha256 '171f89699f286a5854b72b91d06e8f8e3683064c5901fb09d954a9ab6f551f81'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
