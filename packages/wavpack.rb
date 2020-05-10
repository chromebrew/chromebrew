require 'package'

class Wavpack < Package
  description 'WavPack is a completely open audio compression format providing lossless, high-quality lossy, and a unique hybrid compression mode.'
  homepage 'http://www.wavpack.com/'
  version '5.1.0'
  compatibility 'all'
  source_url 'https://github.com/dbry/WavPack/archive/5.1.0.tar.gz'
  source_sha256 '1af7eaccbf560271013d4179d98ef6fc681a2bb3603382577eeba73d438785f4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wavpack-5.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wavpack-5.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wavpack-5.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wavpack-5.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0de1c309b6e2ae6cad6ebf4d3c0bae4bfa46e28d37752946e560208bf873eeec',
     armv7l: '0de1c309b6e2ae6cad6ebf4d3c0bae4bfa46e28d37752946e560208bf873eeec',
       i686: '29efcd53890903576f4fca002ea829172ad50ec0b4f3fd1360d8efdfe5e128de',
     x86_64: '956bf59eae3c4410bfc6ff95ea6f4e59513008fdcd0438dec586fa9bdfc208aa',
  })

  def self.build
    system './autogen.sh'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
