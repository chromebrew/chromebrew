require 'package'

class Jam < Package
  description 'Jam is a software build tool that makes building simple things simple and building complicated things manageable.'
  homepage 'https://www.perforce.com/documentation/jam-documentation'
  version '2.6'
  source_url 'https://swarm.workshop.perforce.com/downloads/guest/perforce_software/jam/jam-2.6.zip'
  source_sha256 '7c510be24dc9d0912886c4364dc17a013e042408386f6b937e30bd9928d5223c'

  binary_url ({
  })
  binary_sha256 ({
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
