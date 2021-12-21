require 'package'

class Musl_native_toolchain < Package
  description 'A modern, simple, and fast C library implementation that strives to be lightweight, fast, simple, free, and correct in the sense of standards-conformance and safety.'
  homepage 'https://musl.cc/'
  version '1.2.2-b76f37fd'
  compatibility 'all'
  license 'MIT, LGPL-2 and GPL-2'
  source_url({
    aarch64: 'https://musl.cc/armv7l-linux-musleabihf-native.tgz',
     armv7l: 'https://musl.cc/armv7l-linux-musleabihf-native.tgz',
       i686: 'https://musl.cc/i686-linux-musl-native.tgz',
     x86_64: 'https://musl.cc/x86_64-linux-musl-native.tgz'
  })
  source_sha256({
    aarch64: '2b37466f716d28a9ef313a8916543f53f9c8c78509e1c8d57a18ca4b171f2205',
     armv7l: '2b37466f716d28a9ef313a8916543f53f9c8c78509e1c8d57a18ca4b171f2205',
       i686: '978471bf7b8111dfd8c5559a23ef18b80bcd85936872f00424f1b7a5300580ee',
     x86_64: 'eb1db6f0f3c2bdbdbfb993d7ef7e2eeef82ac1259f6a6e1757c33a97dbcef3ad'
  })

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/1.2.2-b76f37fd_armv7l/musl_native_toolchain-1.2.2-b76f37fd-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/1.2.2-b76f37fd_armv7l/musl_native_toolchain-1.2.2-b76f37fd-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/1.2.2-b76f37fd_i686/musl_native_toolchain-1.2.2-b76f37fd-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/1.2.2-b76f37fd_x86_64/musl_native_toolchain-1.2.2-b76f37fd-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '740430d7ac599b6ee678943599cf88b31195f695cc00e6c86336a8b687a27804',
     armv7l: '740430d7ac599b6ee678943599cf88b31195f695cc00e6c86336a8b687a27804',
       i686: 'eda5d0e5ec72fa553a75377ac27994e9bb3f5466076de60ff1ad503522288b7b',
     x86_64: 'af4d4c2b4c451a0679c70b4ba39a5b701d6d0df112b89d080c201c6708e27d77'
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
