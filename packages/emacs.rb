require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '29.1'
  license 'GPL-3+, FDL-1.3+, BSD, HPND, MIT, W3C, unicode, PSF-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/emacs/emacs-29.1.tar.xz'
  source_sha256 'd2f881a5cc231e2f5a03e86f4584b0438f83edd7598a09d24a21bd8d003e2e01'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/emacs/29.1_armv7l/emacs-29.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/emacs/29.1_armv7l/emacs-29.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/emacs/29.1_i686/emacs-29.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/emacs/29.1_x86_64/emacs-29.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6ae43bf5c3b04727fd8c2879b94605ce8d3a79c5cbed32c76fd2ec0a55a34ee2',
     armv7l: '6ae43bf5c3b04727fd8c2879b94605ce8d3a79c5cbed32c76fd2ec0a55a34ee2',
       i686: 'd1de460ee14a986d212a9167f74b228e9a67acb1c12ce3b3e85fe0606d55ee1a',
     x86_64: '54767b9f97dae52ee3b6ad63494a1a02b7d9c8f539ad15dc91ef49a4f939c2eb'
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
  depends_on 'sqlite' # R

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
