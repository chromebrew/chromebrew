require 'buildsystems/cmake'

class Tinyxml2 < CMake
  description 'TinyXML2 is a simple, small, efficient, C++ XML parser that can be easily integrated into other programs.'
  homepage 'https://github.com/leethomason/tinyxml2'
  version '11.0.0'
  license 'zlib'
  compatibility 'all'
  source_url 'https://github.com/leethomason/tinyxml2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '340cb19cc859fb541c2b3498191253d5247fd2eee821cdf740ca5fd6c40468e4',
     armv7l: '340cb19cc859fb541c2b3498191253d5247fd2eee821cdf740ca5fd6c40468e4',
       i686: '638051933e59355ec33535b9c5a6466ad6bf3698845d56b7ae98986090cb6904',
     x86_64: 'c5f39cf3f75a8d0e547a1ac31236e84260f9785feec31cb84c668c9e8e54e641'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
  run_tests
end
