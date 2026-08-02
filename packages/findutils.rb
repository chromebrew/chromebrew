require 'buildsystems/autotools'

class Findutils < Autotools
  description 'the basic directory searching utilities of the GNU operating system'
  homepage 'https://www.gnu.org/software/findutils/'
  version '4.11.0'
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/findutils/findutils-#{version}.tar.xz"
  source_sha256 'bfd19cb06cc71f3352d567e90284d8cdac02ac89774bbeadf0b533b0c11432fd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f197c6fc628e381a2d1d84c86876b031781d11e710d1ed9824e9c85e1dee09a1',
     armv7l: 'f197c6fc628e381a2d1d84c86876b031781d11e710d1ed9824e9c85e1dee09a1',
       i686: '60b9d443529dc240da3b6b596488e5162da5cce9118019675a77a3c906812450',
     x86_64: '5ac24168fe8efeb0a4c3a0e64f959d91505abff737897c6e1df4c444cd7665d8'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :executable
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :build

  run_tests

  autotools_configure_options "--without-selinux #{'--disable-year2038' unless ARCH.eql?('x86_64')}"

  def self.patch
    # The c11threads threads.h breaks builds on software that uses gnulib.
    # See: https://github.com/jtsiomb/c11threads/issues/19
    # Note that c11threads is a workaround for C11 Threads only being
    # introduced in Glibc 2.28 as per:
    # https://sourceware.org/bugzilla/show_bug.cgi?id=14092#c10
    if LIBC_VERSION.to_f < 2.28 && ENV['NESTED_CI']
      puts 'Removing the c11threads include/threads.h from the c11threads package to prevent build failures.'.orange
      FileUtils.rm_f "#{CREW_PREFIX}/include/threads.h"
    end
  end
end
