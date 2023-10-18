require 'buildsystems/cmake'

class Abseil_cpp < CMake
  description 'Abseil Common Libraries C++'
  homepage 'https://abseil.io/'
  version '20230802.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/abseil/abseil-cpp/archive/#{version}.tar.gz"
  source_sha256 '987ce98f02eefbaf930d6e38ab16aa05737234d7afbab2d5c4ea7adbe50c28ed'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/abseil_cpp/20230802.1_armv7l/abseil_cpp-20230802.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/abseil_cpp/20230802.1_armv7l/abseil_cpp-20230802.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/abseil_cpp/20230802.1_i686/abseil_cpp-20230802.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/abseil_cpp/20230802.1_x86_64/abseil_cpp-20230802.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a51a050572ebc8f1243f20c2d9816d521b79782b98fce3cfd9705966b03fe7ae',
     armv7l: 'a51a050572ebc8f1243f20c2d9816d521b79782b98fce3cfd9705966b03fe7ae',
       i686: '6ea06e63a8d1cb44251f15742ab1c1e6cd221cb356b650f7580b9b475368da3e',
     x86_64: '3c413c2009fdab56fb499d63104fefcbde3ebcdbb772a0fce1e43cd580ec67f6'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DCMAKE_CXX_STANDARD=17 \
        -DABSL_CXX_STANDARD=17 \
        -DABSL_USE_GOOGLETEST_HEAD=ON \
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
        -DABSL_ENABLE_INSTALL=ON \
        -DCMAKE_MODULE_LINKER_FLAGS=\"-Wl,--no-undefined -Wl,--no-undefined\" \
        -DBUILD_SHARED_LIBS=ON'
end
