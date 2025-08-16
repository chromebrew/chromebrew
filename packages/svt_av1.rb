require 'package'

class Svt_av1 < Package
  description 'Scalable Video Technology AV1 encoder and decoder'
  homepage 'https://gitlab.com/AOMediaCodec/SVT-AV1'
  version '3.1.0'
  license 'BSD-2, Apache-2.0, BSD, ISC, MIT and LGPG-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/AOMediaCodec/SVT-AV1.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f374f353a175f3fb564a2d5002dbf339bc9f1156da3b56967619057b2a982d06',
     armv7l: 'f374f353a175f3fb564a2d5002dbf339bc9f1156da3b56967619057b2a982d06',
     x86_64: '3c215dbc20e0b7c03d8c8860bc4eb6d7c5e69c1c8f80ac8647f8ca3e31d199af'
  })

  depends_on 'glibc' # R
  depends_on 'nasm' => :build

  def self.build
    @arch_flags = ''
    @arch_flags = '-mtune=cortex-a15 -mfloat-abi=hard -mfpu=neon -mtls-dialect=gnu -marm -mlibarch=armv8-a+crc+simd -march=armv8-a+crc+simd' if ARCH == 'armv7l' || ARCH == 'aarch64'
    FileUtils.mkdir_p 'builddir'
    Dir.chdir 'builddir' do
      unless File.file?('build.ninja')
        system "cmake \
          -G Ninja \
          #{CREW_CMAKE_OPTIONS.sub('-pipe', "-pipe #{@arch_flags}")} \
          -DBUILD_SHARED_LIBS=ON \
          -DNATIVE=OFF \
          .."
      end
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
