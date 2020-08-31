require 'package'

class Libparserutils < Package
  description 'Library for building efficient parsers, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.2.4'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libparserutils-0.2.4-src.tar.gz'
  source_sha256 '322bae61b30ccede3e305bf6eae2414920649775bc5ff1d1b688012a3c4947d8'
  
  depends_on 'netsurf_buildsystem'
  
  def self.build
   system "make -j#{CREW_NPROC} PREFIX=#{CREW_PREFIX}"
  end
  def self.install
   system "make -j#{CREW_NPROC} install PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
  end
end
