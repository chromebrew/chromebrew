require 'package'

class Gpart < Package
  description 'Partition table rescue/guessing tool. https://github.com/baruch/gpart'
  homepage 'https://github.com/baruch/gpart/releases'
  version '0.3'
  source_url 'https://github.com/baruch/gpart/archive/0.3.tar.gz'
  source_sha256 'ec56d12ec9ffdb9877c12692ea6e51620b1ae44473d3d253b27fc31ed9ebb4dd'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
