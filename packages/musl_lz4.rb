require 'package'

class Musl_lz4 < Package
  description 'LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core (0.16 Bytes/cycle).'
  homepage 'https://lz4.github.io/lz4/'
  version '1.9.2'
  license 'BSD-2 and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/lz4/lz4/archive/v1.9.2.tar.gz'
  source_sha256 '658ba6191fa44c92280d4aa2c271b0f4fbc0e34d249578dd05e50e76d0e5efcc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_lz4/1.9.2_armv7l/musl_lz4-1.9.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_lz4/1.9.2_armv7l/musl_lz4-1.9.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_lz4/1.9.2_i686/musl_lz4-1.9.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_lz4/1.9.2_x86_64/musl_lz4-1.9.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a2f12adbb2413535fd05f3b8f9cccc02f8674a250d1ac3051f41f539845a4dd1',
     armv7l: 'a2f12adbb2413535fd05f3b8f9cccc02f8674a250d1ac3051f41f539845a4dd1',
       i686: 'cfae6b5d4f0df8b3f7b92a7f64179357629a5d4ca5c84474dc810ba8f71af9f2',
     x86_64: '029d44c8b9c124c5be2d46a36901171a500c8c66e71caa6ffdd08668865b1f57'
  })

  depends_on 'musl_native_toolchain' => :build

  is_static

  def self.build
    load "#{CREW_LIB_PATH}lib/musl.rb"
    system "#{MUSL_ENV_OPTIONS} make PREFIX=#{CREW_MUSL_PREFIX} \
      LIBDIR=#{CREW_MUSL_PREFIX}/lib \
      BUILD_STATIC=yes \
      BUILD_SHARED=no"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_MUSL_PREFIX}/lib", 'install'
  end
end
