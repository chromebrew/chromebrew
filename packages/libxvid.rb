require 'package'

class Libxvid < Package
  description 'The free video codec that is strong in compression and quality.'
  homepage 'https://www.xvid.com/'
  version '1.3.5'
  source_url 'https://downloads.xvid.com/downloads/xvidcore-1.3.5.tar.bz2'
  source_sha256 '7c20f279f9d8e89042e85465d2bcb1b3130ceb1ecec33d5448c4589d78f010b4'


  depends_on 'yasm'

  def self.build
    FileUtils.cd('build/generic') do
      system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
      system "make"
    end
  end

  def self.install
    FileUtils.cd('build/generic') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
