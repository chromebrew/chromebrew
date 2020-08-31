require 'package'

class Libnsgif < Package
  description 'Decoding library for the GIF image file format, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.2.1'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libnsgif-0.2.1-src.tar.gz'
  source_sha256 '9eaea534cd70b53c5aaf45317ae957701685a6b4a88dbe34ed26f4faae879a4b'

  depends_on 'netsurf_buildsystem'
  
  def self.build
   system "make -j#{CREW_NPROC} PREFIX=#{CREW_PREFIX}"
  end
  def self.install
   system "make -j#{CREW_NPROC} install PREFIX=#{CREW_PREFIX}"
  end
end
