# Adapted from Arch Linux grep PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/grep/trunk/PKGBUILD

require 'package'

class Grep < Package
  description 'A string search utility'
  homepage 'https://www.gnu.org/software/grep/'
  version '3.9'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/grep/grep-3.9.tar.xz'
  source_sha256 'abcd11409ee23d4caf35feb422e53bbac867014cfeed313bb5f488aca170b599'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.9_armv7l/grep-3.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.9_armv7l/grep-3.9-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.9_i686/grep-3.9-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.9_x86_64/grep-3.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a6154af6e4abc36435d339cd91b826b9c8f535f022ed8e69e3319f691f300905',
     armv7l: 'a6154af6e4abc36435d339cd91b826b9c8f535f022ed8e69e3319f691f300905',
       i686: 'beb06a03aa72c063905589811b3e7c917d149bb476703c9012e56e965076cede',
     x86_64: 'a2162b32e3d4042f82583edeccfcdbb2aad61790c54e7169f758b45b179b42d9'
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
