require 'package'

class Osl < Package
  description 'OpenScop is a Specification and a Library for Data Exchange in Polyhedral Compilation Tools'
  homepage 'https://github.com/periscop/openscop'
  version '0.9.2'
  source_url 'https://github.com/periscop/openscop/releases/download/0.9.2/osl-0.9.2.tar.gz'
  source_sha256 'eee5cd9bf5b3b8491f95f681cfaa987344f0fb3d7499f5d8e19e3ce75e0c5ed0'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system 'make', 'check'
  end
end
