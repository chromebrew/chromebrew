require 'package'

class Libxvid < Package
  description 'The free video codec that is strong in compression and quality.'
  homepage 'https://www.xvid.com/'
  version '1.3.4-0'
  source_url 'http://downloads.xvid.org/downloads/xvidcore-1.3.4.tar.gz'
  source_sha256 '4e9fd62728885855bc5007fe1be58df42e5e274497591fec37249e1052ae316f'


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
