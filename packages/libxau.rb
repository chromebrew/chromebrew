require 'package'

class Libxau < Package
  description 'xau library for libX11'
  homepage 'https://x.org'
  version '1.0.9'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXau-1.0.9.tar.bz2'
  source_sha256 'ccf8cbf0dbf676faa2ea0a6d64bcc3b6746064722b606c8c52917ed00dcb73ec'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ef6e137ebb752f4015495c60acea0ab17efa50391f4d133e61d25859c791d452',
     armv7l: 'ef6e137ebb752f4015495c60acea0ab17efa50391f4d133e61d25859c791d452',
       i686: '4343e16f6c9bf01c4234a194e7478b45542c58abb0affa1032c2ae9c5abe802c',
     x86_64: '6fe73440b9a5a242617a8a0a4e55a5c2e18fe070e6842852a89b95e23fcd1aa5',
  })

  depends_on 'xorg_proto'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
