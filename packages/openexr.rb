require 'buildsystems/cmake'

class Openexr < CMake
  description 'OpenEXR is a high dynamic-range (HDR) image file format developed by Industrial Light & Magic for use in computer imaging applications.'
  homepage 'https://openexr.com/en/latest/'
  version '3.5.5'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/AcademySoftwareFoundation/openexr.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '22e244044f26a16b7cf2b7aca5ecfd96773c9a6305f51440dcc334d3786526b7',
     armv7l: '22e244044f26a16b7cf2b7aca5ecfd96773c9a6305f51440dcc334d3786526b7',
       i686: '854e82707b852ca10332b27a81d1aa88c38ca200fbb74e884c48ce3aadbe9f21',
     x86_64: 'b1cdec04246a5446a186ddbbbe2066031d23b4e91ffff121b81f4b5c2c362f99'
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
