require 'package'

class Libpciaccess < Package
  description 'Generic PCI access library'
  homepage 'https://x.org'
  version '0.16'
  source_url 'https://www.x.org/archive/individual/lib/libpciaccess-0.16.tar.gz'
  source_sha256 '84413553994aef0070cf420050aa5c0a51b1956b404920e21b81e96db6a61a27'

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
