require 'package'

class Popt < Package
  description 'Library for parsing command line options'
  homepage 'https://directory.fsf.org/wiki/Popt'
  version '1.16'
  source_url 'http://rpm5.org/files/popt/popt-1.16.tar.gz'
  source_sha256 'e728ed296fe9f069a0e005003c3d6b2dde3d9cad453422a10d6558616d304cc8'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "gzip -9 #{CREW_DEST_PREFIX}/share/man/man3/popt.3"
  end
end
