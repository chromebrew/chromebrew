# Not supported on 32-bit architectures.

require 'package'

class Svt_av1 < Package
  description 'Scalable Video Technology AV1 encoder and decoder'
  homepage 'https://gitlab.com/AOMediaCodec/SVT-AV1'
  @_ver = '0.8.6'
  version @_ver
  license 'BSD-2, Apache-2.0, BSD, ISC, MIT and LGPG-2.1+'
  compatibility 'x86_64'
  source_url "https://gitlab.com/AOMediaCodec/SVT-AV1/-/archive/v#{@_ver}/SVT-AV1-v#{@_ver}.tar.bz2"
  source_sha256 'e942959be6b062f4adea33fd5dbfbd5581b178ce87b4baf9bd84283fbc8203e1'

  binary_url({
    x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/svt_av1-0.8.6-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    x86_64: '930dad392dc9b31153adfbdb01f5c9cc947bf58c29c121aac89039a24c043867'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -I#{CREW_PREFIX}/include/harfbuzz' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
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
