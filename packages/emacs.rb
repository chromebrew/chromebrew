require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '27.1'
  license 'GPL-3+, FPL-1.3+, BSD, HPND, MIT, W3C, unicode and PSF-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/emacs/emacs-28.2.tar.xz'
  source_sha256 'ee21182233ef3232dc97b486af2d86e14042dbb65bbc535df562c3a858232488'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/emacs/27.1_armv7l/emacs-27.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/emacs/27.1_armv7l/emacs-27.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/emacs/27.1_i686/emacs-27.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/emacs/27.1_x86_64/emacs-27.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9f30048fd5b6c8f3b2f05614a3df6fca3baee32b4493315d4792a5fee8d2005d',
     armv7l: '9f30048fd5b6c8f3b2f05614a3df6fca3baee32b4493315d4792a5fee8d2005d',
       i686: 'bab7151b034cf1bc21ae57ac9a3d21194d7422d4e4114bdd4948e0e7684c69af',
     x86_64: '091c0563f460d180c7c7c5229395c7ea036dab2dac0b11027a600bb7ecdaff5e'
  })

  depends_on 'lcms'
  depends_on 'libjpeg'
  depends_on 'acl' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'gnutls' # R
  depends_on 'jansson' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'zlibpkg' # R

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
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
