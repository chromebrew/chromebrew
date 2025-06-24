require 'buildsystems/cmake'

class Libjpeg_turbo < CMake
  description 'Libjpeg-turbo implements both the traditional libjpeg API as well as the less powerful but more straightforward TurboJPEG API.'
  homepage 'https://libjpeg-turbo.org'
  version '3.1.1'
  license 'IJG License'
  compatibility 'all'
  source_url 'https://github.com/libjpeg-turbo/libjpeg-turbo.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a320f17f92713f21b365b2a7199deeec3988ed2f6b8860edc43d96b9fb4dc2d5',
     armv7l: 'a320f17f92713f21b365b2a7199deeec3988ed2f6b8860edc43d96b9fb4dc2d5',
       i686: '9491d4737000e80bcbdd7a39e9dc13c2178ff865beff7d800d6159bfc395e8fa',
     x86_64: '886737c6bb0a1da295b306b64ce0cd3bbd1879e24a3604b5e8a030d15b28a7cf'
  })

  depends_on 'nasm' => :build
  depends_on 'glibc' # R

  cmake_options '-DENABLE_STATIC=OFF \
        -DWITH_JAVA=OFF'

  cmake_install_extras do
    FileUtils.install 'src/jpegint.h', "#{CREW_DEST_PREFIX}/include/", mode: 0o644
  end
end
