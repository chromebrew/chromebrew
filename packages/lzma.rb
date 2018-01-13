require 'package'

class Lzma < Package
  description 'LZMA Utils are legacy data compression software with high compression ratio.'
  homepage 'https://tukaani.org/lzma/'
  version '4.32.7'
  source_url 'https://tukaani.org/lzma/lzma-4.32.7.tar.bz2'
  source_sha256 '618e54513993b3a153fa1c150fccdf25788c72b36e84ab4db71911083531cf6a'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "ln -s #{CREW_LIB_PREFIX}/liblzmadec.la #{CREW_DEST_LIB_PREFIX}/liblzma.la"
  end
end
