# Not supported on 32-bit architectures.

require 'package'

class Svt_av1 < Package
  description 'Scalable Video Technology AV1 encoder and decoder'
  homepage 'https://gitlab.com/AOMediaCodec/SVT-AV1'
  @_ver = '1.2.1'
  version @_ver
  license 'BSD-2, Apache-2.0, BSD, ISC, MIT and LGPG-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.com/AOMediaCodec/SVT-AV1.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/svt_av1/1.2.1_armv7l/svt_av1-1.2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/svt_av1/1.2.1_armv7l/svt_av1-1.2.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/svt_av1/1.2.1_i686/svt_av1-1.2.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/svt_av1/1.2.1_x86_64/svt_av1-1.2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cfbee82794fed2260c1c2b24e64831fbc133e5a5a28452a8103c618d98a4b387',
     armv7l: 'cfbee82794fed2260c1c2b24e64831fbc133e5a5a28452a8103c618d98a4b387',
       i686: '30083041d42598459d5b2fe0492a10ca8d6a95b5e727a0b113bbe8ec0adc126e',
     x86_64: 'bb0322853b560c1ca2728ca6412ee895a3fcead79110d21d680ef01de332ae65'
  })

  depends_on 'yasm' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DBUILD_SHARED_LIBS=ON \
        -DNATIVE=OFF \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
