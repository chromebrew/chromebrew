require 'package'

class Libedit < Package
  description 'This is an autotool and libtoolized port of the NetBSD Editline library (libedit).'
  homepage 'http://thrysoee.dk/editline/'
  version '3.1-0'
  compatibility 'all'
  source_url 'https://thrysoee.dk/editline/libedit-20170329-3.1.tar.gz'
  source_sha256 '91f2d90fbd2a048ff6dad7131d9a39e690fd8a8fd982a353f1333dd4017dd4be'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libedit-3.1-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libedit-3.1-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libedit-3.1-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libedit-3.1-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '90f9db2636bdcae5cb4c8d6a0d020398b13c6290164c27776507689bc5fc85be',
     armv7l: '90f9db2636bdcae5cb4c8d6a0d020398b13c6290164c27776507689bc5fc85be',
       i686: '0590ee8aa7923a29332aa436ff42b909cf968c7ab50121df43539d968e3c496f',
     x86_64: '6f6ed8dd83aad5895b5e3927c673d66c5d676a345f3bc6913e94392a74db929a',
  })

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            CPPFLAGS=\"-I#{CREW_PREFIX}/include/ncurses\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
