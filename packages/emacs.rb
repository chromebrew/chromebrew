require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '25.3'
  source_url 'https://ftp.gnu.org/gnu/emacs/emacs-25.3.tar.xz'
  source_sha256 '253ac5e7075e594549b83fd9ec116a9dc37294d415e2f21f8ee109829307c00b'
  
  binary_url ({
  })
  binary_sha256 ({
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
