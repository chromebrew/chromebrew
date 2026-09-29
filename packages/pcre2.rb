require 'buildsystems/cmake'

class Pcre2 < CMake
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org/'
  version '10.49'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/PCRE2Project/pcre2.git'
  git_hashtag "pcre2-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '00adb66d1e03f3a601a64619d9f9fc0b9a23173d697adaf251e8393f74e36a89',
     armv7l: '00adb66d1e03f3a601a64619d9f9fc0b9a23173d697adaf251e8393f74e36a89',
       i686: 'ce37b97c7e2998c0ae04b5a60706e8513a4df745ec1aacd9f774838bf5bf9972',
     x86_64: 'f94867166ded90b519646cb2eae01480fe4576432def4b0d4b067d4547e6e1dc'
  })

  depends_on 'bzip2' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zlib' => :executable

  cmake_options '-DPCRE2_BUILD_TESTS=OFF \
      -DBUILD_SHARED_LIBS=ON \
      -DPCRE2_SUPPORT_JIT=ON \
      -DPCRE2_STATIC_PIC=ON \
      -DPCRE2_BUILD_PCRE2_16=ON \
      -DPCRE2_BUILD_PCRE2_32=ON'
end
