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
    aarch64: '8ea20f411bd98eb45cbee34128240e50e33ebd8a987da2f7602e58a352781e21',
     armv7l: '8ea20f411bd98eb45cbee34128240e50e33ebd8a987da2f7602e58a352781e21',
       i686: '3b49ddea7c24ddf790d4fa63f5e624734d4f19d0389dfe658d2999951904a20b',
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
