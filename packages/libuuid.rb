require 'package'

class Libuuid < Package
  description 'Portable uuid C library'
  homepage 'https://sourceforge.net/projects/libuuid/'
  version '1.0.3'
  source_url 'https://downloads.sourceforge.net/project/libuuid/libuuid-1.0.3.tar.gz'
  source_sha256 '46af3275291091009ad7f1b899de3d0cea0252737550e7919d17237997db5644'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libuuid-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libuuid-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libuuid-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libuuid-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '677071afa4a0b644e3873ef893ac60f0e19bf835d64ca3eadf7e894ebdc02ba6',
     armv7l: '677071afa4a0b644e3873ef893ac60f0e19bf835d64ca3eadf7e894ebdc02ba6',
       i686: 'b9a09da3feeec3091afb5d4a90906a46123e0c1fa5565c722c6072ce727364d0',
     x86_64: 'eff23f2a47e2af6829a77bf0fe9b9889c36de706690b299dd98679b49d3dc4dc',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
