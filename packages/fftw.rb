require 'package'

class Fftw < Package
  description 'FFTW is a C subroutine library for computing the discrete Fourier transform (DFT) in one or more dimensions, of arbitrary input size, and of both real and complex data'
  homepage 'http://www.fftw.org/'
  @_ver = '3.3.9'
  version @_ver
  compatibility 'all'
  source_url "http://www.fftw.org/fftw-#{@_ver}.tar.gz"
  source_sha256 'bf2c7ce40b04ae811af714deb512510cc2c17b9ab9d6ddcf49fe4487eea7af3d'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fftw-3.3.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fftw-3.3.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fftw-3.3.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fftw-3.3.9-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6c5328195b9c1fccaa1ed40c642706d4681bc7cf77429cefcab3b44280db1428',
     armv7l: '6c5328195b9c1fccaa1ed40c642706d4681bc7cf77429cefcab3b44280db1428',
       i686: 'dab931ee59bb137e8a8f644670cc3d645a59cc2ca765b055aa35a8dc51a52344',
     x86_64: '095ec26abe2d9ede1c9c3016850b5e5be43706a102a184de26f93928014e7740'
  })

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --enable-shared=yes \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
