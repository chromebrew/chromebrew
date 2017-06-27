require 'package'

class Lcms < Package
  description 'Little CMS intends to be an OPEN SOURCE small-footprint color management engine, with special focus on accuracy and performance.'
  homepage 'http://www.littlecms.com/'
  version '2.8'
  source_url 'https://downloads.sourceforge.net/project/lcms/lcms/2.8/lcms2-2.8.tar.gz'
  source_sha1 'e9535ec4a572b8fc7a1c405c35e6f4dc97714197'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
