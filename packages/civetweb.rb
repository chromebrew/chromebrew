require 'buildsystems/cmake'

class Civetweb < CMake
  description 'Embedded C/C++ web server'
  homepage 'https://github.com/civetweb/civetweb/'
  version '1.16'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/civetweb/civetweb.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5fb14b489952ec14441dfb8d46963c7a649212e771f38348d4c543ea0a884914',
     armv7l: '5fb14b489952ec14441dfb8d46963c7a649212e771f38348d4c543ea0a884914',
       i686: '7510b42696d93f2e6758a108d468de165e87d786da4e4593e648f374175bfc44',
     x86_64: '0882f5f23adf43bb16669240e5996cbe97ffe737e711838c57109d0a69803403'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
    -DBUILD_TESTING=OFF \
    -DBUILD_SHARED_LIBS=ON \
    -DCIVETWEB_BUILD_TESTING=OFF \
    -DCIVETWEB_ENABLE_LUA=OFF \
    -DCIVETWEB_ENABLE_DUKTAPE=OFF \
    -DCIVETWEB_ENABLE_CXX=ON \
    -DCIVETWEB_ENABLE_SERVER_EXECUTABLE=ON \
    -DCIVETWEB_ENABLE_SSL=ON'
end
