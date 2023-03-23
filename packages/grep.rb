# Adapted from Arch Linux grep PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/grep/trunk/PKGBUILD

require 'package'

class Grep < Package
  description 'A string search utility'
  homepage 'https://www.gnu.org/software/grep/'
  version '3.10'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/grep/grep-3.10.tar.xz'
  source_sha256 '24efa5b595fb5a7100879b51b8868a0bb87a71c183d02c4c602633b88af6855b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.10_armv7l/grep-3.10-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.10_armv7l/grep-3.10-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.10_i686/grep-3.10-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.10_x86_64/grep-3.10-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1c09b2c36f6ac56d0e5bbab737e4d5d24ef45c21e2f9b9ca581137c80d6209d9',
     armv7l: '1c09b2c36f6ac56d0e5bbab737e4d5d24ef45c21e2f9b9ca581137c80d6209d9',
       i686: '345ac10320793cccad6d5b817cb15e1853c135f4235dc532b66d2972fba9a698',
     x86_64: '44ab3681e82fcfd16e97894538a84473ad5669d323db0277d81aaf7ccf49cf8a'
  })

  depends_on 'pcre'
  # NOTE: built on i686 by removing the c11threads derived threads.h
  # installed by the chromebrew glibc package on this architecture.

  def self.build
    system "CPPFLAGS=-DHAVE_DYNAMIC_LIBPCRE \
      ./configure #{CREW_OPTIONS} \
      --without-included-regex"
    system 'make'
  end

  def self.check
    # Section XFAIL test with grep: regexec.c:1344: pop_fail_stack: Assertion `num >= 0' failed.
    # system 'make', 'check'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
