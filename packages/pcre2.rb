require 'buildsystems/cmake'

class Pcre2 < CMake
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org/'
  version '10.45'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/PCRE2Project/pcre2.git'
  git_hashtag "pcre2-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '880eb9d98a13f8532d61d6d414890ab3a5f40f3249d23f85ed097bc9d4650deb',
     armv7l: '880eb9d98a13f8532d61d6d414890ab3a5f40f3249d23f85ed097bc9d4650deb',
       i686: '26c073a2c61b004b2761027cf8a83f752be37098af3a9b7e2d645755d178c657',
     x86_64: '73979e8695cb42e2cac7e6384711170dd3fd3af6734a4db5cf3ce18c72f3cdf9'
  })

  depends_on 'bzip2' # R
  depends_on 'glibc' # R
  depends_on 'readline' # R
  depends_on 'zlib' # R

  cmake_options '-DPCRE2_BUILD_TESTS=OFF \
      -DBUILD_SHARED_LIBS=ON \
      -DPCRE2_SUPPORT_JIT=ON \
      -DPCRE2_STATIC_PIC=ON \
      -DPCRE2_BUILD_PCRE2_16=ON \
      -DPCRE2_BUILD_PCRE2_32=ON'
end
