require 'package'

class Openjpeg < Package
  description 'OpenJPEG is an open-source JPEG 2000 codec written in C language.'
  homepage 'https://github.com/uclouvain/openjpeg/'
  version '2.1.2'
  source_url 'https://github.com/uclouvain/openjpeg/archive/v2.1.2.tar.gz'
  source_sha1 'c8671e7f577fdc58abde1e1f32b10d372e6f9b07'

  depends_on 'cmake'

  def self.build
    system "cmake ."
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
