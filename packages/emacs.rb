require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '25.1'
  source_url 'ftp://ftp.gnu.org/gnu/emacs/emacs-25.1.tar.xz'
  source_sha1 '983e457971e3e3c8964d039c113033f98132b8a8'

  depends_on "zlibpkg" => :build
  depends_on "diffutils" => :build
  depends_on "m4" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def self.build
    system "./configure --prefix=/usr/local --without-x --without-makeinfo --without-selinux"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
