require 'package'

class Gsl < Package
  description 'The GNU Scientific Library (GSL) is a numerical library for C and C++ programmers.'
  homepage 'https://www.gnu.org/software/gsl/'
  version '2.4'
  source_url 'https://ftpmirror.gnu.org/gsl/gsl-2.4.tar.gz'
  source_sha256 '4d46d07b946e7b31c19bbf33dda6204d7bedc2f5462a1bae1d4013426cd1ce9b'

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
  end
end
