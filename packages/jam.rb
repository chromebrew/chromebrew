require 'package'

class Jam < Package
  description 'Jam is a software build tool that makes building simple things simple and building complicated things manageable.'
  homepage 'https://www.perforce.com/documentation/jam-documentation'
  version '2.6'
  license '' # Can't find license
  compatibility 'all'
  source_url 'https://swarm.workshop.perforce.com/downloads/guest/perforce_software/jam/jam-2.6.zip'
  source_sha256 '7c510be24dc9d0912886c4364dc17a013e042408386f6b937e30bd9928d5223c'

  binary_url ({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/jam-2.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/jam-2.6-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/jam-2.6-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/jam-2.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f3b20e59eef2b8445d75ef628daadca9b42a2cb337c0ad19e83065f16f4e08fa',
     armv7l: 'f3b20e59eef2b8445d75ef628daadca9b42a2cb337c0ad19e83065f16f4e08fa',
       i686: 'd1cb265a2736b74115688564f3ba86ba58db11cc4a14e38a8146d9e86655392e',
     x86_64: '7ee76df942ed573943d45a451ce9337c7eead666a40e3c33ed5082c7f178ae6b',
  })

  depends_on 'unzip' => :build

  def self.build
    system "sed -i 's,jam0,jam,g' Makefile"
    system "make"
  end

  def self.install
    system "install -Dm755 jam #{CREW_DEST_PREFIX}/bin/jam"
  end
end
