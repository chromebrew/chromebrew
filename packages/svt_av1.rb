# Not supported on 32-bit architectures.

require 'package'

class Svt_av1 < Package
  description 'Scalable Video Technology AV1 encoder and decoder'
  homepage 'https://gitlab.com/AOMediaCodec/SVT-AV1'
  version '1.3.0'
  license 'BSD-2, Apache-2.0, BSD, ISC, MIT and LGPG-2.1+'
  compatibility 'all'
  source_url "https://gitlab.com/AOMediaCodec/SVT-AV1/-/archive/v#{version}/SVT-AV1-v#{version}.tar.bz2"
  source_sha256 'f85fd13ef16880550e425797bdfdf1b0ba310c21d6b343f74ea79dd2fbb2336e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/svt_av1/1.3.0_armv7l/svt_av1-1.3.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/svt_av1/1.3.0_armv7l/svt_av1-1.3.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/svt_av1/1.3.0_i686/svt_av1-1.3.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/svt_av1/1.3.0_x86_64/svt_av1-1.3.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7c6836c93f395230a1c24f6c609088a1170f6b24de4290a77c2990813e989ebf',
     armv7l: '7c6836c93f395230a1c24f6c609088a1170f6b24de4290a77c2990813e989ebf',
       i686: '9ef3163f101f69f43483a96f885165eb4ab90f163b61de103e0b209b48eac52b',
     x86_64: '5fd98c6acf559d5abb827610d4b0d212a8f8d0ee518ebe97877bab06e6222ac0'
  })

  depends_on 'nasm' => :build
  depends_on 'glibc' # R

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
