require 'package'

class Openjpeg < Package
  description 'OpenJPEG is an open-source JPEG 2000 codec written in C language.'
  homepage 'https://github.com/uclouvain/openjpeg/'
  version '2.1.2'
  source_url 'https://github.com/uclouvain/openjpeg/archive/v2.1.2.tar.gz'
  source_sha256 '4ce77b6ef538ef090d9bde1d5eeff8b3069ab56c4906f083475517c2c023dfa7'

  depends_on 'cmake'

  def self.build
    system "cmake ."
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
