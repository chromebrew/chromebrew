require 'package'

class Trapproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '3.4.3'
  source_url 'https://www.x.org/archive/individual/proto/trapproto-3.4.3.tar.gz'
  source_sha256 'abfb930b5703b5a6ebafe84d0246bd8c6b099ca4a4eab06d1dc0776a8a9b87c1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/trapproto-3.4.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/trapproto-3.4.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/trapproto-3.4.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/trapproto-3.4.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7dbd59055a60a472709faa5509ef70af77ff692e715351f5e20b98957bba0cbb',
     armv7l: '7dbd59055a60a472709faa5509ef70af77ff692e715351f5e20b98957bba0cbb',
       i686: '30c0f0087b36e214e0222d78e514e3546a7464131ef75ea8a4b9e129da5a0174',
     x86_64: 'd311d2bc9a52fe759f90d9030ff3d1d635c81863fdf2e5d8d14f8763b51f4330',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
