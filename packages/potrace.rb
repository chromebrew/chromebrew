require 'package'

class Potrace < Package
  description 'Potrace(TM) is a tool for tracing a bitmap, which means, transforming a bitmap into a smooth, scalable image.'
  homepage 'http://potrace.sourceforge.net/'
  version '1.15'
  source_url 'http://potrace.sourceforge.net/download/1.15/potrace-1.15.tar.gz'
  source_sha256 'a9b33904ace328340c850a01458199e0064e03ccaaa731bc869a842b1b8d529d'

  depends_on 'zlibpkg'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
