require 'package'

class Woff2 < Package
  description 'Web Open Font Format (WOFF) is an open format for using fonts on the Web.'
  homepage 'https://github.com/google/woff2'
  version '1.0.2'
  compatibility 'all'
  source_url 'https://github.com/google/woff2/archive/v1.0.2.tar.gz'
  source_sha256 'add272bb09e6384a4833ffca4896350fdb16e0ca22df68c0384773c67a175594'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/woff2-1.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/woff2-1.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/woff2-1.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/woff2-1.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '192c84faead6c5c71ee8e38def88f239b46b8897ad731e2c2bbee03654d8c794',
     armv7l: '192c84faead6c5c71ee8e38def88f239b46b8897ad731e2c2bbee03654d8c794',
       i686: '34294d13e3ceaa8341e9292652ca81184de7967cc63024c60560e66c8830f5c8',
     x86_64: 'b27803367b73048b733a28e639b6ebcfaaf889b813eefcb43def1af79653ba04',
  })

  depends_on 'brotli'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB}",
             '-DCMAKE_BUILD_TYPE=Release',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
