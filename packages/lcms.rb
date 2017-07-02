require 'package'

class Lcms < Package
  description 'Little CMS intends to be an OPEN SOURCE small-footprint color management engine, with special focus on accuracy and performance.'
  homepage 'http://www.littlecms.com/'
  version '2.8'
  source_url 'https://downloads.sourceforge.net/project/lcms/lcms/2.8/lcms2-2.8.tar.gz'
  source_sha256 '66d02b229d2ea9474e62c2b6cd6720fde946155cd1d0d2bffdab829790a0fb22'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
