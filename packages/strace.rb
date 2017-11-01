require 'package'

class Strace < Package
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '4.19'
  source_url 'https://downloads.sourceforge.net/project/strace/strace/4.19/strace-4.19.tar.xz'
  source_sha256 '7c93ebc6c29280f47c24a0eb86873a99ccb2cac6512c60a60ba4ef99ab807281'

  binary_url ({
  })
  binary_sha256 ({
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
