require 'buildsystems/cmake'

class Libjpeg_turbo < CMake
  description 'Libjpeg-turbo implements both the traditional libjpeg API as well as the less powerful but more straightforward TurboJPEG API.'
  homepage 'https://libjpeg-turbo.org'
  version '3.1.2'
  license 'IJG License'
  compatibility 'all'
  source_url 'https://github.com/libjpeg-turbo/libjpeg-turbo.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e60fa4d21fe92db76e0b1f64738d9c775f5d0cf0af856df4d259ff573aef9700',
     armv7l: 'e60fa4d21fe92db76e0b1f64738d9c775f5d0cf0af856df4d259ff573aef9700',
       i686: '5016c802b9ff56065326eb05891a86ca88972c3d76f868f32a84770188990179',
     x86_64: 'cd84fd0c27e65619a1f9bed5675b043c00ad7d9254a5c1dc66b2142c7b759cf0'
  })

  depends_on 'nasm' => :build
  depends_on 'glibc' # R

  cmake_options '-DENABLE_STATIC=OFF \
        -DWITH_JAVA=OFF'

  cmake_install_extras do
    FileUtils.install 'src/jpegint.h', "#{CREW_DEST_PREFIX}/include/", mode: 0o644
  end
end
