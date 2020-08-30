require 'package'

class Libcss < Package
  description 'CSS parser and selection engine, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.9.1'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libcss-0.9.1-src.tar.gz'
  source_sha256 'd2dce16e93392e8d6a7209420d47c2d56a3811701a0e81a724fc541c63d3c6dc'

  depends_on 'netsurf_buildsystem'
  depends_on 'libparserutils'
  depends_on 'libwapcaplet'

  def self.build
   system "make -j#{CREW_NPROC} PREFIX=#{CREW_PREFIX}"
  end
  def self.install
   system "make -j#{CREW_NPROC} install PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
  end
end
