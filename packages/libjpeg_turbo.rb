require 'buildsystems/cmake'

class Libjpeg_turbo < CMake
  description 'Libjpeg-turbo implements both the traditional libjpeg API as well as the less powerful but more straightforward TurboJPEG API.'
  homepage 'https://libjpeg-turbo.org'
  version '3.1.0'
  license 'IJG License'
  compatibility 'all'
  source_url 'https://github.com/libjpeg-turbo/libjpeg-turbo.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a320f17f92713f21b365b2a7199deeec3988ed2f6b8860edc43d96b9fb4dc2d5',
     armv7l: 'a320f17f92713f21b365b2a7199deeec3988ed2f6b8860edc43d96b9fb4dc2d5',
       i686: '8b68797f4ac975b6db273659b1e62587a5ce3496b2f60914fb061239b279c39a',
     x86_64: '97b8d4494be87df3e17ce291425d4c49cbda0f95a3b9051ac8cce6383a9db6b6'
  })

  depends_on 'nasm' => :build
  depends_on 'glibc' # R

  cmake_options '-DENABLE_STATIC=OFF \
        -DWITH_JAVA=OFF'

  cmake_install_extras do
    FileUtils.install 'src/jpegint.h', "#{CREW_DEST_PREFIX}/include/", mode: 0o644
  end
end
