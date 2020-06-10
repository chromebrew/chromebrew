require 'package'

class Gsl < Package
  description 'The GNU Scientific Library (GSL) is a numerical library for C and C++ programmers.'
  homepage 'https://www.gnu.org/software/gsl/'
  version '2.4'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gsl/gsl-2.4.tar.gz'
  source_sha256 '4d46d07b946e7b31c19bbf33dda6204d7bedc2f5462a1bae1d4013426cd1ce9b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gsl-2.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gsl-2.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gsl-2.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gsl-2.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ee85df18a9d127654d37744df379772b18f23b9a6ea1d4c38eb50016bfe7dd27',
     armv7l: 'ee85df18a9d127654d37744df379772b18f23b9a6ea1d4c38eb50016bfe7dd27',
       i686: '600d5655dfbcef4bb58980ab4d0bd1b21b1d4e7aa9d2dd16ecaeb2fde7ad9714',
     x86_64: '865aefb630aae6987c0c4d56bf4c29f3279f61262552b9bec1ae970948b3868a',
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
