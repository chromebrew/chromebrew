require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '26.1-1'
  source_url 'https://ftp.gnu.org/gnu/emacs/emacs-26.1.tar.xz'
  source_sha256 '1cf4fc240cd77c25309d15e18593789c8dbfba5c2b44d8f77c886542300fd32c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f932a0b4ef4e33e230abd07d39ba12e6661304b2baaddacc5f03470d355dd021',
     armv7l: 'f932a0b4ef4e33e230abd07d39ba12e6661304b2baaddacc5f03470d355dd021',
       i686: 'd5b9fed4b9f42e04da7b326d339e23a1b6cf0367885a413e5dfbff4f90c9feef',
     x86_64: '20adfa13c8b999da71d4efe1c6e86521ad83481e1d593bdcab20eac5c2cb589e',
  })

  depends_on 'lcms'
  depends_on 'libjpeg'

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
