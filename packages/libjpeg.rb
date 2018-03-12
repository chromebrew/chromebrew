require 'package'

class Libjpeg < Package
  description 'JPEG is a free library for image compression.'
  homepage 'http://www.ijg.org/'
  version '9.0-c'
  source_url 'http://www.ijg.org/files/jpegsrc.v9c.tar.gz'
  source_sha256 '1f3a3f610f57e88ff3f1f9db530c605f3949ee6e78002552e324d493cf086ad4'

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
