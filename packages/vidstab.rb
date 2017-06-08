require 'package'

class Vidstab < Package
  description 'Transcode video stabilization plugin.'
  homepage 'http://public.hronopik.de/vid.stab/'
  version '0.98b'
  source_url 'https://github.com/georgmartius/vid.stab/archive/release-0.98b.tar.gz'
  source_sha1 '1030a1baa9b2cba844758a6cd8dd5d5fc23f9cd9'

  depends_on 'cmake'

  def self.build
    system "cmake ."
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
