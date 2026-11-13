require 'buildsystems/cmake'

class Openexr < CMake
  description 'OpenEXR is a high dynamic-range (HDR) image file format developed by Industrial Light & Magic for use in computer imaging applications.'
  homepage 'https://openexr.com/en/latest/'
  version '3.5.4'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/AcademySoftwareFoundation/openexr.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '577550659940b6bacbc90508bb1d799ad12e014c49ee04d8ca35eb7f62053585',
     armv7l: '577550659940b6bacbc90508bb1d799ad12e014c49ee04d8ca35eb7f62053585',
       i686: '09bb86426de7e0ffa00a8220bd2f3e386d6e2f261480e83979297bd53198f520',
     x86_64: '6ee4eb23cdc5fbe21ea7a413bc1e809dc089d29d6124084fc024ae664e81eb58'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libdeflate' => :library
  depends_on 'zstd' => :library

  def self.prebuild
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
