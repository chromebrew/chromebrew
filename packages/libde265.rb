require 'package'

class Libde265 < Package
  description 'Open h.265 video codec implementation.'
  homepage 'https://github.com/strukturag/libde265'
  @_ver = '1.0.8'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/strukturag/libde265/releases/download/v#{@_ver}/libde265-#{@_ver}.tar.gz"
  source_sha256 '24c791dd334fa521762320ff54f0febfd3c09fc978880a8c5fbc40a88f21d905'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libde265-1.0.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libde265-1.0.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libde265-1.0.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libde265-1.0.8-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f2ca6f26fd80159a03e6dc9e3ba62f24ab690c98b03444dc0bad602461643fde',
     armv7l: 'f2ca6f26fd80159a03e6dc9e3ba62f24ab690c98b03444dc0bad602461643fde',
       i686: 'b08e6380514f8c61a026f74bba03cc29eeefddbd3b430065de0c42da5a28d105',
     x86_64: '4d4f93fd7b4cc7ac4003fba0a8a1a42edc43045fae6496b72a78b6f312b1e6cb'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
