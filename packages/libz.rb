require 'package'

class Libz < Package
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://www.zlib.net/'
  version '1.2.11'
  source_url 'https://www.zlib.net/zlib-1.2.11.tar.xz'
  source_sha256 '4ff941449631ace0d4d203e3483be9dbc9da454084111f97ea0a2114e19bf066'

  binary_url ({	
  })	
  binary_sha256 ({	
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
