require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '26.1'
  source_url 'https://ftp.gnu.org/gnu/emacs/emacs-26.1.tar.xz'
  source_sha256 '1cf4fc240cd77c25309d15e18593789c8dbfba5c2b44d8f77c886542300fd32c'

  depends_on 'libjpeg'
  depends_on 'libtiff'
  depends_on 'sommelier'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --localstatedir=#{CREW_PREFIX}/share \
            --with-x=yes \
            --with-x-toolkit=lucid \
            --with-gif=no \
            --without-makeinfo \
            --without-selinux"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
