require 'package'

class Libcheck < Package
  description 'A unit testing framework for C'
  homepage 'https://github.com/libcheck/check'
  version '0.11.0-0'
  source_url 'https://github.com/libcheck/check/releases/download/0.11.0/check-0.11.0.tar.gz'
  source_sha256 '24f7a48aae6b74755bcbe964ce8bc7240f6ced2141f8d9cf480bc3b3de0d5616'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcheck-0.11.0-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcheck-0.11.0-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcheck-0.11.0-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcheck-0.11.0-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bb35c44e7ea979923f5965d786afd1bce8a2b6f45ae2c9bfceafae618a7aaea8',
     armv7l: 'bb35c44e7ea979923f5965d786afd1bce8a2b6f45ae2c9bfceafae618a7aaea8',
       i686: 'bc74db11668432c9040041bcef70b2c0fe4c6451a315c97b8553360a76b09147',
     x86_64: 'bdb2058fa22945b9664cfc36a1357f6551f752594a9941106a9e58883c7a78fc',
  })

  depends_on 'libtool'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
