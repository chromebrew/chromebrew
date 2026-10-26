require 'buildsystems/autotools'

class Libunistring < Autotools
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  version '1.5'
  license 'LGPL-3+ or GPL-2+ and FDL-1.2 or GPL-3+'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libunistring/libunistring-#{version}.tar.xz"
  source_sha256 'fe89007a8a414ae4790b816b86859e877d3ab135db3c37f06541ff7e85ac344b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8a6c36e7d4f6273daffd3a2e90304a29c313c55d63de077f6115ca74b5bedb2f',
     armv7l: '8a6c36e7d4f6273daffd3a2e90304a29c313c55d63de077f6115ca74b5bedb2f',
       i686: '25456ca11e3c89145960433f75e34a4396c6bedc224f2620248977e44efebc98',
     x86_64: 'b62112f53a776d284b1112c426f8e2fc0cf6f735a6e3c015955d902e8327d9b9'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  autotools_skip_autogen

  autotools_configure_options '--enable-static \
      --enable-shared'

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
