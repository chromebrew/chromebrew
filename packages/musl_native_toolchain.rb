require 'package'

class Musl_native_toolchain < Package
  description 'A modern, simple, and fast C library implementation that strives to be lightweight, fast, simple, free, and correct in the sense of standards-conformance and safety.'
  homepage 'https://musl.cc/'
  version '1.2.2-e5d2823'
  compatibility 'all'
  license 'MIT, LGPL-2 and GPL-2'
  source_url({
    aarch64: 'https://musl.cc/armv7l-linux-musleabihf-native.tgz',
     armv7l: 'https://musl.cc/armv7l-linux-musleabihf-native.tgz',
       i686: 'https://musl.cc/i686-linux-musl-native.tgz',
     x86_64: 'https://musl.cc/x86_64-linux-musl-native.tgz'
  })
  source_sha256({
    aarch64: 'bf54a4762aed1a53be247bd5ead66569145c02d7ec78f405b184a7cda80149d1',
     armv7l: 'bf54a4762aed1a53be247bd5ead66569145c02d7ec78f405b184a7cda80149d1',
       i686: 'ae18b6d0fa58a638dba3b6efa1e660433fe9c0a0ef4283955dd934bc09a9898e',
     x86_64: '6bceb516e51d2eecc65e9670f605692fec419bb7ecca701bb021b720f71d6d86'
  })

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/1.2.2-e5d2823_armv7l/musl_native_toolchain-1.2.2-e5d2823-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/1.2.2-e5d2823_armv7l/musl_native_toolchain-1.2.2-e5d2823-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/1.2.2-e5d2823_i686/musl_native_toolchain-1.2.2-e5d2823-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/1.2.2-e5d2823_x86_64/musl_native_toolchain-1.2.2-e5d2823-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd171b09be7381cbde64dc923560b2ec4da61c926f63fc4c2cd2d9778e1b21900',
     armv7l: 'd171b09be7381cbde64dc923560b2ec4da61c926f63fc4c2cd2d9778e1b21900',
       i686: 'cded0394407b43ca30e7b07d91e3a35d3c70e43bcb657f12f8510a8677ef0b27',
     x86_64: 'a99cc10f24baa7cdbf8bdb263c657793606ae8bdacbf8b5a906ddcc1a303547c'
  })

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    ENV['CREW_NOT_STRIP'] = '1'
    ENV['CREW_SHRINK_ARCHIVE'] = '0'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/musl/lib"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/musl/", verbose: true
    Dir.chdir("#{CREW_DEST_PREFIX}/musl/lib") do
      FileUtils.ln_sf 'libc.so', 'ld-musl-x86_64.so.1' if ARCH == 'x86_64'
      FileUtils.ln_sf 'libc.so', 'ld-musl-armhf.so.1' if ARCH == 'armv7l'
      FileUtils.ln_sf 'libc.so', 'ld-musl-i386.so.1' if ARCH == 'i686'
    end
    Dir.chdir("#{CREW_DEST_PREFIX}/musl") do
      FileUtils.ln_sf 'lib', 'lib64' if ARCH == 'x86_64'
    end
  end

  def self.postinstall; end
end
