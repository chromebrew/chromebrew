require 'package'

class Doxygen < Package
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources'
  homepage 'http://www.stack.nl/~dimitri/doxygen/'
  version '1.8.13'
  source_url 'https://github.com/doxygen/doxygen/archive/Release_1_8_13.zip'
  source_sha256 '1a1f67106c7e7642b79884f02faaf753d2e42be1ebac04083c173224123783b5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c4bb163c36d64a4d76732431aef4d57a11b1f82bc2bb4372bad246e6b5cf92f0',
     armv7l: 'c4bb163c36d64a4d76732431aef4d57a11b1f82bc2bb4372bad246e6b5cf92f0',
       i686: '8dae94cac3ae00c944887c83fee4b408a7962bb6d84540b29962c5b9462eae89',
     x86_64: 'a81ec27bd1e67a5bc6e5c1f45ad78f11ac8493593c7e10418f51d117b63a198a',
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
