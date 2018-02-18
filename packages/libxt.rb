require 'package'

class Libxt < Package
  description 'X.org X Toolkit Library'
  homepage 'http://www.x.org'
  version '1.1.5'
  source_url 'https://www.x.org/archive/individual/lib/libXt-1.1.5.tar.gz'
  source_sha256 'b59bee38a9935565fa49dc1bfe84cb30173e2e07e1dcdf801430d4b54eb0caa3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxt-1.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxt-1.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxt-1.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxt-1.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ee8648d4f454ef7fa606d52ed8d2cce97c5e3abff2dcfd74a12b873b41cf9bea',
     armv7l: 'ee8648d4f454ef7fa606d52ed8d2cce97c5e3abff2dcfd74a12b873b41cf9bea',
       i686: 'e14ffe76c72168b6221571cb0346ff9e067f3715c083772bb4fa2dd609b88162',
     x86_64: '0b177148872f51a9e26cdb188c745600034d455c42a6efb151fbd5816e86dabc',
  })

  depends_on 'kbproto'
  depends_on 'libsm'
  depends_on 'libx11'
  depends_on 'util_macros'  
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end