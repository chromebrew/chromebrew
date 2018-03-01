require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '25.3'
  source_url 'https://ftp.gnu.org/gnu/emacs/emacs-25.3.tar.xz'
  source_sha256 '253ac5e7075e594549b83fd9ec116a9dc37294d415e2f21f8ee109829307c00b'
  
  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-25.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-25.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-25.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-25.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9efee852141ebcb349ec99766739ef2babbb6d7b83d66725e32b74d406ab2e49',
     armv7l: '9efee852141ebcb349ec99766739ef2babbb6d7b83d66725e32b74d406ab2e49',
       i686: '0f3710bd6cc4c1f0d6cf727328c94c829197dbae8423f8069bd08556ac68bbab',
     x86_64: 'd135d3f0ffd2cc536fe30fb8b1b002b63e086b4a2f6b56ebd89e451803372040',
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
