require 'package'

class Musl_lz4 < Package
  description 'LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core (0.16 Bytes/cycle).'
  homepage 'https://lz4.github.io/lz4/'
  version '1.9.4'
  license 'BSD-2 and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/lz4/lz4/archive/v1.9.4.tar.gz'
  source_sha256 '0b0e3aa07c8c063ddf40b082bdf7e37a1562bda40a0ff5272957f3e987e0e54b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c39ca05976e35e10d724518052aebce3cdaa54ebd3d1f1a649f2fbae6be8e4ef',
     armv7l: 'c39ca05976e35e10d724518052aebce3cdaa54ebd3d1f1a649f2fbae6be8e4ef',
       i686: '16cbe8e1131fdfcb0cdfe56431b9620d78fb693096001155892edff8c79d701e',
     x86_64: '46c50c6f1ba3eeafcf6c80c28df26e7d25d73edd3b14f6a3fc581acbd4cf2aa0'
  })

  depends_on 'musl_native_toolchain' => :build

  is_static

  def self.build
    load "#{CREW_LIB_PATH}/lib/musl.rb"
    system "#{MUSL_ENV_OPTIONS} make PREFIX=#{CREW_MUSL_PREFIX} \
      LIBDIR=#{CREW_MUSL_PREFIX}/lib \
      BUILD_STATIC=yes \
      BUILD_SHARED=no"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_MUSL_PREFIX}/lib", "PREFIX=#{CREW_MUSL_PREFIX}", 'install'
  end
end
