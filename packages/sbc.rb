require 'package'

class Sbc < Package
  description 'SBC is a digital audio encoder and decoder used to transfer data to Bluetooth audio output devices.'
  homepage 'http://www.linuxfromscratch.org/blfs/view/svn/multimedia/sbc.html'
  version '1.4'
  source_url 'https://www.kernel.org/pub/linux/bluetooth/sbc-1.4.tar.xz'
  source_sha256 '518bf46e6bb3dc808a95e1eabad26fdebe8a099c1e781c27ed7fca6c2f4a54c9'

  depends_on 'libsndfile'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-high-precision',
           '--disable-static',
           '--enable-pie'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
