require 'package'

class Chicken < Package
  description 'CHICKEN is a practical and portable scheme system.'
  homepage 'https://code.call-cc.org/'
  version '6.1.0'
  license 'BSD'
  compatibility 'all'
  source_url "https://code.call-cc.org/releases/#{version}/chicken-#{version}.tar.gz"
  source_sha256 'c6aee9a5374102ba318e0cfae62ded5e1825346577137952d7fb15b3094d49d8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6977c5cb5563c9b5a8259eca7be1ab371c941de7bf19197ec6288e54c938e4f1',
     armv7l: '6977c5cb5563c9b5a8259eca7be1ab371c941de7bf19197ec6288e54c938e4f1',
       i686: 'c5ca9ef2970dbb515352d185878fc13a4c1d53ee9a438b081b62a9e0433a26b1',
     x86_64: 'd3192fff8af6910064221e859510508cc98b16227cf760118633dc473d39ff79'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", 'PLATFORM=linux'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'PLATFORM=linux', 'install'
  end
end
