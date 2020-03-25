require 'package'

class Libjpeg < Package
  description 'JPEG is a free library for image compression.'
  homepage 'http://www.ijg.org/'
  version '9.0-d'
  source_url 'https://www.ijg.org/files/jpegsrc.v9d.tar.gz'
  source_sha256 '99cb50e48a4556bc571dadd27931955ff458aae32f68c4d9c39d624693f69c32'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
