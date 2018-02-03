require 'package'

class Libconfig < Package
  description 'C/C++ Configuration File Library.'
  homepage 'https://hyperrealm.github.io/libconfig/'
  version '1.7.2'
  source_url 'https://hyperrealm.github.io/libconfig/dist/libconfig-1.7.2.tar.gz'
  source_sha256 '7c3c7a9c73ff3302084386e96f903eb62ce06953bb1666235fac74363a16fad9'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}" 
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
