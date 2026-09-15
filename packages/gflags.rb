require 'buildsystems/cmake'

class Gflags < CMake
  description 'C++ library that implements commandline flags processing'
  homepage 'https://gflags.github.io/gflags/'
  version '2.3.1'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/gflags/gflags.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06c5ccea5dc7e04ffa10f5c9eecba9ecc3be8635687c4bf9db6715a372117ff7',
     armv7l: '06c5ccea5dc7e04ffa10f5c9eecba9ecc3be8635687c4bf9db6715a372117ff7',
       i686: '4c487f044016982e7c8005c51e0dbeab4da26b83e3898adcb354bac7aed00bb4',
     x86_64: '1659437b273ec90e00f5607ad2c3afc93a7260dfb1a6e46b080f3457a85e77a9'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options "-DBUILD_SHARED_LIBS=ON -DLIBRARY_INSTALL_DIR=#{CREW_LIB_PREFIX}"
end
