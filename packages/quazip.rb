require 'buildsystems/cmake'

class Quazip < CMake
  description 'Qt/C++ wrapper over minizip'
  homepage 'https://github.com/stachenov/quazip'
  version '1.7.2'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/stachenov/quazip.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ab8ca631a2bf60629f2b1f25f5bb2a1a797890dda0fd77db68213d824faed3c',
     armv7l: '2ab8ca631a2bf60629f2b1f25f5bb2a1a797890dda0fd77db68213d824faed3c',
     x86_64: '6d157f9f1888a142caf24d03ea72e33799d3cf56b1e8d46320e9c1db4c2a4c16'
  })

  depends_on 'bzip2' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'qt5_base' => :library
  depends_on 'zlib' => :library
end
