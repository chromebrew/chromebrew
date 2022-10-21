require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '28.2'
  license 'GPL-3+, FDL-1.3+, BSD, HPND, MIT, W3C, unicode, PSF-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/emacs/emacs-28.2.tar.xz'
  source_sha256 'ee21182233ef3232dc97b486af2d86e14042dbb65bbc535df562c3a858232488'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/emacs/28.2_armv7l/emacs-28.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/emacs/28.2_armv7l/emacs-28.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/emacs/28.2_i686/emacs-28.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/emacs/28.2_x86_64/emacs-28.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '75da5d9c23128eb2044521a7ac32ec7555cbc0701c8deaf3f1c3e468754a06b9',
     armv7l: '75da5d9c23128eb2044521a7ac32ec7555cbc0701c8deaf3f1c3e468754a06b9',
       i686: '07db3ae8c5b1c955e5f135219205e3676ad594918a2aa3bebdce1f40d872c78a',
     x86_64: 'd8141d6c94e921252618ae06dd3f27a8f581f4bfe5fb8f244233e3aef5124777'
  })

  depends_on 'lcms'
  depends_on 'libjpeg'
  depends_on 'acl' # R
  depends_on 'alsa_lib' # R
  depends_on 'dbus' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'gnutls' # R
  depends_on 'gpm' # R
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
