require 'buildsystems/cmake'

class Svt_av1 < CMake
  description 'Scalable Video Technology AV1 encoder and decoder'
  homepage 'https://gitlab.com/AOMediaCodec/SVT-AV1'
  version '4.2.0'
  license 'BSD-2, Apache-2.0, BSD, ISC, MIT and LGPG-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/AOMediaCodec/SVT-AV1.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '39d9baa567f8a1eb203123ffb01714e8156a1d0f5a82ea9d2595160de3298b10',
     armv7l: '39d9baa567f8a1eb203123ffb01714e8156a1d0f5a82ea9d2595160de3298b10',
     x86_64: 'c927b7be0e8278e85fbf4437ea28969dd3b9f371f430281cfd92dfb204135571'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'nasm' => :build

  @arch_flags = ''
  @arch_flags = ' -mtune=cortex-a15 -mfloat-abi=hard -mfpu=neon -mtls-dialect=gnu -marm -mlibarch=armv8-a+crc+simd -march=armv8-a+crc+simd' if ARCH == 'armv7l' || ARCH == 'aarch64'
  cmake_options "#{CREW_CMAKE_OPTIONS.sub('-pipe', "-pipe#{@arch_flags}")} -DBUILD_SHARED_LIBS=ON -DNATIVE=OFF"
end
