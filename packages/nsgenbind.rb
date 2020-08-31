require 'package'

class Nsgenbind < Package
  description 'Tool to generate javascript to dom bindings from w3c webid files'
  homepage 'https://www.netsurf-browser.org'
  version '0.8'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/nsgenbind-0.8-src.tar.gz'
  source_sha256 '4d8d53ad000ada712772365e6a73eb8fc5ce97584af9c865ac5b26a2187f1cb3'

  depends_on 'netsurf_buildsystem'

  def self.build
   system "make -j#{CREW_NPROC} FLEX=flex BISON=bison PREFIX=#{CREW_PREFIX}"
  end
  def self.install
   system "make -j#{CREW_NPROC} DESTDIR=#{CREW_DEST_DIR} install PREFIX=#{CREW_PREFIX}"
  end
end
