require 'package'

class Libvpx < Package
  description 'VP8/VP9 Codec SDK'
  homepage 'http://www.webmproject.org/code/'
  @_ver = '1.10.0-rc1'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/webmproject/libvpx/archive/v#{@_ver}.tar.gz"
  source_sha256 '8e55e04cdefeb1596968e70c5167e13d26132ca214d276292d5cda737a430af5'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libvpx-1.10.0-rc1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libvpx-1.10.0-rc1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libvpx-1.10.0-rc1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libvpx-1.10.0-rc1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '61583e4e5ac53ef7534c948bf05874381c9889cf8bb25771458d332c21caddff',
     armv7l: '61583e4e5ac53ef7534c948bf05874381c9889cf8bb25771458d332c21caddff',
       i686: 'dea476dc36f7afc6a41de73f16f94d62d353cc34504094c6f5bdc64f3a1d9e25',
     x86_64: '2dd18189255d957cf67842b4f12aa040d4d5bec98665c8bb7c900422377716fe'
  })

  depends_on 'yasm' => :build
  depends_on 'ccache' => :build
  depends_on 'libyuv'

  def self.build
    Dir.chdir 'build' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        ../configure #{CREW_OPTIONS.sub(/--mandir=.*/, '')} \
        --disable-debug-libs \
        --disable-install-docs \
        --enable-ccache \
        --enable-debug \
        --enable-libyuv \
        --enable-pic \
        --enable-runtime-cpu-detect \
        --enable-shared \
        --enable-vp8 \
        --enable-vp9 \
        --enable-vp9-highbitdepth"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make DESTDIR=#{CREW_DEST_DIR} install"
    end
  end
end
