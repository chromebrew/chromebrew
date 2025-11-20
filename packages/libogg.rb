require 'buildsystems/cmake'

class Libogg < CMake
  description 'Ogg is a multimedia container format, and the native file and stream format for the Xiph.org multimedia codecs.'
  homepage 'https://xiph.org/ogg/'
  version '1.3.6'
  license 'BSD'
  compatibility 'all'
  source_url 'https://gitlab.xiph.org/xiph/ogg.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e7e8f22e0eae1a3a6ef568e90fc749e0582f45adc8651b6f275063139ebc9480',
     armv7l: 'e7e8f22e0eae1a3a6ef568e90fc749e0582f45adc8651b6f275063139ebc9480',
       i686: '2d87db08728126d3b171ce667d61b18cb3057c47b6a9412e484f3c8a27a5bee5',
     x86_64: 'fc696a6085d698b2f0abc04ec1ea6273c192cf87aa6a8298194c1c7f42d9ea40'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON \
                 -DINSTALL_DOCS=OFF'
end
