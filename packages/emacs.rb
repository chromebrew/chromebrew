require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '25.3'
  source_url 'https://ftp.gnu.org/gnu/emacs/emacs-25.3.tar.xz'
  source_sha256 '253ac5e7075e594549b83fd9ec116a9dc37294d415e2f21f8ee109829307c00b'
  
  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-25.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-25.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-25.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-25.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e363433a22286d83b06ec9a52b582eda470846d9fdb524243814453fa47308af',
     armv7l: 'e363433a22286d83b06ec9a52b582eda470846d9fdb524243814453fa47308af',
       i686: '8fb595ff0dc2f655282fba1a6e9c495005a33e07fa3bfba8c2710a64e67e8a1d',
     x86_64: '30f1312efda0b2bfed72e889b563bf39fbbbf4f5feeb9329a7a09106ffa53f64',
  })

  depends_on "zlibpkg" => :build
  depends_on "diffutils" => :build
  depends_on "m4" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "ncurses"

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --localstatedir=#{CREW_PREFIX}/share \
            --with-x=no \
            --without-makeinfo \
            --without-selinux"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
