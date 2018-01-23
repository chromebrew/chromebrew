require 'package'

class Strace < Package
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '4.19'
  source_url 'https://downloads.sourceforge.net/project/strace/strace/4.19/strace-4.19.tar.xz'
  source_sha256 '7c93ebc6c29280f47c24a0eb86873a99ccb2cac6512c60a60ba4ef99ab807281'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/strace-4.19-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/strace-4.19-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/strace-4.19-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/strace-4.19-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'adf4e8647fc1704a807811e38dc86d750ba520b372c1e1f577e39e094fe7a64b',
     armv7l: 'adf4e8647fc1704a807811e38dc86d750ba520b372c1e1f577e39e094fe7a64b',
       i686: '223bd03968d2c19a3d9a20df07dc9e14dab8520386053b2f2a32d2cfdc865316',
     x86_64: '3e55cfd9b94a71ad590e023d24ec1a5830c4780f1d9e35eacd462fd3086c0dc3',
  })

  depends_on 'buildessential'

  def self.build
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
