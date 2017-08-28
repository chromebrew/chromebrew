require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'http://libuv.org/'
  version '1.9.1'
  source_url 'http://dist.libuv.org/dist/v1.9.1/libuv-v1.9.1.tar.gz'
  source_sha256 'e83953782c916d7822ef0b94e8115ce5756fab5300cca173f0de5f5b0e0ae928'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4f39008b460b6762a5d0d535124bca9825be1e42a7919006f2be63dc38dee0e8',
     armv7l: '4f39008b460b6762a5d0d535124bca9825be1e42a7919006f2be63dc38dee0e8',
       i686: '1db5d574b282aaee557f6b062f290cf48989e839c3b6b2bb6ddcb9fea1ce57ee',
     x86_64: 'ede50a331c2baa80058efcfe2ac83fc3f5ff6c4a6f985148a6f6d32f95154a71',
  })

  depends_on 'glibc'

  def self.build
    system './autogen.sh'
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
