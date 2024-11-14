require 'buildsystems/cmake'

class Libyuv < CMake
  description 'Library for YUV scaling'
  homepage 'https://chromium.googlesource.com/libyuv/libyuv/'
  version '188e4e3'
  license 'BSD-Google'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://chromium.googlesource.com/libyuv/libyuv.git'
  git_hashtag '188e4e3afbfe90f6f13f59db6c929762de07921b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb76ee82bfc4a5b4a20c471da425443e92f93b1e74c826b4f698409e70df5550',
     armv7l: 'fb76ee82bfc4a5b4a20c471da425443e92f93b1e74c826b4f698409e70df5550',
     x86_64: '079922fb87321c186cbbc468bfa310841d2acc1c75a7abe717898a7aa65a3943'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libjpeg_turbo' # R

  def self.patch
    system "sed -i 's,DESTINATION lib,DESTINATION lib#{CREW_LIB_SUFFIX},g' CMakeLists.txt"
  end
end
