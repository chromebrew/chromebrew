require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.24.1'
  compatibility 'all'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.24.1.tar.bz2'
  source_sha256 'fdd5b4ee1916af7b1d402e7dd467f05df7624bb65fb95a0875a03712ecc2d6fd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.24.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.24.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.24.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.24.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1dbede14eac9364679565683f4473cb11996bf126b2317f8e707ff00337481ea',
     armv7l: '1dbede14eac9364679565683f4473cb11996bf126b2317f8e707ff00337481ea',
       i686: 'a105e9a6c565aad505e85cdf0618a272cd4d4efde09fb20fed768172bc8f841a',
     x86_64: '7e61216d322cf0acc5c564cfc5b83663b8593ec420f22410943572ebde1f2aea',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
