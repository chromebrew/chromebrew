require 'buildsystems/cmake'

class Libyuv < CMake
  description 'Library for YUV scaling'
  homepage 'https://chromium.googlesource.com/libyuv/libyuv/'
  version '949cb62'
  license 'BSD-Google'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://chromium.googlesource.com/libyuv/libyuv.git'
  git_hashtag '949cb623bf904c5e7a7c060ab0ae609574870fb3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '063f2d6a7e4ea54093e1a36c79793ca065b2502ba60a79ac25303f7c0e651dff',
     armv7l: '063f2d6a7e4ea54093e1a36c79793ca065b2502ba60a79ac25303f7c0e651dff',
     x86_64: '990789ffbb29fb2b6c52f1ce79df9825af690d6309046fdfd077af91eb7c020b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libjpeg_turbo' # R

  def self.patch
    system "sed -i 's,DESTINATION lib,DESTINATION lib#{CREW_LIB_SUFFIX},g' CMakeLists.txt"
  end
end
