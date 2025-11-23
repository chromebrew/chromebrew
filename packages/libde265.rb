require 'package'

class Libde265 < Package
  description 'Open h.265 video codec implementation.'
  homepage 'https://github.com/strukturag/libde265'
  version '1.0.16'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/strukturag/libde265/releases/download/v#{version}/libde265-#{version}.tar.gz"
  source_sha256 'b92beb6b53c346db9a8fae968d686ab706240099cdd5aff87777362d668b0de7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9bb1e498a24b99f25ca2573efa19af0ba0b80fe787b8290f83710b047b4f8b3d',
     armv7l: '9bb1e498a24b99f25ca2573efa19af0ba0b80fe787b8290f83710b047b4f8b3d',
     x86_64: 'ca2cbda88810f15a62f9afe38722544d170cde511b065ed7495481b194ae83aa'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libsdl' # R
  depends_on 'sdl2' # R

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
