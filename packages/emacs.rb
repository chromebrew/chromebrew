require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '29.1'
  license 'GPL-3+, FDL-1.3+, BSD, HPND, MIT, W3C, unicode, PSF-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://ftp.gnu.org/gnu/emacs/emacs-29.1.tar.xz'
  source_sha256 'd2f881a5cc231e2f5a03e86f4584b0438f83edd7598a09d24a21bd8d003e2e01'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ae43bf5c3b04727fd8c2879b94605ce8d3a79c5cbed32c76fd2ec0a55a34ee2',
     armv7l: '6ae43bf5c3b04727fd8c2879b94605ce8d3a79c5cbed32c76fd2ec0a55a34ee2',
       i686: 'd1de460ee14a986d212a9167f74b228e9a67acb1c12ce3b3e85fe0606d55ee1a',
     x86_64: '54767b9f97dae52ee3b6ad63494a1a02b7d9c8f539ad15dc91ef49a4f939c2eb'
  })

  depends_on 'acl' => :executable_only
  depends_on 'alsa_lib' => :executable_only
  depends_on 'dbus' => :executable_only
  depends_on 'glibc' # R
  depends_on 'glibc' => :executable_only
  depends_on 'gmp' => :executable_only
  depends_on 'gnutls' => :executable_only
  depends_on 'gpm' => :executable_only
  depends_on 'jansson' => :executable_only
  depends_on 'lcms'
  depends_on 'lcms' => :executable_only
  depends_on 'libjpeg_turbo'
  depends_on 'libxml2' # R
  depends_on 'ncurses' => :executable_only
  depends_on 'sqlite' => :executable_only
  depends_on 'zlib' => :executable_only

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
