require 'package'

class Xa < Package
  description 'xa is a high-speed, two-pass portable cross-assembler.'
  homepage 'https://www.floodgap.com/retrotech/xa/'
  version '2.4.1'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.floodgap.com/retrotech/xa/dists/xa-#{version}.tar.gz"
  source_sha256 '32f2164c99e305218e992970856dd8e2309b5cb6ac4758d7b2afe3bfebc9012d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6655914025fa35b6e2a626e1779407a3f894510c8e2c766fbccba67afdbccc3e',
     armv7l: '6655914025fa35b6e2a626e1779407a3f894510c8e2c766fbccba67afdbccc3e',
       i686: '91fa492bf0232bbd54e1d38d0b87d253e64a0ca0da702034b4c59140408258b1',
     x86_64: 'd36c75469a74c8f02dbe12ad6be6f47cadfc5f24fc22367ecf108fefae1b5254'
  })

  def self.patch
    system "sed -i 's,DESTDIR = /usr/local,DESTDIR = #{CREW_DEST_PREFIX},' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', 'install'
  end
end
