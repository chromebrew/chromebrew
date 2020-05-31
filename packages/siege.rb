require 'package'

class Siege < Package
  description 'Siege is an http load testing and benchmarking utility.'
  homepage 'https://www.joedog.org/siege-home/'
  version '4.0.5'
  source_url 'http://download.joedog.org/siege/siege-4.0.5.tar.gz'
  source_sha256 '3b4b7001afa4d80f3f4939066a4932e198e9f949dcc0e3affecbedd922800231'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/siege-4.0.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/siege-4.0.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/siege-4.0.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/siege-4.0.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bdebecd0f52474101942d8f0d993389b1ed3f6aa32d9c3c5a9ffd8ed719814a3',
     armv7l: 'bdebecd0f52474101942d8f0d993389b1ed3f6aa32d9c3c5a9ffd8ed719814a3',
       i686: '152e9eaff55b5cf304aa34a3eb3f4a17a2918a84f1e224c34713cde9334c1f99',
     x86_64: 'b2bb5b875c5e4e7acec1d7c3a3e5e111751ca3ba6a9098be18c0bce295e240b6',
  })

  def self.build
    system "./configure \
           --prefix=#{CREW_PREFIX} \
           --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
  end
end
