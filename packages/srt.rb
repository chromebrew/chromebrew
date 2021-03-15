require 'package'

class Srt < Package
  description 'Secure Reliable Transport library'
  homepage 'https://www.srtalliance.org/'
  @_ver = '1.4.3-rc.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/Haivision/srt/archive/v#{@_ver}.tar.gz"
  source_sha256 '50a05239602f2a402b4a96bc8b8e1ebf98808aa2966311c14f814ad477018a56'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/srt-1.4.3-rc.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/srt-1.4.3-rc.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/srt-1.4.3-rc.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/srt-1.4.3-rc.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9c47c8399de872fe28a96f0dd4d2fac9a8c55b2d009d19962ef3fd49e7ba772f',
     armv7l: '9c47c8399de872fe28a96f0dd4d2fac9a8c55b2d009d19962ef3fd49e7ba772f',
       i686: 'a0e793630412f6b3c936b5489b019f626e04ddf69226e767867624ad3fe5bef3',
     x86_64: '7473da57136746f4f5c66af50bfc642fc81702b4e4975fd7fce016021136ba86'
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
        -DENABLE_STATIC=ON \
        -DBUILD_SHARED_LIBS=ON \
        -DNATIVE=OFF \
        -DENABLE_TESTING=OFF \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
