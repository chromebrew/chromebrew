require 'package'

class Strace < Package
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '4.16'
  source_url 'https://downloads.sourceforge.net/project/strace/strace/4.16/strace-4.16.tar.xz'
  source_sha256 '98487cb5178ec1259986cc9f6e2a844f50e5d1208c112cc22431a1e4d9adf0ef'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/strace-4.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/strace-4.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/strace-4.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/strace-4.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7bf6778f92a4b12849007140824a70a35be7603678b0d7f234c41b6684518f92',
     armv7l: '7bf6778f92a4b12849007140824a70a35be7603678b0d7f234c41b6684518f92',
       i686: 'bdac2c189562f9c06dcd4230552998bbeb5b4f77a60f7cc383ec28b944e8b0c4',
     x86_64: 'f54ad4974c5ecb29f2b2000e4953b715e6fde2598a3db9b6fa3d9dc5683c6036',
  })

  depends_on 'buildessential'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
