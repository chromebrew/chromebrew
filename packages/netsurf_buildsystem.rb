require 'package'

class Netsurf_buildsystem < Package
  description 'Netsurf buildsystem'
  homepage 'https://www.netsurf-browser.org'
  version '1.9'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/buildsystem-1.9.tar.gz'
  source_sha256 '93841e314a688209a20b8745f065393f3a90f01be68f45e96bc8d2f4a2aa9a2a'

  def self.build
   system "make -j#{CREW_NPROC} PREFIX=#{CREW_PREFIX}"
  end
  def self.install
   system "make -j#{CREW_NPROC} install PREFIX=#{CREW_PREFIX}"
  end
end
