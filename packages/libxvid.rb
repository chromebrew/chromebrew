require 'package'

class Libxvid < Package
  description 'The free video codec that is strong in compression and quality.'
  homepage 'https://www.xvid.com/'
  version '1.3.4'
  source_url 'http://downloads.xvid.org/downloads/xvidcore-1.3.4.tar.gz'
  source_sha1 'd8f58e35ec325ebd7de9a28440b725a40ea49dae'

  depends_on 'yasm'

  def self.build
    FileUtils.cd('build/generic') do
      system "./configure"
      system "make"
    end
  end

  def self.install
    FileUtils.cd('build/generic') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
