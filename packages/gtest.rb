require 'package'

class Gtest < Package
  description 'Google Test - C++ testing utility'
  version '1.10.0-389c'
  compatibility 'all'
  source_url 'https://github.com/google/googletest/archive/389cb68b87193358358ae87cc56d257fd0d80189.zip'
  source_sha256 '763e20249e76417bed7ebc44aa85fedf5fbac6f9fb6d30bddb628ab07ebf04f5'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtest-1.10.0-389c-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtest-1.10.0-389c-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtest-1.10.0-389c-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtest-1.10.0-389c-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '4c1dde1b6562fca74a35cd29f627d57ce06e6fb77b1873c34be7e75200ce5826',
      armv7l: '4c1dde1b6562fca74a35cd29f627d57ce06e6fb77b1873c34be7e75200ce5826',
        i686: '111db3afcc8f26d2a9e2d04221c99a8514d786da64fdc06349ea3665eaa3ea86',
      x86_64: '560e28bcf87d89c9c076f0d094c8cfb461392e68679b7d833038a18c4d3c2fa2',
  })


  case ARCH
  when 'aarch64','armv7l'
    ARCH_C_FLAGS = '-march=armv7-a -mcpu=cortex-a15 -mfloat-abi=hard -I/usr/local/include/c++/v1'
    ARCH_CXX_FLAGS = '-march=armv7-a -mcpu=cortex-a15 -mfloat-abi=hard -I/usr/local/include/c++/v1'
  when 'i686','x86_64'
    ARCH_C_FLAGS = ''
    ARCH_CXX_FLAGS = ''
  end
  
    def self.build
      system "sed -E \"s|(GOOGLETEST_VERSION) [0-9\\.]+|\\1 1.10.0|\" -i CMakeLists.txt"
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} cmake -G Ninja \
       -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}  \
       -DCMAKE_BUILD_TYPE=Release \
       -Dgtest_build_tests=OFF \
       -DCMAKE_C_COMPILER=$(which clang) \
       -DCMAKE_CXX_COMPILER=$(which clang++) \
       -DCMAKE_C_FLAGS='#{ARCH_C_FLAGS}' \
       -DCMAKE_CXX_FLAGS='#{ARCH_CXX_FLAGS}' \
       -DCMAKE_LINKER=$(which lld) \
       -DCMAKE_AR=$(which llvm-ar) \
       -DCMAKE_RANLIB=$(which llvm-ranlib) \
       -Bbuilddir"
      system 'ninja -C builddir'
    end
    
    def self.install
      system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    end
end
