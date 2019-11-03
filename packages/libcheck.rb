require 'package'

class Libcheck < Package
  description 'A unit testing framework for C'
  homepage 'https://github.com/libcheck/check'
  version '0.13.0'
  source_url 'https://github.com/libcheck/check/releases/download/0.13.0/check-0.13.0.tar.gz'
  source_sha256 'c4336b31447acc7e3266854f73ec188cdb15554d0edd44739631da174a569909'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'autoreconf --install'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
