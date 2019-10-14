require 'package'

class Aspell < Package
  description 'GNU Aspell is a Free and Open Source spell checker designed to eventually replace Ispell.'
  homepage 'http://aspell.net/'
  version '0.60.7'
  source_url 'https://ftpmirror.gnu.org/aspell/aspell-0.60.7.tar.gz'
  source_sha256 '5ca8fc8cb0370cc6c9eb5b64c6d1bc5d57b3750dbf17887726c3407d833b70e4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '55f12c38478c191f3abae82067fce39110ee4df534954ba5055a05a70c347056',
     armv7l: '55f12c38478c191f3abae82067fce39110ee4df534954ba5055a05a70c347056',
       i686: 'c79471f9ff59ae6775e9f1a7daf9b8d55fff4d97bc0cc5f320bd223b114661f6',
     x86_64: '91bc09fb1859e4d705bed44b9b5c6f1481f65d807389f7117a6d8b95f39dac90',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
