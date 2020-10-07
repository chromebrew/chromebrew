require 'package'

class Gsl < Package
  description 'The GNU Scientific Library (GSL) is a numerical library for C and C++ programmers.'
  homepage 'https://www.gnu.org/software/gsl/'
  version '2.6'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gsl/gsl-2.6.tar.gz'
  source_sha256 'b782339fc7a38fe17689cb39966c4d821236c28018b6593ddb6fd59ee40786a8'


  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
