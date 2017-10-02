require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '25.2'
  source_url 'https://ftp.gnu.org/gnu/emacs/emacs-25.2.tar.xz'
  source_sha256 '59b55194c9979987c5e9f1a1a4ab5406714e80ffcfd415cc6b9222413bc073fa'

  depends_on 'zlibpkg' => :build
  depends_on 'diffutils' => :build
  depends_on 'm4' => :build
  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'ncurses'

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
