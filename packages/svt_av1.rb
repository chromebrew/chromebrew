require 'buildsystems/cmake'

class Svt_av1 < CMake
  description 'Scalable Video Technology AV1 encoder and decoder'
  homepage 'https://gitlab.com/AOMediaCodec/SVT-AV1'
  version '4.3.0'
  license 'BSD-2, Apache-2.0, BSD, ISC, MIT and LGPG-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/AOMediaCodec/SVT-AV1.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71250adc9c67c9c67c02606b4bf0487aa3ea26825bbec52c0383fdfb924012c3',
     armv7l: '71250adc9c67c9c67c02606b4bf0487aa3ea26825bbec52c0383fdfb924012c3',
     x86_64: '8d960c9c6099229dcd62d632cb63b5ce166c0875265ce2c38448d9d736cf1d11'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'nasm' => :build

  @arch_flags = ''
  @arch_flags = ' -mtune=cortex-a15 -mfloat-abi=hard -mfpu=neon -mtls-dialect=gnu -marm -mlibarch=armv8-a+crc+simd -march=armv8-a+crc+simd' if ARCH == 'armv7l' || ARCH == 'aarch64'
  cmake_options "#{CREW_CMAKE_OPTIONS.sub('-pipe', "-pipe#{@arch_flags}")} -DBUILD_SHARED_LIBS=ON -DNATIVE=OFF"
end
