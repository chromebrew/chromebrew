require 'package'

class Musl_native_toolchain < Package
  description 'A modern, simple, and fast C library implementation that strives to be lightweight, fast, simple, free, and correct in the sense of standards-conformance and safety.'
  homepage 'https://musl.cc/'
  version '1.2.2-e5d2823'
  license 'MIT, LGPL-2 and GPL-2'
  compatibility 'all'
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
    aarch64: '20264377f281e5ff63831a7438030365c1b470e81541badf3defc11664e21f45',
     armv7l: '20264377f281e5ff63831a7438030365c1b470e81541badf3defc11664e21f45',
       i686: '89d2f541c5391c30e3cc8eba52dd0835c979245f5c1ee5feb0a45f9ed9ed8bf7',
     x86_64: 'f7e63e0296652ae4d416d350c7c71402ad9c1336bd3ee4b9caafb872c40c6529'
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
    Dir.chdir("#{CREW_DEST_PREFIX}/musl") do
      FileUtils.ln_s 'lib', 'lib64' if ARCH == 'x86_64'
    end
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/musl/", verbose: true
  end

  def self.postinstall; end
end
