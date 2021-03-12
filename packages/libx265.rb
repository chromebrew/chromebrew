require 'package'

class Libx265 < Package
  description 'x265 is a H.265 / HEVC video encoder application library.'
  homepage 'http://x265.org/'
  @_ver = '3.4'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/videolan/x265/archive/#{@_ver}.tar.gz"
  source_sha256 '544d147bf146f8994a7bf8521ed878c93067ea1c7c6e93ab602389be3117eaaf'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libx265-3.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libx265-3.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libx265-3.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libx265-3.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'cf7548c97fb5774a3fea30a580ba1719f7b4efdfb4e5f6db91fac20d651d8442',
     armv7l: 'cf7548c97fb5774a3fea30a580ba1719f7b4efdfb4e5f6db91fac20d651d8442',
       i686: 'dff1da6826ecf734d7012c4ec9cdd5d2c18e505968bcd6a9dcf6a5d7d1234c8d',
     x86_64: 'fc7647ea5a73c0fdbc2cea1f2c842de8a4a72db11b1fce5907ed79669e598ab4'
  })

  depends_on 'nasm' => :build

  def self.build
    case ARCH
    when 'x86_64', 'aarch64', 'armv7l'
      Dir.mkdir 'build-12'
      Dir.chdir 'build-12' do
        system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        cmake \
          -G Ninja \
          #{CREW_CMAKE_OPTIONS} \
          -DLIB_INSTALL_DIR=lib#{CREW_LIB_SUFFIX} \
          -DHIGH_BIT_DEPTH=TRUE \
          -DMAIN12=TRUE \
          -DEXPORT_C_API=FALSE \
          -DENABLE_CLI=FALSE \
          -DENABLE_SHARED=FALSE \
          -Wno-dev \
          ../source"
      end
      system 'ninja -C build-12'
      Dir.mkdir 'build-10'
      Dir.chdir 'build-10' do
        system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        cmake \
          -G Ninja \
          #{CREW_CMAKE_OPTIONS} \
          -DLIB_INSTALL_DIR=lib#{CREW_LIB_SUFFIX} \
          -DHIGH_BIT_DEPTH=TRUE \
          -DEXPORT_C_API=FALSE \
          -DENABLE_CLI=FALSE \
          -DENABLE_SHARED=FALSE \
          -Wno-dev \
          ../source"
      end
      system 'ninja -C build-10'
      Dir.mkdir 'builddir'
      Dir.chdir 'builddir' do
        system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        cmake \
          -G Ninja \
          #{CREW_CMAKE_OPTIONS} \
          -DENABLE_SHARED=TRUE \
          -DLIB_INSTALL_DIR=lib#{CREW_LIB_SUFFIX} \
          -DENABLE_HDR10_PLUS=TRUE \
          -DEXTRA_LIB='x265_main10.a;x265_main12.a' \
          -DEXTRA_LINK_FLAGS='-L .' \
          -DLINKED_10BIT=TRUE \
          -DLINKED_12BIT=TRUE \
          -Wno-dev \
          ../source"
      end
      FileUtils.ln_s '../build-10/libx265.a', 'builddir/libx265_main10.a'
      FileUtils.ln_s '../build-12/libx265.a', 'builddir/libx265_main12.a'
    when 'i686'
      Dir.mkdir 'builddir'
      Dir.chdir 'builddir' do
        system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DENABLE_SHARED=TRUE \
        -DLIB_INSTALL_DIR=lib#{CREW_LIB_SUFFIX} \
        -Wno-dev \
        ../source"
      end
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
