require 'package'

class Osl < Package
  description 'OpenScop is a Specification and a Library for Data Exchange in Polyhedral Compilation Tools'
  homepage 'https://github.com/periscop/openscop'
  version '0.9.2'
  compatibility 'all'
  source_url 'https://github.com/periscop/openscop/releases/download/0.9.2/osl-0.9.2.tar.gz'
  source_sha256 'eee5cd9bf5b3b8491f95f681cfaa987344f0fb3d7499f5d8e19e3ce75e0c5ed0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/osl-0.9.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/osl-0.9.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/osl-0.9.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/osl-0.9.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '171bd5dfa05cc568a97a4fb4d88ad483f3d4a147df7c2e6da3561e9d61f845a7',
     armv7l: '171bd5dfa05cc568a97a4fb4d88ad483f3d4a147df7c2e6da3561e9d61f845a7',
       i686: '8c4a682433e1b332055cac4c152d0b03687d0fc2ccde8ed9e39da3fa3f284600',
     x86_64: '70d5a0b54a59fa9c32cdeb22b9f02198cff7d319b4c8a78688ee992959f49371',
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
