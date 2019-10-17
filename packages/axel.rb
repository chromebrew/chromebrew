require 'package'

class Axel < Package
  description 'Light command line download accelerator for Linux and Unix'
  homepage 'https://github.com/axel-download-accelerator/axel'
  version '2.17.6'
  source_url 'https://github.com/axel-download-accelerator/axel/releases/download/v2.17.6/axel-2.17.6.tar.xz'
  source_sha256 '24ab549021bdfca01ad5e8e95b706869dd30fe9ab1043da4cbb9dff89edc267d'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
