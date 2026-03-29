require 'buildsystems/cmake'

class Svt_av1 < CMake
  description 'Scalable Video Technology AV1 encoder and decoder'
  homepage 'https://gitlab.com/AOMediaCodec/SVT-AV1'
  version '4.1.0'
  license 'BSD-2, Apache-2.0, BSD, ISC, MIT and LGPG-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/AOMediaCodec/SVT-AV1.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a803ccda07fe1abd6e319ba3dd89bc1fa293535efca15024aacd9b9e3a52f4bf',
     armv7l: 'a803ccda07fe1abd6e319ba3dd89bc1fa293535efca15024aacd9b9e3a52f4bf',
     x86_64: '42ef12c79b4810966a1a677ca66e2bcae6eefbc9ccd21bf5ae6e1976a5207c7c'
  })

  depends_on 'glibc' => :library
  depends_on 'nasm' => :build

  @arch_flags = ''
  @arch_flags = ' -mtune=cortex-a15 -mfloat-abi=hard -mfpu=neon -mtls-dialect=gnu -marm -mlibarch=armv8-a+crc+simd -march=armv8-a+crc+simd' if ARCH == 'armv7l' || ARCH == 'aarch64'
  cmake_options "#{CREW_CMAKE_OPTIONS.sub('-pipe', "-pipe#{@arch_flags}")} -DBUILD_SHARED_LIBS=ON -DNATIVE=OFF"
end
