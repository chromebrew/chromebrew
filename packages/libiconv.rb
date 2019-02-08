require 'package'

class Libiconv < Package
  description 'GNU charset conversion library for libc which does not implement it.'
  homepage 'https://www.gnu.org/software/libiconv/'
  version '1.15-1'
  source_url 'https://ftpmirror.gnu.org/libiconv/libiconv-1.15.tar.gz'
  source_sha256 'ccf536620a45458d26ba83887a983b96827001e92a13847b45e4925cc8913178'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  def self.build
    system './configure',
           '--enable-shared',
           '--enable-static',
           '--enable-relocatable',
           "--prefix=#{CREW_PREFIX}",
           '--enable-extra-encodings',
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
