require 'buildsystems/cmake'

class Pcre2 < CMake
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org/'
  version '10.47'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/PCRE2Project/pcre2.git'
  git_hashtag "pcre2-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7ea96601b02228bed691562eaeee0cceb16afc51f9e936dd70d40cbfd5de10f7',
     armv7l: '7ea96601b02228bed691562eaeee0cceb16afc51f9e936dd70d40cbfd5de10f7',
       i686: 'b9da911c67074d3e4d39dc804ff5f8543027af30edc8dc312807bef601704171',
     x86_64: '864929a9e9e90827d72dc6223b1832c71a5a09c98cfd86731c5266c1fe05a3d8'
  })

  depends_on 'bzip2' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R

  cmake_options '-DPCRE2_BUILD_TESTS=OFF \
      -DBUILD_SHARED_LIBS=ON \
      -DPCRE2_SUPPORT_JIT=ON \
      -DPCRE2_STATIC_PIC=ON \
      -DPCRE2_BUILD_PCRE2_16=ON \
      -DPCRE2_BUILD_PCRE2_32=ON'
end
