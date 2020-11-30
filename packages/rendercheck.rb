require 'package'

class Rendercheck < Package
  description 'rendercheck is a program to test a Render extension implementation against separate calculations of expected output.'
  homepage 'https://www.x.org'
  version '1.5'
  compatibility 'all'
  source_url 'https://x.org/archive/individual/app/rendercheck-1.5.tar.bz2'
  source_sha256 '00605679436d65ccf9a6f1f1cb206df7a2e8b28a7821e867922d2b14b009f1cc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rendercheck-1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rendercheck-1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rendercheck-1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rendercheck-1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '90b0f792889946717870f1497e523c3229cb5840feaf1152da6a125710310697',
     armv7l: '90b0f792889946717870f1497e523c3229cb5840feaf1152da6a125710310697',
       i686: 'b0ca933742e0d17470c8f1d3e66dac65c5a03ac4d490a477e6e59c700b08b1b7',
     x86_64: '7c29b512ecdf2472ade1bce7f7b7491cd8f828a1146061fa8e2e512de6dd1dc9',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
