require 'package'

class Radare2 < Package
  description 'unix-like reverse engineering framework and commandline tools'
  homepage 'http://www.radare.org/r/'
  version '2.4.0'
  source_url 'https://github.com/radare/radare2/archive/2.4.0.tar.gz'
  source_sha256 'e2edef4d70c7bbbb47d04002ce9d384eb2fc9c0cd4cbfde77cda8c10cae9ff24'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'openssl'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-openssl'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
