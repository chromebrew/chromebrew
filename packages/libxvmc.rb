require 'package'

class Libxvmc < Package
  description 'X.org X-Video Motion Compensation Library'
  homepage 'http://www.x.org'
  version '1.0.10'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXvMC-1.0.10.tar.gz'
  source_sha256 'd8306f71c798d10409bb181b747c2644e1d60c05773c742c12304ab5aa5c8436'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxvmc-1.0.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxvmc-1.0.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxvmc-1.0.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxvmc-1.0.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ac5519046391db14195055a0b9c48805b1cdc1120127a4e2c432efa6577165b9',
     armv7l: 'ac5519046391db14195055a0b9c48805b1cdc1120127a4e2c432efa6577165b9',
       i686: 'ae47a4220ce08f0e85c0e6ad8a207b857f335be8f1f8e5bc4547f287ec5ebfbd',
     x86_64: '2194a2e6fd9da51ba1f77f10940c1013a355b50995cc34ca882cb0cf41515734',
  })

  depends_on 'libxv'
  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
