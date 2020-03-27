require 'package'

class Siege < Package
  description 'Siege is an http load testing and benchmarking utility.'
  homepage 'https://www.joedog.org/siege-home/'
  version '4.0.5'
  source_url 'http://download.joedog.org/siege/siege-4.0.5.tar.gz'
  source_sha256 '3b4b7001afa4d80f3f4939066a4932e198e9f949dcc0e3affecbedd922800231'

  binary_url ({
  })
  binary_sha256 ({
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
