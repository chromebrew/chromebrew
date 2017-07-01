require 'package'

class Vidstab < Package
  description 'Transcode video stabilization plugin.'
  homepage 'http://public.hronopik.de/vid.stab/'
  version '0.98b'
  source_url 'https://github.com/georgmartius/vid.stab/archive/release-0.98b.tar.gz'
  source_sha256 '530f0bf7479ec89d9326af3a286a15d7d6a90fcafbb641e3b8bdb8d05637d025'

  depends_on 'cmake'

  def self.build
    system "cmake ."
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
