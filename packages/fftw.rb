require 'package'

class Fftw < Package
  description 'FFTW is a C subroutine library for computing the discrete Fourier transform (DFT) in one or more dimensions, of arbitrary input size, and of both real and complex data'
  homepage 'http://www.fftw.org/'
  version '3.3.8'
  compatibility 'all'
  source_url 'http://www.fftw.org/fftw-3.3.8.tar.gz'
  source_sha256 '6113262f6e92c5bd474f2875fa1b01054c4ad5040f6b0da7c03c98821d9ae303'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fftw-3.3.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fftw-3.3.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fftw-3.3.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fftw-3.3.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f3e94c3a07e8966eafe02daa3673de462bab1fbbb0f1aefcc844ffbc53c84307',
     armv7l: 'f3e94c3a07e8966eafe02daa3673de462bab1fbbb0f1aefcc844ffbc53c84307',
       i686: '03800193d0be4a716331a27a948022d0a6ac94183a6b2fe0a988f5d94e3e8ff9',
     x86_64: '47c9b73133cf16339ab6c229ba74ec73155f0fc1bf01bfd0e4e2c6ac7c46f78e',
  })

  def self.build
    system './configure',
           '--enable-shared=yes',
           '--disable-maintainer-mode',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
