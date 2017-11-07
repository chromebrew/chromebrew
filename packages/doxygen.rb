require 'package'

class Doxygen < Package
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources'
  homepage 'http://www.stack.nl/~dimitri/doxygen/'
  version '1.8.13'
  source_url 'https://github.com/doxygen/doxygen/archive/Release_1_8_13.zip'
  source_sha256 '1a1f67106c7e7642b79884f02faaf753d2e42be1ebac04083c173224123783b5'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cmake'
  depends_on 'unzip'

  def self.build
    system "cmake ."
    system "make"
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
