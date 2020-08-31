require 'package'

class Libnsbmp < Package
  description 'Decoding library for BMP and ICO images in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.1.6'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libnsbmp-0.1.6-src.tar.gz'
  source_sha256 '79c49365f860ed451bfc4109eddec8de3e9b7ce5a3be069596bd2aa19279324f'

  depends_on 'netsurf_buildsystem'

  def self.build
   system "make -j#{CREW_NPROC} PREFIX=#{CREW_PREFIX}"
  end
  def self.install
   system "make -j#{CREW_NPROC} install PREFIX=#{CREW_PREFIX}"
  end
end
