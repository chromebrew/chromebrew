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
       i686: 'f8347980ff02d8fe3788a1fa7910beb5b012f25a2ecbbb8f28fca85d19c28cd0',
     x86_64: 'a25406089eec4ef61249c02927b2af2f20602eee7389409739041d5c777942f4'
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
