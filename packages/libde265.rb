require 'package'

class Libde265 < Package
  description 'Open h.265 video codec implementation.'
  homepage 'https://github.com/strukturag/libde265'
  version '1.0.11'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/strukturag/libde265/releases/download/v#{version}/libde265-#{version}.tar.gz"
  source_sha256 '2f8f12cabbdb15e53532b7c1eb964d4e15d444db1be802505e6ac97a25035bab'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f31bdb3f3d2c6f88f2cd78814dba76dfbdf53f3ae719bdb85d44f05cb81b159e',
     armv7l: 'f31bdb3f3d2c6f88f2cd78814dba76dfbdf53f3ae719bdb85d44f05cb81b159e',
     x86_64: '83acdc8cce935ffce2922bd8a8432978662b2c759df192b38c543709800fb574'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libsdl' # R

  def self.build
    system "cmake \
      -B builddir -G Ninja \
      #{CREW_CMAKE_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
      -DENABLE_ENCODER=ON \
      -Wno-dev"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
