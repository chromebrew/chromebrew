require 'package'

class Wol < Package
  description 'Wake up hardware that is Magic Packet compliant'
  homepage 'http://ahh.sourceforge.net/wol/'
  version '0.7.1'
  source_url 'https://downloads.sourceforge.net/ahh/wol-0.7.1.tar.gz'
  source_sha256 'e0086c9b9811df2bdf763ec9016dfb1bcb7dba9fa6d7858725b0929069a12622'

  depends_on 'compressdoc' => :build

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--mandir=#{CREW_PREFIX}/share/man"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "MANDIR=#{CREW_DEST_PREFIX}/share/man/man1", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
  end

end
