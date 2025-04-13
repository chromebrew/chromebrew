# Adapted from Arch Linux grep PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/grep/trunk/PKGBUILD

require 'buildsystems/autotools'

class Grep < Autotools
  description 'A string search utility'
  homepage 'https://www.gnu.org/software/grep/'
  version '3.12'
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/grep/grep-#{version}.tar.xz"
  source_sha256 '2649b27c0e90e632eadcd757be06c6e9a4f48d941de51e7c0f83ff76408a07b9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e26ffb1c929816e035a5e64a5140ae1acdc54a83f115478a907d407a31088a1c',
     armv7l: 'e26ffb1c929816e035a5e64a5140ae1acdc54a83f115478a907d407a31088a1c',
       i686: 'fec68b4cda61591f524d1ea7a2025f97d2b177006f013a26ebd3366e2e04f124',
     x86_64: '81670d54d70bebb2d2d0ae78016603838cb86d28dc844916f8b3d72d994504a0'
  })

  depends_on 'glibc' # R
  depends_on 'pcre2' # R

  # NOTE: built on i686 by removing the c11threads derived threads.h
  # installed by the chromebrew glibc package on this architecture.

  configure_options 'CPPFLAGS=-DHAVE_DYNAMIC_LIBPCRE --without-included-regex'

  # Section XFAIL test with grep: regexec.c:1344: pop_fail_stack: Assertion `num >= 0' failed.
  # run_tests
end
