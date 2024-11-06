require 'package'

class Svt_av1 < Package
  description 'Scalable Video Technology AV1 encoder and decoder'
  homepage 'https://gitlab.com/AOMediaCodec/SVT-AV1'
  version '2.0.0'
  license 'BSD-2, Apache-2.0, BSD, ISC, MIT and LGPG-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.com/AOMediaCodec/SVT-AV1.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6252e978f095cd4657727731e8223ccef315a5eec8926b9f748eaa34fd41cabc',
     armv7l: '6252e978f095cd4657727731e8223ccef315a5eec8926b9f748eaa34fd41cabc',
     x86_64: 'c0e20fc16251760a043b98967055dcaad9088bcb979f73602750913b7f321c43'
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
