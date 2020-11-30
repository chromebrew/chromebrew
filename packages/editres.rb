require 'package'

class Editres < Package
  description 'Editres is a tool that allows users and application developers to view the full widget hierarchy of any Xt Toolkit application that speaks the Editres protocol.'
  homepage 'https://www.x.org'
  version '1.0.7'
  compatibility 'all'
  source_url 'https://x.org/archive/individual/app/editres-1.0.7.tar.bz2'
  source_sha256 '089ad34628e55a779b97e369f55fb12caefc96d684b508d9022eb9e12b775c11'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/editres-1.0.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/editres-1.0.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/editres-1.0.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/editres-1.0.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a0d58ce9b3c97f216a4f44b41b0597d434609db993f623ad2679f83eda9647e5',
     armv7l: 'a0d58ce9b3c97f216a4f44b41b0597d434609db993f623ad2679f83eda9647e5',
       i686: 'e631c24169d134eb2a467c0a435223512120c3c9aa9ebf770e3a33cfd4cb2232',
     x86_64: '33bc1a315e539c110dcaf04b0b89eb1da83dc14b3c568d2fac25982e248f1869',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
