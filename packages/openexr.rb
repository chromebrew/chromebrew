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
    aarch64: '9a4bb82dd68fc8876cecfb623f72ecf5ab18b825938dda2815bc392a4f8b2e43',
     armv7l: '9a4bb82dd68fc8876cecfb623f72ecf5ab18b825938dda2815bc392a4f8b2e43',
       i686: 'c84b412281aa30e183a9666ac6e48e3b47ec3cf26bdd9b5ec55ef60207005dba',
     x86_64: '51813f086728c880085ed62cfe086786f76d2ececaebaf31c79fe5e151975b94'
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
