require 'package'

class Abseil_cpp < Package
  description 'Abseil Common Libraries C++'
  homepage 'https://abseil.io/'
  @_ver = '20200923.3'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/abseil/abseil-cpp/archive/#{@_ver}.tar.gz"
  source_sha256 'ebe2ad1480d27383e4bf4211e2ca2ef312d5e6a09eba869fd2e8a5c5d553ded2'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/abseil_cpp-20200923.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/abseil_cpp-20200923.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/abseil_cpp-20200923.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/abseil_cpp-20200923.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0bcfb2b4924b1c782d918805edf2e6b200ec9547ae362d09ed1122003dd64c49',
     armv7l: '0bcfb2b4924b1c782d918805edf2e6b200ec9547ae362d09ed1122003dd64c49',
       i686: '751aa86540e5a3d70a53217488bb4cb8ca7fc2d37846e2ddf2aa363998e8cb77',
     x86_64: 'ff09779acf76c9d83f69f07dcdcc0dd262beca43b2c74c48a9b9d4fd3ec6a5c0'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
        cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DCMAKE_CXX_STANDARD=17 \
        -DABSL_CXX_STANDARD=17 \
        -DABSL_USE_GOOGLETEST_HEAD=ON \
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
        -DABSL_ENABLE_INSTALL=ON \
        -DCMAKE_MODULE_LINKER_FLAGS=\"-Wl,--no-undefined -Wl,--no-undefined\" \
        -DBUILD_SHARED_LIBS=ON \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
