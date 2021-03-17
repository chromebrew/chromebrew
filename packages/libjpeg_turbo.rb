require 'package'

class Libjpeg_turbo < Package
  description 'Libjpeg-turbo implements both the traditional libjpeg API as well as the less powerful but more straightforward TurboJPEG API.'
  homepage 'https://libjpeg-turbo.org'
  @_ver = '2.0.6'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/libjpeg-turbo/libjpeg-turbo/archive/#{@_ver}.tar.gz"
  source_sha256 '005aee2fcdca252cee42271f7f90574dda64ca6505d9f8b86ae61abc2b426371'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg_turbo-2.0.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg_turbo-2.0.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg_turbo-2.0.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg_turbo-2.0.6-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '03aaee5e33b24e1919784d2167e1bd797c08ebf0af496a5de429dd053552fdaa',
     armv7l: '03aaee5e33b24e1919784d2167e1bd797c08ebf0af496a5de429dd053552fdaa',
       i686: 'ed6436cc18712d3eb58865b0515e6a4856b6999482d9e056e35add57ca4eb54b',
     x86_64: 'd06c24d674194809b95b37cf66b7813230697a4e75ac29756917605097b8bae0'
  })

  depends_on 'yasm' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DWITH_JPEG8=1 \
        -DWITH_JAVA=OFF \
        -DWITH_12BIT=ON \
        -W no-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.check
    system 'ninja -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.install 'jpegint.h', "#{CREW_DEST_PREFIX}/include/", mode: 0o644
  end
end
