require 'package'

class Libwapcaplet < Package
  description 'String internment library, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.4.3'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libwapcaplet-0.4.3-src.tar.gz'
  source_sha256 '9b2aa1dd6d6645f8e992b3697fdbd87f0c0e1da5721fa54ed29b484d13160c5c'
  
  depends_on 'netsurf_buildsystem'

  def self.build
   system "make -j#{CREW_NPROC} PREFIX=#{CREW_PREFIX}"
  end
  def self.install
   system "make -j#{CREW_NPROC} install PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
  end
end
