require 'package'

class Gemacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '26.1'
  source_url 'https://ftp.gnu.org/gnu/emacs/emacs-26.1.tar.xz'
  source_sha256 '1cf4fc240cd77c25309d15e18593789c8dbfba5c2b44d8f77c886542300fd32c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4ded760607b64f706cc83b92042609845f8213a697bc82a931f04ddcf1c94a17',
     armv7l: '4ded760607b64f706cc83b92042609845f8213a697bc82a931f04ddcf1c94a17',
       i686: 'f8c514abd49a4a8aefa6235918d442d75d1a722e9558cd741246769cfeb9c8da',
     x86_64: '7d646d49bec0acf2c7eb79ff589c6f311537233565f43646dafa927de1adbb8c',
  })

  depends_on 'emacs'
  depends_on 'giflib'
  depends_on 'libjpeg'
  depends_on 'libtiff'
  depends_on 'sommelier'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --localstatedir=#{CREW_PREFIX}/share \
            --with-x=yes \
            --with-x-toolkit=lucid \
            --with-gif=yes \
            --without-makeinfo \
            --without-selinux"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "rm -rf #{CREW_DEST_DIR}"
    system "install -Dm755 src/emacs #{CREW_DEST_PREFIX}/bin/gemacs"
    system "install -Dm755 src/emacs-26.1.1 #{CREW_DEST_PREFIX}/bin/gemacs-26.1.1"
  end
end
