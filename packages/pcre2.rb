require 'buildsystems/cmake'

class Pcre2 < CMake
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org/'
  version '10.48'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/PCRE2Project/pcre2.git'
  git_hashtag "pcre2-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ecf1fa026d1a189d558a8d9740168e44879ba95eb8d9a17057a3fdefbbe1bbc',
     armv7l: '4ecf1fa026d1a189d558a8d9740168e44879ba95eb8d9a17057a3fdefbbe1bbc',
       i686: '81a213a95dd5ce9239d93a4104a17ed134a293fc136a3ab5fe9872306fb0b1ec',
     x86_64: 'd4972de5bec5b582c9c940a8023848893dcbe43d0ec92934b998e5cabde8a4d1'
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
