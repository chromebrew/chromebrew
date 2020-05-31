require 'package'

class Swig < Package
  description 'Simplified Wrapper and Interface Generator'
  homepage 'http://www.swig.org'
  version '4.0.1'
  source_url 'http://prdownloads.sourceforge.net/swig/swig-4.0.1.tar.gz'
  source_sha256 '7a00b4d0d53ad97a14316135e2d702091cd5f193bb58bcfcd8bc59d41e7887a9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/swig-4.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/swig-4.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/swig-4.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/swig-4.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bfcc6357fed1a729192a5f94fcb0a42ce9a391c71e973a5c71663bcec5758409',
     armv7l: 'bfcc6357fed1a729192a5f94fcb0a42ce9a391c71e973a5c71663bcec5758409',
       i686: 'd6f872741b8f4c6fb572db6d4e62a4259c43d7de5c3b879db20db4f9799a5d19',
     x86_64: '55ba83675fb3106cb101f487d5d758c845d8cea922abaec52307f5f261fea1b5',
  })

  depends_on 'pcre'
  depends_on 'zlibpkg'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
