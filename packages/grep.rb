# Adapted from Arch Linux grep PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/grep/trunk/PKGBUILD

require 'package'

class Grep < Package
  description 'A string search utility'
  homepage 'https://www.gnu.org/software/grep/'
  version '3.11'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/grep/grep-3.11.tar.xz'
  source_sha256 '1db2aedde89d0dea42b16d9528f894c8d15dae4e190b59aecc78f5a951276eab'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e26ffb1c929816e035a5e64a5140ae1acdc54a83f115478a907d407a31088a1c',
     armv7l: 'e26ffb1c929816e035a5e64a5140ae1acdc54a83f115478a907d407a31088a1c',
       i686: 'c91c85ea8ee3f7d604b4d0a46041918d94fcbec8dfe7f9e35c5eb8478535649c',
     x86_64: '337ed11dee1a3d584105e0b5b4a3ec32bd658ebaa9674a1513223348e457a5b3'
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
